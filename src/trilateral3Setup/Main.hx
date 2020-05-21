package trilateral3Setup;

import haxe.io.UInt16Array;
import haxe.io.Float32Array;
import haxe.io.Int32Array;

// generic js
import js.Browser;
import js.html.Image;
import js.html.Event;
import js.html.KeyboardEvent;
import js.html.MouseEvent;
import js.html.DivElement;
import js.lib.Float32Array;

// WebGL / Canvas setup, basic browser utils
import htmlHelper.webgl.WebGLSetup;
import htmlHelper.tools.CharacterInput;
import htmlHelper.tools.AnimateTimer;
import htmlHelper.tools.DivertTrace;

// image loading
import htmlHelper.tools.ImageLoader;

// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;

// Maths mostly matrix trasforms
import geom.matrix.Matrix4x3;
import geom.matrix.Matrix4x4;
import geom.matrix.Quaternion;
import geom.matrix.DualQuaternion;
import geom.matrix.Matrix1x4;
import geom.move.Axis3;
import geom.move.Trinary;
import geom.matrix.Projection;
import geom.matrix.Matrix1x2;
import geom.flat.f32.Float32FlatRGBA;
import geom.flat.f32.Float32FlatTriangle;
import geom.flat.f32.Float32FlatTriangleXY;
import geom.flat.ui16.UInt16Flat3;
import geom.flat.i32.Int32Flat3;

// Trilateral Contour Drawing Tools
import trilateral3.Trilateral;
import trilateral3.math.Algebra;
import trilateral3.drawing.Pen;
import trilateral3.drawing.DrawType;
import trilateral3.drawing.ColorType;
import trilateral3.shape.Shaper;
import trilateral3.drawing.Contour;
import trilateral3.drawing.EndLineCurve;
import trilateral3.drawing.Sketch;
import trilateral3.drawing.SketchForm;
import trilateral3.drawing.Fill;
import trilateral3.iter.ArrayTriple;


// Color pallettes
import pallette.QuickARGB;
import pallette.Gold;

// Shaders
import trilateral3Setup.shaders.Shaders;

// Keyboard control
import trilateral3Setup.helpers.AxisKeys;
// Layout helper
import trilateral3Setup.helpers.LayoutPos;
// SVG paths
import trilateral3Setup.helpers.PathTests;
// Font Letters as SVG paths
import trilateral3Setup.helpers.DroidSans;
// Grid
import trilateral3Setup.drawings.GridLines;

// Test shapes
import trilateral3Setup.drawings.*;

// Test images
import trilateral3Setup.images.HaxeLogo;

using htmlHelper.webgl.WebGLSetup;
enum ShaderTest {
    WithColor;
    WithTexture;
}
class Main extends WebGLSetup {
    // Allows change to alternative test, texture currently not mapped correctly.
    var shaderTest: ShaderTest  = WithColor;
    //var shaderTest: ShaderTest  = WithTexture;
    
    var backgroundSquare        = true;
    var webgl:                  WebGLSetup;
    public var axisModel        = new Axis3();
    var scale:                  Float;
    var model                   = DualQuaternion.zero;
    var pen:                    Pen;
    var theta:                  Float = 0;
    var toDimensionsGL:         Matrix4x3;
    var layoutPos:              LayoutPos;
    var imageLoader:            ImageLoader;
    // not sure this can be done with final
    static final largeEnough    = 2000000;
    var verts                   = new Float32FlatTriangle( largeEnough );
    var textPos                 = new Float32FlatTriangleXY( largeEnough );
    var cols                    = new Float32FlatRGBA(largeEnough);
    var ind                     = new Int32Flat3(largeEnough);
    public static function main(){ new Main(); }
    public inline static var stageRadius: Int = 600;
    public function new(){
        setupSideTrace();
        super( stageRadius, stageRadius );
        keyboardNavigation();
        glSettings();
        shaderAssign();
        layoutPos   = new LayoutPos( stageRadius );
        createPen();
        loadImages( loaded );
    }
    function setupSideTrace() new DivertTrace();
    function keyboardNavigation(){
        var axisKeys   = new AxisKeys( axisModel );
        axisKeys.reset = resetPosition;
    }
    function resetPosition(): Void model =  DualQuaternion.zero;
    function glSettings(){
        DEPTH_TEST = false;
        BACK       = false;
        darkBackground();
    }
    function createPen() {
        pen = Pen.create( verts, cols );
        Trilateral.transformMatrix = scaleToGL();
    }
    function shaderAssign(){
        var vertexShader = '';
        var fragmentShader = '';
        switch( shaderTest ){
            case WithColor:
                vertexShader = Shaders.vertexColor;
                fragmentShader = Shaders.fragmentColor;
            case WithTexture:
                vertexShader = Shaders.vertexTexture;
                fragmentShader = Shaders.fragmentTexture;
        }
        setupProgram( vertexShader, fragmentShader );
    }
    function loadImages( onLoaded: Void->Void ){
        imageLoader = new ImageLoader( [], onLoaded );
        imageLoader.loadEncoded( [ HaxeLogo.gif ],[ 'haxelogo' ] );
    }
    function loaded(){
        var haxeLogo: Image = cast( imageLoader.images.get('haxelogo'), Image );
        addImage( haxeLogo );
        drawShapes();
        textPos.fromPosition( verts );
        //transformVerticesToGL();
        transformTexturePos();
        uploadVectors();
        setAnimate();
    }
    /*
    // transforms used in trilateral one test of textures 
    // here for thought.. reference.
    vx = tri.ax*scale + -1.0;
    vy = -1.0 * tri.ay*scale + 1.0;
    tx = tri.ax*scale  + -0.5;
    ty = tri.ay*scale + -0.5;
    */
    function transformVerticesToGL() verts.transformAll( scaleToGL() );
    
    function scaleToGL(){
        scale = 1/(stageRadius);
        var v = new Matrix1x4( { x: scale, y: -scale, z: scale, w: 1. } );
        return ( Matrix4x3.unit.translateXYZ( -1., 1., 0. ) ).scaleByVector( v );
    }
    function transformTexturePos() textPos.transformAll( scaleTexture() );
    // currently not mapping texture properly
    function scaleTexture(){
        scale = 1/(stageRadius);
        var v = new Matrix1x4( { x: scale*2, y: scale*2, z: 1., w: 1. } );
        return Matrix4x3.translationXYZ( .5, .5, 0. ).scaleByVector( v );
    }
    function uploadVectors(){
        vertices =  cast verts.getArray();
        colors   =  cast cols.getArray();
        var texs = cast textPos.getArray();
        indices  =  createIndices();
        clearTriangles();
        gl.passIndicesToShader( indices );
        switch( shaderTest ){
            case WithColor:
                gl.uploadDataToBuffers( program, vertices, colors );
            case WithTexture:
                gl.uploadDataToBuffers( program, vertices, colors, texs );
        }
    }
    function createIndices(): UInt16Array{
        ind.pos = 0;
        for( i in 0...verts.size ) {
            ind[ 0 ] = i *3 + 0;
            ind[ 1 ] = i *3 + 1;
            ind[ 2 ] = i *3 + 2; 
            ind.next();
        }
        var arr = ind.getArray();
        return cast arr;
    }
    function darkBackground(){
        var dark = 0x18/256;
        bgRed   = dark;
        bgGreen = dark;
        bgBlue  = dark;
    }
    // example of showing flat array data and of the matrix data.
    public function traceFlatData(){
        trace( toDimensionsGL.pretty(5) );
        trace( verts.getArray() );
        trace( cols.hexAll() );
    }
    function drawShapes(){
        var layoutPos     = new LayoutPos( stageRadius );
        pen.currentColor = 0xff663300;//0xF096FBF3;
        uvQuad( 50., 50., stageRadius, stageRadius );
        //if( backgroundSquare ) new GreenBackground( pen, layoutPos );
        if( backgroundSquare ) new BorderRed(       pen, layoutPos );
        //gridLines( 10, 0x0396FBF3, 0xF096FBF3 );
        var gridLines = new GridLines( pen, stageRadius );
        gridLines.draw( 10, 0x0396FB00, 0xF096FBF3 );
        
        // Bird no longer works suspect out of range may need to transform slightly.
        //new GoldBirdFill(                           pen, layoutPos );
        //new OrangeBirdOutline(                      pen, layoutPos );
        new GreenSquare(                            pen, layoutPos );
        new OrangeDavidStar(                        pen, layoutPos );
        new IndigoCircle(                           pen, layoutPos );
        new VioletRoundedRectangle(                 pen, layoutPos );
        new YellowDiamond(                          pen, layoutPos );
        new MidGreySquareOutline(                   pen, layoutPos );
        new BlueRectangle(                          pen, layoutPos );
        new RedRoundedRectangleOutline(             pen, layoutPos );
        //new FillPoly2Trihx(                         pen, layoutPos );
        //new OutlinePoly2Trihx(                      pen, layoutPos );
        new QuadCurveTest(                          pen, layoutPos );
        new CubicCurveTest(                         pen, layoutPos );
    }
    function uvQuad( x: Float, y: Float, wid: Float, hi: Float ){
        var bx = x;
        var by = y;
        var ex = x + wid;
        var ey = y + hi;
        // Apparently textures are layed out with y+ , fill anti clockwise?
        /*
         d: 0,1   c: 1,1
         a: 0,0   b: 1,0
        */
        var a = { x: bx, y: by };
        var b = { x: ex, y: by };
        var c = { x: ex, y: ey };
        var d = { x: bx, y: ey };
        // Triangles experimenting with ordering, no success.
        /*
         3
         1  2
        */
        pen.triangle2DFill( a.x, a.y
                          , b.x, b.y
                          , d.x, d.y );
        /*
         2 3
           1
        */
        pen.triangle2DFill( b.x, b.y
                          , d.x, d.y
                          , c.x, c.y
                          );
                          
    }
    inline
    function clearTriangles(){
        verts = new Float32FlatTriangle(1000000);
        cols  = new Float32FlatRGBA(1000000);
    }
    inline
    function render_( i: Int ):Void{        
        model  = axisModel.updateCalculate( model );
        var trans: Matrix4x3 = (  offset * model ).normalize();
        ( Projection.perspective() * trans ).updateWebGL( untyped matrix32Array );
        render();
    }
    inline
    function setAnimate(){
        AnimateTimer.create();
        AnimateTimer.onFrame = render_;
    }
    inline
    public static 
    function getOffset(): DualQuaternion {
        var qReal = Quaternion.zRotate( 0 );
        var qDual = new Matrix1x4( { x: 0., y: 0., z: -1., w: 1. } );
        return DualQuaternion.create( qReal, qDual );
    }
    final offset = getOffset();
}
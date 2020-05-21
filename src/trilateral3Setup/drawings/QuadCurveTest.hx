package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Color pallettes
import pallette.QuickARGB;
// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;
// Sketching
import trilateral3.drawing.EndLineCurve;
import trilateral3.drawing.Sketch;
import trilateral3.drawing.SketchForm;
import trilateral3.drawing.Fill;
// SVG paths
import trilateral3Setup.helpers.PathTests; // quadtest_d

class QuadCurveTest extends DrawingLayout{
    override public function draw(){
        pen.currentColor = Blue;
        var sketch = new Sketch( pen, SketchForm.Fine, EndLineCurve.both );
        sketch.width = 2;
        // function to adjust witdth of curve along length
        sketch.widthFunction = function( width: Float, x: Float, y: Float, x_: Float, y_: Float ): Float{
            return width+0.008*2;
        }
        var translateContext = new TranslationContext( sketch, -100, 300 );
        var p = new SvgPath( translateContext );
        p.parse( quadtest_d );
    }
}
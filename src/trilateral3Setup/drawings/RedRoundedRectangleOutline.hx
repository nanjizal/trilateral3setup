package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class RedRoundedRectangleOutline extends DrawingLayout{
    override public function draw(){
        var len = roundedRectangleOutline( pen.drawType
                                    , topLeft.x - size
                                    ,( topLeft.y + bottomLeft.y )/2 - size/2
                                    , size*2, size,  6, 30 );
        pen.colorTriangles( Red, len );
    }
}
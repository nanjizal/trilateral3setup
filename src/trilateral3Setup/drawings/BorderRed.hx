package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class BorderRed extends DrawingLayout{
    override public function draw(){
        var len = squareOutline( pen.drawType
                            , centre.x, centre.y, 600, 20 );
        pen.colorTriangles( Red, len );
    }
}
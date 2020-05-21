package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class MidGreySquareOutline extends DrawingLayout{
    override public function draw(){
        var len = squareOutline( pen.drawType
                            , ( bottomRight.x + centre.x )/2
                            , ( bottomRight.y + centre.y )/2, 0.7*size, 6 );
        pen.colorTriangles( Red, len );
    }
}
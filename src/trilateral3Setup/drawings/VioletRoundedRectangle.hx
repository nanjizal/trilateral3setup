package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class VioletRoundedRectangle extends DrawingLayout{
    override public function draw(){
        var len = roundedRectangle( pen.drawType
                                         , topLeft.x - size
                                         ,( topLeft.y + bottomLeft.y )/2 - size/2, size*2
                                         , size, 30 );
        pen.colorTriangles( Violet, len );
    }
}

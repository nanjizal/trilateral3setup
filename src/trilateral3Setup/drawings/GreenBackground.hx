package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class GreenBackground extends DrawingLayout{
    override public function draw(){
        var len = square( pen.drawType
                            , centre.x
                            , centre.y,  600 );
        pen.colorTriangles( Green, len );
    }
}
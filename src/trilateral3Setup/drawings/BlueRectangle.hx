package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class BlueRectangle extends DrawingLayout{
    override public function draw(){
        var len = rectangle( pen.drawType
                              , centre.x - 100, centre.y - 50
                              , size*2, size );
        pen.colorTriangles( Blue, len );
    }
}
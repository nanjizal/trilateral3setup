package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class IndigoCircle extends DrawingLayout{
    override public function draw(){
        var len = circle( pen.drawType
                   , ( topRight.x + centre.x )/2, ( topRight.y + centre.y )/2
                   ,  size);
        pen.colorTriangles( Indigo, len );
    }
}


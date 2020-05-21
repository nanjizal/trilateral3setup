package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class OrangeDavidStar extends DrawingLayout{
    override public function draw(){
        var len = overlapStar( pen.drawType
                                    , ( bottomLeft.x + centre.x )/2
                                    , ( bottomLeft.y + centre.y )/2, size  );
        pen.colorTriangles( Orange, len );
    }
}

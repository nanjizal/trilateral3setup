package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Shaper for drawing shapes
import trilateral3.shape.Shaper;
// Color pallettes
import pallette.QuickARGB;
class YellowDiamond extends DrawingLayout{
    override public function draw(){
        var len = diamond( pen.drawType
                                , ( topLeft.x + centre.x )/2
                                , ( topLeft.y + centre.y )/2
                                , 0.7*size );
        pen.colorTriangles( Yellow, len );
    }
}
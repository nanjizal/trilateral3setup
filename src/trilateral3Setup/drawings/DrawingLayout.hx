package trilateral3Setup.drawings;
import trilateral3Setup.helpers.LayoutPos;
import trilateral3.drawing.Pen;
import geom.matrix.Matrix1x2;
class DrawingLayout{
    var size = 80;
    var len = 0;
    var centre:                 Matrix1x2;
    var bottomLeft:             Matrix1x2;
    var bottomRight:            Matrix1x2;
    var topLeft:                Matrix1x2;
    var topRight:               Matrix1x2;
    var quarter:                Float;
    var pen:                    Pen;
    public function new( pen: Pen, layoutPos: LayoutPos ){
        this.pen             = pen;
        centre          = layoutPos.centre;
        quarter         = layoutPos.quarter;
        bottomLeft      = layoutPos.bottomLeft;
        bottomRight     = layoutPos.bottomRight;
        topLeft         = layoutPos.topLeft;
        topRight        = layoutPos.topRight;
        draw();
    }
    public function draw(){
        // override with draw functionality.
    }
}

package trilateral3Setup.helpers;

import geom.matrix.Matrix1x2;
class LayoutPos{
    public var centre:                 Matrix1x2;
    public var bottomLeft:             Matrix1x2;
    public var bottomRight:            Matrix1x2;
    public var topLeft:                Matrix1x2;
    public var topRight:               Matrix1x2;
    public var quarter:                Float;
    var stageRadius:            Float;
    public function new( stageRadius_: Float ){
        stageRadius = stageRadius_;
        layoutParameters();
    }
    inline public
    function layoutParameters(){
        centre          = { x: stageRadius, y: stageRadius };
        quarter         = stageRadius/2;
        bottomLeft      = { x: stageRadius - quarter, y: stageRadius + quarter };
        bottomRight     = { x: stageRadius + quarter, y: stageRadius + quarter };
        topLeft         = { x: stageRadius - quarter, y: stageRadius - quarter };
        topRight        = { x: stageRadius + quarter, y: stageRadius - quarter };
    }
}
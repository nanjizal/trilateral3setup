package trilateral3Setup.drawings;
import trilateral3.drawing.Pen;
import trilateral3.drawing.Contour;
import trilateral3.drawing.EndLineCurve;
import trilateral3.drawing.Sketch;
import trilateral3.drawing.SketchForm;
class GridLines {
    var pen: Pen;
    var stageRadius: Int;
    public
    function new( pen: Pen, stageRadius: Int ){
        this.pen         = pen;
        this.stageRadius = stageRadius;
    }
    public
    function draw( spacing: Float, colorA: Int, colorB: Int ){
        var gap = 15;
        var len = Math.ceil((stageRadius*2 - 2*gap )/spacing);
        pen.currentColor = colorB;
        var sketch = new Sketch( pen, SketchForm.Crude, EndLineCurve.both );
        sketch.width = spacing/4;
        var delta = 0.;
        sketch.moveTo( 0, 0 );
        for( i in 1...len ){
            var delta = i*spacing;
            if( i % 10 == 0  ) {
                pen.currentColor = colorA;
            } else {
                pen.currentColor = colorB;
            }
            sketch.moveTo( gap, delta + gap );
            sketch.lineTo( stageRadius*2 - gap, delta + gap );
            sketch.moveTo( delta + gap, gap );
            sketch.lineTo( delta + gap, stageRadius*2 - gap );
        }
    }
}
package trilateral3Setup.drawings;
import trilateral3Setup.drawings.DrawingLayout;
// Color pallettes
import pallette.QuickARGB;
// SVG path parser
import justPath.*;
import justPath.transform.ScaleContext;
import justPath.transform.ScaleTranslateContext;
import justPath.transform.TranslationContext;
// Sketching
import trilateral3.drawing.EndLineCurve;
import trilateral3.drawing.Sketch;
import trilateral3.drawing.SketchForm;
import trilateral3.drawing.Fill;
// SVG paths
import trilateral3Setup.helpers.PathTests; // poly2trihxText

class OutlinePoly2Trihx extends DrawingLayout{
    override public function draw(){
        pen.currentColor = 0xff0000ff;
        var sketch = new Sketch( pen, SketchForm.Fine, EndLineCurve.both );
        sketch.width = 2;
        var scaleContent = new ScaleTranslateContext( sketch, 0, 0, 1.5, 1.5 );
        var p = new SvgPath( scaleContent );
        p.parse( poly2trihxText );
    }
}


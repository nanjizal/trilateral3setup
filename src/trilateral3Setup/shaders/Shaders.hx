package trilateral3Setup.shaders;
// Generic triangle drawing Shaders
class Shaders{
    public static inline var vertexColor: String =
        'attribute vec3 pos;' +
        'attribute vec4 color;' +
        'varying vec4 vcol;' +
        'uniform mat4 modelViewProjection;' +
        'void main(void) {' +
            ' gl_Position = modelViewProjection * vec4(pos, 1.);' +
            ' vcol = color;' +
        '}';
    public static inline var fragmentColor: String =
        'precision mediump float;'+
        'varying vec4 vcol;' +
        'void main(void) {' +
            ' gl_FragColor = vcol;' +
        '}';
    public static inline var vertexTexture: String =
        'attribute vec3 pos;' +
        'attribute vec4 color;' +
        'varying vec4 vcol;' +
        'attribute vec2 aTexture;' +
        'varying vec2 texture;' +
        'uniform mat4 modelViewProjection;' +
        'void main(void) {' + 
            ' gl_Position = modelViewProjection * vec4( pos, 1.0);' +
            ' texture = vec2( aTexture.x , 1.-aTexture.y );' +
            ' vcol = color;' +
        '}';

    public static inline var fragmentTexture: String =
        'precision mediump float;' +
        'uniform sampler2D image;' +
        'varying vec2 texture;' +
        'varying vec4 vcol;' +
        'void main(void) {' +
            'float bound =   step( texture.s, 1. ) *' +
                            'step( texture.t, 1. ) *' +
                            ' ( 1. - step( texture.s, 0. ) ) * '+
                            ' ( 1. - step( texture.t, 0. ) );'+
            'gl_FragColor = texture2D( image, vec2( texture.s, texture.t ) );'+
        '}'; 
}
package trilateral3Setup.helpers;

import htmlHelper.tools.CharacterInput;
import geom.move.Axis3;
import geom.move.Trinary;

class AxisKeys {
    var axisModel: Axis3;
    var characterInput: CharacterInput;
    public var reset: Void->Void;
    public function new( axisModel_: Axis3 ){
        axisModel = axisModel_;
        setInputs();
    }
    inline
    function setInputs(){
        characterInput = new CharacterInput();
        characterInput.commandSignal = commandDown;
        characterInput.navSignal     = navDown;
        characterInput.letterSignal  = letterDown;
    }
    inline
    function commandDown(){
        if( characterInput.cmdDown ){            axisModel.roll( positive );
        } else if( characterInput.altDown ){     axisModel.roll( negative  );
        } else {                                 axisModel.roll( zero );
        }
        if( characterInput.tabDown ) {           axisModel.alongY( negative  );
        } else if( characterInput.shiftDown ){   axisModel.alongY( positive );
        } else {                                 axisModel.alongY( zero );
        }
        if( characterInput.spaceDown ) {         axisModel.alongX( negative );
        } else if( characterInput.controlDown ){ axisModel.alongX( positive );
        } else {                                 axisModel.alongX( zero );
        }
        if( characterInput.deleteDown ) {        axisModel.alongZ( negative );
        } else if( characterInput.enterDown ){   axisModel.alongZ( positive );
        } else {                                 axisModel.alongZ( zero );
        }
        trace( characterInput.commandDown() );
    }
    inline
    function navDown(){
        trace( characterInput.navDown() );
        if( characterInput.leftDown ) {         axisModel.yaw( negative );
        } else if( characterInput.rightDown ){  axisModel.yaw( positive );
        } else {                                axisModel.yaw( zero );
        }
        if( characterInput.upDown ) {           axisModel.pitch( negative );
        } else if( characterInput.downDown ){   axisModel.pitch( positive );
        } else {                                axisModel.pitch( zero );
        }
    }
    inline
    function letterDown( letter: String ){
        if( letter == 'r' || letter == 'p' ){
            axisModel.reset();
            trace( 'reset' );
            if( reset != null ) reset();
        }
        /*
        if( letter == 'q' ){                    quatAxis.along( positive );
        } else if( letter == 'a' ){             quatAxis.alongX( negative );
        } else {                                quatAxis.alongX( zero );
        }
        */
        //trace( 'letter pressed ' + letter );
    }
}
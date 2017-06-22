/**
 * Created by Igor on 20/06/2017.
 */
package view.components
{
    import flash.display.StageAlign;

    import starling.animation.Tween;
    import starling.core.Starling;
    import starling.core.Starling;
    import starling.display.Image;

    import view.Game;

    import view.View;

    public class Hand extends View
    {
        private var handRock:Image;
        private var handPaper:Image;
        private var handScissor:Image;

        private var _state:int = -1;

        public static const DEFAULT_STATE:int = 0 ;
        public static const ROCK_STATE:int = 0 ;
        public static const PAPER_STATE:int = 1 ;
        public static const SCISSOR_STATE:int = 2 ;

        public var onDecisionShow:Function;

        private var _lastDecision:int;

        public var defaultY:int;
        public function Hand()
        {
            handRock = new Image(Game.assets.getTexture("handrock"));
            handPaper = new Image(Game.assets.getTexture("handpaper"));
            handScissor = new Image(Game.assets.getTexture("handscissor"));

            addChild(handRock);
            addChild(handPaper);
            addChild(handScissor);

            reset();

        }

        public function get state():int
        {
            return _state;
        }

        public function set state( value:int ):void
        {
            _state = value;

            handRock.visible = handPaper.visible = handScissor.visible =  false;

            switch (_state)
            {
                case DEFAULT_STATE:
                case ROCK_STATE:
                    handRock.visible = true;
                    break;
                case PAPER_STATE:
                    handPaper.visible = true;
                    break;
                case SCISSOR_STATE:
                    handScissor.visible = true;
                    break;
                default:
                        throw  new Error("UNKNOWN TYPE: " + _state);
                    break;
            }
        }

        public function reset():void
        {
            state = DEFAULT_STATE;
        }

        public function startChoice(decision:int):void
        {
            _lastDecision = decision;
            Starling.juggler.tween(this,0.5,{y:this.y-30,repeatCount:3,onComplete:showCoice});
        }

        private function showCoice():void
        {
            this.y = defaultY;
            state = _lastDecision;
            trace("SHOW CHOICE: " +  this.lastDecision);
            Starling.juggler.delayCall(onDecisionShow,1);
        }

        public function get lastDecision():int
        {
            return _lastDecision;
        }
    }
}

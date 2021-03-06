/**
 * Created by Igor on 20/06/2017.
 */
package view
{
    import controller.GameController;
    import controller.IAcontroller;
    import controller.ResultController;
    import embed.EmbeddedAssets;
    import flash.display.StageAlign;
    import model.Session;
    import model.Session;
    import starling.core.Starling;
    import starling.display.Image;
    import view.components.Hand;
    import view.components.MenuButton;
    import view.components.TextView;

    public class SessionView extends View
    {
        private var handLeft:Hand;
        private var handRight:Hand;
        private var labelLeft:TextView;
        private var labelRight:TextView;
        private var gameStats:TextView;
        private var timeRoshambo:TextView;
        private var session:Session;
        private var btRock:MenuButton;
        private var btPaper:MenuButton;
        private var btScissor:MenuButton;
        private var countTime:int = 0;
        private var lastDecision:int = -1;
        private var countDecisions:int = 0;

        public function SessionView(session:Session)
        {
            this.session = session;

            addChild(new Image(Game.assets.getTexture("backgroundGame")));

            gameStats = new TextView(400,80,"",EmbeddedAssets.VIDEO_PHREAK,30,0xfffffff);
            gameStats.y = 70;
            gameStats.x = session.sessionType == Session.COMPUTER_VS_COMPUTER ? 120: 190;
            timeRoshambo = new TextView(400,80,"",EmbeddedAssets.VIDEO_PHREAK,60,0xfffffff);
            timeRoshambo.y = 20;
            timeRoshambo.x = session.sessionType == Session.COMPUTER_VS_COMPUTER ? 110 : 180;
            handLeft = new Hand();
            handRight = new Hand();

            handLeft.scaleX = -1;
            handLeft.x = 175;
            handRight.x = 420;
            handLeft.y = handRight.y = handLeft.defaultY = handRight.defaultY = 300;


            labelLeft = new TextView(100,80,"0",EmbeddedAssets.VIDEO_PHREAK,50,0xfffffff);
            labelLeft.y = 220;
            labelLeft.x = 50;
            labelRight = new TextView(100,80,"0",EmbeddedAssets.VIDEO_PHREAK,50,0xfffffff);
            labelRight.y = 220;
            labelRight.x = 440;

            addChild(gameStats);
            addChild(timeRoshambo);
            addChild(handLeft);
            addChild(handRight);
            addChild(labelLeft);
            addChild(labelRight);

            if(session.sessionType == Session.PLAYER_VS_COMPUTER)
            {
                btRock = new MenuButton( Game.assets.getTexture( "btgreen" ), "ROCK" );
                btPaper = new MenuButton( Game.assets.getTexture( "btgreen" ), "PAPER" );
                btScissor = new MenuButton( Game.assets.getTexture( "btgreen" ), "SCISSOR" );
                btRock.x = btPaper.x = btScissor.x = 10;
                btRock.y = 20;
                btPaper.y = 90;
                btScissor.y = 160;
                btRock.scale = btPaper.scale = btScissor.scale = 0.8;
                btRock.onTouch = makeChoice;
                btPaper.onTouch = makeChoice;
                btScissor.onTouch = makeChoice;

                addChild( btRock );
                addChild( btPaper );
                addChild( btScissor );
            }

            handRight.onDecisionShow = handLeft.onDecisionShow = onDecisions;

        }

        public function id():int
        {
            return session.id;
        }

        private function makeChoice(bt:MenuButton):void
        {
            enablePlayerButtons(false);

            handLeft.reset();
            handRight.reset();

            gameStats.text = "";
            countDecisions = 0;
            var decision:int = -1;

            switch(bt)
            {
                case btRock:
                    decision = GameController.ROCK;
                    break;
                case btScissor:
                    decision = GameController.SCISSOR;
                    break;
                case btPaper:
                    decision = GameController.PAPER;
                    break;
                default:
                        throw new Error("Decision Error: " + decision);
                    break;
            }

            GameController.ME.updateSessionDecision(decision,session.id);
        }


        private function computerDecision()
        {
            handLeft.reset();
            handRight.reset();
            gameStats.text = "";
            countDecisions = 0;
            GameController.ME.updateSessionDecision(-1,session.id);
        }

        private function applyDecision():void
        {
            if(session.finished) return;

            if(session.sessionType == Session.COMPUTER_VS_COMPUTER)
                Starling.juggler.delayCall(computerDecision,1);
            else if(session.sessionType == Session.PLAYER_VS_COMPUTER)
                enablePlayerButtons(true);
        }

        public function updateGame():void
        {
            if(session.sessionType == Session.PLAYER_VS_COMPUTER)
                gameStats.text = "Player select your choice";
            else if(session.sessionType == Session.COMPUTER_VS_COMPUTER)
            {
                gameStats.text = "Computer on choices";
                applyDecision();
            }
            else
                throw new Error("TURN ERROR" +  session.id +  " | " + session.sessionType);
        }


        public function executeDecision(decision:int):void
        {
            if(session.finished) return;

            lastDecision = decision;
            countTime = 3;
            initTime();

        }


        private function initTime():void
        {
            timeRoshambo.text = countTime.toString();
            Starling.juggler.delayCall(updateTime,1);
        }

        private function updateTime():void
        {
            countTime--;
            timeRoshambo.text = countTime.toString();

            if(countTime==0)
            {
                timeRoshambo.text = "ROSHAMBO";
                Starling.juggler.delayCall(showDecision,1);
            }
            else {initTime();}
        }

        private function showDecision():void
        {
            handLeft.startChoice(session.sessionType == Session.PLAYER_VS_COMPUTER ?  lastDecision : IAcontroller.ME.getDecision());
            handRight.startChoice(IAcontroller.ME.getDecision());
        }

        private function onDecisions():void
        {
            countDecisions++;
            if(countDecisions==2)
                GameController.ME.checkWinnerRound(handLeft.lastDecision, handRight.lastDecision, session.id);
        }

        public function updateWinnerRound(resultRound:int):void
        {
            switch(resultRound)
            {
                case ResultController.LEFT_WIN:
                    gameStats.text = "LEFT SCORES";
                    session.updatePoints(true);
                    labelLeft.text = session.leftPoints.toString();
                    break;
                case ResultController.RIGHT_WIN:
                    gameStats.text = "RIGHT SCORES";
                    session.updatePoints(false);
                    labelRight.text = session.rightPoints.toString();
                    break;
                case ResultController.DRAW_GAME:
                    gameStats.text = "DRAW";
                    break;
                default:
                        throw  new Error("Decision Error: " +  resultRound);
                    break;

            }

            if(ResultController.ME.onWinner(getPoints()))
                GameController.ME.endSession(session.id);
            else
                applyDecision();
        }

        public function getPoints():Vector.<int>
        {
            var vt:Vector.<int> = new Vector.<int>();
            vt.push(session.leftPoints);
            vt.push(session.rightPoints);
            return vt;
        }

        public function endSession():void
        {
            session.finish();

            if(session.leftPoints==3)
                gameStats.text = "LEFT WINS";
            else if(session.rightPoints==3)
                gameStats.text = "RIGHT WINS";
            else
                throw new Error("END SESSION ERROR: " +  session.id +  " | " + session.leftPoints +  " | " + session.rightPoints);

            if(session.sessionType == Session.PLAYER_VS_COMPUTER) enablePlayerButtons(false);
        }

        private function enablePlayerButtons(enable:Boolean):void
        {
            btPaper.touchable =  btRock.touchable = btScissor.touchable = enable;
            btPaper.alpha =  btRock.alpha = btScissor.alpha = enable ? 1 : 0.5;
        }


    }
}

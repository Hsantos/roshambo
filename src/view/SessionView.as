/**
 * Created by Igor on 20/06/2017.
 */
package view
{
    import controller.GameController;
    import controller.IAcontroller;
    import controller.ResultController;

    import embed.EmbeddedAssets;

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
            trace("NEW SESSION CREATED");

            addChild(new Image(Game.assets.getTexture("backgroundGame")));

            gameStats = new TextView(400,80,"",EmbeddedAssets.VIDEO_PHREAK,30,0xfffffff);
            addChild(gameStats);
            gameStats.y = 50;
            gameStats.x = 200;

            timeRoshambo = new TextView(400,80,"0",EmbeddedAssets.VIDEO_PHREAK,60,0xfffffff);
            addChild(timeRoshambo);
            timeRoshambo.y = 30;
            timeRoshambo.x = 230;

            handLeft = new Hand();
            handRight = new Hand();

            handLeft.scaleX = -1;

            addChild(handLeft);
            addChild(handRight);

            handLeft.x = 150;
            handRight.x = 420;
            handLeft.y = handRight.y = 290;


            labelLeft = new TextView(100,80,"0",EmbeddedAssets.VIDEO_PHREAK,60,0xfffffff);
            addChild(labelLeft);
            labelLeft.y = 300;
            labelLeft.x = 20;

            labelRight = new TextView(100,80,"0",EmbeddedAssets.VIDEO_PHREAK,60,0xfffffff);
            addChild(labelRight);
            labelRight.y = 300;
            labelRight.x = 400;


            if(session.sessionType == Session.PLAYER_VS_COMPUTER)
            {
                btRock = new MenuButton( Game.assets.getTexture( "btgreen" ), "ROCK" );
                btPaper = new MenuButton( Game.assets.getTexture( "btgreen" ), "PAPER" );
                btScissor = new MenuButton( Game.assets.getTexture( "btgreen" ), "SCISSOR" );

                btRock.x = btPaper.x = btScissor.x = 10;

                btRock.y = 30;
                btPaper.y = 120;
                btScissor.y = 210;

                addChild( btRock );
                addChild( btPaper );
                addChild( btScissor );

                btRock.onTouch = makeChoice;
                btPaper.onTouch = makeChoice;
                btScissor.onTouch = makeChoice;
            }

            handRight.onDecisionShow = handLeft.onDecisionShow = onDecisions;

        }

        public function id():int
        {
            return session.id;
        }

        private function makeChoice(bt:MenuButton):void
        {
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


        public function updateGame():void
        {
            if(session.sessionType == Session.PLAYER_VS_COMPUTER)
            {
                gameStats.text = "Player select your choice";
            }
            else if(session.sessionType == Session.COMPUTER_VS_COMPUTER)
            {
                gameStats.text = "Computer om choices";
            }
            else
            {
                throw new Error("TURN ERROR" +  session.id +  " | " + session.sessionType);
            }
        }


        public function executeDecision(decision:int):void
        {
            lastDecision = decision;
            countTime = 3;
            disableButtons();
            initTime();

        }

        private function disableButtons():void
        {

        }

        private function initTime():void
        {
            Starling.juggler.delayCall(updateTime,1);
        }

        private function updateTime():void
        {
            timeRoshambo.text = countTime.toString();
            countTime--;

            if(countTime==0)
            {
                timeRoshambo.text = "ROSHAMBO";
                Starling.juggler.delayCall(showDecision,1);
            }
            else {initTime();}
        }

        private function showDecision()
        {
            trace("show decision");
            handLeft.startChoice(session.sessionType == Session.PLAYER_VS_COMPUTER ?  lastDecision : IAcontroller.ME.getDecision());
            handRight.startChoice(IAcontroller.ME.getDecision());


        }

        private function onDecisions():void
        {
            countDecisions++;
            if(countDecisions==2)
            {
                GameController.ME.checkWinnerRound(handLeft.lastDecision, handRight.lastDecision, session.id);
            }
        }


        public function updateWinnerRound(resultRound:int):void
        {
            switch(resultRound)
            {
                case ResultController.LEFT_WIN:
                    gameStats.text = "Left Point";
                    session.updatePoints(true);
                    labelLeft.text = session.leftPoints.toString();
                    break;
                case ResultController.RIGHT_WIN:
                    gameStats.text = "Right Point";
                    session.updatePoints(false);
                    labelRight.text = session.leftPoints.toString();
                    break;
                case ResultController.DRAW_GAME:
                    gameStats.text = "Draw Round";

                    break;
                default:
                        throw  new Error("Decision Error");
                    break;

            }


        }


    }
}

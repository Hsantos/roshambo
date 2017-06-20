/**
 * Created by Igor on 20/06/2017.
 */
package view
{
    import controller.GameController;
    import controller.IAcontroller;

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
        private var gameStats:TextView;
        private var timeRoshambo:TextView;
        private var session:Session;

        private var btRock:MenuButton;
        private var btPaper:MenuButton;
        private var btScissor:MenuButton;
        private var countTime:int = 0;

        private var lastDecision:int = -1;
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
            timeRoshambo.y = 50;
            timeRoshambo.x = 250;

            handLeft = new Hand();
            handRight = new Hand();

            handLeft.scaleX = -1;

            addChild(handLeft);
            addChild(handRight);

            handLeft.x = 150;
            handRight.x = 420;
            handLeft.y = handRight.y = 290;


            if(session.sessionType == Session.PLAYER_VS_COMPUTER)
            {
                btRock = new MenuButton( Game.assets.getTexture( "btgreen" ), "ROCK" );
                btPaper = new MenuButton( Game.assets.getTexture( "btgreen" ), "PAPER" );
                btScissor = new MenuButton( Game.assets.getTexture( "btgreen" ), "SCISSOR" );

                btRock.x = btPaper.x = btScissor.x = 20;

                btRock.y = 50;
                btPaper.y = 160;
                btScissor.y = 270;

                addChild( btRock );
                addChild( btPaper );
                addChild( btScissor );

                btRock.onTouch = makeChoice;
                btPaper.onTouch = makeChoice;
                btScissor.onTouch = makeChoice;
            }

        }

        public function id():int
        {
            return session.id;
        }

        private function makeChoice(bt:MenuButton):void
        {
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


    }
}

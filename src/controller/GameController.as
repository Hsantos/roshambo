/**
 * Created by Igor on 14/06/2017.
 */
package controller
{
    import model.Session;

    import starling.core.Starling;

    import view.GameView;

    public class GameController extends ViewController
    {
        public static const ROCK:int = 0;
        public static const PAPER:int = 1;
        public static const SCISSOR:int = 2;

        public static var ME:GameController = new GameController();

        private var countSessions:int = 0;
        public function GameController()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }

        public function startSession(sessionType:int):void
        {
            var session:Session = new Session(sessionType,countSessions);
            GameView(view).startSession(session);
            countSessions++;
        }

        public function updateSessionDecision(decision:int,sessionId:int):void
        {

        }


        public function checkWinnerRound(decisionLeft:int, decisionRight:int, sessionId:int):void
        {
            //check winner round
            GameView(view).updateWinnerRound(ResultController.ME.getResult(decisionLeft,decisionRight),sessionId);
            Starling.juggler.delayCall(checkWinnerRound,1,sessionId);
        }

        private function checkWinnerSession(sessionId:int):void
        {
            //todo check points for winner or continue round
        }



    }
}

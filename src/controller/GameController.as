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

        private var countSessions:int = 0;

        public static var ME:GameController = new GameController();
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
            GameView(view).updateSessionDecision(decision,sessionId);
        }

        public function checkWinnerRound(decisionLeft:int, decisionRight:int, sessionId:int):void
        {
            GameView(view).updateWinnerRound(ResultController.ME.getResult(decisionLeft,decisionRight),sessionId);
        }

        public function endSession(sessionId:int):void
        {
            GameView(view).endSession(sessionId);
        }



    }
}

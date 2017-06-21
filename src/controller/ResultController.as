/**
 * Created by Igor on 21/06/2017.
 */
package controller
{
    import view.Game;

    public class ResultController
    {
        public static var ME:ResultController = new ResultController();

        public static const LEFT_WIN:int = 0;
        public static const RIGHT_WIN:int = 1;
        public static const DRAW_GAME:int = 2;
        public function ResultController()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }

        public function getResult(resultLeft:int, resultRight:int):int
        {
            if(resultLeft == resultRight) return DRAW_GAME;

            if(resultLeft == GameController.ROCK && resultLeft == GameController.PAPER) return RIGHT_WIN;
            if(resultLeft == GameController.SCISSOR && resultLeft == GameController.ROCK) return RIGHT_WIN;
            if(resultLeft == GameController.PAPER && resultLeft == GameController.SCISSOR) return RIGHT_WIN;

            if(resultLeft == GameController.ROCK && resultLeft == GameController.SCISSOR) return LEFT_WIN;
            if(resultLeft == GameController.PAPER && resultLeft == GameController.ROCK) return LEFT_WIN;
            if(resultLeft == GameController.SCISSOR && resultLeft == GameController.PAPER) return LEFT_WIN;


        }
    }
}

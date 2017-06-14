/**
 * Created by Igor on 14/06/2017.
 */
package controller
{
    import model.Session;

    public class GameController
    {
        public static const ROCK:int = 0;
        public static const PAPER:int = 1;
        public static const SCISSOR:int = 2;
        private var sessionsList:Vector.<Session>;

        public static var ME:GameController = new GameController();
        public function GameController()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }


        public function startSession(sessionType:int):void
        {
            if(!sessionsList)
                sessionsList = new <Session>[]();


            var session:Session = new Session(sessionType);
            sessionsList.push(session);
        }

        public function showMenu():void
        {
            MenuController.ME
        }
    }
}

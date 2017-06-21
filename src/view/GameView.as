/**
 * Created by Igor on 14/06/2017.
 */
package view
{
    import model.Session;

    import starling.display.Image;

    import view.components.ListView;

    public class GameView extends View
    {
        private var sessionView:SessionView;
        private var listView:ListView;

        public function GameView()
        {
            trace("GAME CREATED");
        }

        public function startSession(session:Session):void
        {
            if(!listView)
            {
                listView = new ListView();
                addChild(listView);
            }

            sessionView = new SessionView(session);
            listView.insert(sessionView);
            sessionView.updateGame();
        }

        public function updateSessionDecision(decision:int,sessionId:int):void
        {
            trace("update decision: " +  decision +  "  |  " +  sessionId );
            SessionView(listView.getView(sessionId)).executeDecision(decision);
        }

        public function updateWinnerRound(resultRound:int, sessionId:int):void
        {
            SessionView(listView.getView(sessionId)).updateWinnerRound(resultRound);
        }
    }
}

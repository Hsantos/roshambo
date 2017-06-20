/**
 * Created by Igor on 20/06/2017.
 */
package view
{
    import starling.display.Image;

    import view.components.Hand;

    public class SessionView extends View
    {
        private var handLeft:Hand;
        private var handRight:Hand;

        public function SessionView()
        {
            trace("NEW SESSION CREATED");

            addChild(new Image(Game.assets.getTexture("backgroundGame")));

            handLeft = new Hand();
            handRight = new Hand();

            addChild(handLeft);
            addChild(handRight);

            handLeft.x = 20;
            handRight.x = 300;

            handLeft.y = handRight.y = 200;
        }
    }
}

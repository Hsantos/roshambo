/**
 * Created by Igor on 14/06/2017.
 */
package view
{
    import controller.GameController;

    import flash.events.TouchEvent;

    import model.Session;

    import starling.display.Image;

    import view.components.MenuButton;

    public class MenuView extends View
    {
        private var buttonPvC:MenuButton;
        private var buttonCvC:MenuButton;

        private var bg:Image;
        public function MenuView()
        {
            trace("MENU CREATED");

            bg = new Image(Game.assets.getTexture("background"));
            addChild(bg);

            buttonPvC = new MenuButton(Game.assets.getTexture("btblue"),"PLAYER VS. COMPUTER");
            buttonCvC = new MenuButton(Game.assets.getTexture("btred"),"COMPUTER VS. COMPUTER");
            addChild(buttonPvC)
            addChild(buttonCvC)
            buttonPvC.x = buttonPvC.y = buttonCvC.y = 40;
            buttonCvC.x = 280;

            buttonPvC.onTouch = createPVCSession;
            buttonCvC.onTouch = createCVCSession;

        }

        public function createPVCSession(bt:MenuButton):void
        {
            trace("Create Player VS. Computer Session");
            GameController.ME.startSession(Session.PLAYER_VS_COMPUTER);
        }

        public function createCVCSession(bt:MenuButton):void
        {
            trace("Create Computer VS. Computer Session");
            GameController.ME.startSession(Session.COMPUTER_VS_COMPUTER);
        }

    }
}

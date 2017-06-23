/**
 * Created by Igor on 14/06/2017.
 */
package view
{
    import controller.GameController;
    import embed.EmbeddedAssets;
    import flash.compiler.embed.EmbeddedMovieClip;
    import flash.events.TouchEvent;
    import model.Session;
    import starling.display.Image;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import view.components.MenuButton;
    import view.components.TextView;

    public class MenuView extends View
    {
        private var buttonPvC:MenuButton;
        private var buttonCvC:MenuButton;
        private var bg:Image;
        private var title:TextView;

        public function MenuView()
        {
            bg = new Image(Game.assets.getTexture("background"));
            title = new TextView(500,80,"ROSHAMBO",EmbeddedAssets.VIDEO_PHREAK,60,0x000000);
            title.x = 260;
            buttonPvC = new MenuButton(Game.assets.getTexture("btblue"),"PLAYER VS. COMPUTER");
            buttonCvC = new MenuButton(Game.assets.getTexture("btred"),"COMPUTER VS. COMPUTER");
            buttonPvC.x = 300;
            buttonCvC.x = 530;
            buttonPvC.y = buttonCvC.y = 90;

            addChild(bg);
            addChild(title);
            addChild(buttonPvC);
            addChild(buttonCvC);


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

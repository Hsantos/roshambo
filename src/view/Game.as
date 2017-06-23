/**
 * Created by Igor on 14/06/2017.
 */
package view
{
    import controller.GameController;
    import controller.MenuController;

    import embed.EmbeddedAssets;

    import flash.compiler.embed.EmbeddedMovieClip;

    import flash.text.Font;

    import starling.display.Sprite;
    import starling.utils.AssetManager;
    import view.MenuView;

    public class Game extends  Sprite
    {
        private static var sAssets:AssetManager;

        public function Game()
        {

        }

        public function start(assets:AssetManager):void
        {
            sAssets = assets;
            var menu:MenuView = new MenuView();
            MenuController.ME.startView(menu);
            var game:GameView = new GameView();

            game.x = 230;
            game.y = 200;
            addChild(menu);

            addChild(game);

            GameController.ME.startView(game);
        }

        public static function get assets():AssetManager { return sAssets; }

    }
}

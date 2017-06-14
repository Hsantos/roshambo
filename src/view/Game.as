/**
 * Created by Igor on 14/06/2017.
 */
package view
{
    import starling.display.Sprite;
    import starling.utils.AssetManager;

    public class Game extends  Sprite
    {
        private static var sAssets:AssetManager;

        public function Game()
        {
        }

        public function start(assets:AssetManager):void
        {
            sAssets = assets;
            //addChild(new Image(assets.getTexture("background")));
            trace("Initialize Starling");
        }
    }
}

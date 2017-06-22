/**
 * Created by Igor on 14/06/2017.
 */
package
{
    import controller.GameController;
    import controller.IAcontroller;

    import embed.EmbeddedAssets;

    import flash.display.Sprite;
    import flash.system.Capabilities;
    import flash.system.System;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.utils.AssetManager;

    import view.Game;
    import view.View;


    [SWF(width="1024", height="768", frameRate="60", backgroundColor="#222222")]
    public class Main extends Sprite
    {
        public static var _starling:Starling;

        public function Main()
        {
            start();
        }

        public function start():void
        {
            trace("Initialize Game");
            _starling = new Starling(Game, stage);
            _starling.simulateMultitouch = true;
            _starling.skipUnchangedFrames = true;
            _starling.enableErrorChecking = Capabilities.isDebugger;
            _starling.addEventListener(Event.ROOT_CREATED, function():void
            {
                loadAssets(startGame);
            });

            _starling.start();

        }

        private function loadAssets(onComplete:Function):void
        {
            var assets:AssetManager = new AssetManager();
            assets.verbose = Capabilities.isDebugger;
            assets.enqueue(EmbeddedAssets);

            assets.loadQueue(function(ratio:Number):void
            {
                if (ratio == 1)
                {
                    // now would be a good time for a clean-up
                    System.pauseForGCIfCollectionImminent(0);
                    System.gc();

                    onComplete(assets);
                }
            });
        }

        private function startGame(assets:AssetManager):void
        {
            var game:Game = _starling.root as Game;
            game.start(assets);
        }

    }
}

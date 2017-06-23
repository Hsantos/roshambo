/**
 * Created by Igor on 20/06/2017.
 */
package view.components
{

    import embed.EmbeddedAssets;

    import starling.display.Button;
    import starling.display.Sprite;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextFormat;
    import starling.textures.Texture;

    public class MenuButton extends Button
    {
        public var onTouch:Function;
        public function MenuButton(texture:Texture, text:String)
        {
           this.addEventListener( TouchEvent.TOUCH, buttonTrigger );
           super(texture, text);

            super.textFormat = new TextFormat(EmbeddedAssets.VIDEO_PHREAK,18,0x000000);
        }

        private function buttonTrigger(evt:TouchEvent):void
        {
            if(onTouch && evt.getTouch((stage)).phase == TouchPhase.ENDED)
                onTouch(this);
        }
    }
}

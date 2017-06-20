/**
 * Created by Igor on 20/06/2017.
 */
package view.components
{
    import starling.display.Image;
    import starling.text.TextField;
    import starling.text.TextFormat;
    import starling.textures.Texture;

    public class TextView extends TextField
    {
        public function TextView(//
                width:int, //
                height:int, //
                text:String, //
                fontName:String = "Verdana", //
                fontSize:Number = 12, //
                color:uint = 0, //
                bold:Boolean = false) //
        {

            super(width, height, text, new TextFormat(fontName,fontSize,color));

        }
    }
}

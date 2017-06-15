/**
 * Created by Igor on 14/06/2017.
 */
package embed
{
    public class EmbeddedAssets
    {

        //TEXTURES
        [Embed(source="../../assets/textures/bg/bgmenu.jpg")]
        public static const background:Class;
        [Embed(source="../../assets/textures/bg/bggame.jpg")]
        public static const backgroundGame:Class;

        [Embed(source="../../assets/textures/hand/handpaper.png")]
        public static const handpaper:Class;
        [Embed(source="../../assets/textures/hand/handrock.png")]
        public static const handrock:Class;
        [Embed(source="../../assets/textures/hand/handscissor.png")]
        public static const handscissor:Class;

        [Embed(source="../../assets/textures/bt/bt_blue.png")]
        public static const btblue:Class;
        [Embed(source="../../assets/textures/bt/bt_green.png")]
        public static const btgreen:Class;
        [Embed(source="../../assets/textures/bt/bt_red.png")]
        public static const btred:Class;


        //FONTS
        [Embed(source="../../assets/fonts/videophreak.ttf", mimeType="application/octet-stream")]
        public static const videophreak_ttf:Class;

    }
}

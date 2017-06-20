/**
 * Created by Igor on 14/06/2017.
 */
package controller
{
    import view.MenuView;
    import view.MenuView;
    import view.View;

    public class MenuController extends ViewController
    {

        public static var ME:ViewController = new ViewController();

        public function MenuController()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }

    }
}

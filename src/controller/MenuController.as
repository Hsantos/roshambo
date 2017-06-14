/**
 * Created by Igor on 14/06/2017.
 */
package controller
{
    import view.MenuView;
    import view.MenuView;
    import view.View;

    public class MenuController
    {
        private var view:MenuView;

        public static var ME:MenuController = new MenuController();
        public function MenuController()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }


        public function showView():View
        {
            return MenuView(view);
        }

    }
}

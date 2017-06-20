/**
 * Created by Igor on 20/06/2017.
 */
package controller
{
    import view.View;

    public class ViewController
    {
        protected var view:View;

        public function startView(view:View):void
        {
            this.view = view;
        }
    }
}

/**
 * Created by Igor on 20/06/2017.
 */
package controller
{
    public class IAcontroller
    {
        public static var ME:IAcontroller = new IAcontroller();

        public function IAcontroller()
        {
            if(ME)throw new Error("Singleton... use getInstance()");
            ME = this;
        }

        private var bucket:Array = [GameController.ROCK,GameController.PAPER,GameController.SCISSOR];
        public function getDecision():int
        {
            return bucket[int(Math.random() * bucket.length)];
        }

    }
}

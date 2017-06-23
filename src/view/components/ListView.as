/**
 * Created by Igor on 20/06/2017.
 */
package view.components
{
    import flash.display.Sprite;

    import starling.events.Touch;

    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    import view.SessionView;

    import view.View;

    public class ListView extends View
    {
        private var count:int = 0;
        private var _posX:int = 0;
        private var objList:Vector.<View>;

        public function ListView()
        {
            this.addEventListener( TouchEvent.TOUCH, buttonTrigger );
        }

        public function get posX():int
        {
            return _posX;
        }

        public function insert(obj:*):void
        {
           if(!objList) objList = new <View>[];

           for(var i:int = 0; i< objList.length; i++)
               objList[i].x += (objList[i].width+10);

           addChild(obj as View); 
           objList.push(obj as View);
           count++;
        }

        public function getView(id:int):View
        {
            for(var i:int = 0; i< objList.length; i++)
                if(SessionView(objList[i]).id() == id) return objList[i];

            return null;
        }

        private var lastX:int;
        private var speed:Number = 15;

        private function buttonTrigger(evt:TouchEvent):void
        {
            var tc:Touch = evt.getTouch(stage);

            if(objList == null)return;
            if(objList.length == 1)return;
            if(tc==null) return;
            if(tc.phase != TouchPhase.MOVED) return;

            if(evt.getTouch(stage).globalX > lastX) this.x+=speed;
            else if(evt.getTouch(stage).globalX < lastX) this.x-=speed;

            lastX = evt.getTouch(stage).globalX;

        }
    }
}

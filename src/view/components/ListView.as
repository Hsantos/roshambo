/**
 * Created by Igor on 20/06/2017.
 */
package view.components
{
    import flash.display.Sprite;

    import view.SessionView;

    import view.View;

    public class ListView extends View
    {
        private var count:int = 0;
        private var _posX:int = 0;
        private var objList:Vector.<View>;

        public function ListView()
        {
        }

        public function get posX():int
        {
            return _posX;
        }

        public function insert(obj:*):void
        {
           if(!objList) objList = new <View>[];

           for(var i:int = 0; i< objList.length; i++)
           {
               objList[i].x += objList[i].width;
           }

           addChild(obj as View); 
           objList.push(obj as View);
           count++;
        }

        public function getView(id:int):View
        {
            for(var i:int = 0; i< objList.length; i++)
            {
                if(SessionView(objList[i]).id() == id) return objList[i];
            }

            return null;
        }
    }
}

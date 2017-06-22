/**
 * Created by Igor on 14/06/2017.
 */
package model
{
    public class Session
    {
        private var _sessionType:int;
        private var _sessionId:int;
        private var _leftPoints:int = 0;
        private var _rightPoints:int = 0;
        public static const PLAYER_VS_COMPUTER:int = 0;
        public static const COMPUTER_VS_COMPUTER:int = 1;


        public function Session(sessionType:int,sessionId:int)
        {
            _sessionType = sessionType;
            _sessionId = sessionId;
        }

        public function get sessionType():int
        {
            return _sessionType;
        }

        public function get id():int
        {
            return _sessionId;
        }

        public function updatePoints(left:Boolean):void
        {
            if(left) _leftPoints++;
            else _rightPoints++;
        }

        public function get rightPoints():int
        {
            return _rightPoints;
        }

        public function get leftPoints():int
        {
            return _leftPoints;
        }
    }
}

package emagin.xml
{
    import emagin.*;
    import emagin.data.*;
    import emagin.xml.events.*;
    import flash.events.*;
    import flash.net.*;

    public class VotePhotoSend extends EventDispatcher
    {
        private var ul:URLLoader;
        private var urv:URLVariables;
        private var ur:URLRequest;

        private var LOGGIN_FORM_URL:String="services/photo_vote.php";

        public function VotePhotoSend(param1:Object)
        {
            ul = new URLLoader();
            ur = new URLRequest();
            urv = new URLVariables();
             
            urv.idphoto = param1.idphoto;
          
            
			ur.method = URLRequestMethod.POST;
            ur.data = urv;
            ur.url = LOGGIN_FORM_URL;
            ul.addEventListener(Event.COMPLETE, onXmlLoaded);
            ul.load(ur);
            trace(this + "Envoi  du fomulaire contact" + urv.nom+" urv.Ref "+urv.Ref);
            return;
        }// end function

        private function onXmlLoaded(event:Event) : void
        {
            var _loc_2:XML = null;
            var _loc_3:Number = NaN;
            var _loc_4:LoadEvent = null;
            var _loc_5:Object = null;
            _loc_2 = new XML(event.target.data);
            _loc_3 = Number(_loc_2.@value);
            _loc_4 = new LoadEvent(LoadEvent.VOTE_RESPONSE);
            _loc_5 = new Object();
            _loc_5.suces = _loc_2.@tag=="true" ?true :false;
			_loc_5.id=_loc_2.@id;
            _loc_5.message = _loc_2;
            _loc_4.load_data = _loc_5;
            dispatchEvent(_loc_4);
			trace(this + " onXmlLoaded " +_loc_2+  "  "+ _loc_2.@tag);
            return;
        }// end function

    }
}

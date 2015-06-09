package emagin.xml
{
    import emagin.*;
    import emagin.data.*;
    import emagin.xml.events.*;
    import flash.events.*;
    import flash.net.*;

    public class UploadFinalFormSend extends EventDispatcher
    {
        private var ul:URLLoader;
        private var urv:URLVariables;
        private var ur:URLRequest;

        private var CONTACT_FORM_URL:String="http://192.168.1.2/Jawla/partagetonexperience/"+"services/upload_video.php";

        public function UploadFinalFormSend(param1:Object)
        {
            ul = new URLLoader();
            ur = new URLRequest();
            urv = new URLVariables();
             
            urv.refupload= param1.refupload;
			urv.village= param1.village;
			urv.iduser= param1.iduser;
            
			
			ur.method = URLRequestMethod.POST;
            ur.data = urv;
            ur.url = CONTACT_FORM_URL;
            ul.addEventListener(Event.COMPLETE, onXmlLoaded);
            ul.load(ur);
            trace(this + "Envoi  du fomulaire contact urv.refupload " + urv.refupload+" urv.village "+urv.village+" urv.iduser "+urv.iduser);
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
            _loc_4 = new LoadEvent(LoadEvent.LOAD_REGISTER);
            _loc_5 = new Object();
            _loc_5.suces = _loc_2.@tag;
            _loc_5.message = _loc_2;
            _loc_4.load_data = _loc_5;
            dispatchEvent(_loc_4);
            return;
        }// end function

    }
}

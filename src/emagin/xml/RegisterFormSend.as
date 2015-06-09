package emagin.xml
{
    import com.serbai.xml.events.LoadEvent;
    
    import emagin.*;
    import emagin.data.*;
    
    
    import flash.events.*;
    import flash.net.*;

    public class RegisterFormSend extends EventDispatcher
    {
        private var ul:URLLoader;
        private var urv:URLVariables;
        private var ur:URLRequest;

        private var CONTACT_FORM_URL:String="services/register.php";

        public function RegisterFormSend(param1:Object)
        {
            ul = new URLLoader();
            ur = new URLRequest();
            urv = new URLVariables();
			urv.idfb=param1.userId;
			 
            urv.nom= param1.nom;
			urv.prenom= param1.prenom
            urv.email = param1.email;
            urv.tel = param1.tel;
            urv.ville = param1.ville;
			urv.sex = param1.sex;
			urv.datenaissance = param1.date;
			
			ur.method = URLRequestMethod.POST;
            ur.data = urv;
            ur.url = CONTACT_FORM_URL;
            ul.addEventListener(Event.COMPLETE, onXmlLoaded);
            ul.load(ur);
            trace(this + "Envoi  du fomulaire contact" + urv.nom+" urv.Ref "+urv.email);
             
        } 

        private function onXmlLoaded(event:Event) : void
        {
            var xml:XML = null;
            var num:Number = NaN;
            var loadEvent:LoadEvent = null;
            var object:Object = null;
            xml = new XML(event.target.data);
            num = Number(xml.@value);
            loadEvent = new LoadEvent( LoadEvent.LOAD_REGISTER);
            object = new Object();
            object.suces = xml.@tag;
			object.id= xml.@id;
            object.message = xml;
            loadEvent.load_data = object;
            dispatchEvent(loadEvent);
            
        } 

    }
}

package emagin.managers 
{
	import emagin.Application;
	import flash.external.ExternalInterface;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class ExternalConnectionManager 
	{
		 
		private static var INSTANCE:ExternalConnectionManager;
		public function ExternalConnectionManager(ins:SingletonEnforcer) 
		{
			super();
		}
		public static function getInstance():ExternalConnectionManager {


             if (INSTANCE == null) {

             INSTANCE = new ExternalConnectionManager(new SingletonEnforcer());

		    }
			return INSTANCE;
		}
		public function linkClick(id:String, label:String):void {
			ExternalInterface.call(Application.JS_LINK_FUNCTION, id, label);
		}
		public function searchSwf(id:String, label:String):void {
			ExternalInterface.call(Application.JS_SEARCH_FUNCTION, id, label);
		}
		public function changeLang(lang:String):void {
			ExternalInterface.call(Application.JS_CHANGE_LANG_FUNCTION, lang);
		}

		
	}
	
}
class SingletonEnforcer {};
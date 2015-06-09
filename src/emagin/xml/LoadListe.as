package emagin.xml {
	
	import emagin.data.DataValueObject;
	import emagin.xml.events.LoadEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * @author emagin
	 */
	public class LoadListe extends EventDispatcher {
		
		private var u:URLLoader;
		public function LoadListe(target : IEventDispatcher = null) {
			super(target);
		}
		public function load(path:String):void{
			u= new URLLoader();
			u.addEventListener(Event.COMPLETE, onMediaDataLoaded);
			u.load(new URLRequest(path));
		}
		protected function onMediaDataLoaded(event:Event):void
		{
			// TODO recevoir les donnes txt des piece les convertis en Object , et dispatcher aux autre composant de l'application
			var list:Array=LoadListe.parseXml(new XML(event.target.data));
			var eventLoad:LoadEvent=new LoadEvent(LoadEvent.LOAD_MEDIAS);
			eventLoad.load_data=list;
			dispatchEvent(eventLoad);
		}
		
		/**
		 * fonction qui parse 
		 */
		public static function parseXml(xml : XML) : Array {
			var liste : Array = [];
			var node : XML = null;
			var catnode : XML = null;
			
			for each (node in xml.item) {
				
				
				
				
				
				liste.push({id:node.@id,label:node.@label});
				
			}
			
			return liste;
		}
		
	}
}


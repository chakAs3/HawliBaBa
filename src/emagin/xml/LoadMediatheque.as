
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
	public class LoadMediatheque extends EventDispatcher {
		
		private var u:URLLoader;
		public function LoadMediatheque(target : IEventDispatcher = null) {
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
			var listCats:Array=LoadMediatheque.parseXml(new XML(event.target.data));
			var eventLoad:LoadEvent=new LoadEvent(LoadEvent.LOAD_MEDIAS);
			eventLoad.load_data=listCats;
			dispatchEvent(eventLoad);
		}
		
		/**
		 * fonction qui parse les produit d'une  collection
		 */
		public static function parseXml(xml : XML) : Array {
			var liste : Array = [];
			var node : XML = null;
			var catnode : XML = null;
			var data : DataValueObject;
			var categories:Array=[];
			for each (catnode in xml.categorie) {
				
				liste=[];
				for each (node in catnode.items.item) {
					
					data = new DataValueObject();
					data.setDataFromXML(node);
					liste.push(data);
				}
				categories.push({id:catnode.id,title:catnode.title,image:catnode.image,liste:liste})
			}
			
			return categories;
		}
		
	}
}

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
	public class XMLParser extends EventDispatcher {

		private var u:URLLoader;
		public function XMLParser(target : IEventDispatcher = null) {
			super(target);
		}
		public function load(path:String):void{
			u= new URLLoader();
			u.addEventListener(Event.COMPLETE, onMediaDataLoaded);
			u.load(new URLRequest(path));
		}
		protected function onMediaDataLoaded(event:Event):void
		{
			var xml:XML= new XML(event.target.data);
			var data:Object=parseXml(xml);
			var loadEvent:LoadEvent=new LoadEvent(LoadEvent.LOAD_MEDIAS);
			loadEvent.load_data=data;
			dispatchEvent(loadEvent);
		}

		/**
		 * fonction qui parse les donnees
		 */
		public static function parseXml(xml : XML) : Object {
			var liste : Array = [];
			var node : XML = null;
			var catnode : XML = null;
			var data : DataValueObject;
			var categories:Array=[];
			var items:Array=[];
			for each (catnode in xml.categorie) {
				
				    liste=[];
				for each (node in catnode.items.item) {
                
					data = new DataValueObject();
					data.setDataFromXML(node);
					data.categorie=catnode.title;
					liste.push(data);
					items.push(data);

				}
				categories.push({id:catnode.id,label:catnode.title,image:catnode.image,liste:liste})
			}
            
			return {cats:categories,items:items};
		}
 
	}
}

package emagin.events
{
	//import emagin.components.menu.MainMenuItem;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class ItemEvent extends Event
	{
		
		 
		public static const FILTER_DATE_SELECTED:String = "ActusEvent.FILTER_DATE_SELECTED";
		public static const CATEGORY_SELECTED:String = "ActusEvent.CATEGORY_SELECTED";
		public static const WORDS_SEARCH_SELECTED:String = "ActusEvent.WORDS_SEARCH_SELECTED";
		
		public static const ITEM_SELECTED:String = "ActusEvent.ITEM_SELECTED";
		
		public static const ITEM_SELECTED_SHOW:String = "ActusEvent.ITEM_SELECTED_SHOW";
	 
		 
		 
		public var index:int;
		public var body:*;
		public function ItemEvent(pEvent:String):void {
			super(pEvent,true);
		} 
		
		
	}
	
}
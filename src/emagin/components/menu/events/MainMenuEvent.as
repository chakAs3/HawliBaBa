package emagin.components.menu.events
{
	//import emagin.components.menu.MainMenuItem;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class MainMenuEvent extends Event
	{
		
		 
		public static const ITEM_CLICK:String = "MainMenuEvent.ITEM_CLICK";
		public static const ITEM_ROLLOVER:String = "MainMenuEvent.ITEM_ROLLOVER";
		public static const ITEM_ROLLOUT:String = "MainMenuEvent.ITEM_ROLLOUT";
		
		
		public static const ITEM_GALERY_SELECT:String = "MainMenuEvent.ITEM_GALERY_SELECT";
		public static const ITEM_FILTER:String = "MainMenuEvent.ITEM_FILTER";
		 
		public var item:MovieClip;
		public var index:int;
		public function MainMenuEvent(pEvent:String):void {
			super(pEvent,true);
		} 
		
		
	}
	
}
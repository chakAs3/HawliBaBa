package emagin.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class PaginationEvent extends Event
	{
		
		public static const CHANGE_PAGE:String = "PaginationEvent.CHANGE_PAGE";
	 
		 
		public var page_num:int;
		public var pagination:int;
		public function PaginationEvent(pEvent:String):void {
			super(pEvent);
		} 
		
	}
	
}
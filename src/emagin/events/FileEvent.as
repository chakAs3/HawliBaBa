package emagin.events 
{
	import flash.events.Event;
	import flash.net.FileReference;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class FileEvent extends Event
	{
		
		public static const FILE_SELECTED:String = "FileEvent.FILE_SELECTED";
		 
		 
		public var file:FileReference;
		public function FileEvent(pEvent:String):void {
			super(pEvent);
		} 
		
		
	}
	
}
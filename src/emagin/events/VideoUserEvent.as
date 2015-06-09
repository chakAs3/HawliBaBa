package emagin.events 
{
	import flash.events.Event;
	import flash.net.FileReference;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class VideoUserEvent extends Event
	{
		
		public static const VIDEO_SELECTED:String = "VideoEvent.VIDEO_SELECTED";
		 
		 
		public var objet:Object;
		public function VideoUserEvent(pEvent:String):void {
			super(pEvent,true);
		} 
		
		
	}
	
}
package emagin.components.player.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class ControlerEvent extends Event
	{
		public static const PLAY:int=1
		public static const STOP:int=2;
		public static const PAUSE:int=3;
		public static const VOLUM:Number=0;
		
		public static const CHANGED:String="ControlerEvent.CHANGED";
		public static const SEEK:String="ControlerEvent.SEEK";
		
		public var event:int;
		public var position:Number=0;
		 
		
		public function ControlerEvent(ev:String) 
		{
			super(ev,true);
		}
		
	}
	
}
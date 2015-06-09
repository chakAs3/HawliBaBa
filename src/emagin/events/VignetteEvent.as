package emagin.events 
{
	import emagin.components.media.ImageVignette;
	import emagin.data.Actu;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class VignetteEvent extends Event 
	{
		public static const ACTU_SELECTED:String = "VignetteEvent.ACTU_SELECTED";
		 

		
		public var actu:Actu;
		public var image:ImageVignette;
		public function VignetteEvent(pEvent:String):void {
			super(pEvent);
		} 
		
			
		
		
	}
	
}
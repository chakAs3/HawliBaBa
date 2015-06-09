package emagin.xml.events {

	import flash.events.Event;
	
	public class LoadEvent extends Event {
		
		 
	
		 
	
		public static const LOAD_MEDIAS:String = "LoadEvent.LOAD_MEDIAS";
		public static const LOAD_REGISTER:String = "LoadEvent.LOAD_CONTACT";
		 public static const VALIDATE_STEP1:String = "LoadEvent.VALIDATE_STEP1";
		 
		 
		 public static const LOGIN_RESPONSE:String = "LoadEvent.LOGIN_RESPONSE";
		 
		 public static const VOTE_RESPONSE:String = "urv.score = objet.score;";

		
		public var load_data:*;
		public static var SCORE_RESPONSE:String="urv.score = objet.score;";
		
		public function LoadEvent(pEvent:String):void {
			super(pEvent,true);
		}
	};
	
};
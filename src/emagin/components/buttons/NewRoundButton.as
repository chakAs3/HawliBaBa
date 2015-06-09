package emagin.components.buttons {
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author emagin
	 */
	public class NewRoundButton extends MovieClip {
		public var mc_circle:Sprite
		public function NewRoundButton() {
			
		}
		public function onMRollOver(ev:Event=null):void{
			TweenLite.to(mc_circle,0.5,{rotation:360});
		}
		public function onMRollOut(ev:Event=null):void{
            TweenLite.to(mc_circle,0.5,{rotation:-360});
        }
	}
}

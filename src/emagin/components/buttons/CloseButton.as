package emagin.components.buttons {
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author emagin
	 */
	public class CloseButton extends Sprite /*extends NavDButton */{
		public var mc_icone:Sprite
		public function CloseButton() {
			super();
			addEventListener(MouseEvent.ROLL_OVER,onMOver)
            addEventListener(MouseEvent.ROLL_OUT, onMOut)
			buttonMode=true
		}
		private function onMOut(e:MouseEvent):void 
        {
           
            if(mc_icone)
            TweenMax.to(mc_icone, 0.5, { rotation:360, ease:Elastic.easeOut} );
        }
        
        private function onMOver(e:MouseEvent):void 
        {
            
            if(mc_icone)
            TweenMax.to(mc_icone, 0.5, { rotation:360/*colors.right*/,ease:Elastic.easeOut} );
        }
		
	}
}

package emagin.components.buttons 
{
	import emagin.components.ERectange;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class NavDButton extends Sprite
	{
		public var mc_fond:Sprite;
		public var mc_flech:Sprite		//public var mc_icone:Sprite
		
		public var w : uint;
        public var h : uint;
		
		protected var colors : Object;
        protected var colorsOut : Object;
        protected var colorsOver : Object;
		public function NavDButton() 
		{
			addEventListener(MouseEvent.ROLL_OVER,onMOver)
			addEventListener(MouseEvent.ROLL_OUT, onMOut)
			buttonMode = true;
			
			colorsOut = {left:0x1A1A1A, right:0x000000};
            colorsOver = {left:0xFFFFFF, right:0xCCCCCC};
            colors={left:0x000000, right:0x00000};
			w = mc_fond.width;
            h = mc_fond.height;
			onMOut(null)
		}
		
		private function onMOut(e:MouseEvent):void 
		{
			TweenMax.to(mc_fond, 0.5, { scaleX:1, scaleY:1, ease:Elastic.easeOut } );
			TweenMax.to(colors,0.4, {hexColors:{left:colorsOut.left, right:colorsOut.right}, onUpdate:drawGradient });
			//if(mc_flech)
			//TweenMax.to(mc_flech, 0.5, { alpha:0.5,ease:Elastic.easeOut} );
		}
		
		private function onMOver(e:MouseEvent):void 
		{
			trace(this+"  onMOver  ")
			TweenMax.to(mc_fond, 0.5, { scaleX:1.2, scaleY:1.2, ease:Elastic.easeOut } );
			TweenMax.to(colors, 0.4, {hexColors:{left:colorsOver.left, right:colorsOver.right}, onUpdate:drawGradient });
		//	if(mc_flech)
			//TweenMax.to(mc_flech, 0.5, { alpha:1,ease:Elastic.easeOut} );
		}
		private function drawGradient() : void {
            if(mc_fond.numChildren){
                mc_fond.removeChild(mc_fond.getChildAt(0));
            }
            var rec:ERectange=new ERectange(w,h,colors.left,colors.right,true,[1,1],w);
            rec.x=-w/2;
            rec.y=-h/2;
            mc_fond.addChild(rec)
        }
		
		
	}
	
}
package emagin.components.buttons {
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import emagin.components.ERectange;
	import com.greensock.TweenMax;
	import com.greensock.TweenLite;
	 
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author emagin
	 */
	public class SeeButton extends Sprite {
		public var mc_fond:MovieClip;
		public var txt_label:TextField;		public var mc_icone:Sprite;
		
		public var overColor:int=0x000000;		public var outColor:int=0xFFFFFF;
		public var w : uint;
		public var h : uint;
		protected var colors : Object;
		protected var colorsOut : Object;
		protected var colorsOver : Object;
		private var x0icone : Number;

		
		public function SeeButton() {
			
			addEventListener(MouseEvent.ROLL_OVER, onMRollOver)
			addEventListener(MouseEvent.ROLL_OUT, onMRollOut)
			//txt_label.styleSheet=Application.getInstance().styleGlobal;
			//txt_label.embedFonts=true;
			txt_label.autoSize=TextFieldAutoSize.LEFT;
		
			buttonMode=true;
			mouseChildren=false
			w = mc_fond.width;			h = mc_fond.height;
			
         
			
			colorsOut = {left:0x1A1A1A, right:0x000000};			colorsOver = {left:0xFFFFFF, right:0xCCCCCC};			colors={left:0x000000, right:0x00000};
            
		}

		private function drawGradient() : void {
			if(mc_fond.numChildren){
				mc_fond.removeChild(mc_fond.getChildAt(0));
			}
			var rec:ERectange=new ERectange(w,h,colors.left,colors.right,true,[1,1],6);
			mc_fond.addChild(rec)
		}

		public function setText(str:String):void {
			txt_label.htmlText="<span class='button' >"+str+"</span>" ;
			w=txt_label.width+ 45;
			mc_fond.getChildAt(0).width=w;
			mc_icone.x = txt_label.x + txt_label.textWidth;
			x0icone = mc_icone.x;
			var rec:ERectange=new ERectange(w,h,0xF);
            rec.alpha=0;
            addChild(rec)
			onMRollOut(null)
		}

		protected function onMRollOut(event : MouseEvent) : void {
			TweenLite.to(txt_label,0.3, {tint:outColor});
			TweenMax.to(colors, 0.3, {hexColors:{left:colorsOut.left, right:colorsOut.right}, onUpdate:drawGradient });
			if(x0icone){
				TweenLite.to(mc_icone, 0.3, {x:x0icone,alpha:0})
				TweenLite.to(txt_label, 0.3, {x:int((mc_fond.width - txt_label.width)/2)});
			}
		}

		protected function onMRollOver(event : MouseEvent) : void {
			if(x0icone){
                TweenLite.to(mc_icone, 0.3, {x:x0icone+10,alpha:1})
                TweenLite.to(txt_label, 0.3, {x:10});
            }
			TweenLite.to(txt_label,0.3, {tint:overColor});
			TweenMax.to(colors, 0.3, {hexColors:{left:colorsOver.left, right:colorsOver.right}, onUpdate:drawGradient });
		}
	}
}

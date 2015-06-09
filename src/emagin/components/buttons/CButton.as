package emagin.components.buttons {
	import flash.text.AntiAliasType;
	import com.greensock.TweenLite;

	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	import emagin.Application;
	import flash.text.TextField;
	import flash.display.Sprite;

	/**
	 * @author emagin
	 */
	public class CButton extends Sprite {
		public var txt_label:TextField
		public var mc_flech:Sprite;
		private var overColor : int=0xFFFFFF;
		private var outColor : int=0xCCCCCC;

		public function CButton() {
			txt_label.styleSheet=Application.getInstance().styleGlobal;
            txt_label.embedFonts=true;
            txt_label.autoSize=TextFieldAutoSize.LEFT;
			txt_label.antiAliasType=AntiAliasType.ADVANCED
			buttonMode=true;
            mouseChildren=false;
            addEventListener(MouseEvent.ROLL_OVER, onMRollOver);
            addEventListener(MouseEvent.ROLL_OUT, onMRollOut);
            onMRollOut(null);
		}
		public function setText(str:String):void {
			txt_label.htmlText="<span class='titleParag'>"+str+"</span>";
		}

		protected function onMRollOut(event : MouseEvent) : void {
            TweenLite.to(txt_label,0.5, {tint:outColor});           // TweenLite.to(txt_label,0.5, {x:outColor});
        }

        protected function onMRollOver(event : MouseEvent) : void {
            TweenLite.to(txt_label,0.5, {tint:overColor});
        }
	}
}

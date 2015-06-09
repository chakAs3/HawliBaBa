package emagin.components.buttons {
	import emagin.Application;
	import flash.text.TextField;
	import emagin.components.EToggleButton;

	/**
	 * @author emagin
	 */
	public class FullScreenButton extends EToggleButton {
		public var txt_label:TextField
		public function FullScreenButton() {
			super();
			toogleMode=true;
			txt_label.autoSize="left";
			txt_label.embedFonts=true;
			txt_label.styleSheet=Application.getInstance().styleGlobal;
			txt_label.htmlText="<span class='aideLabel' >" + "FULLSCREEN"+"</span>";
		}
		override public function setEtat(bool:Boolean):void{
			super.setEtat(bool);
			if(bool)
			txt_label.htmlText="<span class='aideLabel' >" + "NORMAL"+"</span>";
			else
			txt_label.htmlText="<span class='aideLabel' >" + "FULLSCREEN"+"</span>";
			
		}
	}
}

package emagin.components.buttons 
{
	import com.greensock.TweenMax;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class GaleryMenuButton extends Sprite
	{
		
		public var txt_label:TextField;
		public var mc_fond:Sprite
		
		public var selected:Boolean
		public function GaleryMenuButton() 
		{
			txt_label.defaultTextFormat = new TextFormat("standard 07_53", 8);
			txt_label.embedFonts = true;
			addListeners();
			buttonMode = true;
			mouseChildren = false;
			txt_label.text = txt_label.text;;
			
		}
		public function addListeners():void {
			addEventListener(MouseEvent.ROLL_OVER, onMRollOver);
			addEventListener(MouseEvent.ROLL_OUT, onMRollOut);
			onMRollOut(null);
		}
		
		private function onMRollOver(e:MouseEvent):void 
		{
			TweenMax.to(txt_label, 0.5, { tint:0xFFFFFF } );
		    TweenMax.to(mc_fond, 0.5, { alpha:1 } );
		}
		
		private function onMRollOut(e:MouseEvent):void 
		{
			TweenMax.to(txt_label, 0.5, { tint:0x333333 } );
			TweenMax.to(mc_fond, 0.5, { alpha:0 } );
		}
		public function select():void {
			TweenMax.to(txt_label, 0.5, { tint:0xFFFFFF } );
			TweenMax.to(mc_fond, 0.5, { alpha:1 } );
			mouseEnabled = false;
			mouseChildren = false;
			removeEventListener(MouseEvent.ROLL_OUT, onMRollOut);
			selected = true;
		}
		public function unselect():void {
			TweenMax.to(txt_label, 0.5, { tint:0x333333 } );
			addEventListener(MouseEvent.ROLL_OUT, onMRollOut);
			TweenMax.to(mc_fond, 0.5, { alpha:0 } );
			mouseEnabled = true;
			//mouseChildren = false;
			selected=false
		}
		
	}
	
}
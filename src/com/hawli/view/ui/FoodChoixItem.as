package com.hawli.view.ui
{
	import com.greensock.TweenMax;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FoodChoixItem extends Sprite
	{
		public var btn_choisir:SimpleButton
		public function FoodChoixItem()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			TweenMax.to(getChildAt(0),0.3,{scaleX:1,scaleY:1,tint:0x955D31});
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			TweenMax.to(getChildAt(0),0.3,{scaleX:1.02,scaleY:1.02,tint:0xEF632C});
			
		}
	}
}
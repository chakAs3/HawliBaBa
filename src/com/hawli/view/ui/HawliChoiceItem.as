package com.hawli.view.ui
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class HawliChoiceItem extends MovieClip
	{
		public var custom:MovieClip;
		public function HawliChoiceItem()
		{
			super();
			addEventListener(MouseEvent.ROLL_OVER,onRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onRollOut);
		}
		
		protected function onRollOut(event:MouseEvent):void
		{
			TweenMax.to(getChildAt(1),0.3,{scaleX:1,scaleY:1,tint:0x955D31});
		}
		
		protected function onRollOver(event:MouseEvent):void
		{
			TweenMax.to(getChildAt(1),0.3,{scaleX:1.05,scaleY:1.05,tint:0xEF632C});
			
		}
	}
}
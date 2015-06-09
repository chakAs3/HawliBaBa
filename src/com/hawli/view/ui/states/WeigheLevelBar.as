package com.hawli.view.ui.states
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	public class WeigheLevelBar extends Sprite
	{
		public var txt_weight:TextField;
		public var txt_level:TextField;
		public var mc_progress_bar:Sprite;
		public function WeigheLevelBar()
		{
			super();
			mc_progress_bar.scaleX=0;
		}
		public function setPurcent(i:int,p:Number):void{
			mc_progress_bar.scaleX=p;
			txt_level.text=i+"";
		}
	}
}
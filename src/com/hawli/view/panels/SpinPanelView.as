package com.hawli.view.panels
{
	import com.hawli.view.events.ViewEvent;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SpinPanelView extends Sprite
	{
		public var btn_close:SimpleButton;
		public var btn_spin:SimpleButton;
		
		public var mc_selector:Sprite;
		public var mc_result:MovieClip;
		public var mc_roullette:Sprite;
		
		public var items:Array;
		
		public function SpinPanelView()
		{
			 
			mc_result.visible=false;	
		}
		
		 
	}
}
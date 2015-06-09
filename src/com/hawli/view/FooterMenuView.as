package com.hawli.view
{
	import com.mtc.components.EToggleButton;
	
	import flash.display.Sprite;

	public class FooterMenuView extends Sprite
	{
		public var btn_fullscreen:EToggleButton;
		public var btn_sound:EToggleButton;
		public var btn_help:EToggleButton;
		public var btn_sound_effect:EToggleButton;
		public function FooterMenuView()
		{
			btn_fullscreen.toogleMode=true;
			btn_sound.toogleMode=true;
			btn_sound_effect.toogleMode=true;
			
		}
	 
	}
}
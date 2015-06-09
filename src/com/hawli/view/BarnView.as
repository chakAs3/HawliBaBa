package com.hawli.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class BarnView extends Sprite implements IEnvironnementView
	{
		public var mc_water_container:MovieClip;
		public var mc_food_container:MovieClip;
		/* icone cusor in screen */
		public var mc_drag_icone:MovieClip;
		public var mc_erase_moche:MovieClip;
		public var mc_bala:MovieClip;
		public var mc_drag_hawli:MovieClip
		/* **************************  µ*/
		
		public var mc_bad:MovieClip;
		public var mc_window:MovieClip;
		
		public var hawliView:HawliView;
		public var mc_door:MovieClip;
		public var mc_fond:MovieClip;
		public var mc_dog:MovieClip;
		public var mc_tban:MovieClip;
		public var mc_blaka:MovieClip;
		public var mc_camera:MovieClip;
		public function BarnView()
		{
			mc_drag_icone.visible=false;
			mc_drag_icone.mouseChildren=false;
			mc_drag_icone.mouseEnabled=false;
			
			mc_erase_moche.visible=false;
			mc_erase_moche.mouseChildren=false;
			mc_erase_moche.mouseEnabled=false;
			mc_erase_moche.stop();
			
			mc_bala.visible=false;
			mc_bala.mouseChildren=false;
			mc_bala.mouseEnabled=false;
			
			mc_drag_hawli.visible=false;
			mc_drag_hawli.mouseChildren=false;
			mc_drag_hawli.mouseEnabled=false;
			mc_drag_hawli.stop();
			
			mc_camera.visible=false;
			mc_camera.mouseChildren=false;
			mc_camera.mouseEnabled=false;
			mc_camera.stop();
		}
		public override function get width():Number{
		 return	super.width-200;
		}
		public function addHawli(hawli:HawliView):void{
			hawliView=hawli
			addChildAt(hawli,Math.min(getChildIndex(mc_food_container),getChildIndex(mc_water_container)))
		}
	}
}
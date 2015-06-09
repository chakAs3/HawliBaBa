package com.hawli.view
{
	import flash.display.Sprite;

	public class OutBarnView extends Sprite implements IEnvironnementView
	{
		public function OutBarnView()
		{
		}
		public function addHawli(hawli:HawliView):void{
			addChild(hawli)//,Math.min(getChildIndex(mc_food_container),getChildIndex(mc_water_container))-1)
		}
	}
}
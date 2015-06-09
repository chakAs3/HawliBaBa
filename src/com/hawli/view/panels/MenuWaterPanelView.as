package com.hawli.view.panels
{
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.ui.FoodChoixItem;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuWaterPanelView extends Sprite
	{
		public var btn_close:SimpleButton;
		
		public var btn_1:FoodChoixItem;
		public var btn_2:FoodChoixItem;
		public var btn_3:FoodChoixItem;
		public var btn_4:FoodChoixItem;
		
		public var items:Array;
		
		public function MenuWaterPanelView()
		{
			super();
			items=[btn_1,btn_2,btn_3,btn_4];
			for (var i:int = 0; i < items.length; i++) 
			{
				(items[i] as FoodChoixItem).addEventListener(MouseEvent.CLICK,onClickItem)
			}
			
		}
		
		protected function onClickItem(event:MouseEvent):void
		{
			var index:int= items.indexOf(event.currentTarget);
			dispatchEvent(new ViewEvent(ViewEvent.SELECT_WATER,index));
			
		}
	}
}
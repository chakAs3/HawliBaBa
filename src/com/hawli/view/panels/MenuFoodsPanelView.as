package com.hawli.view.panels
{
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.ui.FoodChoixItem;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MenuFoodsPanelView extends Sprite
	{
		public var btn_close:SimpleButton;
		
		public var btn_tben:FoodChoixItem;
		public var btn_ch3ir:FoodChoixItem;
		public var btn_foul:FoodChoixItem;
		public var btn_jelbana:FoodChoixItem;
		
		public var items:Array;
		public function MenuFoodsPanelView()
		{
			super();
			items=[btn_tben,btn_ch3ir,btn_foul,btn_jelbana];
			for (var i:int = 0; i < items.length; i++) 
			{
				trace("MenuFoodsPanelView "+items[i] );
				(items[i] as FoodChoixItem).addEventListener(MouseEvent.CLICK,onClickItem)
			}
			
		}
		
		protected function onClickItem(event:MouseEvent):void
		{
			var index:int= items.indexOf(event.currentTarget);
			dispatchEvent(new ViewEvent(ViewEvent.SELECT_FOOD,index));	
		}
	}
}
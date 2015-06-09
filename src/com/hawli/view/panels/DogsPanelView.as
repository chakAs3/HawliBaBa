package com.hawli.view.panels
{
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.ui.FoodChoixItem;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class DogsPanelView extends Sprite
	{
		public var btn_close:SimpleButton;
		
		public var btn_dog1:FoodChoixItem;
		public var btn_dog2:FoodChoixItem;
		public var btn_dog3:FoodChoixItem;
		public var btn_dog4:FoodChoixItem;
		
		public var items:Array;
		public function DogsPanelView()
		{
			super();
			items=[btn_dog1,btn_dog2,btn_dog3,btn_dog4];
			for (var i:int = 0; i < items.length; i++) 
			{
				trace("MenuFoodsPanelView "+items[i] );
				(items[i] as FoodChoixItem).addEventListener(MouseEvent.CLICK,onClickItem)
			}
			
		}
		
		protected function onClickItem(event:MouseEvent):void
		{
			var index:int= items.indexOf(event.currentTarget);
			dispatchEvent(new ViewEvent(ViewEvent.SELECT_DOG,index));	
		}
	}
}
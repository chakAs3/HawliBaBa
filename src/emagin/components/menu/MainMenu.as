package  emagin.components.menu
{
	 
	import emagin.components.ERectange;
	import emagin.components.menu.events.MainMenuEvent;
	import emagin.utils.*;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class MainMenu extends Sprite
	{
		public var items:Array=[];
		public var data:Array=[{label:"Votre score" ,id:"Votrescore"},{label:"Top scores" ,id:"Topscores"},{label:"Classement" ,id:"Classement"}];
		public var selectedItem:MainMenuItem;
	 
		public function MainMenu() 
		{
			 
			 addEventListener(Event.ADDED_TO_STAGE,onAdded)
		}
		
		private function onAdded(e:Event):void 
		{
			init();
		}
		 
		public function init():void{
			var x0:int=0
			var item:MainMenuItem;
			 
			items=[];
			for ( var i:int; i < data.length ; i++) {
				data[i].index =( i+1);
				 
				item=new MainMenuItem(data[i]);
				item.addEventListener(MouseEvent.CLICK,onMClick)
				//item.addEventListener(MouseEvent.ROLL_OVER,onMRollOver)	
				item.x=x0;
				
				x0=item.x+ item.width+10;
				
				addChild(item)
				items.push(item);
			 
				
				
				
			}
			 
			 
		}
		
		 
		 
		
		private function onMClick(e:MouseEvent):void 
		{
			if(selectedItem){
				selectedItem.unselect();
			}
			selectedItem=e.currentTarget as MainMenuItem;
			selectedItem.select();
			var index:int=items.indexOf((e.currentTarget as MainMenuItem));
		 
			//selectItemIndex(index);
			dispatcheSelectItem(index);
			
			
		}
		public function seletIndex(index:int):void{
			if(selectedItem){
				selectedItem.unselect();
			}
			selectedItem=items[index];
			selectedItem.select();
			 
			
			//selectItemIndex(index);
			dispatcheSelectItem(index);
		}
	 
		public function dispatcheSelectItem(index:int):void{
			var event:MainMenuEvent=new MainMenuEvent(MainMenuEvent.ITEM_CLICK);
			event.index=index;
			dispatchEvent(event);
		}
		public function rollOutAllItems(item:MainMenuItem):void{
			for (var i:int = 0; i < items.length; i++) 
			{
				if(items[i] != item)
					(items[i] as MainMenuItem).onMRollOut(null);;	
			}
		}
		
		protected function onMRollOver(eve:MouseEvent):void
		{
			 
		}
		
		
	}
	
}
package com.hawli.view.ui
{
	import com.hawli.model.vo.OperationVo;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.managers.ToolTipManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class PalletteActionPanel extends Sprite
	{
		public var items:Array;
		private var vspace:int=75;

		private var tm:ToolTipManager;
		public function PalletteActionPanel()
		{
			super();
			items=[];
			tm=new ToolTipManager();
		}
		public function createItems(data:Array):void{
			var actionItem:OperationItem;
			var operationVo:OperationVo;
			for (var i:int = 0; i < data.length; i++) 
			{
				operationVo=data[i] as OperationVo;
			
				actionItem=new OperationItem(operationVo.id,operationVo.label,operationVo.label);
				actionItem.operationVo=operationVo;
				actionItem.addEventListener(MouseEvent.CLICK,onClickItem);
				addChild(actionItem);
				tm.addItem(actionItem,operationVo.label);
				items.push(actionItem)
				actionItem.x=i*vspace;
			}
			
		}
		
		protected function onClickItem(event:MouseEvent):void
		{
			 var oe:ViewEvent=new ViewEvent(ViewEvent.OPERATION_CLICKED,(event.currentTarget as OperationItem).operationVo)
			dispatchEvent(oe);
		}
	}
}
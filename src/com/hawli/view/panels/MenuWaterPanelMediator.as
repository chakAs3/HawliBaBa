package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.WaterVo;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.managers.ToolTip;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MenuWaterPanelMediator extends Mediator
	{
		[Inject]
		public var view:MenuWaterPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function MenuWaterPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClosePanel);
			eventMap.mapListener(view,ViewEvent.SELECT_WATER,onSelectionWater);
			//TODO : add Listen to the context
		}
		
		private function onSelectionWater(e:ViewEvent):void
		{
			var fo:WaterVo=gameModel.waterUnit[int(e.body)] as WaterVo
			if((gameModel.userVo.hawliVo.cash-fo.currency)>=0){
			eventDispatcher.dispatchEvent(new GameEvent(GameEvent.ADD_ACTION,gameModel.waterUnit[int(e.body)]));
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		    }else{
				var tootipAler:ToolTip=new ToolTip();
				tootipAler.x=40;
				tootipAler.y=180;
				tootipAler.setText(" Votre solde est insuffisant");
				( view.items[int(e.body)] as Sprite ).addChild(tootipAler);
				TweenLite.to(tootipAler,0.5,{delay:2,alpha:0,onComplete:function(t:ToolTip){t.parent.removeChild(t)   }});
			}
		}
		
		private function onClickClosePanel(e:MouseEvent):void
		{
			
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		}
	}
}
package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.DogVo;
	import com.hawli.view.events.ViewEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class DeathPanelMediator extends Mediator
	{
		[Inject]
		public var view:DeathPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;
		public function DeathPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_replay,MouseEvent.CLICK,onClickClosePanel);
			 
			//TODO : add Listen to the context
			view.mc_death_message.gotoAndStop(gameModel.userVo.hawliVo.death);
			view.txt_name.text=gameModel.userVo.hawliVo.name;
		}
		
		private function onClickClosePanel(e:MouseEvent):void
		{
			
		   view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));    
		   setTimeout(dispatch,1000,new GameEvent(GameEvent.SHOW_POPUP_CREATEHAWLI));
			
		}		
		
	 
	}
}
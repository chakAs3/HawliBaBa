package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HelpPanelMediator extends Mediator
	{
		[Inject]
		public var view:HelpPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;
		public function HelpPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickSpin);
			eventMap.mapListener(view.btn_jouer,MouseEvent.CLICK,onClickSpin);
			 
			//TODO : add Listen to the context
		 
		}
		
		private function onClickSpin(e:MouseEvent):void
		{
			
			trace(this+" onClickClosePanel ");
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}		
		
	 
	}
}
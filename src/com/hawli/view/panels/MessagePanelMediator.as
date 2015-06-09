package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	 
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MessagePanelMediator extends Mediator
	{
		[Inject]
		public var view:MessagePanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;
		public function MessagePanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClose);
			//eventMap.mapListener(view.btn_invite,MouseEvent.CLICK,onClickInvite);
			 
			//TODO : add Listen to the context
		 
		}
		
		private function onClickClose(e:MouseEvent):void
		{
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}
		
		private function onClickInvite(e:MouseEvent):void
		{
			 
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		
		}
	   
		
	 
	}
}
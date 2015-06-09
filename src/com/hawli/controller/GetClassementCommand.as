/*
 * Copyright (c) 2012 the original author or authors
 *
  
 */

package com.hawli.controller
{
 
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.ServiceEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.model.vo.SettingVo;
	import com.hawli.service.GameService;
	
	import flash.utils.setInterval;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetClassementCommand extends Command
	{
		[Inject]
		public var gameEvent:GameEvent;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var gameService:GameService;
		
		override public function execute():void
		{
			// Add a Hawli operation
			// A Mediator will be created for it automatically
			trace(this +" execute "+gameEvent.type)
			if(gameEvent.type == GameEvent.GET_CLASSEMENT ){
				gameService.getClassement();
				gameService.eventDispatcher.addEventListener(ServiceEvent.CLASSEMENT_RECIEVED,onClassementReceived);
			}
		}
		
		private function onClassementReceived(e:ServiceEvent):void
		{
		 
			trace(this +" classement "+e.body);
			dispatch(new GameEvent(GameEvent.CLASSEMENT_LOADED,e.body));
		}
		
	 
		
	}
}
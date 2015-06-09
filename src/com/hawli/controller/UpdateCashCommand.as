/*
 * Copyright (c) 2009 the original author or authors
 *
 */

package com.hawli.controller
{
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.ServiceEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.service.GameService;
	import com.hawli.view.HawliView;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateCashCommand extends Command
	{
		[Inject]
		public var gameEvent:GameEvent;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var gameService:GameService;
		override public function execute():void
		{
			// Add a Hawli to the view
			// A Mediator will be created for it automatically
			
			//contextView.addChild(hawli);
			gameService.updateCash(gameModel.userVo.id,int(gameEvent.body));
			gameService.updateInvidIds(gameModel.userVo.id,0,gameModel.invited_users);
			//gameService.eventDispatcher.addEventListener(ServiceEvent.CREATE_HAWLI_RECIEVED,onCreateHawliReceived)
		}
		
		private function onCreateHawliReceived(e:ServiceEvent):void
		{
			
			dispatch(new GameEvent(GameEvent.GET_DATA_HAWLI_TIMER));
		}
	}
}
/*
 * Copyright (c) 2009 the original author or authors
 *
 *
 */

package com.hawli.controller
{
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.ServiceEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.DogVo;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.service.GameService;
	import com.hawli.view.HawliView;
	
	import org.robotlegs.mvcs.Command;
	
	public class UpdateDogCommand extends Command
	{
		[Inject]
		public var gameEvent:GameEvent;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var gameService:GameService;
		override public function execute():void
		{
			// Add a Hawli (sheep) to the view
			// A Mediator will be created for it automatically
			
			//contextView.addChild(hawli);
			trace(this+" UpdateDogCommand "+DogVo(gameEvent.body).id+"  "+DogVo(gameEvent.body).cost)
			gameService.updateDog(gameModel.userVo.id,DogVo(gameEvent.body).id,DogVo(gameEvent.body).cost);

		}
		
		 
	}
}
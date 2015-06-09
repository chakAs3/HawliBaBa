/*
 * Copyright (c) 2012 the original author or authors
 *
  
 */

package com.hawli.controller
{
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.service.GameService;
	import com.hawli.view.HawliView;
	
	import org.robotlegs.mvcs.Command;
	
	public class OperationCommand extends Command
	{
		[Inject]
		public var operationEvents:OperationEvent;
		
		[Inject]
		public var gameService:GameService;
		
		[Inject]
		public var gameModel:GameModel;
		
		override public function execute():void
		{
			// Add a Hawli operation
			// A Mediator will be created for it automatically
			
			var operation:OperationVo=operationEvents.body as OperationVo;
			
			trace(this+" operationTO execute :"+operation + " idType : " +operation.idType+" value :  "+operation.value);
			operation.idUser=gameModel.userVo.id; // injection de l'utilisation pour l'envoi
			gameService.sendOperation(operation);
		 
		}
		public function sendOperationToService(operation:OperationVo):void{
			
		}
	}
}
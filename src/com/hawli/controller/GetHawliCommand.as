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
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	import org.robotlegs.mvcs.Command;
	
	public class GetHawliCommand extends Command
	{
		[Inject]
		public var gameEvent:GameEvent;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var gameService:GameService;
		
		
		private var count:int=0;
		override public function execute():void
		{
			// Add a Hawli operation
			// A Mediator will be created for it automatically
			var timer:Timer=gameModel.timer 
			if(gameEvent.type == GameEvent.HAVE_HAWLI ){
				
				gameService.userHaveHawli(	gameModel.userVo.id,gameModel.getSession());
				gameService.eventDispatcher.addEventListener(ServiceEvent.HAVE_HAWLI_RECIEVED,onHaveHawliReceived);
			}else if(gameEvent.type == GameEvent.GET_DATA_HAWLI_TIMER){
				if(!timer.hasEventListener( TimerEvent.TIMER ))
			   timer.addEventListener(TimerEvent.TIMER, getDataHawli);
			   getDataHawli();
			   gameService.eventDispatcher.addEventListener(ServiceEvent.HAWLI_DATA_RECIEVED,onDataReceived)
		     //  setInterval(getDataHawli,SettingVo.TIMER_DATA_UPDATE);
			   timer.start();
			}else if(gameEvent.type == GameEvent.STOP_DATA_HAWLI_TIMER){
				trace(this+" STOP_DATA_HAWLI_TIMER ");
				gameService.eventDispatcher.removeEventListener(ServiceEvent.HAWLI_DATA_RECIEVED,onDataReceived);	
				timer.stop(); 
 
			}
			
		}
		
		private function onHaveHawliReceived(e:ServiceEvent):void
		{
				gameModel.invited_users=String(e.body.invited_ids).split(",");
			if(!e.body.havehawli){// if he dont have hawli
				dispatch(new GameEvent(GameEvent.SHOW_POPUP_HELP));
				dispatch(new GameEvent(GameEvent.SHOW_POPUP_CREATEHAWLI));
			}else{ // if he  has hawli
				dispatch(new GameEvent(GameEvent.GET_DATA_HAWLI_TIMER));
			}
			gameModel.userVo.name=e.body.prenom+"  "+e.body.nom;
			
		}
		
		private function onDataReceived(e:ServiceEvent):void
		{
			trace(this+" onDataReceived HawliVo :"+HawliVo(e.body).custom+"  "+HawliVo(e.body).name+"  "+HawliVo(e.body).type)
			
			dispatch(new GameEvent(GameEvent.DATA_HAWLI_CHANGED,e.body));
		}
		
		private function getDataHawli(e:Event=null):void
		{
			trace(this+"GET getDataHawli")
			gameService.getHawliInfo(gameModel.userVo.id);
			
		}
		
	}
}
/*
 * Copyright (c) 2011 the original author or authors
 *
 */

package com.hawli.view
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.OperationTypes;
	import com.hawli.model.OperationsModel;
	import com.hawli.model.StatsModel;
	import com.hawli.model.vo.FoodVo;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.model.vo.SettingVo;
	import com.hawli.model.vo.WaterVo;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundTransform;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class HawliMediator extends Mediator
	{
		[Inject]
		public var view:HawliView;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function HawliMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void
		{
			// Listen to the view
			eventMap.mapListener(view, MouseEvent.CLICK, onClick);
			eventMap.mapListener(view, MouseEvent.MOUSE_DOWN, onHMouseDown);
			trace(this+" onRegister")
			// Listen to the context
			eventMap.mapListener(eventDispatcher, GameEvent.DATA_HAWLI_CHANGED, dataHawliChanged);
			eventMap.mapListener(eventDispatcher, GameEvent.HAWLI_CLICKED, onSomeBallClicked);
			eventMap.mapListener(eventDispatcher, GameEvent.DO_CARESS, onDoCaress);
			eventMap.mapListener(eventDispatcher, GameEvent.DO_DRAG, onDoDrag);
			eventMap.mapListener(eventDispatcher, GameEvent.HIT_HAWLI, onHitHawli);
			eventMap.mapListener(eventDispatcher, GameEvent.WALK_TO_POSITION, onWalkToPosition);
			eventMap.mapListener(eventDispatcher, GameEvent.HAWLI_TO_FOOD, onGoToFood);
			eventMap.mapListener(eventDispatcher, GameEvent.HAWLI_TO_SLEEP, onGoToSleep);
			eventMap.mapListener(eventDispatcher, GameEvent.HAWLI_TO_OUT, onGoOut);
			eventMap.mapListener(eventDispatcher, GameEvent.HAWLI_TO_IN, onGoIn);
			eventMap.mapListener(eventDispatcher, GameEvent.SOUND_EFFET,onChangeSoundEffect);
			initComponent();
		}
		
		private function onChangeSoundEffect(e:GameEvent):void
		{
			if(e.body){
				trace(this+" onChangeSoundEffect "+e.body);
				 
				TweenLite.to(view.spriteSheet, 0, {volume:1});
			}else{
				trace(this+" onChangeSoundEffect "+e.body);
				 
				TweenLite.to(view.spriteSheet, 0, {volume:0});
			}
			
		}
		
		private function onGoIn(e:GameEvent):void
		{
			var body:Point=new Point(e.body.x,e.body.y);
			var distance:int=Math.sqrt(Math.pow((body.x -	view.x),2)+Math.pow((body.y -	view.y),2));
			var time:Number=Math.abs(distance/80);
			if((body.x -	view.x)!=0)
				view.spriteSheet.scaleX=-(body.x -	view.x)/Math.abs((body.x -	view.x));
			view.goState("walk");
			//TweenLite.killTweensOf(view);
			gameModel.isBusy=true;
			TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onComplete:function(){
				gameModel.isBusy=false;
				view.goState("stand");
				dispatch(new GameEvent(GameEvent.CHANGE_ENVIRONNEMENT));
				
			}});
			
		}
		
		private function onGoOut(e:GameEvent):void
		{
			var body:Point=new Point(e.body.x,e.body.y);
			var distance:int=Math.sqrt(Math.pow((body.x -	view.x),2)+Math.pow((body.y -	view.y),2));
			var time:Number=Math.abs(distance/80);
			if((body.x -	view.x)!=0)
			view.spriteSheet.scaleX=-(body.x -	view.x)/Math.abs((body.x -	view.x));
			view.goState("walk");
			//TweenLite.killTweensOf(view);
			gameModel.isBusy=true;
			TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onComplete:function(){
				gameModel.isBusy=false;
				view.goState("stand");
			   dispatch(new GameEvent(GameEvent.CHANGE_ENVIRONNEMENT));
			 
			}});
			
			
		}
		
		private function dataHawliChanged(e:GameEvent):void
		{
			if(gameModel.isDeath) return ;
			var hawliVo:HawliVo=HawliVo(e.body); 
			view.goLevel(gameModel.getPercentLevelWeight(hawliVo.weight).level);
			view.setCostum(hawliVo.custom);
			//trace(this+"dataHawliChanged hawliVo.gender :"+hawliVo.gender);
			view.setStyle(gameModel.getLabelTypeFromId(hawliVo.type));
			if(hawliVo.happiness < SettingVo.MAX_HAPINESS_VALUE/2){
				view.setHappinessState(2);
			}else{
				view.setHappinessState(1);
			}
			view.setEatState(int((hawliVo.food/SettingVo.MAX_FOOD_VALUE)*10))
			if(hawliVo.death!=0){
				view.goState("dying");
				view.isDeath=true;
				gameModel.isDeath=true;
				dispatch(new GameEvent(GameEvent.STOP_DATA_HAWLI_TIMER));
				setTimeout(removeHawliAndShowGameOver,2000)
			
			}
			
			
		}
		private function removeHawliAndShowGameOver():void{
			eventDispatcher.dispatchEvent(new GameEvent(GameEvent.SHOW_POPUP_DEATH));
			view.parent.removeChild(view);
		}
		override public function onRemove():void{
			// Listen to the view
			eventMap.unmapListeners() ;
		}
		
		private function onDoDrag(e:GameEvent):void
		{   
			if(gameModel.isBusy || gameModel.changingEnv) return;
			stopMovingTween();
			view.startDrag(false,new Rectangle(280,SettingVo.YHAWLI-100,gameModel.farm_width-420,100));
		//	view.addEventListener(MouseEvent.MOUSE_UP,onUpMouseView);
			
			view.stage.addEventListener(MouseEvent.MOUSE_UP,onUpMouseView);
			view.goState("drag");
			gameModel.isDraggin=true;
			
		}
		
		private function stopMovingTween():void
		{
			TweenLite.killTweensOf(view);
		}
		
		protected function onUpMouseView(event:MouseEvent):void
		{
			view.stopDrag();
			view.stage.removeEventListener(MouseEvent.MOUSE_UP,onUpMouseView);
			gameModel.isDraggin=false;
			view.goState("drop");
			
		}
		
		private function onHMouseDown(e:MouseEvent):void
		{
			trace(this+" onHMouseDown ");
			if( gameModel.activeAction==OperationTypes.CARESS ) 
				if(view.spriteSheet.mouton.hit)
			eventDispatcher.dispatchEvent(new GameEvent(GameEvent.DO_CARESS));
			if( gameModel.activeAction == OperationTypes.CHANGE_LOCATION){
				eventDispatcher.dispatchEvent(new GameEvent(GameEvent.DO_DRAG));	
			}
		}
		private function onGoToSleep(e:GameEvent):void
		{
			var body:Point=new Point(e.body.x,e.body.y);
			var distance:int=Math.sqrt(Math.pow((body.x -	view.x),2)+Math.pow((body.y -	view.y),2));
			var time:Number=Math.abs(distance/80);
			if((body.x -	view.x)!=0)
			view.spriteSheet.scaleX=-(body.x -	view.x)/Math.abs((body.x -	view.x));
			view.goState("walk");
			//TweenLite.killTweensOf(view);
			gameModel.isBusy=true;
			TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onComplete:function(){view.goState("sleep");gameModel.isBusy=false;gameModel.isSleeping=true}});
		}
		private function onGoToFood(e:GameEvent):void
		{
			var body:Point=new Point(e.body.pos.x,e.body.pos.y);
			var distance:int=(body.x -	view.x);
			var time:Number=Math.abs(distance/120);
			if(distance!=0)
			view.spriteSheet.scaleX=-distance/Math.abs(distance);
			view.goState("walk");
			if(e.body.food is FoodVo){
				TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onCompleteParams:[e.body.food],onComplete:function(food:FoodVo){
					view.goState("eat")
				    var operation:OperationVo=OperationsModel.GIVE_FOOD1;
					operation.cost=food.currency;
					operation.value=food.calory;
					dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operation));
					setTimeout(finishAction,SettingVo.EAT_DELAY,food);
				}});
				
			}else{
				TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onCompleteParams:[e.body.food],onComplete:function(water:WaterVo){
					view.goState("drink");
					var operation:OperationVo=OperationsModel.GIVE_WATER;
					operation.cost=water.currency;
					operation.value=water.calory;
					dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operation));
				    setTimeout(finishAction,SettingVo.EAT_DELAY,water);
				}});
				
			}
			
		}
		private function finishAction(vo:*):void{
			view.goState("stopeating");
			dispatch(new GameEvent(GameEvent.FINISH_FOOD_DRINK,vo));
			gameModel.listActionToDo.shift();
			gameModel.isBusy=false;
		}
		private function onWalkToPosition(e:GameEvent):void
		{
			var body:Point=new Point(e.body.x,e.body.y);
			var distance:int=Math.sqrt(Math.pow((body.x -	view.x),2)+Math.pow((body.y -	view.y),2));
			var time:Number=Math.abs(distance/80);
			if((body.x -	view.x)!=0)
			view.spriteSheet.scaleX=-(body.x -	view.x)/Math.abs((body.x -	view.x));
			view.goState("walk");
			body.y=Math.min(SettingVo.YHAWLI,Math.max(SettingVo.YHAWLI-100,body.y));
			body.x=Math.max(300,Math.min(gameModel.farm_width-200,body.x));
			TweenLite.to(view,time,{x:body.x,y:body.y,ease:Linear.easeNone,onComplete:function(){view.goState("stand")}});
			gameModel.isSleeping=false;
		}
		private function gotoPositon(p:Point):void{
			var body:Point=p
				body.x=Math.max(200,Math.min(gameModel.farm_width-100,body.x));
			
			var distance:int=(body.x -	view.x);
			var time:Number=Math.abs(distance/120);
			view.spriteSheet.scaleX=-distance/Math.abs(distance);
			view.goState("walk");
			TweenLite.to(view,time,{x:body.x,ease:Linear.easeNone,onComplete:function(){view.goState("stand")}});
			
		}
		
		private function onHitHawli(e:GameEvent):void
		{
			view.goState("hit");
			gameModel.countHawliHit++;
			if(gameModel.countHawliHit > SettingVo.MAX_SUPPORT_HIT ){
				gameModel.countHawliHit=0;
				//var xx:int=view.x+(-200+Math.random()*400);
				//xx=Math.max(200,Math.min(gameModel.farm_width-100));
				gotoPositon(new Point(view.x+(-200+Math.random()*400),SettingVo.YHAWLI));
				
			}
			var operationVo:OperationVo=OperationsModel.HIT_HAWLI;
			
			dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operationVo));
		}
		
		private function onDoCaress(e:GameEvent):void
		{
			view.goState("caress");
			var operationVo:OperationVo=OperationsModel.CARESS;
		 
			dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operationVo));
		}
		
		private function initComponent():void
		{
			view.setCostum(gameModel.userVo.hawliVo.custom);	
			view.setStyle(gameModel.getLabelTypeFromId(gameModel.userVo.hawliVo.type));
			view.goState("stand");	
			view.goLevel(int(gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.weight).level))
			setTimeout(view.goState,100,"stand");
			gameModel.isDeath=false;
			//view.setStyle("normal");
		}
		
		protected function onClick(e:MouseEvent):void
		{
			// Manipulate the model
			 
			// Dispatch to context
			eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HAWLI_CLICKED));
			if(gameModel.activeAction==OperationTypes.ERASE_FLIES){
				if(view.spriteSheet.mouton.hit)
			 eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HIT_HAWLI)); 
			}
		}
		
		protected function onSomeBallClicked(e:GameEvent):void
		{
			// Manipulate the view
			 
		}
	}
}
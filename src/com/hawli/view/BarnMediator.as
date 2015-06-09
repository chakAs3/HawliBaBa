package com.hawli.view
{
	import classes.quietless.core.ApplicationScreenShotMain;
	
	import com.greensock.TweenLite;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.Cryptage;
	import com.hawli.model.GameModel;
	import com.hawli.model.OperationTypes;
	import com.hawli.model.OperationsModel;
	import com.hawli.model.StatsModel;
	import com.hawli.model.vo.DogVo;
	import com.hawli.model.vo.FoodVo;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.model.vo.SettingVo;
	import com.hawli.model.vo.WaterVo;
	import com.hawli.view.ui.BugZone;
	import com.hawli.view.ui.DroppingsZone;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class BarnMediator extends Mediator
	{
		[Inject]
		public var view:BarnView;
		
		[Inject]
		public var statsModel:StatsModel;
		
		[Inject]
		public var gameModel:GameModel;

		private var currentCursor:MovieClip;

		private var bugZone:BugZone;
		
		private var inBarnElements:Array;
		private var outBarnElements:Array;
		private var droppings:DroppingsZone;

		private var screenShot:ApplicationScreenShotMain;
		
		public function BarnMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			
			// TODO : add Listen to the view
			// eventMap.mapListener(view,Event.ENTER_FRAME,onEnterFramView)
			 eventMap.mapListener(view.stage,Event.RESIZE,onResize);
			 eventMap.mapListener(view,MouseEvent.MOUSE_OVER,onViewMouseOver)	;
			 eventMap.mapListener(view,MouseEvent.MOUSE_OUT,onViewMouseOut);
			 eventMap.mapListener(view,MouseEvent.MOUSE_DOWN,onViewMouseDown)	;
			 eventMap.mapListener(view,MouseEvent.MOUSE_UP,onViewMouseUp);
			 
			// eventMap.mapListener(view.mc_bad,MouseEvent.CLICK,onBadMouseClick);
			 eventMap.mapListener(view,MouseEvent.CLICK,onViewMouseClick);
			 eventMap.mapListener(view.mc_door,MouseEvent.CLICK,onDoorMouseClick);
			 eventMap.mapListener(view.mc_blaka,MouseEvent.CLICK,onBlakaMouseClick);
			//TODO : add Listen to the context
			 eventMap.mapListener(eventDispatcher,GameEvent.ADD_ACTION,onAddActionEat )	;
			 eventMap.mapListener(eventDispatcher,GameEvent.ADD_DOG,onAddDog )	;
			 eventMap.mapListener(eventDispatcher,GameEvent.FINISH_FOOD_DRINK,onFinishFoodDrink);
			 eventMap.mapListener(eventDispatcher,GameEvent.DATA_HAWLI_CHANGED,onHawliDataChange);
			 eventMap.mapListener(eventDispatcher,GameEvent.CHANGE_ENVIRONNEMENT,onDoChangeEnvironnement);
			 eventMap.mapListener(eventDispatcher,GameEvent.SOUND_EFFET,onChangeSoundEffect);
			 eventMap.mapListener(eventDispatcher,GameEvent.SHOW_MOUSE,onShowMouse);
			 view.cacheAsBitmap=true;
			//view.mc_water_container.gotoAndStop(0);
			 inBarnElements=[view.mc_bad,view.mc_water_container,view.mc_food_container,view.mc_window,view.mc_door]
			 outBarnElements=[view.mc_tban,view.mc_blaka];
			 for (var i:int = 0; i < outBarnElements.length; i++) 
			 {
				 outBarnElements[i].visible=false;
			 }
			 resize();
		}
		
		private function onShowMouse(e:GameEvent):void
		{
			Mouse.show();
			
		}
		
		private function onAddDog(e:GameEvent):void
		{
			trace(this+"onAddDog "+e.body); 
			if(e.body is DogVo){
			trace(this+"onAddDog "+(e.body as DogVo).id);	
			  if(gameModel.environnent==1){
			   view.mc_dog.gotoAndStop((e.body as DogVo).id+1);
			  } 
			  dispatch(new GameEvent(GameEvent.SEND_UPDATE_DOG,e.body));
			}
				 
			
		}
		
		private function onHawliDataChange(e:GameEvent):void
		{
			
			if(gameModel.isDeath) return;
			if(gameModel.userVo.hawliVo.state != gameModel.environnent){
				if(gameModel.userVo.hawliVo.state==0)
					setIn()
				else
					setOut();
				
				dispatch(new GameEvent(GameEvent.CHANGE_ENVIRONNEMENT,new Object()));
			}
			if(!view.hasEventListener(Event.ENTER_FRAME)){
				eventMap.mapListener(view,Event.ENTER_FRAME,onEnterFramView)
			}
			
		}
		private function onChangeSoundEffect(e:GameEvent):void
		{
			if(e.body){
				trace(this+" onChangeSoundEffect "+e.body);
				
				TweenLite.to(view, 0, {volume:1});
			}else{
				trace(this+" onChangeSoundEffect "+e.body);
				
				TweenLite.to(view, 0, {volume:0});
			}
			
		}
		private function onBlakaMouseClick(e:MouseEvent):void
		{
			if(gameModel.activeAction==OperationTypes.NONE && !gameModel.isBusy && !gameModel.changingEnv){
				gameModel.changingEnv=true;	
				dispatch(new GameEvent(GameEvent.HAWLI_TO_IN,new Point(view.mc_blaka.x,view.mc_blaka.y)));
			}
		}
		
		private function onDoChangeEnvironnement(e:GameEvent):void
		{

			animateChangeEnvironnement();
			dispatch(new GameEvent(GameEvent.SEND_CHANGE_ENV,gameModel.environnent));
				
		}
		private function animateChangeEnvironnement():void{
			trace(this+" onDoChangeEnvironnement ")
			if(gameModel.environnent==0){
				gameModel.environnent=1;
				setTimeout(function(){ 
					
					setOut();
				},1200);
				
			}else{
				gameModel.environnent=0;
				setTimeout(function(){ 
					
					setIn();
				},1200);
			}
		}
		private function setIn():void{
			view.mc_fond.gotoAndStop(1);
			for (var i:int = 0; i < inBarnElements.length; i++) 
			{
				inBarnElements[i].visible=true;
			}
			for (var i:int = 0; i < outBarnElements.length; i++) 
			{
				outBarnElements[i].visible=false;
			}
			
			//if(gameModel.userVo.hawliVo.dog>-1){
			  view.mc_dog.gotoAndStop(1);
			//}
			view.mc_door.gotoAndStop(1);
			gameModel.changingEnv=false;
		}
		private function setOut():void{
			view.mc_fond.gotoAndStop(2)
			for (var i:int = 0; i < inBarnElements.length; i++) 
			{
				inBarnElements[i].visible=false;
			}
			for (var i:int = 0; i < outBarnElements.length; i++) 
			{
				outBarnElements[i].visible=true;
			}
			if(gameModel.userVo.hawliVo.dog>-1){
				view.mc_dog.number_hits=gameModel.userVo.hawliVo.attack+1;
				view.mc_dog.gotoAndStop((gameModel.userVo.hawliVo.dog+1));
			}else{
				// 
				view.mc_dog.dog_name=(gameModel.dogsUnit[Math.abs(gameModel.userVo.hawliVo.dog)-1] as DogVo).name;
				view.mc_dog.gotoAndStop(6);
			}
			 
			
			gameModel.changingEnv=false;
			
		}
		
		private function onViewMouseUp(e:MouseEvent):void
		{
			if(gameModel.activeAction==OperationTypes.CHANGE_LOCATION){
				if(currentCursor){
					currentCursor.gotoAndStop(1)
				}
			}
			
		}
		
		private function onViewMouseDown(e:MouseEvent):void
		{
			if(gameModel.activeAction==OperationTypes.CHANGE_LOCATION){
				if(currentCursor){
					currentCursor.gotoAndStop(2)
				}
			}
			
		}
		
		private function onDoorMouseClick(e:MouseEvent):void
		{
			trace(this+"onDoorMouseClick")
			//dispatch(new GameEvent(GameEvent.SEND_UPDATE_CASH,1000))// a enlever
			//dispatch(new GameEvent(GameEvent.HAWLI_TO_SLEEP,new Point(view.mc_bad.x,view.mc_bad.y))); 
			if(gameModel.activeAction==OperationTypes.NONE && !gameModel.isBusy)
			if(!gameModel.changingEnv){
				gameModel.changingEnv=true;	
			    view.mc_door.gotoAndPlay(3);
			    dispatch(new GameEvent(GameEvent.HAWLI_TO_OUT,new Point(view.mc_door.x,view.mc_door.y))); 
			}
		}
		
		private function onViewMouseClick(e:MouseEvent):void
		{
			trace(this+"onViewMouseClick")
			if(gameModel.activeAction==OperationTypes.ERASE_FLIES){
			 
				if(currentCursor==view.mc_erase_moche){
					currentCursor.play();
				}
				//currentCursor.visible=true;
			}
			if(gameModel.activeAction==OperationTypes.ERASE_DROPPINGS){
				if(currentCursor==view.mc_bala){
					currentCursor.play();
				}
			}
			if(gameModel.activeAction==OperationTypes.CAMERA){
				if(currentCursor==view.mc_camera && !screenShot){
					currentCursor.visible=false;
					currentCursor.play();
					screenShot=new ApplicationScreenShotMain();
					screenShot.box=this.view;
					screenShot._filename= ((new Date()).time+"")+".png";
					screenShot.takeSnapshot(new Rectangle(view.mc_camera.x-view.mc_camera.width/2,view.mc_camera.y-view.mc_camera.height/2,view.mc_camera.width,view.mc_camera.height));
					screenShot.uploadSnapshot();
					screenShot.addEventListener("UploadDone",onUploadDone);
					currentCursor.visible=true;
					setTimeout(function(){
						                    gameModel.activeAction=OperationTypes.NONE ;
						                    currentCursor.visible=false;
											//screenShot=null;
					                      },1000);
				}
			}
			
		}
		
		protected function onUploadDone(event:Event):void
		{
			gameModel.imageToPublish="http://"+SettingVo.SERVER+"/jawla/hawli/images/hwala/"+screenShot._filename;//www.fb-concours.com
			screenShot=null;
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_SHARE));
			
		}
		
		private function onViewMouseOut(e:MouseEvent):void
		{
			 if(currentCursor){
				 currentCursor.visible=false;
				 Mouse.show();
			 }
			
		}
		
		private function onViewMouseOver(e:MouseEvent):void
		{
			if(gameModel.activeAction==OperationTypes.CARESS ){
				Mouse.hide();
				currentCursor=view.mc_drag_icone;
				currentCursor.visible=true;
				
			}else if(gameModel.activeAction==OperationTypes.ERASE_FLIES){
				Mouse.hide();
				currentCursor=view.mc_erase_moche;
				currentCursor.visible=true;
			}else if(gameModel.activeAction==OperationTypes.ERASE_DROPPINGS){
				Mouse.hide();
				currentCursor=view.mc_bala;
				currentCursor.visible=true;
			}else if(gameModel.activeAction==OperationTypes.CHANGE_LOCATION){
				Mouse.hide();
				currentCursor=view.mc_drag_hawli;
				currentCursor.visible=true;
			}else if(gameModel.activeAction==OperationTypes.NONE){
				Mouse.show();
				currentCursor=null;
				//currentCursor.visible=true;
			}else if(gameModel.activeAction==OperationTypes.CAMERA){
				Mouse.hide();
				currentCursor=view.mc_camera;
				currentCursor.visible=true;
				//currentCursor.visible=true;
			}
			
			
			
		}
		
		private function onFinishFoodDrink(e:GameEvent):void
		{
			if(e.body is FoodVo){
				//view.mc_food_container.spriteSheet.gotoAndStop(1);
				view.mc_food_container.gotoAndPlay(16);
			}else{
				//view.mc_water_container.spriteSheet.gotoAndStop(1);
				view.mc_water_container.gotoAndPlay(20);
			}
			
		}
		
		private function onAddActionEat(e:GameEvent):void
		{
			 
		    trace(this+" gameModel.environnent : "+gameModel.environnent);
			if(gameModel.changingEnv || gameModel.environnent==1) return;  
			if(e.body is FoodVo){
				if(!gameModel.haveFoodAction()){
			        addFood(e.body);
					gameModel.listActionToDo.push(e.body);
					
				}
			 
			}else if(e.body is WaterVo){
				if(!gameModel.haveWaterAction()){
					addWater(e.body as WaterVo)
					gameModel.listActionToDo.push(e.body);
				}
			}
			
		}
		
		private function addWater(param:WaterVo):void
		{
			view.mc_water_container.water=param.id;
			view.mc_water_container.gotoAndPlay(2);//spriteSheet.gotoAndStop(param.id);
		}
		
		private function addFood(body:FoodVo):void
		{
			trace(this+"addFood "+body.id)
			view.mc_food_container.food=body.id;
			view.mc_food_container.gotoAndPlay(2);//spriteSheet.gotoAndStop(body.id);	
		}
		
		private function onResize(e:Event):void
		{
			
			resize();
		}
		
		private function resize():void
		{
		 
			view.y=int((view.stage.stageHeight-view.height)/2)+30
				
			if(view.width < view.stage.stageWidth ){
				view.x = (view.stage.stageWidth-view.width)/2;
				return;
			}	
			 if (view.x < view.stage.stageWidth-view.width)
			{
				view.x = view.stage.stageWidth-view.width // view.stage.stageWidth;
			}
			else if (view.x > 0)
			{
				view.x = 0 ;
			} 
		}
		
		private function onEnterFramView(e:Event):void
		{
			
			onTick();
			checkTache();
			checkIconeCursor(); 
			checkFlisAndDroppings();
			checkPerspectiveHawli();
			//checkSpin();
			checkIA();
		}
		
		private function checkSpin():void
		{
			if(gameModel.timerCount > 22500 && !gameModel.isSpined){
				dispatch(new GameEvent(GameEvent.ACTIVE_SPIN,true));
				gameModel.isSpined=true;
				trace(this+"checkSpin =");
			}
		}
		
		private function checkIA():void
		{
			if(gameModel.isDeath) return
			gameModel.timerCount++
				//trace(this+"(gameModel.timerCount%1000)"+(gameModel.timerCount%1000));
			if(Math.random()>0.7 &&
				(gameModel.timerCount%1000)==0 && 
				(!gameModel.isBusy && gameModel.activeAction==OperationTypes.NONE) && 
				!gameModel.isSleeping && 
				!gameModel.isDraggin &&
				!gameModel.changingEnv){
			   // aller dormir
			  dispatch(new GameEvent(GameEvent.HAWLI_TO_SLEEP,new Point(view.mc_bad.x,view.mc_bad.y))); 
			}
			if(Math.random()>0.2 && 
				(gameModel.timerCount%400)==0 && 
				(!gameModel.isBusy && gameModel.activeAction==OperationTypes.NONE) && 
				!gameModel.isSleeping  && 
				!gameModel.isDraggin &&
			    !gameModel.changingEnv){
				//aller a une position aleatoir
				goRandomPosition();
			}
			
			if(Math.random()>0.5 && (gameModel.timerCount%1300)==0  ){
			     // jouer l'animation diiib
				 view.mc_window.play();
			}
		}
		
		private function goRandomPosition():void
		{
		   	var pos:Point=new Point(130+(Math.random()*(gameModel.farm_width-100)),(SettingVo.YHAWLI-100)+Math.random()*100);
            dispatch(new GameEvent(GameEvent.WALK_TO_POSITION,pos));
		}
		
		private function checkPerspectiveHawli():void
		{
			if(!view.hawliView) return ;
			var scale:Number=Math.abs(view.hawliView.y-SettingVo.YHAWLI)/(100);
			var scaleMin:Number=(0.15)*(scale);
			
			//trace(this+" scale "+(1-scaleMin));
			view.hawliView.scaleX=view.hawliView.scaleY=(1-scaleMin);
			if(gameModel.isDraggin && view.mouseX > 280 && view.mouseX < (gameModel.farm_width-440) ){
				view.hawliView.x=view.mouseX;	
			}
			
		}
		
		private function checkFlisAndDroppings():void
		{
			if(gameModel.userVo && gameModel.userVo.hawliVo) {
			//	trace(this+"gameModel.userVo.hawliVo.happiness "+gameModel.userVo.hawliVo.happiness)
				if(gameModel.userVo.hawliVo.happiness < SettingVo.MAX_HAPINESS_VALUE/3 )
					createBug();
				if(gameModel.userVo.hawliVo.happiness < SettingVo.MAX_HAPINESS_VALUE/5 )
					createDroppings();
				
				
				if(bugZone){
					TweenLite.to(bugZone,9,{x:view.hawliView.x});
					if(view.mc_erase_moche.hit ){
						if(bugZone.bugHit(view.mc_erase_moche.hit)){
						var operation:OperationVo=OperationsModel.ERASE_FLIES;
						dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operation));
						}// 
					}
				}
				if(droppings){
					//TweenLite.to(bugZone,9,{x:view.hawliView.x});
					if(view.mc_bala.hit ){
						if(droppings.hit(view.mc_bala.hit)){
							view.mc_bala.gotoAndPlay("stars");	
						var operation:OperationVo=OperationsModel.ERASE_FLIES;
						dispatch(new OperationEvent(OperationEvent.USER_OPERATION,operation));
						}// 
					}
				}
			}
		}
		
		private function createDroppings():void
		{
			if(droppings || (droppings && droppings.numChildren>0 )) return ;
			droppings=new DroppingsZone();
			droppings.x=300//Sview.hawliView.x;
			droppings.y=SettingVo.YHAWLI-100;
			view.addChildAt(droppings,view.getChildIndex(view.hawliView));
			droppings.createDroppings(10);
			
		}
		
		private function checkIconeCursor():void
		{
			if(currentCursor){
				currentCursor.x=view.mouseX;
				currentCursor.y=view.mouseY;
			}
			
		}
		
		private function checkTache():void
		{
			if(gameModel.listActionToDo.length){
				if( !gameModel.isBusy){
					if(gameModel.listActionToDo[0] is FoodVo){
					 dispatch(new GameEvent(GameEvent.HAWLI_TO_FOOD,{pos:new Point(view.mc_food_container.x,SettingVo.YHAWLI),food:gameModel.listActionToDo[0]}));
					 gameModel.isBusy=true	
					}else if(gameModel.listActionToDo[0] is WaterVo){
						dispatch(new GameEvent(GameEvent.HAWLI_TO_FOOD,{pos:new Point(view.mc_water_container.x,SettingVo.YHAWLI),food:gameModel.listActionToDo[0]}));
						gameModel.isBusy=true	
					}
				}
			}
			
		}
		
		
		private function createBug():void{
			//trace(this+" createBug ");
			if(bugZone) return ;
			bugZone=new BugZone();
			bugZone.x=600;
			bugZone.y=view.hawliView.y;
			view.addChildAt(bugZone,view.getChildIndex(view.hawliView)+1);
			bugZone.createBug(10);
		}
		
		
		
		public function onTick():void{
			//ExternalInterface.call("console.log"," mouseX  "+ view.stage.mouseX);
			if(view.width < view.stage.stageWidth ){
				view.x = (view.stage.stageWidth-view.width)/2;
				return ;
			}
			
			if(view.stage.mouseX && view.stage.mouseX > 0 && view.stage.mouseX < view.stage.stageWidth )
			if (view.stage.mouseY < view.stage.stageHeight-20)
			{
				if (view.stage.mouseX < 253 && view.x <  0 - (253- view.stage.mouseX) / 10)
				{
					view.x = view.x + (253 - view.stage.mouseX) / 10;
				}
				else if (view.stage.mouseX > (view.stage.stageWidth-230) && view.x > (view.stage.stageWidth-view.width) + (view.stage.mouseX - (view.stage.stageWidth-230)) / 10)
				{
					view.x = view.x - (view.stage.mouseX - (view.stage.stageWidth-230)) / 10;
				}
				else if (view.stage.mouseX < 253)
				{
					view.x = 0 // view.stage.stageWidth;
				}
				else if (view.stage.mouseX > view.stage.stageWidth-230)
				{
					view.x = view.stage.stageWidth-view.width;
				} 
				
			} 
		}
	}
}
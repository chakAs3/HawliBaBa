/*
 * Copyright (c) 2012 the original author or authors
 
 */

package com.hawli.view
{
 
	import classes.quietless.core.ApplicationScreenShotMain;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.Cryptage;
	import com.hawli.model.GameModel;
	import com.hawli.model.OperationTypes;
	import com.hawli.model.StatsModel;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.model.vo.SettingVo;
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.sounds.Ambiance;
	import com.mtc.InscriptionModel;
	import com.mtc.managers.ToolTipManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.system.Security;
	import flash.utils.setTimeout;
	
	import mx.core.mx_internal;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class MainScreenMediator extends Mediator
	{
		[Inject]
		public var view:MainScreenView;
		
		[Inject]
		public var statsModel:StatsModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public var currentEnvironnementView:IEnvironnementView

		private var hawli:HawliView;

		private var ambianceSound:Sound;

		private var chanelAmbiance:SoundChannel;
		
		public function MainScreenMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		
		override public function onRegister():void
		{
			Security.allowDomain("fb-concours.com","facebook.com");
		//	var _k:*=String(new key()) ;
			//gameModel.key=_k;
			//Cryptage.key=_k;
			
			gameModel.userVo.id=view.root.loaderInfo.parameters.userid ||  gameModel.userVo.id ;
			
			if(InscriptionModel.userInfo && InscriptionModel.userInfo.userid ){
				gameModel.userVo.id=InscriptionModel.userInfo.userid;
			//gameModel.userVo.id=212;
			 ExternalInterface.call("console.log",InscriptionModel.userInfo.id);
			 ExternalInterface.call("console.log",InscriptionModel.userInfo.id_fb );
			 loadImageFace("https://graph.facebook.com/"+InscriptionModel.userInfo.id+"/picture");
			}
			// Listen to the view
			eventMap.mapListener(view.stage,Event.RESIZE,onResizeStage);
			eventMap.mapListener(view.containerEnvironnement,MouseEvent.CLICK,onClickViewScreen);
		    eventMap.mapListener(view,ViewEvent.OPERATION_CLICKED,onOperationClickItem);
			eventMap.mapListener(view.btn_spin,MouseEvent.CLICK,onSpinClick);
			eventMap.mapListener(view.btn_dog,MouseEvent.CLICK,onDogClick);
			eventMap.mapListener(view.mc_invite,MouseEvent.CLICK,onInviteClick);
			eventMap.mapListener(view.mc_order,MouseEvent.CLICK,onClassementClick);
			eventMap.mapListener(view.btn_phone,MouseEvent.CLICK,onPhoneClick);
			eventMap.mapListener(view.btn_camera,MouseEvent.CLICK,onCameraClick);
				// Listen to the context
			view.createView(gameModel.operationsUser);
			eventMap.mapListener(eventDispatcher, GameEvent.VALIDE_HAWLI, onValideHawli);
			eventMap.mapListener(eventDispatcher, GameEvent.DATA_HAWLI_CHANGED, dataHawliChanged);
			eventMap.mapListener(eventDispatcher,GameEvent.CHANGE_ENVIRONNEMENT,onDoChangeEnvironnement);
			eventMap.mapListener(eventDispatcher,GameEvent.ACTIVE_SPIN,onDoActiveSpin);
			
			
			setEnvironnent(gameModel.environnent);
			dispatch(new GameEvent(GameEvent.ACTIVE_SPIN,false));
			view.resize();
			var cc:ToolTipManager=new ToolTipManager();
			cc.addItem(view.btn_dog,"Acheter un chien");
			//cc.addItem(view.mc_cash,"ton argent");
			cc.addItem(view.mc_order,"Classement");
			cc.addItem(view.btn_spin,"Roue de la Chance");
			cc.addItem(view.mc_invite,"Inviter");
			cc.addItem(view.btn_phone,"Astuces du jeu");
			cc.addItem(view.btn_camera,"Photographier");
			//lauchSoundAmbiance();
		}
		
		private function onCameraClick(e:MouseEvent):void
		{
			/*var screenShot:ApplicationScreenShotMain=new ApplicationScreenShotMain();
			screenShot.box=this.view.containerEnvironnement;
			screenShot._filename=Cryptage.encrypt((new Date()).time+"")+".jpg";
			screenShot.takeSnapshot(new Rectangle(30,30,400,400));
			screenShot.uploadSnapshot();*/
			gameModel.activeAction=OperationTypes.CAMERA
			
		}		
		
		
		private function onPhoneClick(e:MouseEvent):void
		{
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_TIPS));
			
			
		}
		
		private function onClassementClick(e:MouseEvent):void
		{
			 
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_CLASSEMENT));
		}
		
		private function onInviteClick(e:MouseEvent):void
		{
			 dispatch(new GameEvent(GameEvent.SHOW_POPUP_INVITE));
			
		}
		
		private function loadImageFace(param0:String):void
		{
			var imageLoad:ImageLoader=new ImageLoader(param0,{name:"photoTeam", estimatedBytes:2400, container:view.mc_profile.mc_avatar, alpha:1, width:50, height:50, scaleMode:"proportionalInside"});
		 imageLoad.load();
		}
		
		private function onDogClick(e:MouseEvent):void
		{
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_DOGS));
			
		}
		
		private function onDoActiveSpin(e:GameEvent):void
		{
			trace(this+" onDoActiveSpin "+e.body) 
			if(!e.body){
				
				// TweenMax.to(view.btn_spin, 0.3, {colorMatrixFilter:{ amount:1, brightness:1.3, saturation:0.2}});
				// view.btn_spin.mouseEnabled=false;
				 view.btn_spin.gotoAndStop(1);
				 gameModel.timeToSpin*=2;
				 view.btn_spin.lanceTimer(gameModel.timeToSpin);
			}else{
				// TweenMax.to(view.btn_spin, 0.3, {colorMatrixFilter:{ amount:1, brightness:1, saturation:1}});
				 view.btn_spin.mouseEnabled=true;
			 }
				 
			
		}
		
		private function onSpinClick(e:Event):void
		{
			if(view.btn_spin.currentFrame==2)
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_SPIN));
			//view.btn_spin.visible;
		}
		
		private function onDoChangeEnvironnement(e:GameEvent):void
		{
			if(!e.body){
			view.calc_off.gotoAndPlay(1);
			setTimeout(function(){view.calc_off.gotoAndPlay(21)},1400);
			}else{
				
			}
			
			if(gameModel.environnent==0){
			   view.active(3,false);
			   view.active(2,false);
			}else if(gameModel.environnent==1){
				view.active(3);
				view.active(2);
			}
			
		}
		private function setEnvironnent(envi:int):void{
			///if(envi==0){
				if(view.containerEnvironnement.numChildren )
				view.containerEnvironnement.removeChildAt(0);	
				currentEnvironnementView=	new BarnView();
			    view.containerEnvironnement.addChild(currentEnvironnementView as Sprite);
				view.containerEnvironnement.visible=true;
	    	/*}else if(envi==1){
				if(view.containerEnvironnement.numChildren )
				view.containerEnvironnement.removeChildAt(0);
				currentEnvironnementView=	new OutBarnView();
				view.containerEnvironnement.addChild(currentEnvironnementView as Sprite);	
			}*/
		}
		
		private function dataHawliChanged(e:GameEvent):void
		{
			 
			if(gameModel.isDeath) return;
			gameModel.userVo.hawliVo=HawliVo(e.body) ;
			trace(this+"dataHawliChanged "+HawliVo(e.body).weight)
			if(!hawli){
				addHawliToView();
				view.containerEnvironnement.visible=true;
			    
			}
				if(gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.weight).level != gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.lweight).level){
				 dispatch(new GameEvent(GameEvent.SHOW_POPUP_UPGARDLEVEL));
			    }
			    trace(this+"level "+gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.weight).level)
			    trace(this+"last level "+gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.lweight).level)
			if(gameModel.userVo.hawliVo.session!=gameModel.getSession()){
				dispatch(new GameEvent(GameEvent.SHOW_POPUP_ALERT,"Vous êtes connecté sur une autre fenètre"));
				eventMap.unmapListeners();
			}
			updateDataView();
		}
		
		private function onClickViewScreen(e:MouseEvent):void
		{
			
			if(gameModel.isDeath || !Sprite(currentEnvironnementView) || gameModel.activeAction!=OperationTypes.NONE  || gameModel.isBusy ) return;
			trace(this+" e.target.name " +e.target.name)
			if(e.target.name=="mc_fond" && !gameModel.changingEnv){
			  var pos:Point=new Point(Sprite(currentEnvironnementView).mouseX,Sprite(currentEnvironnementView).mouseY);
			  eventDispatcher.dispatchEvent(new GameEvent(GameEvent.WALK_TO_POSITION,pos));
			}
		}
		
		private function onValideHawli(e:GameEvent):void
		{
			gameModel.userVo.hawliVo=HawliVo(e.body) ;
			hawli = new HawliView();
			hawli.x = Math.random() * (gameModel.farm_width-hawli.width)+hawli.width;
			hawli.y = SettingVo.YHAWLI//Math.random() * 375+hawli.height; 
		    currentEnvironnementView.addHawli(hawli);
			
			
			updateDataView();
			dispatch(new GameEvent(GameEvent.SEND_CREATE_HAWLI,gameModel.userVo.hawliVo));
			//dispatch(new GameEvent(GameEvent.GET_DATA_HAWLI_TIMER));
			
		}
		private function addHawliToView():void{
			hawli = new HawliView();
			hawli.x = Math.random() * (gameModel.farm_width-hawli.width)+hawli.width;
			hawli.y = SettingVo.YHAWLI//Math.random() * 375+hawli.height; 
			currentEnvironnementView.addHawli(hawli);
			//updateDataView();
			view.btn_spin.lanceTimer(gameModel.timeToSpin);
		}
		public function updateDataView():void{
			view.mc_profile.txt_name_user.text=gameModel.userVo.name;
			view.mc_profile.txt_name_hawli.text=gameModel.userVo.hawliVo.name;
			
			view.mc_cash.txt_cash.text=gameModel.userVo.hawliVo.cash+" DH";
			view.mc_weight.txt_weight.text=(gameModel.userVo.hawliVo.weight/1000).toFixed(2)+" KG";
			
			var ojectLevel:Object=gameModel.getPercentLevelWeight(int(gameModel.userVo.hawliVo.weight))
			view.mc_weight.setPurcent(ojectLevel.level,ojectLevel.purcent);
			
			view.mc_bars.bar_hapiness.mc_progress.scaleX=gameModel.userVo.hawliVo.happiness/SettingVo.MAX_HAPINESS_VALUE;
			view.mc_bars.bar_food.mc_progress.scaleX=gameModel.userVo.hawliVo.food/SettingVo.MAX_FOOD_VALUE;
			view.mc_bars.bar_water.mc_progress.scaleX=gameModel.userVo.hawliVo.water/SettingVo.MAX_WATER_VALUE;
		     
			view.btn_dog.gotoAndStop((gameModel.userVo.hawliVo.dog>=0)?(gameModel.userVo.hawliVo.dog+1):1);
		}
		
		private function onOperationClickItem(ev:ViewEvent):void
		{
			 trace(this+" onOperationClickItem "+OperationVo(ev.body).idType);
			// gameModel.isBusy=false;
			 
			// if( gameModel.activeAction== OperationTypes.CARESS || gameModel.activeAction== OperationTypes.ERASE_FLIES || gameModel.activeAction== OperationTypes.ERASE_DROPPINGS )
				// gameModel.isBusy=false; 
			
			 switch(OperationVo(ev.body).idType)
			 {
				 case OperationTypes.GIVE_WATER:
				 {
					 gameModel.activeAction=OperationTypes.GIVE_WATER;
					 eventDispatcher.dispatchEvent(new GameEvent(GameEvent.SHOW_POPUP_WATER));
					 
					 break;
				 }
				 case OperationTypes.GIVE_FOOD:
				 {
					 gameModel.activeAction=OperationTypes.GIVE_FOOD;
					 eventDispatcher.dispatchEvent(new GameEvent(GameEvent.SHOW_POPUP_FOOD)); 
					 break;
				 }
				 case OperationTypes.CARESS:
				 {
					 //eventDispatcher.dispatchEvent(new GameEvent(GameEvent.DO_CARESS)); 
					// if(!gameModel.isBusy)
					 gameModel.activeAction=OperationTypes.CARESS;
					 //gameModel.isBusy=true;
					 break;
				 }
				 case OperationTypes.ERASE_FLIES:
				 {
					// eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HIT_HAWLI)); 
					// if(!gameModel.isBusy)
					 gameModel.activeAction=OperationTypes.ERASE_FLIES;
					// gameModel.isBusy=true;
					// view.calc_off.play();
					 break;
				 }
				 case OperationTypes.ERASE_DROPPINGS:
				 {
					 // eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HIT_HAWLI)); 
					 gameModel.activeAction=OperationTypes.ERASE_DROPPINGS;
					 break;
				 }
				 case OperationTypes.CHANGE_LOCATION:
				 {
					 // eventDispatcher.dispatchEvent(new GameEvent(GameEvent.HIT_HAWLI)); 
					// if(!gameModel.isBusy)
					 gameModel.activeAction=OperationTypes.CHANGE_LOCATION;
					 //gameModel.isBusy=true;
					 break;
				 } 		 
					 
				 default:
				 {
					
					 gameModel.activeAction=OperationTypes.NONE;
					
					 break;
				 }
			 }
			// gameModel.activeAction=OperationVo(ev.body).idType;
			// var operationEvent:OperationEvent=new OperationEvent(OperationEvent.USER_OPERATION,OperationVo(ev.body));
			// eventDispatcher.dispatchEvent(operationEvent);
		}
		
		private function onResizeStage(e:Event):void
		{
			 view.resize();
			
		}
		
		protected function onBallClicked(e:GameEvent):void
		{
			// Manipulate the view
		 
		}
	}
}
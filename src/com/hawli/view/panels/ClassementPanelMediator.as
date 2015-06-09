package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.DogVo;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.ui.ClassementItem;
	
	import emagin.components.scroller.EScroller;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ClassementPanelMediator extends Mediator
	{
		[Inject]
		public var view:ClassementPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;

		private var list:Array;

		private var scollPan:Sprite;
		public function ClassementPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClosePanel);
			 
			//TODO : add Listen to the context
		   eventMap.mapListener(eventDispatcher,GameEvent.CLASSEMENT_LOADED,onClassementLoaded);
		   dispatch(new GameEvent(GameEvent.GET_CLASSEMENT));
		}
		
		private function onClassementLoaded(e:GameEvent):void
		{
			eventMap.unmapListener(eventDispatcher,GameEvent.CLASSEMENT_LOADED,onClassementLoaded);
			view.mc_loader.visible=false
			list=(new Array(e.body))[0];
			scollPan=new Sprite();
			view.mc_container.addChild(scollPan);
			createListe();
			
		}		
		
		private function createListe():void
		{
			trace(this+" list "+list);
			scollPan.y=33;
			for (var i:int = 0; i < list.length; i++) 
			{
				var hvo:HawliVo=list[i] as HawliVo;
				//trace(this+" hvo "+hvo +"  "+(hvo is HawliVo)+"  "+(hvo as HawliVo));
				var classemntItem:ClassementItem=new ClassementItem();
				classemntItem.txt_num.text=" "+(i+1);
				classemntItem.txt_name.text=hvo.name;
				classemntItem.txt_weight.text=(hvo.weight/1000).toFixed(2)+" KG";
				classemntItem.txt_cash.text=hvo.cash+" DH";
				classemntItem.x=276;
				classemntItem.tete.visage.gotoAndStop(hvo.type+1);
				classemntItem.tete.custom.gotoAndStop(hvo.custom);
				if(hvo.dog>-1)
				classemntItem.dog.gotoAndStop(hvo.dog+1);
				else
				classemntItem.dog.gotoAndStop(1);
				classemntItem.y=(i*61);
				scollPan.addChild(classemntItem);
			}
			
			var scroller:EScroller=new EScroller(10,370);
			scroller.x=600+5;
			scroller.y=33;
			scroller.setScrolTarget(scollPan,370);
			view.mc_container.addChild(scroller);
		}
		
		private function onClickClosePanel(e:MouseEvent):void
		{
			
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}		
		
	 
	}
}
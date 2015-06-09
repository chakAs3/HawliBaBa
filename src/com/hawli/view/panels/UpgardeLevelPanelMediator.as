package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.managers.FaceBookGraph;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class UpgardeLevelPanelMediator extends Mediator
	{
		[Inject]
		public var view:UpgardeLevelPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;
		public function UpgardeLevelPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClose);
			eventMap.mapListener(view.btn_publish,MouseEvent.CLICK,onClickPublish);
			 
			//TODO : add Listen to the context
			
			view.txt_kilo.text=(gameModel.userVo.hawliVo.weight/1000)+"";
			view.txt_level.text=gameModel.getPercentLevelWeight(gameModel.userVo.hawliVo.weight).level+"";
		    
			view.mc_partage.txt_publication.text="7awli Ba3 Ba3 J'ai participé au jeu Maroc Telecom et mon mouton a atteint le poid de "+(gameModel.userVo.hawliVo.weight/1000).toFixed(2)+"kg ";
			view.mc_partage.visible=false;
			view.mc_partage.alpha=0;
			eventMap.mapListener(view.mc_partage.btn_publish,MouseEvent.CLICK,onClickFacePublish);
		}
		
		private function onClickFacePublish(e:MouseEvent):void
		{
			 FaceBookGraph.publishToStream(view.mc_partage.txt_label.text,view.mc_partage.txt_publication.text);
			 dispatch(new GameEvent(GameEvent.SEND_UPDATE_CASH,1));
			 view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		}
		
		private function onClickPublish(e:MouseEvent):void
		{
			
			//ExternalInterface.call("shareFacebook",(gameModel.userVo.hawliVo.weight/1000),view.txt_level.text);
			view.mc_partage.visible=true;
			view.mc_partage.alpha=0;
			TweenLite.to(view.mc_partage,0.5,{alpha:1});
		}
		
		private function onClickClose(e:MouseEvent):void
		{
			
			trace(this+" onClickClosePanel ");
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}		
		
	 
	}
}
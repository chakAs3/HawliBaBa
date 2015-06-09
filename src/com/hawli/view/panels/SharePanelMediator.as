package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.greensock.loading.ImageLoader;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.managers.FaceBookGraph;
	
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SharePanelMediator extends Mediator
	{
		[Inject]
		public var view:SharePanelView;
		
		[Inject]
		public var gameModel:GameModel;

		private var index:int;
		public function SharePanelMediator()
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
			if(gameModel.imageToPublish)
			loadImageFace(gameModel.imageToPublish);
			view.txt_publication.text="J'ai participé au jeu 7awli Ba3 Ba3 de Maroc Telecom  ";
			 
			eventMap.mapListener(view.btn_publish,MouseEvent.CLICK,onClickFacePublish);
		}
		private function loadImageFace(param0:String):void
		{
			var imageLoad:ImageLoader=new ImageLoader(param0,{name:"photoShare", estimatedBytes:2400, container:view.mc_image, alpha:1, width:view.mc_image.width, height:view.mc_image.height, scaleMode:"proportionalInside"});
			imageLoad.load();
		}
		private function onClickFacePublish(e:MouseEvent):void
		{
			 FaceBookGraph.publishToStream(view.txt_label.text,view.txt_publication.text,gameModel.imageToPublish);
			 view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		}
		
		private function onClickPublish(e:MouseEvent):void
		{
			
			//ExternalInterface.call("shareFacebook",(gameModel.userVo.hawliVo.weight/1000),view.txt_level.text);
			view.mc_image.visible=true;
			view.mc_image.alpha=0;
			TweenLite.to(view.mc_image,0.5,{alpha:1});
		}
		
		private function onClickClose(e:MouseEvent):void
		{
			
			trace(this+" onClickClosePanel ");
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}		
		
	 
	}
}
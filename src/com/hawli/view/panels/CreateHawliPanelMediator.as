package com.hawli.view.panels
{
	import com.hawli.controller.CreateHawliCommand;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.vo.HawliVo;
	import com.hawli.view.events.ViewEvent;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class CreateHawliPanelMediator extends Mediator
	{
		[Inject]
		public var view:CreateHawliPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function CreateHawliPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClosePanel);
			eventMap.mapListener(view.btn_valider,MouseEvent.CLICK,onClickValidePanel);
			view.btn_close.visible=false;
			//TODO : add Listen to the context
		}
		
		private function onClickValidePanel(e:MouseEvent):void
		{
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			var gender:String=	MovieClip(view.mc_selection.tete.visage).currentLabel;
			var custom:int=MovieClip(view.mc_selection.tete.custom).currentFrame;
			gameModel.userVo.hawliVo=new HawliVo(0,gameModel.userVo.id,20,20,0,"HAGA",300,gameModel.getIdfromLabel(gender),0);
			gameModel.userVo.hawliVo.gender=gender;
			gameModel.userVo.hawliVo.custom=custom;
			gameModel.userVo.hawliVo.type=gameModel.getIdfromLabel(gender);
			gameModel.userVo.hawliVo.name=view.txt_name.text;
			gameModel.userVo.hawliVo.session=gameModel.getSession();
			eventDispatcher.dispatchEvent(new GameEvent(GameEvent.VALIDE_HAWLI,gameModel.userVo.hawliVo));
		}
		
		private function onClickClosePanel(e:MouseEvent):void
		{	
		 
		  view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		}
	}
}
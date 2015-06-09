package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	import com.hawli.view.sounds.RolletteDemarrage;
	import com.hawli.view.sounds.RouletteWin;
	
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class SpinPanelMediator extends Mediator
	{
		[Inject]
		public var view:SpinPanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		public var spins:Array=[5,10,100,20,50,5,30,20];

		private var index:int;
		public function SpinPanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickClosePanel);
			eventMap.mapListener(view.btn_spin,MouseEvent.CLICK,onClickSpin);
			 
			//TODO : add Listen to the context
		}
		
		private function onClickSpin(e:MouseEvent):void
		{
			
			launchSpin() ;
			
		}		
		
		private function launchSpin():void
		{
			//gameModel.getRandomSpin();
			var randAngle:int=int(Math.random()*360);
			index=randAngle/(360/spins.length);
			
			TweenLite.to(view.mc_selector,10,{rotation:(360*7)+randAngle,ease:Quint.easeOut});
			TweenLite.to(view.mc_roullette,10,{rotation:-(360*2),ease:Quint.easeOut,onComplete:showResultat});
			
			//trace(this+" index  "+index)
			view.btn_spin.mouseEnabled=false;
			view.btn_spin.alpha=0.6;
			
			playSound();
			
		}		 
		
		private function playSound():void
		{
			var s:Sound=new RolletteDemarrage();
			s.play();	
		}
		
		private function showResultat():void
		{
			view.mc_result.txt_label.text=spins[index]+" DH ";
			view.mc_result.visible=true;
			view.mc_result.alpha=1;
			trace(this+"  showResultat  ")
			TweenLite.from(view.mc_result,0.5,{y:view.mc_result.y+30,alpha:0});
			var s:Sound=new RouletteWin();
			s.play();
			setTimeout(sendSpinValue,2000);
		}
		
		private function sendSpinValue():void
		{
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP)); 
			dispatch(new GameEvent(GameEvent.ACTIVE_SPIN,false));
			dispatch(new GameEvent(GameEvent.SEND_UPDATE_CASH,spins[index]))
		}
		
		private function onClickClosePanel(e:MouseEvent):void
		{
			
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP)); 
		}
	}
}
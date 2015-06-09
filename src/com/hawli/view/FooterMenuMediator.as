package com.hawli.view
{
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.StatsModel;
	import com.hawli.view.sounds.Ambiance;
	import com.mtc.components.EToggleButton;
	
	import flash.display.StageDisplayState;
	import flash.events.FullScreenEvent;
	import flash.events.MouseEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class FooterMenuMediator extends Mediator
	{
		[Inject]
		public var view:FooterMenuView;
		[Inject]
		public var gameModel:GameModel;

		private var ambianceSound:Ambiance;
		private var chanelAmbiance:SoundChannel;
		
		public function FooterMenuMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			
			// TODO : add Listen to the view
			eventMap.mapListener(view.btn_fullscreen,MouseEvent.CLICK,onFullScreenClick)
			eventMap.mapListener(view.btn_sound,MouseEvent.CLICK,onSoundClick);
			eventMap.mapListener(view.btn_sound_effect,MouseEvent.CLICK,onSoundEffectClick)
			eventMap.mapListener(view.btn_help,MouseEvent.CLICK,onHelpClick)	;
			eventMap.mapListener(view.stage,FullScreenEvent.FULL_SCREEN,onFullScreenChange)
				//TODO : add Listen to the context
		//	view.btn_sound_effect.visible=false;
			lauchSoundAmbiance();
		}
		private function lauchSoundAmbiance():void
		{
			ambianceSound=new Ambiance()
			chanelAmbiance=ambianceSound.play(0,130);
			
			
		}
		private function onFullScreenChange(e:FullScreenEvent):void
		{
			if(e.fullScreen){
				view.btn_fullscreen.setEtat(true);
			}else{
				view.btn_fullscreen.setEtat(false);
			}
			
		}
		private function onHelpClick(e:MouseEvent):void
		{
			dispatch(new GameEvent(GameEvent.SHOW_POPUP_HELP));
			
		}
		
		private function onSoundEffectClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			if(view.btn_sound_effect.selected){
				SoundMixer.stopAll();
				//gameModel.sound
				dispatch(new GameEvent(GameEvent.SOUND_EFFET,false));
			}else{
				//SoundMixer.
				dispatch(new GameEvent(GameEvent.SOUND_EFFET,true));
			}
			
		}
		
		private function onSoundClick(e:MouseEvent):void
		{
			// TODO Auto Generated method stub
			if(!view.btn_sound.selected){
				chanelAmbiance=ambianceSound.play();
			}else{
				chanelAmbiance.stop();
			}
				
			
		}
		
		private function onFullScreenClick(e:MouseEvent):void
		{
			if((e.currentTarget as EToggleButton).selected){
				view.stage.displayState=StageDisplayState.FULL_SCREEN;
			}else{
				view.stage.displayState=StageDisplayState.NORMAL;
			}
			
		}
	}
}
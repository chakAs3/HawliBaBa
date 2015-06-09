package emagin.components.ui {
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import emagin.VideoScreen;
	import emagin.components.EToggleButton;
	import emagin.components.media.ImageVignette;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class VideoPlayer extends MovieClip
	{
		public var video_screen:VideoScreen
		private var imageVgnette:ImageVignette;
		private var btn_BigPlay:EToggleButton;
		private var dim:Object;
		public function VideoPlayer(w:int=400,h:int=280) 
		{
			
			 
			dim = { w:w, h:h };
			video_screen = new VideoScreen(null,w,h, [0xE6B700,0x222222,  0xFFFFFF, VideoScreen.themeColor/*0x1179A6*/]);
			video_screen.setSize(w, h);
			//video_screen.bouclePlay = true; 
			addChild(video_screen);
			
			video_screen.mediaControler.btn_fullscreen.addEventListener(MouseEvent.CLICK,onClickFullSceen)
			
			//video_screen.playVideo()
			addEventListener(Event.ADDED_TO_STAGE, onAdded)
			addEventListener(Event.REMOVED_FROM_STAGE,onRemoved)
		}
		
		private function onAdded(e:Event):void 
		{
			stage.addEventListener(Event.FULLSCREEN,onChageFullScreen)
		}
		
		private function onRemoved(e:Event):void 
		{
			stage.removeEventListener(Event.FULLSCREEN, onChageFullScreen)
			video_screen.close();
		}
		
		private function onClickFullSceen(e:MouseEvent):void 
		{
			    //stage.addChild(video_screen);
				
			if (video_screen.mediaControler.btn_fullscreen.selected) {
				if (stage.displayState == "fullScreen" ) {
					onChageFullScreen(null);
				}
				stage.displayState = "fullScreen";
				 
			}else {
				stage.displayState = "normal";
			}
			
		}
		
		private function onChageFullScreen(e:Event):void 
		{
			if (stage.displayState == "fullScreen" && video_screen.mediaControler.btn_fullscreen.selected) {
				stage.addChild(video_screen);
				video_screen.setSize_(stage.stageWidth, stage.stageHeight);
				video_screen.mediaControler.btn_fullscreen.setEtat(true);
			}else {
				this.addChild(video_screen);
				video_screen.setSize_(dim.w, dim.h);
				video_screen.mediaControler.btn_fullscreen.setEtat(false);
			}
		}
		public function setVideoData(videoPath:String, imagePath:String):void {
			try{
			video_screen.setVideoFile(videoPath);//"upload/videos/video.flv";
			}catch(e:Error){
				
			}
			imageVgnette = new ImageVignette(imagePath);
		//	imageVgnette.load();
			imageVgnette.setSize(dim.w, dim.h);
			//addChild(imageVgnette);
			btn_BigPlay = new BigPlayButton();
			btn_BigPlay.addEventListener(MouseEvent.CLICK,onClickBigButton)
			//addChild(btn_BigPlay);
			centerBigPlayButton();
			onClickBigButton(null);
		}
		
		public function onClickBigButton(e:MouseEvent):void 
		{
			TweenMax.to(imageVgnette, 0.3, { autoAlpha:0 } );
			TweenMax.to(btn_BigPlay, 0.3, { autoAlpha:0 } );
			video_screen.playVideo();
		}
		public function centerBigPlayButton():void {
			btn_BigPlay.x = (dim.w)/2;
			btn_BigPlay.y = (dim.h)/2;
		}
	}
	
}
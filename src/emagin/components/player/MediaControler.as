package emagin.components.player 
{
	import flash.display.MovieClip;
	//import emagin.components.EButton;
	import emagin.components.ERectange;
	import emagin.components.EToggleButton;
	import emagin.components.player.events.ControlerEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class MediaControler extends Sprite
	{
		public var btn_play:EToggleButton;
		public var btn_Stop:EToggleButton;
		public var btn_fullscreen:EToggleButton;
		public var seekbar:SeekBar;
		
		
		
		public var volumControler:VolumControler;
		
		private var played:Boolean;
		
		public var txt_time:TextField
		
		public var mc_fond:Sprite;		public var mc_fond_seek:MovieClip;
		public function MediaControler(wi:int=400,colors:Array=null) 
		{
			
			//mc_fond=new ERectange(420,30,0x000000);
			//mc_fond.alpha=0.5;
			//mc_fond.y=-5;
			//addChild(mc_fond);
			
			
			//btn_play=new PlayButton();
			//btn_play.setSize(40,20);
			btn_play.toogleMode = true;
			btn_play.x = 0;
			btn_play.colors=[0xFFFFFF,colors[3]]
			btn_play.setEtat(true);
			
			//btn_Stop=new StopButton( );
			//btn_Stop.setSize(40,20);
		
			btn_Stop.visible = false;
			btn_Stop.x = btn_play.x //+ btn_play.width+5;
			btn_Stop.colors=[0x000000,colors[3]]
			
			seekbar=new SeekBar(colors);
			seekbar.x=btn_Stop.x+btn_Stop.width+10;
			seekbar.setWidth(200);
			
			btn_fullscreen.colors=[0xFFFFFF,colors[3]]
			
			
			//txt_time=new TextField();
			//txt_time.width=92;
			//txt_time.height=30
			txt_time.autoSize = TextFieldAutoSize.LEFT;
			txt_time.defaultTextFormat = new TextFormat("Arial", 9);
		    txt_time.text = "00:00";
			//txt_time.embedFonts = true;
			txt_time.height=10;
			
			volumControler = new VolumControler(colors);
			volumControler.visible = true;
			
			
			
			/***btn_play.x=20;***
			btn_Stop.x=70;*/
			//seekbar.x=120;
			seekbar.y=Math.round(height/2-seekbar.height/2+3);
			
			//txt_time.x=seekbar.x+seekbar.width+10;/******/
			txt_time.y=int((mc_fond.height-txt_time.height)/2) ;
			volumControler.x=wi-volumControler.width-20;/* **** */
			volumControler.y=int((mc_fond.height-volumControler.height)/2)    ;//seekbar.y
			
			
			addChild(btn_play)
			addChild(btn_Stop);
			addChild(seekbar);
			addChild(txt_time);
			addChild(volumControler);
			
			
			
			//setWidth(wi);
			
		   
			
			setListeners();
		 
		}
		public function setListeners():void{
			btn_play.addEventListener(MouseEvent.CLICK,onPlayClick);
			btn_Stop.addEventListener(MouseEvent.CLICK,onStopClick);
		}
		
		private function onStopClick(e:MouseEvent):void 
		{
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			event.event=ControlerEvent.STOP;
			dispatchEvent(event);
		}
		public function updateBarProgress(value:Number):void{
			trace(this+" updateBarProgress "+value)
			seekbar.setPosition(value);
		}
		public function setTimeInfo(time:String):void{
			trace(this+"  "+time)
			txt_time.text=time;
			//txt_time.x=int(volumControler.x-30-104+((104-txt_time.width)/2));
			txt_time.x=int(width-30-104+((104-txt_time.width)/2))-30;
			
		}
		
		private function onPlayClick(e:MouseEvent):void 
		{
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			trace(this+" Play Click   played= " +played);
			if(!played){
			  event.event=ControlerEvent.PLAY;
			  event.position=seekbar.mc_bar_progress.width / seekbar.mc_fond.width;
			  dispatchEvent(event);
			 // btn_play.setText("pause"); 
			}else{
			  event.event=ControlerEvent.PAUSE;
			  dispatchEvent(event);
			 // btn_play.setText("play");
			}
			//played=!played;
			
		}
		public function setPlayButton(play:Boolean):void{
			trace(this+" setPlayButton (play ="+play+")");
			played=play
			if(played){
			  btn_play.setEtat(true); 
			}else{	  
			  btn_play.setEtat(false);
			}
			
		}
		public function setWidth(wi:int):void{
			if(mc_fond.width==wi) return;
			mc_fond.width=wi;
			volumControler.x=wi-volumControler.width-105;
			txt_time.x=int(wi-10-txt_time.width-btn_fullscreen.width)//volumControler.x-30-txt_time.width;
			seekbar.setWidth(volumControler.x - seekbar.x - 10);
			btn_fullscreen.x = wi  - btn_fullscreen.width;
			mc_fond_seek.visible=false;
		//	mc_fond_seek.mc_fond.width=seekbar.width+20+46-10;			//mc_fond_seek.mc_fond1.width=seekbar.width+18+46-10;
			trace(this+"\n WIDTH  \n"+wi);
			
			
		}
		override public function get height():Number{
			return mc_fond.height;
		}
	}
	
}
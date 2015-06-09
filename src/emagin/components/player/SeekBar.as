package emagin.components.player 
{
	import emagin.components.ERectange;
	import emagin.components.player.events.ControlerEvent;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.geom.Rectangle;
	 
	 
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import com.greensock.*;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class SeekBar extends Sprite
	{
		public var mc_fond:Sprite
		public var mc_bar_progress:Sprite;
		public var mc_bar_loaded:Sprite;
		
		public var mc_cursor:Sprite;
		private var position:Number;
		
		private var update:Boolean=true;
		
		public var colors:Array=[0x000000,0x454545,0x777777,0x1555FF]
		private var rect_bar_mask:ERectange;
		private var mc_total:ERectange;
		
		
		public function SeekBar(colors:Array=null) 
		{
			this.colors=(colors)?colors:this.colors;
			
			mc_fond=new Sprite()
			//mc_fond.addChild(new ERectange(290,9,this.colors[0],0x00,false,null,9));
			addChild(mc_fond);
			
			mc_total=new ERectange(mc_fond.width-6,8,this.colors[2],0x00,false,null,0) 
			mc_total.x=3
			mc_total.y=3
			addChild(mc_total);
			
			mc_bar_loaded=new Sprite()
			mc_bar_loaded.y=3;
			mc_bar_loaded.x=3;
			mc_bar_loaded.alpha=1
			mc_bar_loaded.addChild(new ERectange(1 ,8,this.colors[0]));
			addChild(mc_bar_loaded);
			
			mc_bar_progress=new Sprite();
			mc_bar_progress.y=0;
			mc_bar_progress.x=3;
			//mc_bar_progress.addChild(new ERectange(1 ,3,this.colors[3]))
			//rect_bar_mask=new ERectange(mc_total.width ,3,0x1555FF,0x0,false,null,9);
			//rect_bar_mask.x=mc_total.x;
			//rect_bar_mask.y=mc_total.y;
			//addChild(rect_bar_mask);
			mc_bar_progress.mask=rect_bar_mask;
			mc_bar_loaded.mask=rect_bar_mask
			
			 
			addChild(mc_bar_progress);
			
			mc_cursor=new SeekCursorDrag();
			mc_cursor.y=-2;
			mc_cursor.buttonMode=true;
			
			//mc_cursor.addChild(new ERectange(4,14,0xFF0F01));
			addChild(mc_cursor);
			mc_cursor.addEventListener(MouseEvent.ROLL_OVER,onRollOverCursor)
			mc_cursor.addEventListener(MouseEvent.ROLL_OUT,onRollOutCursor)
			mc_cursor.addEventListener(MouseEvent.MOUSE_DOWN,onPRessCursor)
			mc_cursor.addEventListener(MouseEvent.MOUSE_UP,onReleaseCursor);
			
			mc_bar_loaded.addEventListener(MouseEvent.CLICK,onCLichBarLoad);
			mc_bar_progress.addEventListener(MouseEvent.CLICK,onCLichBarLoad);
			mc_bar_loaded.buttonMode=true;
			mc_bar_progress.buttonMode=true;
			
		
			
		}
		public function initDimension(wi:int):void{
			
			update=false
			removeChild(mc_fond);
			removeChild(mc_total);
			removeChild(mc_bar_progress);
			removeChild(mc_bar_loaded);
			
			trace(this+" initDimension  mc_total.width: "+mc_total.width)
			
			var currentPregress:Number =mc_total.width>0? mc_bar_progress.width / mc_total.width: 0.02;
			trace('currentPregress: ' + (currentPregress));
			var currentLoaded:Number =mc_total.width>0? mc_bar_loaded.width / mc_total.width : 0.01;
			
			mc_fond=new Sprite()
			mc_fond.addChild(new ERectange(wi,4,this.colors[0],0x00,false,null,0));
			
			addChild(mc_fond);
			
			mc_total=new ERectange(mc_fond.width,4,this.colors[2],0x00,false,null,0) 
			mc_total.x=0
			mc_total.y=0
			addChild(mc_total);
			
			mc_bar_loaded=new Sprite()
			mc_bar_loaded.y=0;
			mc_bar_loaded.x=0;
			mc_bar_loaded.alpha=1
			mc_bar_loaded.addChild(new ERectange(currentLoaded*mc_total.width ,4,this.colors[1]));			var sprite:Sprite=(mc_bar_loaded.addChild(new ERectange(currentLoaded*mc_total.width ,6,0xFFFFFF))) as Sprite;
			sprite.alpha=0;
			sprite.y=-3
			addChild(mc_bar_loaded);
			
			mc_bar_progress=new Sprite();
			mc_bar_progress.y=0;
			mc_bar_progress.x=0;
			mc_bar_progress.addChild(new ERectange(currentPregress*mc_total.width ,4,this.colors[3]))
			rect_bar_mask=new ERectange(mc_total.width ,3,0x1555FF,0x0,false,null,0);
			rect_bar_mask.x=mc_total.x;
			rect_bar_mask.y=mc_total.y;
			//addChild(rect_bar_mask)
			
			var rect_bar_l_mask:ERectange=new ERectange(mc_total.width ,3,0x1555FF,0x0,false,null,0);
			rect_bar_l_mask.x=mc_total.x;
			rect_bar_l_mask.y=mc_total.y;
			//addChild(rect_bar_l_mask);
			
			
			//mc_bar_progress.mask=rect_bar_mask;
			//mc_bar_loaded.mask=rect_bar_l_mask;
			
			 
			addChild(mc_bar_progress);
			
			//mc_cursor=new SeekCursorDrag();
			//mc_cursor.y=-1
			//mc_cursor.buttonMode=true;
			addChild(mc_cursor);
			mc_cursor.x = mc_bar_progress.width ;
			
			
			
			
			
			mc_bar_loaded.addEventListener(MouseEvent.CLICK,onCLichBarLoad);
			mc_bar_progress.addEventListener(MouseEvent.CLICK,onCLichBarLoad);
			mc_bar_loaded.buttonMode=true;
			mc_bar_progress.buttonMode=true;
			update=true;
			
			 trace(this+"after initDimension  mc_total.width: "+mc_total.width)
		}
		
		
		private function onCLichBarLoad(e:MouseEvent):void 
		{
			dispatchStopEvent();
			setPosition(this.mouseX/mc_fond.width);
			dispatchPlayAtEvent();
		}
		public function setPosition(purcent:Number):void{
			trace(this+" pourcent "+purcent+" "+update+"  "+mc_total.width)
			if(update){
			  mc_bar_progress.width=purcent*mc_total.width;
				trace('purcent*mc_total.widt: ' + (purcent * mc_total.width)+" ,mc_bar_progress.width "+mc_bar_progress.width);
				mc_cursor.x=mc_bar_progress.x+(purcent * mc_total.width)//mc_bar_progress.width;
			}
		}
		public function setWidth(wi:int):void{
			initDimension(wi);
		}
		public function setLoadedPosition(purcent:Number):void{
			//trace(this+" pourcent "+purcent)
			if(update){
			mc_bar_loaded.width=mc_total.x+purcent*mc_total.width;
			//mc_cursor.x=mc_bar_progress.x+mc_bar_progress.width;
			}
		}
		
		
		public function dispatchStopEvent():void{
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			event.event=ControlerEvent.STOP;
			 
			dispatchEvent(event);
		}
		public function dispatchPlayAtEvent():void{
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			event.event=ControlerEvent.PLAY;
			event.position=mc_cursor.x/mc_fond.width;
			dispatchEvent(event);
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			 
			if (e.eventPhase >= EventPhase.AT_TARGET ) onReleaseCursor(null);
		
		}
		
		
		
		
		/* function replay event Curssor */
		private function onReleaseCursor(e:MouseEvent):void 
		{
			mc_cursor.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			dispatchPlayAtEvent();
			//faut dipatcher l'evement strop
		}
		
		private function onPRessCursor(e:MouseEvent):void 
		{
			//faut dispatcher l'evenement drag start;
			dispatchStopEvent();
			mc_cursor.startDrag(false,new Rectangle( 0, mc_cursor.y, mc_total.width,0 ));
			
		    stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
		}
		
		private function onRollOutCursor(e:MouseEvent):void 
		{
			TweenMax.to(mc_cursor, 1, {colorMatrixFilter:{brightness:1}});
		}
		
		private function onRollOverCursor(e:MouseEvent):void 
		{
			//TweenLite.to(mc_cursor,0.5,{tint:0xFF5555});
			TweenMax.to(mc_cursor, 1, {colorMatrixFilter:{brightness:1.6}});
		}
		
		
		
		public function setSize(w:int,h:int):void{
			mc_fond.width=w;
			mc_fond.height=h; 	
		}
		
		/*
		flashmo_pointer.onPress = function()
   {
	       this.startDrag(true, flashmo_bar_bg._x, this._y, flashmo_bar_bg._width + flashmo_bar_bg._x, this._y );
	s.stop(); clearInterval(my_interval);
}
flashmo_pointer.onRelease = flashmo_pointer.onReleaseOutside = function()
{
	this.stopDrag();
	new_position = s.duration * (this._x - flashmo_bar_bg._x) / (flashmo_bar_bg._width * 1000);
	s.start(new_position); fm_play.gotoAndStop(1);
	my_interval = setInterval(update_bar, 100);
}
		*/
	}
	
}
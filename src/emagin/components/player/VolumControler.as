package emagin.components.player {
	import com.greensock.*;
	
	import emagin.components.ERectange;
	import emagin.components.EToggleButton;
	import emagin.components.player.events.ControlerEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class VolumControler extends Sprite
	{
		public var mc_fond:Sprite
		public var mc_bar_progress:Sprite;
		public var mc_zone:Sprite;
		private var position:Number;
		private var mc_total:ERectange;
		public var colors:Array=[0x000000,0x454545,0x777777,0xDE6B1E];
		private var rect_bar_mask:ERectange;
		
		private var muteButton:MovieClip;//EToggleButton;
		
		public var volum:Number=0;
		 
		public function VolumControler(colors:Array) 
		{
			
			if(colors)this.colors=colors;
			
			muteButton=new MovieClip();
			muteButton.x=-20;
			muteButton.toogleMode=true;
			muteButton.addEventListener(MouseEvent.CLICK,onMuteClick)
			addChild(muteButton);
			TweenLite.to(mc_bar_progress,0.01,{tint:colors[3]})
			
			var wi:int=56;
			//mc_fond=new Sprite()
			//mc_fond.addChild(new ERectange(wi,9,this.colors[0],0x00,false,null,9));
			//addChild(mc_fond);
			
			//mc_total=new ERectange(mc_fond.width-6,3,this.colors[2],0x00,false,null,3) 
			//mc_total.x=3
			//mc_total.y=3
			//this.addEventListener(MouseEvent.CLICK,onClickFond);
			//addChild(mc_total);
			
			 
			
			/*mc_bar_progress=new Sprite();
			mc_bar_progress.y=3;
			mc_bar_progress.x=3;
			mc_bar_progress.addChild(new ERectange(1 ,3,this.colors[3]))
			rect_bar_mask=new ERectange(mc_total.width ,3,0x1555FF,0x0,false,null,9);
			rect_bar_mask.x=mc_total.x;
			rect_bar_mask.y=mc_total.y;
			addChild(rect_bar_mask);
			mc_bar_progress.mask=rect_bar_mask;*/
			
			 
			addChild(mc_bar_progress);
			
			//mc_zone= new ERectange(mc_fond.width, mc_fond.height);
			mc_zone.alpha=0
			mc_zone.buttonMode=true;
			setCursorPostition(0.7);
			
			//mc_cursor.addChild(new ERectange(4,14,0xFF0F01));
			//addChild(mc_zone);
			
			
			//mc_cursor.addEventListener(MouseEvent.ROLL_OVER,onRollOverCursor)
			//mc_cursor.addEventListener(MouseEvent.ROLL_OUT,onRollOutCursor)
			addEventListener(MouseEvent.MOUSE_DOWN,onPRessCursor)
			addEventListener(MouseEvent.MOUSE_UP,onReleaseCursor);
			this.buttonMode=true;
		}
		
		private function onClickFond(e:MouseEvent):void 
		{
			//trace(this+e.target)
			if(!(e.target is ERectange)) return;
			var volum:Number=mc_fond.mouseX/mc_fond.width;
			setBarPositionTween(volum);
		}
		
		private function onMuteClick(e:MouseEvent):void 
		{
			if((e.currentTarget as EToggleButton).selected){
				volum=mc_zone.x/mc_fond.width;
				setBarPositionTween(0)
			}else{
			   	setBarPositionTween(volum);
			}
			trace(this+" Volum : "+volum);
		}
		public function setBarPositionTween(pos:Number):void{
			TweenLite.to(mc_zone,0.9,{x:pos*(mc_fond.width-4),onUpdate:onTweenMuteVolom})
			TweenLite.to(mc_bar_progress,0.9,{width:pos*(mc_fond.width-4)})
		}
		
		private function onTweenMuteVolom():void
		{
			dispatchVolumValue(Number(mc_zone.x/(mc_fond.width-4)));
		}
		
		private function setCursorPostition(pos:Number):void{
			var mc_zonex:int=pos*mc_fond.width;
			mc_bar_progress.width=mc_zonex;
			volum=pos;
			trace(this+"setCursorPostition volum "+volum);
			
			dispatchVolumValue(pos);
		}
		
		private function onReleaseCursor(e:MouseEvent):void 
		{
			//mc_zone.stopDrag();
			mc_zone.removeEventListener(Event.ENTER_FRAME,onEEnterFram);
			stage.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			mc_bar_progress.width=mouseX;
			//dispatchPlayAtEvent();
			//faut dipatcher l'evement strop
		}
		
		private function onPRessCursor(e:MouseEvent):void 
		{
			//faut dispatcher l'evenement drag start;
			 
		///	mc_zone.startDrag(true,new Rectangle( 0, mc_zone.y, mc_fond.width-4,  mc_zone.y ));
			mc_zone.addEventListener(Event.ENTER_FRAME,onEEnterFram)
			
		    stage.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			
		}
		
		private function onEEnterFram(e:Event):void 
		{
			
			mc_bar_progress.width=mc_fond.mouseX ;
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			event.event=ControlerEvent.VOLUM;
			event.position = mc_bar_progress.width / mc_fond.width;
			dispatchEvent(event);
			
		}
		public function dispatchVolumValue(value:Number=1):void{
			var event:ControlerEvent=new ControlerEvent(ControlerEvent.CHANGED);
			event.event=ControlerEvent.VOLUM;
			event.position=value;
			dispatchEvent(event);
		}
		
		private function onRollOutCursor(e:MouseEvent):void 
		{
			//TweenLite.to(mc_cursor,0.5,{removeTint:true});
		}
		
		private function onRollOverCursor(e:MouseEvent):void 
		{
			//TweenLite.to(mc_cursor,0.5,{tint:0xFF5555});
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			 
			if (e.eventPhase >= EventPhase.AT_TARGET ) onReleaseCursor(null);
		
		}
		public function getVolum():Number{
			return mc_bar_progress.width/mc_fond.width;
		}
		
	}
	
}
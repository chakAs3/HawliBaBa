﻿package emagin.components.scroller 
{
	import emagin.components.ERectange;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author chakir
	 */
	public class EMouseScroller extends EventDispatcher
	{
		private var hScroller:int;
		private var scrollTarget:DisplayObject;
		
		private var _ymax:int=0;
		private var _ymin:int=0;
		private var _msque:ERectange;
		
		
		public function EMouseScroller(mc:DisplayObject,h:int) 
		{
			 hScroller = h;
			_ymax = mc.y;
			_ymin = mc.y-mc.height + hScroller;			
			if ( mc.parent) {
				_msque = new ERectange(mc.width*2, hScroller,0x115500); 
				_msque.alpha=.3;
				mc.parent.addChild(_msque);
				mc.mask = _msque;
			    //_msque.buttonMode=true;
				_msque.y = mc.y+5;
				_msque.x = mc.x;
				scrollTarget = mc;
				var pr:Number = hScroller / mc.height;
				//scroller_bar.height = pr * scroller_fond.height-2;
				setListeners();
			}
			
		}
		public function setHeigth(h:int):void{
			_msque.height=h;
			hScroller=h;
			scrollTarget.y=_msque.y;
		}
		private function getYmin():int {
			_ymin = scrollTarget.y + 6 - scrollTarget.height + hScroller;	
			return _ymin;
		}
		public function setListeners():void {
			//_msque.addEventListener(MouseEvent.ROLL_OVER,onMOver)
			//_msque.addEventListener(MouseEvent.ROLL_OUT,onMOut)
			//
			scrollTarget.addEventListener(MouseEvent.ROLL_OVER,onMOver)
			scrollTarget.addEventListener(MouseEvent.ROLL_OUT,onMOut)
		}
		
		private function onMOut(e:MouseEvent):void 
		{
			trace(this+"Out Out text\n")
			_msque.removeEventListener(Event.ENTER_FRAME,onEnterFram);
		}
		
		private function onEnterFram(e:Event):void 
		{
			var d:int = _msque.mouseY - hScroller / 2;
			trace( this + "Distance " + d);
			
			if ( (scrollTarget.y >= _ymax && d < 0) || (scrollTarget.y <= ymin && d > 0)) {
				scrollTarget.y = int(scrollTarget.y);
			return;
			}
			scrollTarget.y += Math.round((- d * 0.09));
		}
		
		private function onMOver(e:MouseEvent):void 
		{
			trace(this+"Over Over Text\n")
			_msque.addEventListener(Event.ENTER_FRAME,onEnterFram)
		}
		 
		
		public function get msque():ERectange { return _msque; }
		
		public function get ymin():int { _ymin=_ymax-scrollTarget.height + hScroller;		return _ymin; }
		
		
	}
	
}
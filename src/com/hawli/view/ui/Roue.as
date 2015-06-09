package com.hawli.view.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	
	import emagin.components.EPreloader;
	
	import flash.display.MovieClip;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	public class Roue extends MovieClip
	{
		public var loader:EPreloader;

		private var interval:int;
		
		private var object:Object={x:0};
		public function Roue()
		{
			super();
			//mouseEnabled=false;
			//mouseChildren=false;
			buttonMode=false;
		}
		public function lanceTimer(time:int):void{
			//if(interval) clearTimeout(interval);
		  //interval=setTimeout(active,time);
			//mouseChildren=false;
			//mouseEnabled=false;
			buttonMode=false;
		  loader.setPourcent(0);
		  object.x=0;
		  TweenLite.to(object,time,{x:1,ease:Linear.easeNone,onUpdate:function(){ loader.setPourcent(object.x) },onComplete:function(){active()}});
		}
		
		public function active():void
		{
			// TODO Auto Generated method stub
			mouseEnabled=true;
			gotoAndStop(2);
			 
		}
	}
}
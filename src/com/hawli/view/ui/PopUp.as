package com.hawli.view.ui
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.components.ERectange;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class PopUp extends Sprite
	{
		public var _stage:Stage;
		public var fond:Sprite;
		public var panel:DisplayObject
		private var container:Sprite
		public function PopUp(panel:DisplayObject,_stage:Stage)
		{
			super();
			this.fond=addChild(new Sprite()) as Sprite;
			this.fond.addChild(new ERectange(20,20));
		    this.fond.alpha=0.7;
			this.panel=panel;
			this.panel.x=-(this.panel.width/2);
			this.panel.y=-(this.panel.height/2);
			panel.addEventListener(ViewEvent.CLOSE_POPUP,onClosePopUp);
			this.addChild(panel);
			container=addChild(new Sprite()) as Sprite;
			container.addChild(panel);
			this.addChild(container);
			this._stage=_stage;
			//_stage.addChild(this);
			resize();
			_stage.addEventListener(Event.RESIZE,onResize);
			animationIn();
		}
		
		protected function onResize(event:Event):void
		{
			resize();
			
		}
		
		protected function onClosePopUp(event:ViewEvent):void
		{
			_stage.removeEventListener(Event.RESIZE,onResize);
			animationOut()
			
		}
		public function resize():void{
			this.fond.width=_stage.stageWidth;
			this.fond.height=_stage.stageHeight;
			//this.panel.x=int((_stage.stageWidth-this.panel.width)/2);
			//this.panel.y=int((_stage.stageHeight-this.panel.height)/2);
			this.container.x=int((_stage.stageWidth)/2);
			this.container.y=int((_stage.stageHeight)/2);
		}
		public function animationIn():void{
			
			TweenLite.from(fond,0.5,{alpha:0,ease:Bounce.easeOut});
			TweenLite.from(container,0.5,{scaleX:0.9,scaleY:0.9,alpha:0,ease:Back.easeOut,delay:0.4});
		}
		public function animationOut():void{
			TweenLite.to(fond,0.6,{alpha:0,ease:Bounce.easeOut,delay:0.4,onComplete:onCompleteOut});
			 
			TweenLite.to(container,0.5,{scaleY:0.6,scaleX:0.6,alpha:0,ease:Back.easeIn});
			
		}
		
		private function onCompleteOut():void
		{
			if(parent)
				parent.removeChild(this);
			
		}
	}
}
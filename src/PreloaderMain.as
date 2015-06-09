package
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Bounce;
	import com.mtc.panels.MainPanel;
	
	import emagin.components.EPreloader;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.system.System;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	import flash.utils.setTimeout;
	
	public class InscriptionMain extends Sprite
	{
		private var path:String="hawli.swf";
		private var loader:Loader;
 
		public var mc_preload:MovieClip;
		public var mainPanel:MainPanel ;

		private var myContextMenu:ContextMenu;
		public function InscriptionMain()
		{
			super();
			Security.allowDomain("*");
			Security.allowDomain("facebook.com");
			stage.quality = StageQuality.MEDIUM;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			path=loaderInfo.parameters.path || path;
			 
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoading);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			addEventListener("LoadGame",onGoLoadGame);

			mc_preload.visible=false;
			mc_preload.alpha=0;
			mc_preload.y=0;
		    mc_preload.preload.mc_progress.scaleX=0;
			
			myContextMenu = new ContextMenu();
			removeDefaultItems();
			addCustomMenuItems();
			contextMenu = myContextMenu;
		}
		private function addCustomMenuItems() : void {
		 
			var copyrightItem : ContextMenuItem = null;
			var secondItem : ContextMenuItem = null;
		 
			copyrightItem = new ContextMenuItem("Copyright 2011 Maroc Telecom");
			secondItem = new ContextMenuItem("Agence de communication Promoseven");
			var secondItem2:ContextMenuItem = new ContextMenuItem("Studio de création Marshmallow Digital");
			myContextMenu.customItems.push(copyrightItem);

			return;
		}
		
		protected function menuSelectHandler(event:ContextMenuEvent):void
		{
			// TODO Auto-generated method stub
			
		}
		private function removeDefaultItems() : void {
			var contectMenuitems : ContextMenuBuiltInItems = null;
			myContextMenu.hideBuiltInItems();
			contectMenuitems = myContextMenu.builtInItems;
			contectMenuitems.print = true;
			return;
		}// end function
		protected function onGoLoadGame(event:Event):void
		{
			 mc_preload.visible=true;
			 TweenLite.to(mainPanel.im1,0.6,{x:mainPanel.im1.x+400,alpha:0});
			 TweenLite.to(mc_preload,1,{y:154+140,alpha:1,delay:1,ease:Bounce.easeOut,onComplete:function(){ loadGame();}});
			 for (var i:int = 0; i < mc_preload.numChildren; i++) 
			 {
				 TweenLite.from(mc_preload.getChildAt(i),0.6,{y:mc_preload.getChildAt(i).y-80,alpha:0,delay:1+i*0.2,ease:Bounce.easeOut });
				  
			 }
			 
		}

		public function loadGame():void{
			loader.load(new URLRequest(path));
			
		}
		
		private function onLoaded(event : Event) : void {
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onLoading);
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaded);
			 setTimeout(function(){
						//loader.content.userid=309;
			    addChild(loader.content);
			   //txt_pourcent.visible=false;
			    removeChildAt(0);
			 },1200);
		}
		
		private function onLoading(event : ProgressEvent) : void {
			trace(this+" onLoading "+event.bytesLoaded);
			//txt_pourcent.visible=true
			mc_preload.preload.mc_progress.scaleX=((event.bytesLoaded/event.bytesTotal));
			mc_preload.txt_poucent.text=Math.floor((event.bytesLoaded/event.bytesTotal)*100) + "%";
		}
	}
}
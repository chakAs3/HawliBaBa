package emagin.managers 
{
	 
	import caurina.transitions.Equations;
	import emagin.components.ERectange;
	import emagin.components.ProjectsScreen;
	import emagin.components.ProjectVignette;
	import gs.TweenLite;
 
	import emagin.events.AnimationEvent;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Chakir 
	 */
	public class AnimationManager extends EventDispatcher
	{
		private static var INSTANCE:AnimationManager;
		
		var x0:int = 0;
		var y0:int = 0;
		var w0:int = 0;
		public function AnimationManager(forecer:SingletonEnforcer ) 
		{
			super();
		}
		public static function getInstance():AnimationManager {
		   if (INSTANCE == null) {

           INSTANCE = new AnimationManager(new SingletonEnforcer());

           }
           return INSTANCE;
		}
		public function enterAnimate(clips:Array):void {
			     var xx:int = x0;
			for (var i:int = 0; i < clips.length; i++) {
				
				//Tweener.addTween(clips[i], { x : xx, transition:"linear", time:1,delay:i*0.5 } );
				TweenLite.to(clips[i],0.5,{ x : clips[i].x, ease:"easeOut",  delay:i*0.1 } )
			     clips[i].x = clips[i].x+900;
				}
			
		}
		public function enterAnimate2Row(clips:Array):void {
			     var xx:int = x0;
			for (var i:int = 0; i < clips.length; i+=2) {
				
				//Tweener.addTween(clips[i], { x : xx, ease:"linear", time:0.4, delay:i * 0.2 } );
				//Tweener.addTween(clips[i+1], { x : xx, ease:"linear", time:0.4,delay:i*0.2 } );
				TweenLite.to(clips[i],0.4, { x : xx, ease:"linear",   delay:i * 0.2 } )
				TweenLite.to(clips[i+1],0.4, { x : xx, ease:"linear",   delay:i * 0.2 } )
			    
			     xx += clips[i].width+10;
				}
			
		}
		public function enterAnimateScreen(screen:ProjectsScreen):void {
			var clips:Array = screen.panels;     
			var xx:int = x0;
			var numDelayPanel:int =   screen.numLines;
			for (var i:int = 0; i < clips.length; i++) {
				clips[i].x+=600;
				//Tweener.addTween(clips[i], { x : xx, ease:"easeOut", time:1, delay:int(i/numDelayPanel) * 0.1 } );
				TweenLite.to(clips[i],1, { x : xx, ease:"easeOut",   delay:int(i/numDelayPanel) * 0.1 })
				if(((i+1)%screen.numLines)==0)
			     xx += clips[i].width+screen.hspace;
				}
			
		}
		public function enterVerticalAnimateScreen(screen:ProjectsScreen):void {
			var clips:Array = screen.panels;     
			 
			var numDelayPanel:int =   screen.numLines;
			for (var i:int = 0; i < clips.length; i++){
				clips[i].x+=600
				TweenLite.to(clips[i],1, { x :screen.panelsPosition[i].x, ease:"easeOut",   delay:int(i) * 0.05 })
				
			}
				 
				//Tweener.addTween(clips[i], { x : xx, ease:"easeOut", time:1, delay:int(i/numDelayPanel) * 0.1 } );
				
				 
			
		}
		public function selectItemAnimate(item:Sprite, clips:Array):void {
			for (var i:int = 0; i < clips.length; i++) {
				
				//Tweener.addTween(clips[i], { x : clips[i].x-item.x, ease:"linear", time:0.5} );
				TweenLite.to(clips[i],0.4, { x : clips[i].x-item.x, ease:Equations.easeOutExpo })
			    
				}
		}
		public function selectItemAnimatePage(item:Sprite, clips:Array):void {
			var index:int=clips.indexOf(item);
			var sign:int=item.x/Math.abs(item.x);
			trace( " SIN "+sign)
			for (var i:int = 0; i < clips.length; i++) {
				 var delay:Number=(sign>0)?(i>=index?0.05:0):(clips[i].x<0?0.05:0);
				//Tweener.addTween(clips[i], { x : clips[i].x-item.x, ease:"easeOut", time:0.9,delay:delay} );
			    TweenLite.to(clips[i],0.5, { x : clips[i].x-item.x, ease:"easeOut",  delay:0} )
				}
		}
		
		public function selectItemAnimatePageAlpha(item:Sprite, clips:Array,pagination:int=8,currentIndex:int=0):void {
			var index:int=clips.indexOf(item);
			var sign:int=item.x/Math.abs(item.x);
			 var i:int;
			 trace(this+" currentIndex :"+currentIndex+ " index :"+index)
			 if(index!=currentIndex)
			    for(  i= currentIndex ; i < (currentIndex+ pagination ); i++){
				  if(!clips[i]) break;
				  clips[i].alpha=1;
				  trace(this+"1 - "+i+" "+clips[i])
				  TweenLite.to(clips[i],0.5, { autoAlpha : 0, ease:"easeOut",  delay:(i-currentIndex)*0.1,onComplete:onCompletePositionPage,onCompleteParams:[clips[i]]} )	;
				}
			    for (i= 0; i < clips.length; i++) {
			 
			     TweenLite.to(clips[i],0.001, { x : clips[i].x-item.x, ease:"easeOut",  delay:0+0.8} )
				}
				 trace(this+" pagination :"+pagination)
				for( i= index ; i < (index+ pagination ); i++){
				
				   trace(this+" 2 -"+i+" "+clips[i])
				   if(!clips[i]) break;
				   clips[i].alpha=0;
				  TweenLite.to(clips[i],0.5, { autoAlpha : 1, ease:"easeOut",  delay:(i-index)*0.1+0.8} )	;
				}
		}
		
		private function onCompletePositionPage(clip:Sprite):void
		{
			//clip.alpha=1;
			clip.visible=true;
		}
		//public function showDownEffect(clip:DisplayObject):void {
			//var maskContainer: DisplayObjectContainer= clip.parent;
			//var maske:ERectange = new ERectange(clip.width, clip.height);
			//maske.x =  clip.x;
			//maske.y =  clip.y;
			//clip.mask = maske;
			//maskContainer.addChild(maske);
			//Tweener.addTween(maske, { y: maske.y, ease:"linear", time:0.8 } );
			//maske.y = clip.y - clip.height-10;
			//
			    //
			//
			//
		//}
		//public function showDownClipEffect(clip:DisplayObject):void {
			//var maskContainer: DisplayObjectContainer= clip.parent;
			//var maske:ERectange = new ERectange(clip.width, clip.height);
			//maske.x =  clip.x;
			//maske.y =  clip.y+4;
			//clip.mask = maske;
			//maskContainer.addChild(maske);
			//Tweener.addTween(clip, { y: clip.y, ease:"linear", time:1 } );
			//clip.y = clip.y - clip.height-1;
			//
			    //
			//
			//
		//}
		//public function showUpEffect(clips:Array):void {
			    //for (var i:int = 0; i < clips.length; i++) {
				//
				//Tweener.addTween(clips[i], { y : clips[i].y, ease:"easeInOutBack", time:0.5, delay:int(i) * 0.2 } );
				//clips[i].y = 360;
				//}
				 //
		//}
		//public function outAnimate(screen:MovieClip) {
			  // Tweener.addTween(screen, { x : screen.x+5*screen.width/12,y:screen.y+5*screen.height/12,alpha:0,width:screen.width/6,height:screen.height/6, transition:"linear", time:2 } );
			     //Tweener.addTween(screen, { x : -screen.width - 300, transition:"linear", time:0.5, onComplete:function() { 
					 //trace("Finished Animation!!"); 
					 //var event2:AnimationEvent = new AnimationEvent(AnimationEvent.ANIM_FINISHED);
				         //event2.animated_object = screen ;
						 //dispatchEvent(event2); }} );
			     //
		//}
		
	}
	
}
class SingletonEnforcer {};
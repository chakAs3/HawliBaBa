package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class CreateHawliPanelView extends Sprite
	{
		public var btn_close:SimpleButton;
		public var btn_valider:SimpleButton;
		
		public var normal:Sprite;
		public var tamahdite:Sprite;
		public var sardi:Sprite;
		public var benkil:Sprite;
		public var deman:Sprite;
		public var items:Array;
		
		public var mc_selection:MovieClip
		public var txt_name:TextField;
		
		public var btn_next:SimpleButton;
		public var btn_prev:SimpleButton;
		
		public var label:String= "Nom du mouton";
		public function CreateHawliPanelView()
		{
			 
			items=[normal,tamahdite,sardi,benkil,deman];
			for (var i:int = 0; i < items.length; i++) 
			{
				trace(items[i]);
				(items[i] as MovieClip).buttonMode=true;
				(items[i] as MovieClip).addEventListener(MouseEvent.CLICK,onClickChoiceItem);
			}
			btn_next.addEventListener(MouseEvent.CLICK,onClickNext)
			btn_prev.addEventListener(MouseEvent.CLICK,onClickPrev)
			checkButtons();
			txt_name.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			txt_name.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
			txt_name.text=label;
		}
		
		protected function onFocusIn(event:FocusEvent):void
		{
			if(txt_name.text==label){
				txt_name.text="";
			}
			
		}
		
		protected function onFocusOut(event:FocusEvent):void
		{
			if(txt_name.text=="" ){
				txt_name.text=label;
			} 
			
		}
		
		protected function onClickPrev(event:MouseEvent):void
		{
			 
			MovieClip(mc_selection.tete.custom).prevFrame();
			mc_selection.tete.alpha=1;
			TweenLite.from(mc_selection.tete,0.4,{alpha:0});
			checkButtons();
			 
		}
		private function checkButtons():void{
			if(MovieClip(mc_selection.tete.custom).currentFrame == 30 ){
				//btn_next.enabled=false;
				btn_next.mouseEnabled=false;
				btn_next.alpha=0.6
			}else{
				btn_next.mouseEnabled=true;
				btn_next.alpha=1
			}
			if(MovieClip(mc_selection.tete.custom).currentFrame == 1 ){
				btn_prev.mouseEnabled=false;
				btn_prev.alpha=0.6
			}else{
				btn_prev.mouseEnabled=true;
				btn_prev.alpha=1
			}
		}
		
		protected function onClickNext(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			MovieClip(mc_selection.tete.custom).nextFrame();
			mc_selection.tete.alpha=1;
			TweenLite.from(mc_selection.tete,0.4,{alpha:0});
			checkButtons();
			
		}
		
		protected function onClickChoiceItem(event:MouseEvent):void
		{
			 
			mc_selection.tete.visage.gotoAndStop(Sprite(event.currentTarget).name);
		}
	}
}
package com.hawli.view.ui
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Bounce;
	import com.hawli.model.vo.OperationVo;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class OperationItem extends Sprite
	{
		 
		public var operationVo:OperationVo;
		public var mc_fond:MovieClip
		public var mc_icone:MovieClip;
		public var mc_ombre:Sprite;
		public function OperationItem(id:int,name:String,label:String)
		{
			super();
			 
			mouseChildren=false;
			buttonMode=true;
			addEventListener(MouseEvent.ROLL_OVER,onMRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onMRollOut);
			TweenLite.to(mc_fond,0,{y:0,ease:Bounce.easeIn})
			TweenLite.to(mc_fond.mc_over,0,{alpha:0});
			mc_icone.stop();
			mc_icone.gotoAndStop(id);
		}
		public function active(bool:Boolean):void{
			mouseEnabled=bool;
			if(!bool){
				
				TweenMax.to(this, 0.3, {colorMatrixFilter:{ amount:1, brightness:1.3, saturation:0.2}});
			 
			}else{
				TweenMax.to(this, 0.3, {colorMatrixFilter:{ amount:1, brightness:1, saturation:1}});
				 
			}
			if(bool)
			addEventListener(MouseEvent.ROLL_OUT,onMRollOut);
			else	
			removeEventListener(MouseEvent.ROLL_OUT,onMRollOut);
		}
		
		protected function onMRollOver(event:MouseEvent):void
		{
			// TODO Auto-generated method stub
			TweenLite.to(mc_fond,0.4,{y:-10,ease:Bounce.easeOut})
			TweenLite.to(mc_icone,0.5,{y:2,ease:Bounce.easeOut})	
			TweenLite.to(mc_fond.mc_over,0.4,{alpha:1})
			TweenLite.to(mc_ombre,0.4,{alpha:0.5})
		}
		
		protected function onMRollOut(event:MouseEvent):void
		{
			TweenLite.to(mc_fond,0.4,{y:0,ease:Bounce.easeOut})
			TweenLite.to(mc_icone,0.5,{y:12,ease:Bounce.easeOut})		
			TweenLite.to(mc_fond.mc_over,0.4,{alpha:0})
			TweenLite.to(mc_ombre,0.4,{alpha:1})
			
		}
	}
}
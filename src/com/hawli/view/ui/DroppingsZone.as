

package com.hawli.view.ui
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class DroppingsZone extends Sprite
	{
		public function DroppingsZone()
		{
		}
		public function createDroppings(num:int):void{
			
			for (var i:int = 0; i < num; i++) 
			{
				var dirt:Dirt=new Dirt();
				addChild(dirt);
				dirt.x=Math.random()*900;
				dirt.y=Math.random()*100;
				dirt.scaleX=dirt.scaleY=Math.random()*0.5+0.5;
				TweenLite.from(dirt,0.5,{alpha:0,delay:i*0.5});
			}
			
		}
		
		public function hit(hit:MovieClip):Boolean
		{
			for (var i:int = 0; i < numChildren; i++) 
			{
				if(this.getChildAt(i).hitTestObject(hit)){
					this.removeChildAt(i);
					
					return true;
				}
			}
			return false;
			
		}
	}
}
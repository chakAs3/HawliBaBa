package com.hawli.view.ui
{
	import com.mtc.components.ERectange;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class BugZone extends Sprite
	{
		public var items:Array;
		public function BugZone()
		{
			super();
			//addChild(new ERectange(1000,10));
		}
		public function createBug(num:int=9):void{
			var bug:MovieClip;
			for (var i:int = 0; i < num; i++) 
			{
				bug=new Bug();
				bug.x=i*10//-100+Math.random()*200;
				bug.y=50//-100+Math.random()*200;
				addChild(bug);
			}
			
		}
		public function bugHit(hit:Sprite):Boolean{
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
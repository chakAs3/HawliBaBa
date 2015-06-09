package com.hawli.model.vo
{
	public class LevelVo
	{
		public var index:int;
		public var min:int;
		public var max:int;
		public var label:String;
		
		public function LevelVo(index:int,min:int,max:int,label:String)
		{
			this.index=index;
			this.min=min;
			this.max=max;
			this.label=label;
		}
	}
}
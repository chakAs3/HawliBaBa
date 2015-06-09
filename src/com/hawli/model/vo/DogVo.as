package com.hawli.model.vo
{
	public class DogVo extends Object
	{
		public var name:String;
		public var id:int;
		public var cost:int;
		public function DogVo(id:int,name:String,cost:int)
		{
			super();
			this.id=id;
			this.name=name;
			this.cost=cost;
		}
	}
}
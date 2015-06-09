package com.hawli.model.vo
{
	public class FoodVo extends Object
	{
		public var id:int;
		public var name:String;
		public var label:String;
		public var currency:int;
		public var calory:int;
		public function FoodVo(id:int,name:String,currency:int,calory:int)
		{
			super();
			this.id=id;
			this.name=name;
			this.currency=currency;
			this.calory=calory;
		}
	}
}
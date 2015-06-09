package com.hawli.model.vo
{
	public class HawliVo
	{
		public var id:int;
		public var idUser:int;
		public var cash:int;
		public var dog:int;
		public var lastConnection:Object;
		public var name:String;
		public var weight:int;
		public var lweight:int;
		public var type:int;
		public var happiness:int;
		public var water:int;
		public var food:int;
		public var state:int;
		public var x:int;
		public var y:int;
		public var death:int;
		
		public var custom:int;
		public var gender:String;
		public var attack:int;
		
		public var session:String;
		
		public function HawliVo(id:int=0, idUser:int=0,cash:int=0, dog:int=0, lastConnection:Object=null, name:String=null, weight:int=0, type:int=0, happiness:int=0, water:int=0, food:int=0, state:int=0, x:int=0, y:int=0, death:int=0)
		{
			this.id = id;
			this.idUser = idUser;
			this.cash = cash;
			this.dog = dog;
			this.lastConnection = lastConnection;
			this.name = name;
			this.weight = weight;
			this.type = type;
			this.happiness = happiness;
			this.water = water;
			this.food = food;
			this.state = state;
			this.x = x;
			this.y = y;
			this.death = death;
		}
	}
}
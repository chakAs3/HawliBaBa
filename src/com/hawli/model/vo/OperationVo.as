package com.hawli.model.vo
{
	public class OperationVo{
		
		public var id:int;
		public var idUser:*;
		public var idType:int;
		public var label:String;
		public var cost:int;
		public var value:int;
		public var bonus:int;
		public var date:Object;
		
		public function OperationVo(id:int=0,idUser:int=0, idType:int=0,label:String="", cost:int=0, value:int=0, bonus:int=0, date:Object=null){
			this.id=id;
			this.idUser=idUser;
			this.idType = idType;
			this.label=label;
			this.cost=cost;
			this.value=value;
			this.bonus=bonus;
			this.date = date;
		}
	}
}
package com.hawli.model
{
	import com.hawli.model.vo.FoodVo;
	import com.hawli.model.vo.OperationVo;
	
	import org.robotlegs.mvcs.Actor;
	
	public final class OperationsModel extends Actor
	{
		public static const CARESS:OperationVo=new OperationVo(1,0,OperationTypes.CARESS,"Caresser",0,0,10);
		public static const GIVE_WATER:OperationVo=new OperationVo(4,0,OperationTypes.GIVE_WATER,"Donner à boire",10,100);
		
		public static const GIVE_FOOD1:OperationVo=new OperationVo(3,0,OperationTypes.GIVE_FOOD,"Nourrir",10,100);
		public static const GIVE_FOOD2:OperationVo=new OperationVo(31,0,OperationTypes.GIVE_FOOD,"GIVE_FOOD",10,300);
		public static const GIVE_FOOD3:OperationVo=new OperationVo(32,0,OperationTypes.GIVE_FOOD,"GIVE_FOOD",10,600);
		
		public static const ERASE_DROPPINGS:OperationVo=new OperationVo(5,0,OperationTypes.ERASE_DROPPINGS,"Nettoyer la bergerie",0,0,16);
		public static const ERASE_FLIES:OperationVo=new OperationVo(2,0,OperationTypes.ERASE_FLIES,"Tuer les mouches",0,0,16);
		
		public static const CHANGE_LOCATION:OperationVo=new OperationVo(6,0,OperationTypes.CHANGE_LOCATION,"Déplacer le mouton",0,0,0);
		public static const NONE:OperationVo=new OperationVo(7,0,OperationTypes.NONE,"Mode sélection",0,0,0);
		public static const HIT_HAWLI:OperationVo=new OperationVo(8,0,OperationTypes.HIT_HAWLI,"curseur",0,0,-10);
		
		
		public var foodsUnit:Array;//[
		private function createListeFoods():void{
			foodsUnit=[];
			foodsUnit.push(new FoodVo(1,"fool",20,100));
			foodsUnit.push(new FoodVo(2,"jelbana",20,200));
			foodsUnit.push(new FoodVo(3,"tben",20,300));
			foodsUnit.push(new FoodVo(4,"ch3ir",20,150));
			
		}
	}

}
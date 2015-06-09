/*
 * Copyright (c) 2009 the original author or authors
 *
 */

package com.hawli.model
{
	import com.hawli.model.vo.DogVo;
	import com.hawli.model.vo.FoodVo;
	import com.hawli.model.vo.LevelVo;
	import com.hawli.model.vo.SettingVo;
	import com.hawli.model.vo.UserVo;
	import com.hawli.model.vo.WaterVo;
	
	import flash.utils.Timer;
	
	import org.robotlegs.mvcs.Actor;

/**
 * @default  The Model that contains all  Vo for the game
 * @author ©haki®
 */
	
	public class GameModel extends Actor
	{
		protected var _clickCount:int;
		
		public var userVo:UserVo;
		public var setting:SettingVo;
		
		public var timeConnected:Date;

		// All to operation can be done by the player
		
		public var operationsUser:Array=[OperationsModel.CARESS,OperationsModel.ERASE_FLIES,OperationsModel.GIVE_FOOD1,OperationsModel.GIVE_WATER,OperationsModel.ERASE_DROPPINGS,OperationsModel.CHANGE_LOCATION,OperationsModel.NONE]
		
		public var foodsUnit:Array;//[{idfood:1,calory:4},{idfood:2,calory:10},{idfood:3,calory:}];
		public var waterUnit:Array;
		
		public var dogsUnit:Array;
		
		public var levelsHawli:Array;
		public var environnent:int=0;
		private var gender:Array;
		public var listActionToDo:Array=[];
		private var _isBusy:Boolean=false;
		public var isSleeping:Boolean;
		public var activeAction:int;
		public var countHawliHit:int=0;
		public var farm_width:int=1500;
		public var isDraggin:Boolean;
		public var timerCount:int=0;
		public var isSpined:Boolean=false;
		public var changingEnv:Boolean=false;
		public var isDeath:Boolean;
		public var timeToSpin:int=60*5;

		private var session:String;
		public var invited_users:Array=[];

		public var timer:Timer=new Timer(SettingVo.TIMER_DATA_UPDATE);
		
		public var key:*;
		public var imageToPublish:String="";
		 
		public function GameModel()
		{
			_clickCount = 0;

			createListeFoods();

			activeAction=OperationTypes.NONE;
			// set hawli( sheep ) types (  "normal","tamahdite","sardi","benkil","deman"  )
			gender=["normal","tamahdite","sardi","benkil","deman"];
			//  set hawli( sheep )  age level , ->baby ->young ->old
			levelsHawli=[new LevelVo(1,0,30,"baby"),
				         new LevelVo(2,31,60,"jeune"),
						 new LevelVo(3,61,100,"vieux")];
		}
		
		
		public function get isBusy():Boolean
		{
			return _isBusy;
		}

		public function set isBusy(value:Boolean):void
		{
			trace(this+"isBusy = "+value) ;
			_isBusy = value;
		}

		private function createListeFoods():void{
			// set food categories with cost , and calories
			foodsUnit=[];
			foodsUnit.push(new FoodVo(1,"fool",10,100));
			foodsUnit.push(new FoodVo(2,"jelbana",20,200));
			foodsUnit.push(new FoodVo(3,"tben",30,300));
			foodsUnit.push(new FoodVo(4,"ch3ir",40,400));

			// set water quantity  with cost and the calories
			waterUnit=[];
			waterUnit.push(new WaterVo(1,"1 litres",10,100));
			waterUnit.push(new WaterVo(2,"2 litres",20,200));
			waterUnit.push(new WaterVo(3,"3 litres",30,300));
			waterUnit.push(new WaterVo(4,"4 litres",40,400));

			// set dogs types  with cost
			dogsUnit=[];
			dogsUnit.push(new DogVo(1,"rosa",100));
			dogsUnit.push(new DogVo(2,"leo",200));
			dogsUnit.push(new DogVo(3,"brad",300));
			dogsUnit.push(new DogVo(4,"slougi",400));
		}

		/**
		 * get percent of the progress and the level
		 * @param weight
		 * @return
		 */
		public function getPercentLevelWeight(weight:int):Object
		{
			trace(this+" getPercentLevelWeight "+weight) ;
			weight /= 1000;
			var lv:LevelVo;
			for (var i:int = 0; i < levelsHawli.length; i++) 
			{
				lv=levelsHawli[i] as LevelVo
				if(weight>=lv.min && weight <= lv.max )
					break;
			}

			var purcent:Number=(weight - lv.min)/(lv.max-lv.min);

			return {level:lv.index,purcent:purcent};
			
		}

		/**
		 * check the pipeline if there is food Action
		 * @return
		 */
		public function haveFoodAction():Boolean
		{
			for (var i:int = 0; i < listActionToDo.length; i++) 
			{
				if(listActionToDo[i] is FoodVo){
					 return true
				}
			}
		 return false;	
		}
		/**
		 * check the pipeline if there is water Action
		 * @return
		 */
		public function haveWaterAction():Boolean
		{
			for (var i:int = 0; i < listActionToDo.length; i++) 
			{
				if(listActionToDo[i] is WaterVo){
					return true
				}
			}
			return false;	
		}
		
		public function getIdfromLabel(gender:String):int
		{

			return this.gender.indexOf(gender);
		}
		public function getLabelTypeFromId(id:int):String
		{

			return this.gender[id];
		}
		
		public function getSession():String
		{
			if(!session)
			session=(Math.random()*1000)+"-"+(new Date()).time;
			return session;
			
		}
	}
}
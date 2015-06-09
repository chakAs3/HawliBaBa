package com.hawli.view
{
	import com.hawli.model.GameModel;
	import com.hawli.model.StatsModel;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class OutBarnMediator extends Mediator
	{
		[Inject]
		public var view:OutBarnView;
		
		[Inject]
		public var statsModel:StatsModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function OutBarnMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			
			// TODO : add Listen to the view
			 
			//TODO : add Listen to the context
		}
	}
}
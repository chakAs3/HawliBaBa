/*
 * Copyright (c) 2012 the original author or authors
 *
  
 */

package com.hawli.controller
{
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.vo.OperationVo;
	import com.hawli.service.GameService;
	import com.hawli.view.HawliView;
	import com.hawli.view.panels.ClassementPanelView;
	import com.hawli.view.panels.CreateHawliPanelView;
	import com.hawli.view.panels.DeathPanelView;
	import com.hawli.view.panels.DogsPanelView;
	import com.hawli.view.panels.HelpPanelView;
	import com.hawli.view.panels.InvitePanelView;
	import com.hawli.view.panels.MenuFoodsPanelView;
	import com.hawli.view.panels.MenuWaterPanelMediator;
	import com.hawli.view.panels.MenuWaterPanelView;
	import com.hawli.view.panels.MessagePanelView;
	import com.hawli.view.panels.SharePanelView;
	import com.hawli.view.panels.SpinPanelView;
	import com.hawli.view.panels.TipsPanelView;
	import com.hawli.view.panels.UpgardeLevelPanelView;
	import com.hawli.view.ui.PopUp;
	
	import org.robotlegs.mvcs.Command;
	
	public class ShowPopUpCommand extends Command
	{
		[Inject]
		public var gameEvent:GameEvent;
		
	 
		
		override public function execute():void
		{
			// Add a Hawli operation
			// A Mediator will be created for it automatically
			trace(this+" ShowPopUpCommand execute :"+gameEvent.type)
			if(gameEvent.type==GameEvent.SHOW_POPUP_FOOD)
				contextView.addChild( new PopUp(new MenuFoodsPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_WATER )
				contextView.addChild( new PopUp(new MenuWaterPanelView(),contextView.stage));	
			else if(gameEvent.type==GameEvent.SHOW_POPUP_CREATEHAWLI )
				contextView.addChild( new PopUp(new CreateHawliPanelView(),contextView.stage));	
			else if(gameEvent.type==GameEvent.SHOW_POPUP_SPIN )
				contextView.addChild( new PopUp(new SpinPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_DEATH )
				contextView.addChild( new PopUp(new DeathPanelView(),contextView.stage));	
			else if(gameEvent.type==GameEvent.SHOW_POPUP_DOGS )
				contextView.addChild( new PopUp(new DogsPanelView(),contextView.stage));	
			else if(gameEvent.type==GameEvent.SHOW_POPUP_HELP )
				contextView.addChild( new PopUp(new HelpPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_INVITE )
				contextView.addChild( new PopUp(new InvitePanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_UPGARDLEVEL )
				contextView.addChild( new PopUp(new UpgardeLevelPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_CLASSEMENT )
				contextView.addChild( new PopUp(new ClassementPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_TIPS )
				contextView.addChild( new PopUp(new TipsPanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_ALERT )
				contextView.addChild( new PopUp(new MessagePanelView(),contextView.stage));
			else if(gameEvent.type==GameEvent.SHOW_POPUP_SHARE )
				contextView.addChild( new PopUp(new SharePanelView(),contextView.stage));
			
			
			
			dispatch(new GameEvent(GameEvent.SHOW_MOUSE));
			
		}
		 
	}
}
/*
 * Copyright (c) 2012 the original author or authors
 
 */

package com.hawli
{
	import com.hawli.controller.ChangeEnvironnementCommand;
	import com.hawli.controller.CreateHawliCommand;
	import com.hawli.controller.GetClassementCommand;
	import com.hawli.controller.GetHawliCommand;
	import com.hawli.controller.OperationCommand;
	import com.hawli.controller.ShowPopUpCommand;
	import com.hawli.controller.StartupCommand;
	import com.hawli.controller.UpdateCashCommand;
	import com.hawli.controller.UpdateDogCommand;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.controller.events.OperationEvent;
	import com.hawli.model.GameModel;
	import com.hawli.model.StatsModel;
	import com.hawli.model.UserModel;
	import com.hawli.service.GameCryptService;
	import com.hawli.service.GameService;
	import com.hawli.view.BarnMediator;
	import com.hawli.view.BarnView;
	import com.hawli.view.FooterMenuMediator;
	import com.hawli.view.FooterMenuView;
	import com.hawli.view.HawliMediator;
	import com.hawli.view.HawliView;
	import com.hawli.view.MainScreenMediator;
	import com.hawli.view.MainScreenView;
	import com.hawli.view.OutBarnMediator;
	import com.hawli.view.OutBarnView;
	import com.hawli.view.panels.ClassementPanelMediator;
	import com.hawli.view.panels.ClassementPanelView;
	import com.hawli.view.panels.CreateHawliPanelMediator;
	import com.hawli.view.panels.CreateHawliPanelView;
	import com.hawli.view.panels.DeathPanelMediator;
	import com.hawli.view.panels.DeathPanelView;
	import com.hawli.view.panels.DogsPanelMediator;
	import com.hawli.view.panels.DogsPanelView;
	import com.hawli.view.panels.HelpPanelMediator;
	import com.hawli.view.panels.HelpPanelView;
	import com.hawli.view.panels.InvitePanelMediator;
	import com.hawli.view.panels.InvitePanelView;
	import com.hawli.view.panels.MenuFoodsPanelMediator;
	import com.hawli.view.panels.MenuFoodsPanelView;
	import com.hawli.view.panels.MenuWaterPanelMediator;
	import com.hawli.view.panels.MenuWaterPanelView;
	import com.hawli.view.panels.MessagePanelMediator;
	import com.hawli.view.panels.MessagePanelView;
	import com.hawli.view.panels.SharePanelMediator;
	import com.hawli.view.panels.SharePanelView;
	import com.hawli.view.panels.SpinPanelMediator;
	import com.hawli.view.panels.SpinPanelView;
	import com.hawli.view.panels.TipsPanelMediator;
	import com.hawli.view.panels.TipsPanelView;
	import com.hawli.view.panels.UpgardeLevelPanelMediator;
	import com.hawli.view.panels.UpgardeLevelPanelView;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.adapters.SwiftSuspendersInjector;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	public class HawliAppContext extends Context
	{
		protected static const XML_CONFIG:XML =
			<types>
			   <type name='com.hawli.view::HawliMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
				  
			   </type>
			   <type name='com.hawli.view::MainScreenMediator'>
				  <field name='view'/>
				  <field name='statsModel'/>
                  <field name='gameModel'/>
			   </type>
 			   <type name='com.hawli.view::FooterMenuMediator'>
				  <field name='view'/>
				  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view::BarnMediator'>
				  <field name='view'/>
				  <field name='statsModel'/>
                  <field name='gameModel'/>
			   </type>
			   <type name='com.hawli.view::OutBarnMediator'>
				  <field name='view'/>
				  <field name='statsModel'/>
                  <field name='gameModel'/>
			   </type>
              <type name='com.hawli.view.panels::MenuWaterPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view.panels::MenuFoodsPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			   <type name='com.hawli.view.panels::CreateHawliPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view.panels::SpinPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
              <type name='com.hawli.view.panels::DeathPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view.panels::DogsPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view.panels::HelpPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			   <type name='com.hawli.view.panels::InvitePanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			  <type name='com.hawli.view.panels::UpgardeLevelPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
               <type name='com.hawli.view.panels::ClassementPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			  <type name='com.hawli.view.panels::TipsPanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			 <type name='com.hawli.view.panels::MessagePanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
 			  <type name='com.hawli.view.panels::SharePanelMediator'>
				  <field name='view'/>
                  <field name='gameModel'/>
			   </type>
			
			
			
			   <type name='com.hawli.controller::OperationCommand'>
				  <field name='operationEvents'/>
				  <field name='gameService'/>
				  <field name='gameModel'/>
			   </type>
			   <type name='com.hawli.controller::GetHawliCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
              <type name='com.hawli.controller::GetClassementCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
               <type name='com.hawli.controller::CreateHawliCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
               <type name='com.hawli.controller::UpdateCashCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
              <type name='com.hawli.controller::UpdateDogCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
			  <type name='com.hawli.controller::ChangeEnvironnementCommand'>
				  <field name='gameModel'/>
				  <field name='gameService'/>
                  <field name='gameEvent'/>
			   </type>
			
              <type name='com.hawli.controller::ShowPopUpCommand'>
				  <field name='gameEvent'/>
			   </type>
			   
			</types>;
		public function HawliAppContext(contextView:DisplayObjectContainer)
		{
			injector=new SwiftSuspendersInjector(XML_CONFIG);
			super(contextView);
		}
		
		override public function startup():void
		{
			// Map some Commands to Events
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent);
			commandMap.mapEvent(OperationEvent.USER_OPERATION, OperationCommand, OperationEvent );
			commandMap.mapEvent(GameEvent.GET_DATA_HAWLI_TIMER, GetHawliCommand, GameEvent );
			commandMap.mapEvent(GameEvent.STOP_DATA_HAWLI_TIMER, GetHawliCommand, GameEvent );
			
			commandMap.mapEvent(GameEvent.GET_CLASSEMENT, GetClassementCommand, GameEvent );
			commandMap.mapEvent(GameEvent.HAVE_HAWLI, GetHawliCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SEND_CREATE_HAWLI, CreateHawliCommand, GameEvent );
			 // Popup show command
			commandMap.mapEvent(GameEvent.SHOW_POPUP_FOOD, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_WATER, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_CREATEHAWLI, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_SPIN, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_DEATH, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_DOGS, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_HELP, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_INVITE, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_UPGARDLEVEL, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_CLASSEMENT, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_TIPS, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_ALERT, ShowPopUpCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SHOW_POPUP_SHARE, ShowPopUpCommand, GameEvent );
			
			commandMap.mapEvent(GameEvent.SEND_UPDATE_CASH, UpdateCashCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SEND_CHANGE_ENV, ChangeEnvironnementCommand, GameEvent );
			commandMap.mapEvent(GameEvent.SEND_UPDATE_DOG, UpdateDogCommand, GameEvent );
			
			// Create a rule for Dependency Injection
			injector.mapSingleton(GameModel);
			injector.mapSingleton(UserModel);
			injector.mapSingleton(StatsModel);
			injector.mapSingleton(GameService);
			
			// Here we bind Mediator Classes to View Classes:
			// Mediators will be created automatically when
			// view instances arrive on stage (anywhere inside the context view)
			
			mediatorMap.mapView(HawliView, HawliMediator);
			mediatorMap.mapView(MainScreenView, MainScreenMediator);
			mediatorMap.mapView(FooterMenuView, FooterMenuMediator);
			mediatorMap.mapView(BarnView,BarnMediator);
			mediatorMap.mapView(OutBarnView,OutBarnMediator);
			mediatorMap.mapView(SpinPanelView,SpinPanelMediator);
			mediatorMap.mapView(DogsPanelView,DogsPanelMediator);
			mediatorMap.mapView(HelpPanelView,HelpPanelMediator);
			mediatorMap.mapView(UpgardeLevelPanelView,UpgardeLevelPanelMediator);
			mediatorMap.mapView(ClassementPanelView,ClassementPanelMediator);
			mediatorMap.mapView(TipsPanelView,TipsPanelMediator);
			mediatorMap.mapView(MessagePanelView,MessagePanelMediator);
			mediatorMap.mapView(SharePanelView,SharePanelMediator);
			
			mediatorMap.mapView(CreateHawliPanelView,CreateHawliPanelMediator);
			mediatorMap.mapView(MenuFoodsPanelView,MenuFoodsPanelMediator);
			mediatorMap.mapView(MenuWaterPanelView,MenuWaterPanelMediator);
			mediatorMap.mapView(DeathPanelView,DeathPanelMediator);
			mediatorMap.mapView(InvitePanelView,InvitePanelMediator);
			
			// Manually add the main screen to stage
			contextView.addChild(new MainScreenView());
			
			// And we're done
			super.startup();
		}
	
	}
}
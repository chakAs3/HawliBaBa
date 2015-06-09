package com.hawli.view.panels
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	import com.hawli.controller.events.GameEvent;
	import com.hawli.model.GameModel;
	import com.hawli.view.events.ViewEvent;
	import com.mtc.managers.FaceBookGraph;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class InvitePanelMediator extends Mediator
	{
		[Inject]
		public var view:InvitePanelView;
		
		[Inject]
		public var gameModel:GameModel;
		
		
		 

		private var index:int;
		public function InvitePanelMediator()
		{
			// Avoid doing work in your constructors!
			// Mediators are only ready to be used when onRegister gets called
		}
		override public function onRegister():void
		{
			trace(this+"onRegister")
			// TODO : add Listen to the view
		 
			eventMap.mapListener(view.btn_close,MouseEvent.CLICK,onClickSpin);
			eventMap.mapListener(view.btn_invite,MouseEvent.CLICK,onClickInvite);
			 
			//TODO : add Listen to the context
		 
		}
		
		private function onClickInvite(e:MouseEvent):void
		{
			if(FaceBookGraph.userInfo && FaceBookGraph.userInfo.id){
			   FaceBookGraph.dispatcher.addEventListener(GameEvent.FIRENDS_INVIENTED,onInvitedFriends);	
			   FaceBookGraph.inviteFriends(onUICallback,gameModel.invited_users);
			}
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
		
		}
	   public  function onUICallback(result:Object):void{
			if(result == null){
				trace('User closed the pop up window without inviting any friends');
				ExternalInterface.call("console.log","User closed the pop up window without inviting any friends ");
				
				return
			}
			var invitedUsers:Array  = new Array();
			invitedUsers = result.to as Array;
			trace('You Have Invited ', invitedUsers.length,' friends');
			//dispatcher.dispatchEvent(new GameEvent(GameEvent.FIRENDS_INVIENTED,invitedUsers));
			//Simple if else if you want user to invite certain amount of friends;
			gameModel.invited_users=invitedUsers.concat(gameModel.invited_users);
			ExternalInterface.call("console.log"," You Have Invited "+invitedUsers.length);
			if(invitedUsers.length > 1){
				trace('GREAT, USER IS GENERATING TRAFFIC');
			}else{
				trace('No Good, User invited only one friend.');
			}
			
			
			var cash:int=(invitedUsers.length*15)
			dispatch(new GameEvent(GameEvent.SEND_UPDATE_CASH,cash));
		}
		protected function onInvitedFriends(event:GameEvent):void
		{
			var cash:int=((new Array(event.body)).length*15)
			ExternalInterface.call("console.log","GameEvent.FIRENDS_INVIENTED "	)
			ExternalInterface.call("console.log","(new Array(event.body)).length "+(new Array(event.body)).length	)
			dispatch(new GameEvent(GameEvent.SEND_UPDATE_CASH,cash));
		}
		
		private function onClickSpin(e:MouseEvent):void
		{
			
			trace(this+" onClickClosePanel ");
			view.dispatchEvent(new ViewEvent(ViewEvent.CLOSE_POPUP));
			
		}		
		
	 
	}
}
/*
 * Copyright (c) 2010 the original author or authors
 *
 */

package com.hawli.controller.events
{
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const HAWLI_CLICKED:String = 'GameEvent.HAWLI_CLICKED';
		
		public static const VALIDE_HAWLI:String = 'GameEvent.VALIDE_HAWLI';
		
		public static const SHOW_POPUP_FOOD:String = 'GameEvent.SHOW_POPUP_FOOD';
		public static const SHOW_POPUP_WATER:String = 'GameEvent.SHOW_POPUP_WATER';
		
		public static const SHOW_POPUP_CREATEHAWLI:String = 'GameEvent.SHOW_POPUP_CREATEHAWLI';
		public static const SHOW_POPUP_SPIN:String = 'GameEvent.SHOW_POPUP_SPIN';
		
		public static var DO_CARESS:String = 'GameEvent.DO_CARESS';;
		public static var HIT_HAWLI:String = 'GameEvent.HIT_HAWLI';;
		
		private var _body:*;
		public static var WALK_TO_POSITION:String = 'GameEvent.WALK_TO_POSITION';
		public static var DATA_HAWLI_CHANGED:String = 'GameEvent.DATA_HAWLI_CHANGED';
		public static var GET_DATA_HAWLI_TIMER:String = 'GameEvent.GET_DATA_HAWLI_TIMER';;
		public static var ADD_ACTION:String="GameEvent.ADD_ACTION";
		public static var HAWLI_TO_FOOD:String="GameEvent.HAWLI_TO_FOOD";;
		public static var FINISH_FOOD_DRINK:String="GameEvent.FINISH_FOOD_DRINK";
		public static var HAWLI_TO_SLEEP:String="GameEvent.GO_SLEEP";
		public static var DO_DRAG:String="GameEvent.DO_DRAG";
		public static var HAVE_HAWLI:String="GameEvent.HAVE_HAWLI";
		public static var SEND_CREATE_HAWLI:String="GameEvent.SEND_CREATE_HAWLI";
		public static var HAWLI_TO_IN:String="GameEvent.HAWLI_TO_IN";
		public static var HAWLI_TO_OUT:String="GameEvent.HAWLI_TO_OUT";
		public static var CHANGE_ENVIRONNEMENT:String="GameEvent.CHANGE_ENVIRONNEMENT";
		public static var SEND_UPDATE_CASH:String="GameEvent.SEND_UPDATE_CASH";
		public static var ACTIVE_SPIN:String="GameEvent.ACTIVE_SPIN";
		public static var SEND_CHANGE_ENV:String="GameEvent.SEND_CHANGE_ENV";
		public static var SHOW_POPUP_DEATH:String="GameEvent.SHOW_POPUP_DEATH";
		public static var SHOW_POPUP_DOGS:String="GameEvent.SHOW_POPUP_DOGS";
		public static var ADD_DOG:String="GameEvent.ADD_DOG";
		public static var SEND_UPDATE_DOG:String="GameEvent.SEND_UPDATE_DOG";
		public static var SHOW_POPUP_HELP:String="GameEvent.SHOW_POPUP_HELP";
		public static var SHOW_POPUP_INVITE:String="GameEvent.SHOW_POPUP_INVITE";
		public static var FIRENDS_INVIENTED:String="GameEvent.FIRENDS_INVIENTED";
		public static var SHOW_POPUP_UPGARDLEVEL:String="GameEvent.SHOW_POPUP_UPGARDLEVEL";
		public static var CLASSEMENT_LOADED:String="GameEvent.CLASSEMENT_LOADED";
		public static var GET_CLASSEMENT:String="GameEvent.GET_CLASSEMENT";
		public static var SHOW_POPUP_CLASSEMENT:String="GameEvent.SHOW_POPUP_CLASSEMENT";
		public static var SHOW_POPUP_TIPS:String="GameEvent.SHOW_POPUP_TIPS";
		public static var SHOW_POPUP_ALERT:String="GameEvent.SHOW_POPUP_ALERT";;
		public static var SOUND_EFFET:String="GameEvent.SOUND_EFFET";;;
		public static var SHOW_MOUSE:String="GameEvent.SHOW_MOUSE";
		public static var STOP_DATA_HAWLI_TIMER:String="GameEvent.STOP_DATA_HAWLI_TIMER";
		public static var SHOW_POPUP_SHARE:String="GameEvent.SHOW_POPUP_SHARE";
		
		
		public function GameEvent(type:String, body:* = null)
		{
			super(type);
			_body = body;
		}
		
		public function get body():*
		{
			return _body;
		}
		
		override public function clone():Event
		{
			return new GameEvent(type, body);
		}
	
	}
}
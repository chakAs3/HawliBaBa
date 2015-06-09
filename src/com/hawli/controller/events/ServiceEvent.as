/*
 * Copyright (c) 2010 the original author or authors
 *
 */

package com.hawli.controller.events
{
	import flash.events.Event;
	
	public class ServiceEvent extends Event
	{
		public static const HAWLI_DATA_RECIEVED:String = "ServiceEvent.HAWLI_DATA_RECIEVED";
		public static const USER_DATA_RECIEVED:String = "ServiceEvent.USER_DATA_RECIEVED";
		public static const HAVE_HAWLI_RECIEVED:String = "ServiceEvent.HAVE_HAWLI_RECIEVED";
		public static const CLASSEMENT_RECIEVED:String = "ServiceEvent.CLASSEMENT_RECIEVED";
		 
		private var _body:*;
		public static var HAWLIS_DATA_RECIEVED:String ="ServiceEvent.HAWLIS_DATA_RECIEVED";
		public static var CREATE_HAWLI_RECIEVED:String ="ServiceEvent.CREATE_HAWLI_RECIEVED";;
		
		public function ServiceEvent(type:String, body:* = null)
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
			return new ServiceEvent(type, body);
		}
	
	}
}
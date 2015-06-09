/*
 * Copyright (c) 2010 the original author or authors
 *
 */

package com.hawli.controller.events
{
	import flash.events.Event;
	
	public class OperationEvent extends Event
	{
		public static const USER_OPERATION:String = 'USER_OPERATION';
		
		public static const CARESSE:String = 'CARESSE';
		public static const GIVE_WATHER:String = 'GIVE_WATHER';
		public static const GIVE_FOOD:String = 'GIVE_FOOD';
		
		private var _body:*;
		
		public function OperationEvent(type:String, body:* = null)
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
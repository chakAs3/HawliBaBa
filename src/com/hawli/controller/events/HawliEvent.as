/*
 * Copyright (c) 2010 the original author or authors
 *
 */

package com.hawli.controller.events
{
	import flash.events.Event;
	
	public class HawliEvent extends Event
	{
		public static const MOVE:String = "HawliEvent.MOVE";
		public static const EAT:String = "HawliEvent.EAT";
		public static const DRINK:String = "HawliEvent.DRINK";
		
		private var _body:*;
		
		public function HawliEvent(type:String, body:* = null)
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
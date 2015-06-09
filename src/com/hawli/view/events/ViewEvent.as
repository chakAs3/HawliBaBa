/*
 * Copyright (c) 2010 the original author or authors
 *
 */

package com.hawli.view.events
{
	import flash.events.Event;
	
	public class ViewEvent extends Event
	{
		public static const OPERATION_CLICKED:String = 'ViewEvent.OPERATION_CLICKED';
		
		private var _body:*;
		public static var CLOSE_POPUP:String="ViewEvent.CLOSE_POPUP";
		public static var SELECT_WATER:String="ViewEvent.SELECT_WATER"; 
		public static var SELECT_FOOD:String="ViewEvent.SELECT_FOOD"; 
		public static var SELECT_DOG:String="ViewEvent.SELECT_DOG"; 
		
		public function ViewEvent(type:String, body:* = null)
		{
			super(type,true);
			_body = body;
		}
		
		public function get body():*
		{
			return _body;
		}
		
		override public function clone():Event
		{
			return new ViewEvent(type, body);
		}
	
	}
}
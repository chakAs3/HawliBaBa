/*
 * Copyright (c) 2009 the original author or authors
 *
 
 */

package com.hawli.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class HawliView extends Sprite
	{
		protected var color:uint;
		protected var radius:Number = 10;
		
		public var spriteSheet:MovieClip
		public var isDeath:Boolean;

		private var currentState:String;
		public function HawliView()
		{
			//alpha = 0.75;
			alpha=1;
			//useHandCursor = true;
			//buttonMode = true;
			draw();
			spriteSheet.gender="sardi";
		}
		
		public function poke():void
		{
			 
		}
		/**
		 * function pour animation d'etat
		 * */
		public function goState(labelframe:String):void{
			if(!isDeath && (labelframe!=currentState || labelframe=="hit" || labelframe=="caress" ) )
			spriteSheet.mouton.gotoAndPlay(labelframe);
			currentState=labelframe;
		}
		/**
		 * function pour animation d'etat
		 * */
		public function setHappinessState(frame:int):void{
			//if(spriteSheet.mouton && spriteSheet.mouton.yeux && spriteSheet.mouton.yeux.yeux){
			 spriteSheet.hapiness=frame//mouton.yeux.yeux.gotoAndStop(frame);
			 trace(this+"setHappinessState "+frame)
			//}
		}
		/**
		 * function pour animation d'etat
		 * */
		public function setEatState(frame:int):void{
			//if(spriteSheet.mouton && spriteSheet.mouton.yeux && spriteSheet.mouton.yeux.yeux){
			spriteSheet.eat=frame//mouton.yeux.yeux.gotoAndStop(frame);
			trace(this+"setHappinessState "+frame)
			//}
		}
		/**
		 * function pour changer d'etat de tranche d'age selon le poids
		 * */
		public function goLevel(frame:int):void{
			trace(this+"goLevel  "+frame);
			var current:String=spriteSheet.mouton.currentLabel;
			spriteSheet.gotoAndStop(frame);
			spriteSheet.mouton.gotoAndPlay(current);
		}
		/**
		 * function pour personnalisé le style d'animal
		 * */
		public function setCostum(labelframe:uint):void{
			spriteSheet.custom=labelframe;
		}
		
		public function setStyle(labelframe:String):void{
			trace(this+" setStyle: "+labelframe)
			spriteSheet.gender=labelframe;
		}
		
		public function draw():void
		{
			 
		}
		 
	
	}
}
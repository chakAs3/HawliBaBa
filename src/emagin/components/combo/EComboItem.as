﻿package emagin.components.combo 
{
	//import caurina.transitions.Tweener;
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class EComboItem extends MovieClip
	{
		public var txt_label:TextField;
		public var mc_flech:Sprite;
		public var mc_selection:Sprite;
		public var mc_fond:Sprite;
		public var mc_trait:Sprite;
		
		public var id:*;
		private var rewind:Boolean=true;
		public var colors:Array=[0x000000,0xFF7404];
		public function EComboItem() 
		{
			//mc_selection.width = 0;
			//mc_fond=new Sprite();
			txt_label.autoSize = TextFieldAutoSize.LEFT;
			txt_label.multiline = false;
			txt_label.defaultTextFormat=new TextFormat("Chalkboard", 12,null,null,true);;
			txt_label.textColor=colors[0];
			//txt_label.embedFonts = true;
			txt_label.mouseEnabled = false;
			txt_label.antiAliasType = "advanced";
			addEventListener(MouseEvent.ROLL_OVER,onMOUver)
			addEventListener(MouseEvent.ROLL_OUT, onMOut);
			
			mc_fond.alpha = 0;
			mc_selection.height = 0;
			//onMOut(null);
			 
			//this.filters=[new DropShadowFilter(1,90,0x000000,0.9,2,2)]; // ajout de filter sur l'item optionnel
			
		}
		
		 
		
		public function onMOut(e:MouseEvent):void 
		{
			//Tweener.addTween(mc_selection,{time:0.6,height:0,y:mc_fond.height}) 
			TweenMax.to(txt_label, 0.5, { tint:colors[0] } )
			
		}
		
		public function onMOUver(e:MouseEvent):void 
		{
			//Tweener.addTween(mc_selection,{time:0.6,height:mc_fond.height,y:0})  
			TweenMax.to(txt_label,0.5,{tint:colors[1]})
		}
		public function setColorSelection(color:int):void{
			//var ct:ColorTransform=new ColorTransform();
			//ct.color=color;
			//mc_selection.transform.colorTransform=ct;
			
			
		}
		public function setWidth(wi:int):void {
			mc_fond.width = wi;
			mc_trait.width = wi;
			mc_selection.width=wi
		}
		
		
		 
		
	}
	
}
/*
 * Copyright (c) 2009 the original author or authors
 *
 
 */

package com.hawli.view
{
	import com.hawli.view.ui.OperationItem;
	import com.hawli.view.ui.PalletteActionPanel;
	import com.hawli.view.ui.Roue;
	import com.hawli.view.ui.states.CashBar;
	import com.hawli.view.ui.states.ProfileUserBar;
	import com.hawli.view.ui.states.WeigheLevelBar;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.IEventDispatcher;
	
	
	public class MainScreenView extends Sprite
	{
		protected var textField:TextField;
		
		public var paletteActions:PalletteActionPanel;
		public var mc_fond:Sprite;
		public var mc_weight:WeigheLevelBar;
		public var mc_profile:ProfileUserBar;
		public var mc_cash:CashBar;
		public var btn_spin:Roue;
		public var btn_dog:MovieClip;
		public var btn_phone:MovieClip
		public var mc_invite:Sprite;
		
		
		public var mc_bars:MovieClip;
		public var mc_order:MovieClip;
		public var calc_off:MovieClip
		
		public var mc_footer_menu:FooterMenuView
		
		public var containerEnvironnement:Sprite
		
		public var btn_camera:MovieClip;
		
		public function MainScreenView()
		{
			//
			containerEnvironnement=addChildAt(new Sprite(),1) as Sprite;
			calc_off.mouseChildren=false;
			calc_off.mouseEnabled=false;
			btn_spin.buttonMode=true;
			btn_dog.buttonMode=true;
			mc_invite.buttonMode=true;
			mc_order.buttonMode=true;
			btn_phone.buttonMode=true;
			btn_camera.buttonMode=true;
		}
		
		public function createView(data:Array):void
		{
			paletteActions=new PalletteActionPanel()
			paletteActions.createItems(data);
			addChild(paletteActions);
		}
		public function active(index:int,active:Boolean=true):void{
			(paletteActions.items[index]  as OperationItem).active(active);
		}
		public function resize():void{
			paletteActions.x=int((stage.stageWidth-paletteActions.width)/2);
			paletteActions.y= stage.stageHeight-70;
			mc_fond.width=stage.stageWidth;
			mc_fond.height=stage.stageHeight;
			mc_profile.x=20;
			//btn_spin.x=20;
			mc_weight.x=stage.stageWidth-mc_weight.width-20;
			mc_cash.x=int((stage.stageWidth-mc_cash.width)/2)+30;
			mc_bars.x=int(	stage.stageWidth-255-20);
			mc_order.x= int(	stage.stageWidth-60-20);
			calc_off.x=int((stage.stageWidth)/2);
			calc_off.y=int((stage.stageHeight)/2);
			
			mc_footer_menu.x=int(stage.stageWidth-mc_footer_menu.width-20);
			mc_footer_menu.y= int(stage.stageHeight-mc_footer_menu.height-20);
			
			mc_invite.x=int(stage.stageWidth-60-20);
			
			var max:int=Math.max(stage.stageWidth,stage.stageHeight);
			calc_off.width=max;
			calc_off.scaleY=calc_off.scaleX;
			//containerEnvironnement.y=int(stage.stageHeight-containerEnvironnement.height)/2+40;
		}
	}
}
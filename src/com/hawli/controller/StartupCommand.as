/**
 * @author Cotton Hou
 */
package com.hawli.controller
{

 

import com.hawli.controller.events.GameEvent;
import com.hawli.view.HawliView;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;

import org.robotlegs.mvcs.Command;


public class StartupCommand extends Command
{

   
	
	override public function execute ():void
    {
       
		// geus user ;
		

        

		// if the user doesnt have a sheep
		
		dispatch(new GameEvent(GameEvent.HAVE_HAWLI));
		//dispatch(new GameEvent(GameEvent.SHOW_POPUP_HELP));
    }

}
}

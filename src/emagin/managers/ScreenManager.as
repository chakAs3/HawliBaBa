package emagin.managers 
{
	import emagin.Application;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import com.greensock.*;
 
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class ScreenManager extends EventDispatcher
	{
		private static var INSTANCE:ScreenManager;
	
		public function ScreenManager(enfocer:SingletonEnforcer) 
		{
			 super()
		}
		public static function getInstance():ScreenManager {


          if (INSTANCE == null) {

           INSTANCE = new ScreenManager(new SingletonEnforcer());

           }
           return INSTANCE;
		}
		public function center(clip:Sprite, centerPoint:Point):void {
			var oWidth:int = Application.STAGE.stageWidth;
			var oHeight:int = Application.STAGE.stageHeight;
			clip.x = Math.round(oWidth / 2)-centerPoint.x;
	        clip.y = Math.round(oHeight / 2)-centerPoint.y;
		}
		public function centerAnimate(clip:Sprite, centerPoint:Point,oWidth:int,oHeight:int,time:Number=1):void {
			 
			var clipx:int = Math.round(oWidth / 2)-centerPoint.x;
	        var clipy:int = Math.round(oHeight / 2)-centerPoint.y;
			TweenLite.to(clip,time,{x:clipx,y:clipy});
		}
		public  function setLuminosite(mcCible:DisplayObject,_valeur:Number){
    // Matrice de balance de la luminosité
         var tbMatrice:Array = [];
         tbMatrice.push(1, 0, 0, 0,  _valeur); // Rouge
         tbMatrice.push(0, 1, 0, 0,  _valeur); // Vert
         tbMatrice.push(0, 0, 1, 0,  _valeur); // Bleu
         tbMatrice.push(0, 0, 0, 1, 0); // Alpha
    
          var cmfTest:ColorMatrixFilter = new ColorMatrixFilter(tbMatrice);
          mcCible.filters = [ cmfTest  ];
       }
	   public function getRadio(oWidth:Number, oHeight:Number,nWidth:Number, nHeight:Number,ratioAll:Boolean=false,maxRatio:Boolean=false):Number {
		   var ratio:Number=1;
		     var coefw:Number = nWidth/oWidth;
			 var coefh:Number = nHeight / oHeight;	
			
		   if (Number(!maxRatio)*Number(oHeight * coefw > nHeight) ) {
				ratio=coefh;
			} else {
				ratio=coefw;			
			}
			if(maxRatio) ratio=Math.max(coefh,coefw);
			return (ratio<1 || ratioAll) ? ratio:1;
		}
	   public static function resampleBitmapData (bmp:BitmapData, ratio:Number):BitmapData {
	      if (ratio >= 1) {
		     return ( resizeBitmapData(bmp, ratio));
        	}
	           else {
		    var bmpData:BitmapData = bmp.clone();
		    var appliedRatio:Number = 1;
		
		    do {
		  	if (ratio < 0.5 * appliedRatio) {
				 bmpData =  resizeBitmapData(bmpData, 0.5);
				 appliedRatio = 0.5 * appliedRatio;
			  }
			else {
				bmpData =  resizeBitmapData(bmpData, ratio / appliedRatio);
				appliedRatio = ratio;
			}
		   } while (appliedRatio != ratio);
		
		  return (bmpData);
	     }
       }
	   
	   public static function resizeBitmapData (bmp:BitmapData, ratio:Number):BitmapData {
	     var bmpData:BitmapData = new BitmapData(Math.round(bmp.width * ratio), Math.round(bmp.height * ratio));
	     var scaleMatrix:Matrix = new Matrix(bmpData.width / bmp.width, 0, 0, bmpData.height / bmp.height, 0, 0);
	     var colorTransform:ColorTransform = new ColorTransform();
	      bmpData.draw(bmp, scaleMatrix, colorTransform, null, null, true);
			
	     return (bmpData);
       }


 
		   

	 	
	}
	
}
class SingletonEnforcer {};
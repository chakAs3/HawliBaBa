package  emagin.components.menu
{
	import com.greensock.*;
	import com.greensock.easing.Elastic;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	 
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class MainMenuItem extends Sprite
	{
		 
		private var id:String;
		 
		
		 
		
		public var mc_over:MovieClip;
		 
		public var txt_label:TextField;
		public function MainMenuItem(object:Object):void 
		{
			
			var format:TextFormat=new TextFormat();
			format.size=14;
			format.font="Rockwell"; 
			format.bold=true;
			/*txt_label=new TextField();
			txt_label.autoSize=TextFieldAutoSize.LEFT;
			txt_label.selectable=false;
			txt_label.textColor=0x000000;
			txt_label.embedFonts=true;
			
			
			
			
			
			
			
			txt_label.defaultTextFormat=format;
			
			
			txt_label.text = String(object.label).toUpperCase();;
			txt_label.x=18;
			txt_label.y=7;
			bar = new BarMenuItem()//new ERectange(txt_label.textWidth+20,4,0xC38B15);
			bar.width = txt_label.textWidth + 40;*/
			txt_label.defaultTextFormat=format;
			txt_label.selectable=false;
			 buttonMode=true;
			 mouseChildren=false
			 mc_over.alpha=0;
			txt_label.text=object.label
			addEventListener(MouseEvent.ROLL_OVER,onMRollOver);
			addEventListener(MouseEvent.ROLL_OUT,onMRollOut);
			
			 
			
			
			
		 
			addEventListener(MouseEvent.CLICK,onCLick)
			//TweenMax.to(bar_masque, 0.003, { height:0 } )
			
		}
		
		public function onMRollOut(e:MouseEvent):void 
		{
			TweenMax.to(mc_over, 0.3, { alpha:0 } );
			TweenMax.to(txt_label,0.5,{tint:0x3F8AA4}); 
		}
		
		public function onMRollOver(e:MouseEvent):void 
		{
			TweenMax.to(mc_over, 0.3, { alpha:1 } )
			TweenMax.to(txt_label,0.5,{tint:0x7FCADD});
			
		}
		
		private function onCLick(e:MouseEvent):void 
		{
			//select();
			
		}
		public function select(second:Boolean=false):void{
		   // TweenLite.to(bar,0.5,{y:0});
		    onMRollOver(null);
			buttonMode = false;
			mouseEnabled=false
			mouseChildren = false;
			 
			//TweenLite.to(bar,0.5,{y:0,ease:Elastic.easeInOut});
			removeEventListener(MouseEvent.ROLL_OUT,onMRollOut);
		}
		 
		public function unselect():void{
		  
		  onMRollOut(null);
		  buttonMode = true;
		  mouseEnabled = true;
		 // mouseChildren = true;
		 
		  addEventListener(MouseEvent.ROLL_OUT,onMRollOut);
		}
		
		
	}
	
}
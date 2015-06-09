package emagin.components.buttons {
	 

	import flash.events.MouseEvent;

	import com.greensock.TweenMax;

	import emagin.Application;

	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
 

	/**
	 * @author emagin
	 */
	public class SeeRoundButton extends CloseButton {
		public var txt_label:TextField
		public function SeeRoundButton() {
			super();
			txt_label.styleSheet=Application.getInstance().styleGlobal;
            txt_label.embedFonts=true;
            txt_label.autoSize=TextFieldAutoSize.LEFT;
            buttonMode=true;
            mouseChildren=false
            addEventListener(MouseEvent.ROLL_OVER,onMOver)
            addEventListener(MouseEvent.ROLL_OUT, onMOut)
			setText("VOIR");
		}
	     public function setText(str:String):void{
			txt_label.htmlText="<span class='menuItem' >"+str+"</span>" ;
            
           // onMOut(null)
		}
		private function onMOut(e:MouseEvent):void 
        {
           
            if(txt_label)
            TweenMax.to(txt_label, 0.5, { tint:colors.left } );
        }
        
        private function onMOver(e:MouseEvent):void 
        {
            
            if(txt_label)
            TweenMax.to(txt_label, 0.5, { tint:colors.right } );
        }
        public function over():void{
        	//super.on
        	
        }
         public function out():void{
            
        }
	}
}

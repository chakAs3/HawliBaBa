package emagin.components.buttons {
	import flash.text.AntiAliasType;

	import emagin.components.ERectange;

	import flash.display.Sprite;

	/**
	 * @author emagin
	 */
	public class DetailButton extends SeeButton {
		public function DetailButton() {
			super();
			txt_label.antiAliasType=AntiAliasType.NORMAL;
		}

		public override function setText(str:String):void{
			txt_label.htmlText="<span class='buttonDetail' >"+str+"</span>" ;
            w=txt_label.width+ 20+10;
            mc_fond.getChildAt(0).width=w;
			outColor=0x999999;
			
			var rec:ERectange=new ERectange(w,h,0xF);
            rec.alpha=0;
            addChild(rec)
			onMRollOut(null);
		}
	}
}

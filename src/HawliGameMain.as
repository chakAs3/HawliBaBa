package
{
	import com.hawli.HawliAppContext;
	import com.hawli.model.Cryptage;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class HawliGameMain extends Sprite
	{

		private var _context:HawliAppContext;

		[Embed(source="hawli.key" ,mimeType='application/octet-stream')]
		var key:Class;

		// technic to secure the Key from the decompiler
		public function HawliGameMain()
		{
			super();
			var _k:*=String(new key()) ;
			Cryptage.key=_k;
			
		    addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			
		}
		
		protected function onAdded(event:Event):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			// initialize the framework  ,
			_context = new HawliAppContext(this);
			
		}
	}
}
package emagin.data 
{
	
	/**
	 * ...
	 * @author Chakir
	 */
	public class DataValueObject 
	{
		public var id:String;
		public var title:String;
		public var image:String;
		public var vignette:String;
		public var date :String;
		public var descr:String;
		public var video:String;
		public var link:String;
		
		public var index:int;
		public var c:int;
		
		public var categorie:String;
		
		public var type:String
		
		public var xml:XML;
		
		public var vote:int;
		
		public var village:String
 
		public function DataValueObject() 
		{
			
		}
		public function setDataFromXML(xml:XML):void {
			//var myPattern:RegExp = //gi; 
			//_id = int(parseInt(Application.decryptId(xml.@id), 10));
			//trace(xml.descrip.toString()+" TTTTTTTTTTTTTTTTTTTTTTT "+xml.titre.toString())
			this.xml=xml;
			id = xml.@id.toString();
			 
			title =  xml.title.toString() 
			image = xml.image.toString();
			 
			vignette = xml.vignette ;
			vote=int(xml.@vote)
			 
			type=xml.@type;
			link=xml.link;
			 
			village=xml.@village || "1";
			
			 
		}
		public function dateToString(st:String):String{
			var arr:Array=st.split("/");
			return arr[1]+"/"+arr[0]+"/"+arr[2];
		}
	}
	
}
 package emagin.managers{

	/**
	 * ...
	 * @author ©haki®
	 */
	 
	 
	import emagin.events.FileEvent;
	
	import flash.events.*;
	import flash.net.*;
	public class FileManager extends EventDispatcher {
		public const ON_UPLOAD_FILE:String="OnImportImage";
		public var f:FileReference;
		public var lastFileSelect:String;
		private var docFilter:FileFilter;
		
		public var objet:Object=new Object();
		private var urv:URLVariables;
		private var uploadUrl:URLRequest;

		private var SERVER_URL:String="http://192.168.1.2/Jawla/partagetonexperience/";

		private var UPLOAD_URL:String="services/upload_video_tmp.php";
		

		public function FileManager() {
			super();
			docFilter = new FileFilter("Image (jpg,png ,jpeg )", "*.jpg;*.png;*.jpeg;");
			urv= new URLVariables();
		}
		public function browsFile() {
			f=new FileReference();
			f.addEventListener(Event.SELECT,onFileSelect);
			f.addEventListener(IOErrorEvent.IO_ERROR,errorFile);
			f.addEventListener(Event.COMPLETE, uploadComplete);
			f.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA,uploadCompleteDataHandler);

			f.browse([docFilter]);
			
		}
		
		private function uploadCompleteDataHandler(e:DataEvent):void 
		{
			//trace(" uploadCompleteData: " +  e.target.data);

		}
		public function cancel():void {
			if (f)
			f.cancel();
		}
		
		private function errorFile(e:IOErrorEvent) {
			trace("error " + e.toString());
			dispatchEvent(new Event("ErrorFile"));
		}
		private function uploadComplete(e:Event) {
			lastFileSelect = f.name;
			
			//trace(this + " event " + e + " uploadUrl  " + e.target.data);
			
			var ev:Event=new Event(ON_UPLOAD_FILE);
			dispatchEvent(ev);
		}
		private function onFileSelect(e:Event):void {
			var file:FileReference = FileReference(e.target);
			trace("selectHandler: " + file.name );
			 var event:FileEvent=new FileEvent(FileEvent.FILE_SELECTED);
			 event.file=file;
			 dispatchEvent(event);
			
			uploadUrl = new URLRequest();
			uploadUrl.method=URLRequestMethod.POST;
			urv.refupload =  objet.refupload;
			trace(this, "* L'ENVOI DU RefUpload =" + urv.refupload + " ******* ETAP UPLOAD *****" );
			
			uploadUrl.data=urv;
			 
			uploadUrl.url = SERVER_URL+UPLOAD_URL;
			file.upload(uploadUrl);
		}
	}
}
package emagin.components.upload 
{
	import emagin.components.buttons.ValideButton;
	import emagin.components.EToggleButton;
	import emagin.data.VideoUserData;
	import emagin.xml.events.LoadEvent;
	import emagin.xml.SendFormUpload;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class UploadStep3 extends MovieClip
	{
		private var _infoUser:Object
		private var _infoVideo:Object
		
		
		public var txt_nom:TextField;
		public var txt_pseudo:TextField;
		public var txt_email:TextField;
		public var txt_tel:TextField;
		public var txt_cin:TextField;
		public var txt_addresse:TextField;
		public var txt_date:TextField;
		
		
		public var txt_titre:TextField;
		public var txt_tags:TextField;
		public var txt_desc:TextField;
		public var txt_file:TextField;
		
		
		public var btn_send:ValideButton;
		
		public var btn_modifier_video:EToggleButton;
		public var btn_modifier_user:EToggleButton;
		
		public var refUpload:String;
		
		public function UploadStep3() 
		{
			
			
			/* video */
			 txt_titre.embedFonts = true;
			 txt_file.embedFonts = true;
			 txt_tags.embedFonts = true;
			 txt_desc.embedFonts = true;
			 /* user */
			 txt_nom.embedFonts = true;
			 txt_pseudo.embedFonts = true;
			 txt_email.embedFonts = true;
			 txt_tel.embedFonts = true;
			 txt_cin.embedFonts = true;
			 txt_addresse.embedFonts = true;
			 txt_date.embedFonts = true;
			 
			 btn_modifier_user.addEventListener(MouseEvent.CLICK, onClikUserMod);
			 btn_modifier_video.addEventListener(MouseEvent.CLICK, onClikVideoMod);
			 btn_send.addEventListener(MouseEvent.CLICK, onClikbtnSend);
			 
		}
		
		private function onClikbtnSend(e:MouseEvent):void 
		{
			var sendUploadform:SendFormUpload = new SendFormUpload(infoUser, infoVideo,refUpload);
			sendUploadform.addEventListener(LoadEvent.VIDEO_RESPONSE_ADD, onResponseAddVideo)
			
			trace(this + "  sendVideo Upload  ");
			//onResponseAddVideo(null)// pour test ;
			dispatchEvent(new Event("VideoSent"));
		}
		
		
		private function onResponseAddVideo(e:LoadEvent):void 
		{
			// reponse video add
			
			
			
			var venn:LoadEvent = new LoadEvent(LoadEvent.VIDEO_RESPONSE_ADD);
			venn.load_data= e.load_data;
			dispatchEvent(venn);
			
			
		}
		
		private function onClikVideoMod(e:MouseEvent):void 
		{
			var event:LoadEvent = new LoadEvent(LoadEvent.VALIDATE_STEP2);
			dispatchEvent(event);
		}
		
		private function onClikUserMod(e:MouseEvent):void 
		{
			var event:LoadEvent = new LoadEvent(LoadEvent.VALIDATE_STEP1);
			dispatchEvent(event);
		}
		
		public function get infoUser():Object { return _infoUser; }
		
		public function set infoUser(value:Object):void 
		{
			_infoUser = value;
			 txt_nom.text = value.nom;
			 txt_pseudo.text=value.pseudo
			 txt_email.text = value.email;
			 txt_date.text = value.date;
			 txt_tel.text = value.tel;
			 txt_cin.text = value.cin;
			 txt_addresse.text = value.address;
		}
		
		public function get infoVideo():Object { return _infoVideo; }
		
		public function set infoVideo(value:Object):void 
		{
			_infoVideo = value;
			 txt_titre.text = value.titre;
			 txt_file.text = value.file;
			 txt_tags.text = value.tags;
			 txt_desc.text = value.desc;
			
			
		}
		
	}
	
}
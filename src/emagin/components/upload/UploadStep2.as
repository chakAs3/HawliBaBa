package emagin.components.upload 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import emagin.components.buttons.ValideButton;
	import emagin.components.ui.ErrorPuceForm;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	 
	import emagin.xml.events.LoadEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	
	import emagin.utils.EmailValidator;
	import emagin.xml.events.LoadEvent;
	
	
	import emagin.events.FileEvent;
	import emagin.managers.FileManager;
	
	/**
	 * ...
	 * @author ©haki®
	 */
	public class UploadStep2 extends MovieClip
	{
		public var txt_titre:TextField;
		public var txt_tags:TextField;
		public var txt_desc:TextField;
		
		public var txt_file:TextField;
		
		private var elementsToValidate:Array;
		
		
		private var errorEmail:String="adresse email invalide";
		private var errorEmptyFields:String = "champs obligatoirs";
		
		public var btn_send:ValideButton;
		public var txt_error:TextField
		public var ojectRequest:Object;
		
		public var mc_error_titre:ErrorPuceForm;
		public var mc_error_upload:ErrorPuceForm;
		
		public var mc_bar_progression:MovieClip;
		
		
		public var btn_browse:MovieClip;
		
		public var refUpload:String;
		private var fm:FileManager;
		
		public var valideUpload:Boolean = false;

		public function UploadStep2() 
		{
			
			 txt_titre.embedFonts = true;
			 txt_file.embedFonts = true;
			 txt_tags.embedFonts = true;
			 txt_desc.embedFonts = true;
			 txt_error.embedFonts = true;
			 
			 txt_error.visible = false;
			 
			 txt_titre.tabIndex = 6;
			 txt_tags.tabIndex = 7;
			 txt_desc.tabIndex = 8;
			 
			 mc_error_titre.alpha = 0;
			 mc_error_titre.setText("Champ obligatoire");
			 
			 mc_error_upload.alpha = 0;
			 
			 txt_error.selectable = false;
			 
			 txt_titre.addEventListener(FocusEvent.FOCUS_IN,onFocusTextFields)
			
			elementsToValidate=new Array();
			 
			elementsToValidate.push( { element:txt_titre, validator:"empty",mc_error:mc_error_titre } );
			 
			elementsToValidate.push( { element:txt_file, validator:"empty" ,mc_error:mc_error_upload} );
			
			btn_send.addEventListener(MouseEvent.CLICK, onCLickSendBTn) ;
			btn_browse.addEventListener(MouseEvent.CLICK, onMClickBrows) ;
			
			mc_bar_progression.mc_fond.mask = mc_bar_progression.mc_masque;
			mc_bar_progression.mc_masque.x = -mc_bar_progression.mc_masque.width;
		}
		
		private function onFocusTextFields(e:FocusEvent):void 
		{
			 
			 TweenMax.to(mc_error_titre, 0.5, { alpha:0 } );
		}
		private function onCLickSendBTn(e:MouseEvent):void 
		{
			validateForm();
		}
		private function onCLickResetBTn(e:MouseEvent):void 
		{
			resetForm()
		}
		private function onMClickBrows(e:MouseEvent):void 
		{
		   fm = new FileManager();
		   fm.objet.RefUpload = refUpload;
		   fm.browsFile();
		   fm.addEventListener(FileEvent.FILE_SELECTED, onFileSelected);
		   fm.addEventListener("ErrorFile",onErrorFileUpload)
		    TweenMax.to(mc_error_upload, 0.5, { alpha:0 } );
		   
		}
		
		private function onErrorFileUpload(e:Event):void 
		{
			 mc_error_upload.setText( "Erreur d'upload de la vidéo");
			TweenMax.to(mc_error_upload, 0.5, { alpha:1 } );
			valideUpload = false;
		}
		
		private function onFileSelected(e:FileEvent):void 
		{
			txt_file.text = e.file.name;
			trace(this+ " onFileSelected "+ e.file.size )
			if(e.file.size > 15000000){
			  mc_error_upload.setText( "Taille max de la vidéo 15Mo ");
			   TweenMax.to(mc_error_upload, 0.5, { alpha:1 } );
			  fm.cancel();
			  valideUpload = false;
			}
			
			e.file.addEventListener(ProgressEvent.PROGRESS,onFileCVPRogress)
			e.file.addEventListener( Event.COMPLETE, onFileCVComplete);
			TweenLite.to(mc_bar_progression.mc_fond.mc_anime, 0.5, { alpha:1 } );
		}
		private function onFileCVComplete(e:Event):void 
		{
			txt_file.alpha = 1;
			valideUpload = true;
			TweenLite.to(mc_bar_progression.mc_fond.mc_anime, 0.5, { alpha:0 } );
		}
		
		private function onFileCVPRogress(e:ProgressEvent):void 
		{
			var pourcent:Number=(e.bytesLoaded/e.bytesTotal);
			//barCVprogression.width=pourcent*120;
			var px = pourcent * mc_bar_progression.mc_masque.width-mc_bar_progression.mc_masque.width+1;
		    TweenLite.to(mc_bar_progression.mc_masque, 0.7, { x:px } );
			trace(this+" % "+pourcent);
		}
		public function validateForm():void{
			var error:Array=new Array();
			trace("validateForm");
			//var flechAlert:FlechAlert;
			for (var i:int=0;i< elementsToValidate.length ; i++){
				trace(" elemet "+i+" >"+elementsToValidate[i].element)
				switch(elementsToValidate[i].validator){
			     case "empty": 
				 var empty:Boolean=((elementsToValidate[i].element as TextField).text=="");
				//( elementsToValidate[i].element as ETextForm).showFlechError(empty);
				 //TweenMax.to(arrayIcones[i], 0.5, { tint:0xFF0000 } );
				 if (empty) {    error.push("Empty champ"); 
				 
				  TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:1 } );
				 }
				 break;
			    
				 case "email": 
				 var valide:Boolean=EmailValidator.isValidEmail((elementsToValidate[i].element as TextField).text) ;
				  if (! valide ) {
					  error.push("The email adress is not valid.");
					  //TweenMax.to(arrayIcones[i], 0.5, { tint:0xFF0000 } );
					  trace("email invalide "); 
				  }
				  //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
				 ; break;
				 case "emails": 
				 var valide:Boolean=EmailValidator.isValidEmailList((elementsToValidate[i].element as TextField).text) ;
				  if (! valide ) {
					  error.push("The email adress is not valid.");
					  //TweenMax.to(arrayIcones[i], 0.5, { tint:0xFF0000 } );
					  trace("email invalide "); 
				  }
				  //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
				 ; break;
			      default : break;
		        }
			}
			if (error.length) {
				
			 txt_error.htmlText =( (error.indexOf("The email adress is not valid.")>-1)?errorEmail:"" )+( (error.indexOf("Empty champ")>-1)?errorEmptyFields:"" );
			 //if (error.length == elementsToValidate.length)
			 
			 //txt_error.htmlText =errorAllField//"All fields are mandatory"
			 //txt_error.textColor = 0xFFFFFF ;
			
			}else {
				if (!valideUpload) {
					txt_error.text = "selectionnes une vidéo a uploader ";
					return;
				}
			 txt_error.htmlText =""//errorAllField//"All fields are mandatory";
			 //txt_error.textColor = 0x333333;
			  sendForm();
			  //resetForm()
			  
			}
			//addEventListener("FocusEventIn", onFocusInText ) 
			//txt_error.x = int(txt_com.x + (txt_com.width - txt_error.width) / 2);
		}
		
		 
		public function sendForm():void {
		    ojectRequest = { titre:txt_titre.text,file:txt_file.text,  tags:txt_tags.text ,desc:txt_desc.text};
			 
			dispatchValidateForm(ojectRequest);
		}
		
		private function dispatchValidateForm(objet:Object):void
		{
			var loadEvent:LoadEvent = new LoadEvent(LoadEvent.VALIDATE_STEP2);
			loadEvent.load_data = objet;
			dispatchEvent(loadEvent);
		}
		 
		
		private function onResponse(e:LoadEvent):void 
		{
			trace(this + "Retour Send comments");
		}
		private function resetForm():void
		{
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
			 elementsToValidate[i].element.text = "";
			 //TweenLite.to(arrayIcones[i], 0.2, { tint:0x999999 } );
			 
			}
			txt_error.text = "";
			
			
		}
		
	}
	
}
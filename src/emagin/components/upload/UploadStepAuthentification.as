package emagin.components.upload 
{
	 
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.mtc.CModel;
	import com.mtc.InscriptionModel;
	import com.mtc.components.RectButton;
	import com.mtc.managers.FaceBookGraph;
	
	import emagin.components.ECombo;
	import emagin.components.combo.events.EComboEvent;
	import emagin.components.formulaire.ErrorPuceForm;
	import emagin.events.FileEvent;
	import emagin.managers.FileManager;
	import emagin.utils.DateUtil;
	import emagin.utils.EmailValidator;
	import emagin.xml.SendLogginFormSend;
	import emagin.xml.UploadFinalFormSend;
	import emagin.xml.events.LoadEvent;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * ...
	 * @author ©haki®
	 */
	public class UploadStepAuthentification extends MovieClip
	{
		
		public var titre:String = "formulaire d'information";
		
		public var txt_nom:TextField;
		public var txt_pseudo:TextField;
		public var txt_email:TextField;
		public var txt_passe:TextField;
		 
		
		
		public var mc_error_pseudo:ErrorPuceForm;
		public var mc_error_passe:ErrorPuceForm;
		 
		public var mc_error_upload:ErrorPuceForm;
		
		public var mc_error_date:ErrorPuceForm;
		public var mc_error_village:ErrorPuceForm;
		
		public var txt_label_cin:TextField;
		
		public var mc_check:*//ECheckBox;
		
		public var txt_error:TextField
		
		private var elementsToValidate:Array;
		
		
		private var errorEmail:String="adresse email invalide ";
		private var errorEmptyFields:String = "champs obligatoires ";
		
		public var btn_send:SimpleButton;
		public var btn_valide:SimpleButton;
		
		public var date_container:Sprite;
		public var ojectRequest:Object;
		private var dataJour:Array;
		private var dataAns:Array;
		private var dataMonth:Array;
		private var jourCombo:ECombo;
		private var moisCombo:ECombo;
		private var ansCombo:ECombo;
		
		public var btn_regelement:MovieClip
		//private var mc_regement:ReglementPanel;

		private var villeCombo:ECombo;

		private var villageCombo:ECombo;
		
		
		public var txt_file:TextField;
		public var mc_bar_progression:MovieClip;
		public var btn_browse:MovieClip;
		
		public var refUpload:String;
		private var fm:FileManager;		
		public var valideUpload:Boolean = false;
		
		public var mc_masque:Sprite;

		private var userid:String;
		
		
		
		public var mc_label1:Sprite;
		
		public function UploadStepAuthentification() 
		{
			 
			 
			
			 
			 
			 txt_email.embedFonts = true;
			 //txt_passe.embedFonts = true;
			 
			 //txt_passe.displayAsPassword=true;
			// txt_tel.embedFonts = true;
			 // txt_cin.embedFonts = true;
			// txt_addresse.embedFonts = true;
			 
			// txt_label_cin.embedFonts = true;
			// txt_label_cin.selectable = false;
			 // txt_label_cin.defaultTextFormat = new TextFormat("Myriad Pro", 12, null, false, true);
			 
			  
			 //txt_pseudo.tabIndex = 0;
			// txt_passe.tabIndex = 1;
			 //txt_tel.tabIndex = 3;
			 //txt_cin.tabIndex = 4;
			 //txt_addresse.tabIndex = 5;
			 
			 
			 //txt_tel.restrict = "[0-9]";
			 //txt_cin.restrict = "A-Z 0-9";
			 
			 
 
			// txt_error.visible = false;
			 
			elementsToValidate=new Array();
			 
			//elementsToValidate.push( { element:txt_cin, validator:"empty" ,mc_error:mc_error_cin} )
			elementsToValidate.push( { element:txt_email, validator:"email" ,mc_error:mc_error_pseudo} )
		//	elementsToValidate.push( { element:txt_passe, validator:"empty" ,mc_error:mc_error_passe} );
		 
			//elementsToValidate.push( { element:txt_tel, validator:"empty" ,mc_error:mc_error_tel} )
			//
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
			 
				elementsToValidate[i].element.addEventListener(FocusEvent.FOCUS_IN,onFocusTextFields)
			  
			 
			}
			
			//btn_send.addEventListener(MouseEvent.CLICK, onCLickSendBTn) ;
			btn_valide.addEventListener(MouseEvent.CLICK, onCLickOkLoggin) ;
			
			 
			
			
			
			
			 
			
			resetForm();
			//creationReglement();
			if(InscriptionModel.userInfo)
			 txt_email.text=InscriptionModel.userInfo.email;
			 txt_email.selectable=false;
		}
		
		
		public function creationReglement():void {
			/*mc_regement = new  ReglementPanel();
			mc_regement.x = -22;
			mc_regement.x = -10;
			parent.addChild(mc_regement);
			mc_regement.visible = false;
			btn_regelement.addEventListener(MouseEvent.CLICK, onClickREgementPanel)
			mc_regement.btn_close.addEventListener(MouseEvent.CLICK, onCloseRegementClick)
			btn_regelement.buttonMode = true;*/
		}
		
		private function onCloseRegementClick(e:MouseEvent):void 
		{
			//TweenMax.to(mc_regement, 0.5, { autoAlpha:0 } );
			//TweenMax.to(this, 0.5, { autoAlpha:1,delay:0.3 } ); PRÉNOM
		}
		/* **************** Upload functions************************************/
		private function onMClickBrows(e:MouseEvent):void 
		{
			refUpload=String("rf"+(new Date()).time).substring(0,10);
			fm = new FileManager();
			fm.objet.refupload =refUpload 
			fm.browsFile();
			fm.addEventListener(FileEvent.FILE_SELECTED, onFileSelected);
			fm.addEventListener("ErrorFile",onErrorFileUpload)
			TweenMax.to(mc_error_upload, 0.5, { alpha:0 } );
			
		}
		private function onErrorFileUpload(e:Event):void 
		{
			mc_error_upload.setText( "Erreur d'upload de la photo");
			TweenMax.to(mc_error_upload, 0.5, { alpha:1 } );
			valideUpload = false;
		}
		
		private function onFileSelected(e:FileEvent):void 
		{
			txt_file.text = e.file.name;
			trace(this+ " onFileSelected "+ e.file.size )
			if(e.file.size > 15000000){
				mc_error_upload.setText( "Taille max de la photo 15Mo ");
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
		
		/* ****************************************************/
		
		private function onClickREgementPanel(e:MouseEvent):void 
		{
			TweenMax.to(this, 0.5, { autoAlpha:0 } );
			//TweenMax.to(/ement, 0.5, { autoAlpha:1,delay:0.2 } );
		}
		private function onFocusTextFields(e:FocusEvent):void 
		{
			/*if(txt_addresse.text=="...")
			txt_addresse.text = "";
			txt_error.text = "";
			*/
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
			 if(elementsToValidate[i].element == e.currentTarget)  
			 TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:0 } );
			}
			
			 
		}
		private function onCLickSendBTn(e:MouseEvent):void 
		{
			validateForm();
		}
		private function onCLickResetBTn(e:MouseEvent):void 
		{
			resetForm()
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
				 
				 if (empty) { 
					 TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:1 } );
				 
				 error.push("Empty champ"); 
				 (elementsToValidate[i].mc_error as ErrorPuceForm).setText("Champ obligatoire");
				 }
				 break;
			    
				 case "email": 
				 var valide:Boolean=EmailValidator.isValidEmail((elementsToValidate[i].element as TextField).text) ;
				  if (! valide ) {
					  error.push("The email adress is not valid.");
					  TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:1 } );
					  (elementsToValidate[i].mc_error as ErrorPuceForm).setText("adresse email invalide");
					  trace("email invalide "); 
				  }
				  //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
				 ; break;
				 case "emails": 
				 var valide:Boolean=EmailValidator.isValidEmailList((elementsToValidate[i].element as TextField).text) ;
				  if (! valide ) {
					  error.push("The email adress is not valid.");
					  TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:1 } );
					  trace("email invalide "); 
				  }
				  //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
				 ; break;
				 case "list": 
					 var noselect:Boolean=((elementsToValidate[i].element as ECombo).selectedIndex==-1) ;
					 if ( noselect ) {
						 error.push("choisi une ville");
						 TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:1 } );
						 (elementsToValidate[i].mc_error as ErrorPuceForm).setText("choisi un village ");
						 trace(" village ");  
					 }
					 //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
					 ; break;
			      default : break;
		        }
			}
			 
			if (error.length) {
				
			 txt_error.htmlText =( (error.indexOf("The email adress is not valid.")>-1)?errorEmail:"" )+( (error.indexOf("Empty champ")>-1)?errorEmptyFields:"" );
			 if (error.length == elementsToValidate.length)
			 
			 //txt_error.htmlText =errorAllField//"All fields are mandatory"
			 txt_error.textColor = 0xFFFFFF ;
			
			}else{
			 txt_error.htmlText =""//errorAllField//"All fields are mandatory";
			 //txt_error.textColor = 0x333333;
			 
			 
			 txt_error.htmlText =""
			 sendForm();
			  //resetForm()
			  
			}
			//addEventListener("FocusEventIn", onFocusInText ) 
			//txt_error.x = int(txt_com.x + (txt_com.width - txt_error.width) / 2);
		}
		
		 
		public function sendForm():void {
			/*var idvillage:String=villageCombo.data[villageCombo.selectedIndex].id;
			trace(this+" CModel.id_user "+CModel.id_user)
		    ojectRequest = { refupload:refUpload,iduser:CModel.id_user,village:idvillage};
			var send:UploadFinalFormSend = new UploadFinalFormSend(ojectRequest);
		   send.addEventListener(LoadEvent.LOAD_REGISTER, onResponseSendComments)
			*/
			//if(!EmailValidator.isValidEmail(txt_email.text)) return;
			var checkUserLogin:SendLogginFormSend=new SendLogginFormSend({pseudo:txt_email.text,id_fb:FaceBookGraph.userInfo.id});
			
			checkUserLogin.addEventListener(LoadEvent.LOGIN_RESPONSE,onLoginREsponse)
			//dispatchValidateForm(ojectRequest);
		}
		
		private function dispatchValidateForm(objet:Object):void
		{
			var loadEvent:LoadEvent = new LoadEvent(LoadEvent.VALIDATE_STEP1);
			loadEvent.load_data = objet;
			dispatchEvent(loadEvent);
		}
		public function dispatchAddComment(objet:Object):void {
			objet.date = "12/12/2012 12:12";
			//var loadEvent:LoadEvent = new LoadEvent(LoadEvent.COMMENT_RESPONSE_ADD);
			//loadEvent.load_data = objet;
			//dispatchEvent(loadEvent);
		}
		
		 
		private function resetForm():void
		{
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
				if( elementsToValidate[i].element is TextField)
					elementsToValidate[i].element.text = "";
				//TweenLite.to(arrayIcones[i], 0.2, { tint:0x999999 } );
				TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:0 } );
			}
			//TweenMax.to(mc_error_date, 0.5, { alpha:0 } );
			txt_error.text = "";
			if(txt_file)
				txt_file.text="";
		
			
			
			
		}
		
		protected function onComboVilleChanged(event:Event):void
		{
			// TODO Auto-generated method stub
		}
		
		protected function onComboVillageChanged(event:Event):void
		{
			// TODO Auto-generated method stub
		}
		
		protected function onCLickOkLoggin(event:MouseEvent):void
		{
			//validateForm();
			sendForm();
		}
		
		protected function onLoginREsponse(event:LoadEvent):void
		{
			// TODO Auto-generated method stub
			userid=event.load_data.id;
			trace(this+" onLoginREsponse "+userid)
			InscriptionModel.userInfo.email=txt_email.text;
			InscriptionModel.userInfo.userid=userid;
			 
			//CModel.id_user=userid
			ExternalInterface.call("console.log"," onLoginREsponse "+event.load_data.suces);
			if(event.load_data.suces ){
				 
				txt_email.mouseEnabled=false;
				btn_valide.mouseEnabled=false;
				//btn_valide.mouseChildren=false;
			 	btn_valide.visible=false;
				//txt_pseudo.text=event.load_data.nom;
				dispatchValidateForm(event.load_data);
			}
		}
		
		protected function onResponseSendComments(event:LoadEvent):void
		{
			txt_error.text= event.load_data.message;
			if( event.load_data.suces){
				resetForm();
				if(mc_bar_progression.mc_masque)
					TweenLite.to(mc_bar_progression.mc_masque, 0.7, { x:-300 } );				
			}
		}
		
		
	}
	
}
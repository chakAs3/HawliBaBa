package emagin.components.upload 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.mtc.CModel;
	import com.mtc.InscriptionModel;
	import com.mtc.components.RectButton;
	import com.mtc.managers.FaceBookGraph;
	import com.serbai.xml.events.LoadEvent;
	
	import emagin.components.ECombo;
	import emagin.components.buttons.ECheckBox;
	import emagin.components.combo.events.EComboEvent;
	import emagin.components.formulaire.ErrorPuceForm;
	import emagin.events.FileEvent;
	import emagin.managers.FileManager;
	import emagin.utils.DateUtil;
	import emagin.utils.EmailValidator;
	import emagin.xml.RegisterFormSend;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * ...
	 * @author ©haki®
	 */
	public class UploadStep1 extends MovieClip
	{
		
		public var titre:String = "formulaire d'information";
		
		public var txt_nom:TextField;
		public var txt_pseudo:TextField;
		public var txt_email:TextField;
		public var txt_tel:TextField;
		public var txt_cin:TextField;
		public var txt_addresse:TextField;
		
		
		public var mc_error_nom:ErrorPuceForm;
		public var mc_error_prenom:ErrorPuceForm;
		public var mc_error_email:ErrorPuceForm;
		public var mc_error_tel:ErrorPuceForm;
		public var mc_error_cin:ErrorPuceForm;
		public var mc_error_upload:ErrorPuceForm;
		
		public var mc_error_date:ErrorPuceForm;
		public var mc_error_ville:ErrorPuceForm;
		public var mc_error_village:ErrorPuceForm;
		
		public var txt_label_cin:TextField;
		
		public var mc_check:*//ECheckBox;
		
		public var txt_error:TextField
		
		private var elementsToValidate:Array;
		
		
		private var errorEmail:String="Adresse email invalide ";
		private var errorEmptyFields:String = "Champs obligatoires ";
		
		public var btn_send:SimpleButton;
		
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
		
		 
		
		public function UploadStep1() 
		{
			 
			 
			
			 
			 txt_nom.embedFonts = true;
			 txt_pseudo.embedFonts = true;
			 txt_email.embedFonts = true;
			 txt_tel.embedFonts = true;
			 
			 txt_error.embedFonts = true;
			 // txt_cin.embedFonts = true;
			// txt_addresse.embedFonts = true;
			 
			// txt_label_cin.embedFonts = true;
			// txt_label_cin.selectable = false;
			 // txt_label_cin.defaultTextFormat = new TextFormat("Myriad Pro", 12, null, false, true);
			 
			 txt_nom.tabIndex = 0;
			 txt_pseudo.tabIndex = 1;
			 txt_email.tabIndex = 2;
			 txt_tel.tabIndex = 3;
			 //txt_cin.tabIndex = 4;
			 //txt_addresse.tabIndex = 5;
			 
			 
			 txt_tel.restrict = "[0-9]";
			 txt_tel.maxChars=10;
			 //txt_cin.restrict = "A-Z 0-9";
			 
			 
 
			 //.visible = false;
			 
			elementsToValidate=new Array();
			elementsToValidate.push( { element:txt_email, validator:"email" ,mc_error:mc_error_email} )
			elementsToValidate.push( { element:txt_nom, validator:"empty" ,mc_error:mc_error_nom} )
			//elementsToValidate.push( { element:txt_cin, validator:"empty" ,mc_error:mc_error_cin} )
			elementsToValidate.push( { element:txt_pseudo, validator:"empty" ,mc_error:mc_error_prenom} )
			//elementsToValidate.push( { element:txt_file, validator:"empty" ,mc_error:mc_error_upload} );
			elementsToValidate.push( { element:txt_tel, validator:"empty" ,mc_error:mc_error_tel} )
			//
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
			 
				elementsToValidate[i].element.addEventListener(FocusEvent.FOCUS_IN,onFocusTextFields)
			  
			 
			}
			
			btn_send.addEventListener(MouseEvent.CLICK, onCLickSendBTn) ;
			
			date_container = new Sprite();
		//	date_container.filters = [new DropShadowFilter(1, 90, 0, 0.3, 2, 2)];
			addChild(date_container);
			date_container.x = 240;
			date_container.y = 203;
			
			dataJour = new Array();
			for (var i:int = 1; i <= 31 ; i++) {
				dataJour.push( { id:i, label:i+"" } );
			}
			 dataMonth = new Array();
			 dataMonth.push( { id:1, label:"Jan" } );
			 dataMonth.push( { id:2, label:"Fév" } );
			 dataMonth.push( { id:3, label:"Mar" } );
			 dataMonth.push( { id:4, label:"Avr" } );
			 dataMonth.push( { id:5, label:"Mai" } );
			 dataMonth.push( { id:6, label:"Jui" } );
			 dataMonth.push( { id:7, label:"Juil" } );
			 dataMonth.push( { id:8, label:"Août" } );
			 dataMonth.push( { id:9, label:"Sep" } );
			 dataMonth.push( { id:10, label:"Oct" } );
			 dataMonth.push( { id:11, label:"Nov" } );
			 dataMonth.push( { id:12, label:"Déc" } );
			 
			 dataAns = new Array();
			for (var _i:int = 1950; _i < 2008 ; _i++) {
				dataAns.push( { id:_i, label:_i+"" } );
			}
			 
			
			jourCombo = new ECombo(dataJour, 60,38,[0xF3EFE9,0xD0C7B7]);
			jourCombo.txt_choix.text = "JJ";
			jourCombo.addEventListener(EComboEvent.ITEM_SELECTED,onComboDate)
			date_container.addChild(jourCombo);
			
			moisCombo = new ECombo(dataMonth, 65,38,[0xF3EFE9,0xD0C7B7]);
			moisCombo.txt_choix.text = "MM";
			date_container.addChild(moisCombo);
			moisCombo.addEventListener(EComboEvent.ITEM_SELECTED,onComboDate)
			moisCombo.x = jourCombo.width - 2 -6;
			
			
			ansCombo = new ECombo(dataAns, 70,38,[0xF3EFE9,0xD0C7B7]);
			ansCombo.txt_choix.text = "AA";
			date_container.addChild(ansCombo);
			ansCombo.addEventListener(EComboEvent.ITEM_SELECTED,onComboDate)
			ansCombo.x =moisCombo.x+ moisCombo.width-2-6 ;
		    
			
			
			
			var dataVilles:Array = CModel.villeList//new Array();
			/*dataVilles.push( { id:"Casablanca", label:"Casablanca" } );
			dataVilles.push( { id:"Rabat", label:"Rabat" } );
			dataVilles.push( { id:"Salé", label:"Salé" } );
			dataVilles.push( { id:"Tanger", label:"Tanger" } );
			dataVilles.push( { id:"Agadir", label:"Agadir" } );
			dataVilles.push( { id:"Ouajda", label:"Ouajda" } );
			dataVilles.push( { id:"Tetouan", label:"Tetouan" } );
			dataVilles.push( { id:"Jadida", label:"Jadida" } );*/
			 
			var dataVillage:Array = CModel.villageList//new Array();
			/*dataVillage.push( { id:"1", label:"Village 1" } );
			dataVillage.push( { id:"2", label:"Village 2" } );
			dataVillage.push( { id:"3", label:"Village 3" } );
			dataVillage.push( { id:"4", label:"Village 3" } );
			dataVillage.push( { id:"5", label:"Village 5" } );
			dataVillage.push( { id:"6", label:"Village 6" } );*/
			 
			
			villeCombo = new ECombo(dataVilles, 200,38,[0xF3EFE9,0xD0C7B7],3,0,7);
			villeCombo.txt_choix.text = "Votre Ville";
			addChildAt(villeCombo,getChildIndex(date_container)-1);
			villeCombo.addEventListener(EComboEvent.ITEM_SELECTED,onComboVilleChanged)
			villeCombo.x =240
			villeCombo.y =286;
			villeCombo.filters = [new DropShadowFilter(1, 90, 0, 0.3, 2, 2)];	
				
			/*villageCombo = new ECombo(dataVillage, 161+60,30,[0xFFFFFF,0xE6E6E6],6,0,5);
			villageCombo.txt_choix.text = "Village";
			addChildAt(villageCombo,getChildIndex(villeCombo)-1);
			villageCombo.addEventListener(EComboEvent.ITEM_SELECTED,onComboVillageChanged)
			villageCombo.x =2
			villageCombo.y =234	
			villageCombo.filters = [new DropShadowFilter(1, 90, 0, 0.3, 2, 2)];
			*/
			elementsToValidate.push( { element:villeCombo, validator:"list" ,mc_error:mc_error_ville} )
			//elementsToValidate.push( { element:villageCombo, validator:"list" ,mc_error:mc_error_village} )
			
			/*
			mc_bar_progression.mc_fond.mask = mc_bar_progression.mc_masque;
			mc_bar_progression.mc_masque.x = -mc_bar_progression.mc_masque.width-2;
			
			btn_browse.addEventListener(MouseEvent.CLICK, onMClickBrows) ;
			*/
			resetForm();
			creationReglement();
			setInfoFromFaceObjet(FaceBookGraph.userInfo);
		}
		public function setInfoFromFaceObjet(object:Object):void{
			txt_pseudo.text=object.first_name || "";
			txt_nom.text=object.last_name || "";
			txt_email.text=object.email || "";
		}
		
		private function onComboDate(e:EComboEvent):void 
		{
			if (jourCombo.txt_choix.text == "JJ" ||  moisCombo.txt_choix.text == "MM" || ansCombo.txt_choix.text =="AA") {
				 
			}else {
				//var date_n:Date = new Date(ansCombo.txt_choix.text, mois + 1, jourCombo.txt_choix.text);
				if (Number(ansCombo.txt_choix.text) > 1992 ) {
					// txt_label_cin.text = "N° CIN du tuteur ou resp. légal";
				}else {
					// txt_label_cin.text = "N° CIN";
				}
				TweenMax.to(mc_error_date, 0.5, { alpha:0} );
			}
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
			//TweenMax.to(this, 0.5, { autoAlpha:1,delay:0.3 } );
		}
		/* **************** Upload functions************************************/
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
						 (elementsToValidate[i].mc_error as ErrorPuceForm).setText("choisi un element ");
						 trace("no element choisi ");  
					 }
					 //( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
					 ; break;
			      default : break;
		        }
			}
			/**************************/
			var mois:int = moisCombo.selectedIndex;
			var date_n:Date=new Date(ansCombo.txt_choix.text, mois+1, jourCombo.txt_choix.text);
			date_n.date == Number(jourCombo.txt_choix.text);
			 var nbr_jour:Number = new Date(ansCombo.txt_choix.text, mois+ 1, 0).getDate() as Number;
           
			trace(this +mois+ " DATE :  date_n.date nbr_jour:" + nbr_jour + ",jourCombo.txt_choix :  " + jourCombo.txt_choix.text);
			
			/*****************************/
			if (nbr_jour < Number( jourCombo.txt_choix.text)) {
				error.push("Empty champ");
				txt_error.text = "Date de naissance invalide";
				trace(this + " Invalide Date ");
				 TweenMax.to(mc_error_date, 0.5, { alpha:1 } );
				 (mc_error_date as ErrorPuceForm).setText("Date de naissance invalide");
			}
			if (jourCombo.txt_choix.text == "JJ" ||  moisCombo.txt_choix.text == "MM" || ansCombo.txt_choix.text =="AA") {
				error.push("Empty champ");
				txt_error.text = "Saisissez vote date de naissance";
				TweenMax.to(mc_error_date, 0.5, { alpha:1 } );
				(mc_error_date as ErrorPuceForm).setText("Date de naissance obligatoire");
			}
			
			if (error.length) {
				
			 txt_error.htmlText =( (error.indexOf("The email adress is not valid.")>-1)?errorEmail:"" )+( (error.indexOf("Empty champ")>-1)?errorEmptyFields:"" );
			 if (error.length == elementsToValidate.length)
			 
			 //txt_error.htmlText =errorAllField//"All fields are mandatory"
			 txt_error.textColor = 0xFFFFFF ;
			
			}else{
			 txt_error.htmlText =""//errorAllField//"All fields are mandatory";
			 //txt_error.textColor = 0x333333;
			  if (!mc_check.selected){
			    txt_error.text="Veuillez accepter les termes et conditions du jeu"
			     return;
			 }
			 if (!valideUpload) {
				// txt_error.text = "selectionnes une vidéo a uploader ";
				 //return;
			 }
			 txt_error.htmlText =""
			 sendForm();
			  //resetForm()
			  
			}
			//addEventListener("FocusEventIn", onFocusInText ) 
			//txt_error.x = int(txt_com.x + (txt_com.width - txt_error.width) / 2);
		}
		
		 
		public function sendForm():void {
		    
			var idville:String=villeCombo.data[villeCombo.selectedIndex].id;
			//var idvillage:String=villageCombo.data[villageCombo.selectedIndex].id;
			ojectRequest = {userId:FaceBookGraph.userInfo.id, email:txt_email.text,nom:txt_nom.text ,tel:txt_tel.text,ville:idville,/*village:idvillage,*/date:jourCombo.txt_choix.text+"/"+(moisCombo.selectedIndex+1)+"/"+ansCombo.txt_choix.text,prenom:txt_pseudo.text,sex:FaceBookGraph.userInfo.gender};
			var send:RegisterFormSend = new RegisterFormSend(ojectRequest);
			send.addEventListener(LoadEvent.LOAD_REGISTER, onResponseSendRegister)
			
			dispatchValidateForm(ojectRequest);
		}
		
		private function dispatchValidateForm(objet:Object):void
		{
			//var loadEvent:LoadEvent = new LoadEvent(LoadEvent.VALIDATE_STEP1);
			//loadEvent.load_data = objet;
			//dispatchEvent(loadEvent);
		}
		public function dispatchAddComment(objet:Object):void {
			objet.date = "12/12/2012 12:12";
			//var loadEvent:LoadEvent = new LoadEvent(LoadEvent.COMMENT_RESPONSE_ADD);
			//loadEvent.load_data = objet;
			//dispatchEvent(loadEvent);
		}
		
		private function onResponseSendRegister(e:LoadEvent):void 
		{
			txt_error.text=e.load_data.message;
			trace(this+" "+e.load_data.message)
			if(e.load_data.suces){
				InscriptionModel.userInfo.id_fb=FaceBookGraph.userInfo.id
				InscriptionModel.userInfo.userid=e.load_data.id;
				dispatchEvent(new Event("RegistreDone",true));
			}
		}
		private function resetForm():void
		{
			for (var i:int = 0; i < elementsToValidate.length ; i++) { 
				if( elementsToValidate[i].element is TextField)
			 elementsToValidate[i].element.text = "";
			 //TweenLite.to(arrayIcones[i], 0.2, { tint:0x999999 } );
			 TweenMax.to(elementsToValidate[i].mc_error, 0.5, { alpha:0 } );
			}
			 TweenMax.to(mc_error_date, 0.5, { alpha:0 } );
			txt_error.text = "";
			
			
		}
		
		protected function onComboVilleChanged(event:Event):void
		{
			// TODO Auto-generated method stub
			TweenMax.to(mc_error_ville, 0.5, { alpha:0} );
		}
		
		protected function onComboVillageChanged(event:Event):void
		{
			// TODO Auto-generated method stub
			TweenMax.to(mc_error_village, 0.5, { alpha:0} );
		}
		
		
	}
	
}
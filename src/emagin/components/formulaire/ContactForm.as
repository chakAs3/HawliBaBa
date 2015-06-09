package emagin.components.formulaire {
	import com.greensock.TweenLite;
	
	//import emagin.Application;
	import emagin.components.ECombo;
	//import emagin.components.buttons.SeeButton;
	import emagin.utils.EmailValidator;
	import emagin.xml.RegisterFormSend;
	import emagin.xml.events.LoadEvent;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author emagin
	 */
	public class ContactForm extends Sprite {
		
		public var txt_title:TextField		public var txt_error:TextField
		/* les champs */
		public var txt_name:TextField
		public var txt_lastname:TextField		public var txt_email:TextField		public var txt_object:TextField;
		public var txt_message:TextField
		
		
		/* les label champs   ***/
		public var label_name:TextField
        public var label_email:TextField        public var label_dept:TextField
        public var label_message:TextField        public var label_info:TextField
        
        /* combo */
        public var comboDept:ECombo;
        
        /* buttons */
        public var btn_send:SimpleButton;
        public var btn_reset:SimpleButton;
		private var elementsToValidate : Array;
		private var errorAllField : String="tous les champs  sont obligatoire ";
		private var errorEmail : String=" email non valide ";
		private var errorEmptyFields : String=" des champs doivent etre non vide ";

		public var btn_close:*;
		public function ContactForm() {
			/*txt_title.embedFonts=true;
			
			txt_name.embedFonts=true;			txt_email.embedFonts=true;			txt_message.embedFonts=true;*/
			
			txt_name.tabIndex=0;
			txt_lastname.tabIndex=1;
            txt_email.tabIndex=2;
            txt_object.tabIndex=3;
			txt_message.tabIndex=4;
			
			/*label_name.autoSize="left";
            label_email.autoSize="left";            label_dept.autoSize="left";
            label_message.autoSize="left";
            
            label_name.embedFonts=true;
            label_email.embedFonts=true;
            label_dept.embedFonts=true;
            label_message.embedFonts=true;
            
            label_name.antiAliasType="advanced";
            label_email.antiAliasType="advanced";
            label_dept.antiAliasType="advanced";
            label_message.antiAliasType="advanced";*/
            
            /*
			label_name.styleSheet=Application.getInstance().styleGlobal;			label_email.styleSheet=Application.getInstance().styleGlobal;			label_dept.styleSheet=Application.getInstance().styleGlobal;			label_message.styleSheet=Application.getInstance().styleGlobal;			label_info.styleSheet=Application.getInstance().styleGlobal;			txt_title.styleSheet=Application.getInstance().styleGlobal;			txt_error.styleSheet=Application.getInstance().styleGlobal;
			 */
			
			
			/*label_name.htmlText="<span class='formLabel' >" + "Nom et prénom"+"</span>";			label_email.htmlText="<span class='formLabel' >" + "Votre email"+"</span>";			label_dept.htmlText="<span class='formLabel' >" + "Département à contacter"+"</span>";			label_message.htmlText="<span class='formLabel' >" + "Sujet du message"+"</span>";			label_info.htmlText="<span class='aideLabel' >" + " * CHAMPS OBLIGATOIRS"+"</span>";			txt_title.htmlText="<span class='titleParag' >" + "NOUS LAISSER UN MESSAGE"+"</span>";*/
			
			// var txtStyle:Object = Application.getInstance().styleGlobal.getStyle(".formtext");// get le style du text de saisi pour le formulaire 
            var txtFormat:TextFormat = new TextFormat("Georgia",null,null,false,true);//new TextFormat(txtStyle.fontFamily, txtStyle.fontSize, txtStyle.color, txtStyle.fontWeight);
        
			txt_name.defaultTextFormat = txtFormat;
			txt_lastname.defaultTextFormat = txtFormat;			txt_email.defaultTextFormat = txtFormat;			txt_message.defaultTextFormat = txtFormat;
			txt_object.defaultTextFormat = txtFormat;
			
			txt_error.defaultTextFormat = txtFormat;
			
			txt_email.text="";			txt_name.text= "";			txt_message.text = "";
			 
			btn_send.addEventListener(MouseEvent.CLICK, onBtnSendClick)
			addChild(btn_send)
			
			 
			btn_reset.addEventListener(MouseEvent.CLICK, onBtnResetClick);
			addChild(btn_reset)
			
			
			
			
			elementsToValidate=new Array();
         
            elementsToValidate.push({element:txt_name, validator:"empty"});
			elementsToValidate.push({element:txt_lastname, validator:"empty"});
			elementsToValidate.push({element:txt_object, validator:"empty"});
            elementsToValidate.push({element:txt_message, validator:"empty"});
            elementsToValidate.push({element:txt_email, validator:"email"});
            setDataCombo(null)
            //animateIn();
		}
		public function animateIn():void{
            for (var i : int = 0; i < numChildren; i++) {
                TweenLite.from(getChildAt(i),0.5,{y:getChildAt(i).y+10,alpha:0,delay:0.01*i});
            }
             
        }
		public function setDataCombo(array:Array):void {
			if(!array)array=[{id:"1",label:"Departement 1"},{id:"2",label:"Departement 2"},{id:"3",label:"Departement 3"}]
			comboDept = new ECombo(array, 296, 24, [0x002527, 0x002527], 0, 0);
            //comboDept.style=Application.getInstance().styleGlobal;
            comboDept.bublingEvent=true;
            comboDept.txt_choix.text = "départements";
            
            comboDept.y =  183;
            comboDept.x =  369;
            addChild(comboDept);
			if (array.length == 1)
            {
                comboDept.enabled = false;
                comboDept.mouseEnabled = false;
                comboDept.mouseChildren = false;
                comboDept.txt_choix.text = array[0].label;
            }
		}
		public function validateForm():void{
            var error:Array=new Array();
            trace("validateForm");
           
            for (var i:int=0;i< elementsToValidate.length ; i++){
                trace(" elemet "+i+" >"+elementsToValidate[i].element)
                switch(elementsToValidate[i].validator){
                 case "empty": 
                 var empty:Boolean=((elementsToValidate[i].element as TextField).text=="");
                   //( elementsToValidate[i].element as ETextForm).showFlechError(empty);
                 if(empty){    
                     error.push("Empty champ");
                     trace("errror epmty ");
                    
                 }
                 
                 ;
                 
                 
                 
                 break;
                 case "email": 
                 var valide:Boolean=EmailValidator.isValidEmail((elementsToValidate[i].element as TextField).text) ;
                  if(! valide ){
                     
                     error.push("The email adress is not valid.");
                     trace("email invalide ");
                       
                  }
                 // ( elementsToValidate[i].element as ETextForm).showFlechError(!valide);
                 ; break;
                  default :; break;
                }
            }
            if (error.length) {
                
             txt_error.htmlText =( (error.indexOf("The email adress is not valid.")>-1)?errorEmail:"" )+( (error.indexOf("Empty champ")>-1)?errorEmptyFields:"" );
             if (error.length == elementsToValidate.length)
             txt_error.text =errorAllField//"All fields are mandatory"
            // txt_error.textColor = 0xB68501 ;
            
            }else{
             txt_error.text =""//errorAllField//"All fields are mandatory";
             //txt_error.textColor = 0xB68501;
              
               sendForm();
            //afficheMessageConfirmation()
             
            }
            //addEventListener("FocusEventIn", onFocusInText ) 
		}

		 
		public function sendForm():void{
            var objectForm:Object={};
         
         
            objectForm.email=txt_email.text;
             
            
            objectForm.name = txt_name.text+" "+txt_lastname;
		 
            objectForm.message = txt_message.text;
            
            objectForm.dept = comboDept.data[comboDept.selectedIndex].id+"";
			//  objectForm.prenom=mc_last_name.txt_label.text;
            var contactSend:RegisterFormSend=new RegisterFormSend(objectForm);
            contactSend.addEventListener(LoadEvent.LOAD_REGISTER,onLoadContact)
		}

		private function onLoadContact(e:LoadEvent):void 
        {
            var cc:Object=e.load_data;
            txt_error.htmlText = cc.message;
            
            if (cc.suces) {
               // afficheMessageConfirmation()
                
            }
            onBtnResetClick(null);
        }
        private function onBtnResetClick(e:MouseEvent):void 
        {
            resetForm();
             
        }
        
        private function onBtnSendClick(e:MouseEvent):void 
        {
            validateForm();
        }
        
        public function resetForm():void{
             for each( var elem:Object in elementsToValidate){
                  elem.element.text="";
                // (elem.element as T).showFlechError(false);
             }
             txt_error.htmlText =""// errorAllField//"All fields are mandatory";
             txt_error.textColor = 0x333333;
        }
	}
}

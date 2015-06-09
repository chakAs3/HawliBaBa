package emagin.components.formulaire
{
    import caurina.transitions.*;
    import emagin.data.*;
    import emagin.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ETextForm extends MovieClip
    {
        public var mc_flech_error:MovieClip;
        private var tweenTextColor:TweenColor;
        private var _hauteur:Number;
        public var mc_fond:Sprite;
        private var _textLabel:String = "";
        private var _outCadreColor:int = 19045;
        private var _outTextColor:int = 11776947;
        private var _overCadreColor:int = 31155;
        public var txt_label:TextField;
        private var _overTextColor:int = 16777215;
        private var tweenColor:TweenColor;
        private var _largeur:Number;
        public var mc_compteur:Sprite;

        public function ETextForm()
        {
            _textLabel = "";
            _overCadreColor = Project.WEB_TYPE;
            _outCadreColor = 19045;
            _overTextColor = 16777215;
            _outTextColor = 11776947;
            txt_label.embedFonts = true;
            txt_label.text = _textLabel;
            txt_label.textColor = _outTextColor;
            tweenColor = new TweenColor(mc_compteur, 43);
            tweenTextColor = new TweenColor(txt_label, 43);
            setListeners();
            mc_flech_error.alpha = 0;
            return;
        }// end function

        public function set outTextColor(param1:int) : void
        {
            _outTextColor = param1;
            return;
        }// end function

        private function onTextFocusOut(event:FocusEvent) : void
        {
            tweenColor.setColor(_outCadreColor);
            tweenTextColor.setColor(_outTextColor);
            return;
        }// end function

        public function get largeur() : Number
        {
            return _largeur;
        }// end function

        public function set largeur(param1:Number) : void
        {
            _largeur = param1;
            mc_fond.width = _largeur;
            mc_compteur.width = _largeur;
            txt_label.width = _largeur - 10;
            return;
        }// end function

        public function showFlechError(param1:Boolean = true) : void
        {
            Tweener.addTween(mc_flech_error, {alpha:int(param1), time:0.4});
            return;
        }// end function

        public function get outCadreColor() : int
        {
            return _outCadreColor;
        }// end function

        public function get hauteur() : Number
        {
            return _hauteur;
        }// end function

        public function get overCadreColor() : int
        {
            return _overCadreColor;
        }// end function

        public function set textLabel(param1:String) : void
        {
            _textLabel = param1;
            txt_label.text = _textLabel;
            return;
        }// end function

        public function set overTextColor(param1:int) : void
        {
            _overTextColor = param1;
            return;
        }// end function

        public function set outCadreColor(param1:int) : void
        {
            _outCadreColor = param1;
            return;
        }// end function

        public function get outTextColor() : int
        {
            return _outTextColor;
        }// end function

        public function get overTextColor() : int
        {
            return _overTextColor;
        }// end function

        private function onTextFocusIn(event:FocusEvent) : void
        {
            tweenColor.setColor(_overCadreColor);
            tweenTextColor.setColor(_overTextColor);
            return;
        }// end function

        public function set hauteur(param1:Number) : void
        {
            _hauteur = param1;
            mc_fond.height = _hauteur;
            mc_compteur.height = _hauteur;
            if (_hauteur > 20)
            {
                txt_label.multiline = true;
            }
            txt_label.height = _hauteur - 4;
            return;
        }// end function

        public function get textLabel() : String
        {
            return _textLabel;
        }// end function

        public function set overCadreColor(param1:int) : void
        {
            _overCadreColor = param1;
            return;
        }// end function

        public function setListeners() : void
        {
            txt_label.addEventListener(FocusEvent.FOCUS_IN, onTextFocusIn);
            txt_label.addEventListener(FocusEvent.FOCUS_OUT, onTextFocusOut);
            onTextFocusOut(null);
            return;
        }// end function

    }
}

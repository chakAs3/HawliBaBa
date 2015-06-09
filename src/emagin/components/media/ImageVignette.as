package emagin.components.media
{
    import emagin.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class ImageVignette extends Sprite
    {
        private var path:String;
        private var pWidth:Number = 35;
        private var _bitmap:BitmapData;
        private var _image:Bitmap;
        private var _originalBitmap:BitmapData;
        public var _chargeur:Loader;
        private var pHeight:Number = 18;
        private var isAllSize:Boolean = true;
        private var isFull:Boolean = false;

        public function ImageVignette(param1:String, param2:Boolean = false, param3:Boolean = false)
        {
            _chargeur = new Loader();
            pWidth = 35;
            pHeight = 18;
            isFull = false;
            isAllSize = true;
            this.isFull = param2;
            this.isAllSize = param3;
            this.path = param1;
            _chargeur = new Loader();
            _chargeur.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImage);
            trace("nom d\'image " + param1);
            return;
        }// end function

        public function onCompleteImage(event:Event) : void
        {
            var _loc_2:Bitmap = null;
            var _loc_3:BitmapData = null;
            var _loc_4:Number = NaN;
            var _loc_5:Number = NaN;
            var _loc_6:Number = NaN;
            var _loc_7:Event = null;
            _loc_2 = Bitmap(_chargeur.content);
            trace(" width " + pWidth + "  height " + pHeight + "");
            _loc_3 = new BitmapData(_loc_2.width, _loc_2.height, true, 0);
            _loc_3.draw(_loc_2);
            originalBitmap = _loc_3;
            _bitmap = _loc_3;
            _image = new Bitmap(_loc_3);
            addChild(_image);
            _loc_5 = pWidth / _image.width;
            _loc_6 = pHeight / _image.height;
            if (Number(!isAllSize) * Number(_image.height * _loc_5 > pHeight))
            {
                _loc_4 = _loc_6;
            }
            else
            {
                _loc_4 = _loc_5;
            }
            if (isAllSize)
            {
                _loc_4 = Math.max(_loc_6, _loc_5);
            }
            if (_loc_4 != 1)
            {
                _image.bitmapData = ImageUtil.resampleBitmapData(_image.bitmapData, _loc_4);
            }
            _bitmap = _image.bitmapData;
            _loc_7 = new Event("ImageLoaded");
            dispatchEvent(_loc_7);
            return;
        }// end function

        public function getBitmap() : BitmapData
        {
            return _bitmap;
        }// end function

        public function get bitmap() : BitmapData
        {
            return _bitmap;
        }// end function

        public function get image() : Bitmap
        {
            return _image;
        }// end function

        public function get originalBitmap() : BitmapData
        {
            return _originalBitmap;
        }// end function

        public function set bitmap(param1:BitmapData) : void
        {
            _bitmap = param1;
            return;
        }// end function

        public function setSize(param1:Number, param2:Number) : void
        {
            pWidth = param1;
            pHeight = param2;
            return;
        }// end function

        public function setPosition(param1:Number, param2:Number) : void
        {
            this.x = param1;
            this.y = param2;
            return;
        }// end function

        public function set image(param1:Bitmap) : void
        {
            _image = param1;
            return;
        }// end function

        public function set originalBitmap(param1:BitmapData) : void
        {
            _originalBitmap = param1;
            return;
        }// end function

        public function load() : void
        {
            _chargeur.load(new URLRequest(path));
            return;
        }// end function

    }
}

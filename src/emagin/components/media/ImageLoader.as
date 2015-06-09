package emagin.components.media 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

    public class ImageLoader extends Sprite {
        private var url:String = "http://profile.ak.fbcdn.net/hprofile-ak-snc4/hs330.snc4/41546_1140609036_2423_q.jpg";        
		private var loader : Loader;
		private var _image : Bitmap;
		private var isAllSize : Boolean;
		private var pWidth : Number;
		private var pHeight : Number;

		//"http://cetobscurobjetdudesir.net.s3.amazonaws.com/20090606-_MG_4903.jpg";

        public function ImageLoader(url:String, isAllSize:Boolean=false) {
        	
			this.isAllSize=isAllSize;
			
			loader= new Loader();
            configureListeners(loader.contentLoaderInfo);
            
            var context:LoaderContext=new LoaderContext();
             context.checkPolicyFile=true;
          
			var request:URLRequest = new URLRequest(url);
            loader.load(request, context);

			//addChild(loader);
        }

		public function get getImage():Bitmap
		{
			return _image;
		}

		public function set getImage(value:Bitmap):void
		{
			_image = value;
		}

        private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, completeHandler);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            dispatcher.addEventListener(Event.UNLOAD, unLoadHandler);
        }

        private function completeHandler(event:Event):void {
            trace("completeHandler: " + event);
            
               var imageChargee:Bitmap = (loader.content) as Bitmap;
               
               var bitmap:BitmapData = new BitmapData(imageChargee.width, 
                                                imageChargee.height,
                                                true,
                                                0x00000000
                                                     );
               bitmap.draw(imageChargee);
              _image= new Bitmap(bitmap);
              addChild(_image); 
             
			  pWidth = (pWidth || _image.width);
			  pHeight = (pHeight || _image.height);
			  
			  var ratio:Number;
              var coefw:Number = pWidth / _image.width;
              var coefh:Number = pHeight / _image.height;
              
              if (Number(!isAllSize)*Number(_image.height * coefw > pHeight) ) {
                 ratio=coefh;
              }else {
                 ratio=coefw;
              }
              
			_image.smoothing=true;
			_image.scaleX = ratio;                			_image.scaleY = ratio;   
			
			dispatchEvent(new Event("ImageLoaded",true));
		}
        public  function setSize(w:Number,h:Number) : void
        {
            pWidth=w;
            pHeight=h;   
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
        }

        private function initHandler(event:Event):void {
            trace("initHandler: " + event);
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("ioErrorHandler: " + event);
			dispatchEvent(new Event("ImageLoaded",true));
        }

        private function openHandler(event:Event):void {
            trace("openHandler: " + event);
        }

        private function progressHandler(event:ProgressEvent):void {
            trace("progressHandler: bytesLoaded=" + event.bytesLoaded + " bytesTotal=" + event.bytesTotal);
			var eventPRogres:ProgressEvent=new ProgressEvent(ProgressEvent.PROGRESS);
			eventPRogres.bytesLoaded=event.bytesLoaded
			eventPRogres.bytesTotal=event.bytesTotal;
			dispatchEvent(eventPRogres);
        }

        private function unLoadHandler(event:Event):void {
            trace("unLoadHandler: " + event);
        }

        private function clickHandler(event:MouseEvent):void {
            trace("clickHandler: " + event);
            var loader:Loader = Loader(event.target);
            loader.unload();
		}
		
		public function get image() : Bitmap {
			return _image;
		}
		
		public function set image(image : Bitmap) : void {
			_image = image;
		}
	}
}
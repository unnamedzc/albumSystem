package elements 
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class smallPicBt extends MovieClip 
	{
		private var _selected:Boolean = false;
		private var _loader:Loader;
		private var _bigPicUrl:String;
		
		private var _bigPicIntro:String;
		
		public function smallPicBt() 
		{
			super();
			stop();	
			_loader = new Loader();	
			addChild(_loader);
			this.buttonMode = true;
		}
		
		public function reset():void
		{
			_loader.unload();
			selected = false;
			
			this.visible = false;
			_bigPicUrl = null;
		}
		
		public function set selected(value:Boolean)
		{
			_selected = value;
			_selected == true?
				gotoAndStop(2):gotoAndStop(1);				
		}
		
		public function get Intro():String
		{
				return _bigPicIntro;
		}
		
		public function get Url():String 
		{
			return _bigPicUrl;
		}		
		
		public function loadPic($loadUrl:String,$intro:String)
		{
			loadingMark.visible = true;
			this.visible = true;
			_bigPicUrl = $loadUrl;
			_bigPicIntro = $intro;
			_loader.unload();
			_loader.load(new URLRequest($loadUrl));
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		
		private function progressHandler(evt:ProgressEvent):void 
		{
			
		}
		private function completeHandler(event:Event):void 
		{
			loadingMark.visible = false;
			_loader.width = _loader.height = 58;
			
		}
	}

}
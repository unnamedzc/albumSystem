package elements 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class picPreviewer extends Sprite 
	{
		private var _des:TextField;
		private var _dataXmlUrl:String;
		private var _loading:Sprite;
		internal const PIC_WIDTH:int = 280;
		internal const PIC_HEIGHT:int = 250;
		
		private var _loader:Loader;
		public function picPreviewer(title:String,picUrl:String,dataXmlUrl:String) 
		{
			super();
			_des = this.des;
			_des.text = title;
			_loading = loadingMark;
			
			_dataXmlUrl = dataXmlUrl;
			
			_loader = new Loader();	
			addChild(_loader);
			_loader.x = 14;
			_loader.y = 18;
			this.buttonMode = true;
			_loader.unload();
			_loader.load(new URLRequest(picUrl));
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			
		}
		
		private function progressHandler(evt:ProgressEvent):void 
		{
			
		}
		private function completeHandler(event:Event):void 
		{
			loadingMark.visible = false;
			_loader.width = PIC_WIDTH;
			_loader.height = PIC_HEIGHT;			
		}
		
		public function reset():void
		{
			_loader.unload();
		}
		
		public function get dataXmlUrl():String
		{
			return _dataXmlUrl;
		}
		
	}

}
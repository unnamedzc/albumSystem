package elements {
	import elements.smallPicBt;
	import elements.subMenuBt;
	import fl.motion.easing.Bounce;
	import fl.transitions.Tween;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;
	import fl.motion.easing.Elastic;
	import Events.MyEvent;
	
	import com.greensock.TweenLite;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class MainPage extends Sprite 
	{
		
		//const
		private const MAX_PICS:int = 12;
		private const PIC_WIDTH:int = 807;// 800;
		private const PIC_HEIGHT:int = 387;// 380;
		//var
		private var urlRequest:URLRequest;
		private var loadxml:URLLoader;
		private var smallConArr:Vector.<smallPicBt> = new Vector.<smallPicBt>;
		private var _loader:Loader;
		private var _selectedMenuId:int;
		private var _mainXml:XML;
		private var _pageXML:XML
		private var _mainPageUrl:String;
		
		private var _blackTween:TweenLite;
		
		private var smallPicLen:int;
		private var _currentStartPicId:int;
		
		public function MainPage() 
		{
			super();
			//trace("ok");
			//initSmallContainer();
			//menuContainer.visible = false;
			
		}
		
		
		
		private function initBigContainer():void
		{
			_loader = new Loader();
			loaderContainer.addChild(_loader);
		}
		
		private function initSmallContainer():void
		{
			var _smallPicBt:smallPicBt; //= new smallPicBt();
			for (var i = 0; i < MAX_PICS; i++ )
			{
				_smallPicBt = new smallPicBt();
				smallContainer.addChild(_smallPicBt);
				_smallPicBt.x = (_smallPicBt.width + 6) * i;
				_smallPicBt.visible = false;
				smallConArr.push(_smallPicBt);
			}
		}
		
		public function loadXML(xmlURL:String)
		{
			initSmallContainer();
			initBigContainer();
			urlRequest=new URLRequest(xmlURL)
			loadxml=new URLLoader(urlRequest)
			loadxml.addEventListener(ProgressEvent.PROGRESS,xmlLoaded);
			loadxml.addEventListener(Event.COMPLETE, xmlComplete);
		}		
		
		public function disposeAll():void
		{
			try{
				loadxml = null;
				if(_loader)
					_loader.unload();
				
				TweenLite.killTweensOf(this);
				if (smallConArr.length > 0)
				{
					for each(var smallBt:smallPicBt in smallConArr)
					{
						smallBt.reset();
						smallContainer.removeChild(smallBt);
					}
					smallConArr = new Vector.<smallPicBt>;
					smallConArr.length = 0;
				}
				subMenuContainer.removeChildren();
			}catch (e:Error)
			{
				throw(e);
			}
		}		
		
		private function  xmlLoaded(e:ProgressEvent):void{
			try{
				var tar=e.target;
				var bytes:Number=tar.bytesLoaded/tar.bytesTotal;
			}catch(e:Error){
				throw("cuowu")	
			}
			//trace(bytes.toFixed(2));
		}
		
		private function xmlComplete(e:Event):void {
			_mainXml = XML(e.target.data);
			//var subMenuLength:int = _mainXml.subMenu.length();
			//trace(xml.subMenu.length())
			/*var subMenu:subMenuBt;
			for (var i = 0; i < subMenuLength; i++ )
			{
				//trace(_mainXml.subMenu[i].@Title);
				subMenu=new subMenuBt(_mainXml.subMenu[i].@Title)
				subMenuContainer.addChild(subMenu);
				subMenu.x = (subMenu.width + 10) * i;
				subMenu.menuId = i;
				subMenu.addEventListener(MouseEvent.CLICK, onChoosesubMenu);
			}*/
			
			//default set to page1
			_selectedMenuId = 0;
			parseXmlAndInitPic(_mainXml);			
			
		}
		
		private function onChoosesubMenu(e:MouseEvent):void
		{
			//trace(_selectedMenuId,(e.currentTarget as subMenuBt).menuId)
			if (_selectedMenuId == (e.currentTarget as subMenuBt).menuId)
			{
				return;
			}
			reset();
			//trace((e.currentTarget as subMenuBt).menuId);
			_selectedMenuId=(e.currentTarget as subMenuBt).menuId
			parseXmlAndInitPic(_mainXml.subMenu[_selectedMenuId]);
		}
		
		private function onChooseSmallPic(e:MouseEvent):void
		{
			var newUrl = (e.currentTarget as smallPicBt).Url;
			
			if (_mainPageUrl == newUrl)
			{
				return;
			}
			intro.text=(e.currentTarget as smallPicBt).Intro;
			for each(var tempSmall:smallPicBt in smallConArr )
			{
				tempSmall.selected = false;
			}
			(e.currentTarget as smallPicBt).selected = true;
			loadMainPic(newUrl);
		}
		
		private function reset():void
		{
			for each(var tempSmall:smallPicBt in smallConArr )
			{
				tempSmall.reset();
				tempSmall.removeEventListener(MouseEvent.CLICK,onChooseSmallPic);
			}
			_loader.unload();
			TweenLite.killTweensOf(this);
		}
		private function btAddListeners():void
		{
			toLSmall.removeEventListener(MouseEvent.CLICK,changeSmallPic)
			toRSmall.removeEventListener(MouseEvent.CLICK,changeSmallPic)
			toLSmall.addEventListener(MouseEvent.CLICK,changeSmallPic)
			toRSmall.addEventListener(MouseEvent.CLICK,changeSmallPic)
		}
		
		private function get currentStartPicId():int
		{
			return _currentStartPicId;
		}
		
		private function set currentStartPicId(value:int)
		{
			if (value > _pageXML.Pic.length()-MAX_PICS+1)
			{
				_currentStartPicId = 1;
			}else if(value<1)
			{
				_currentStartPicId = _pageXML.Pic.length() - MAX_PICS + 1;
			}else{
				_currentStartPicId = value;
			}
			trace("currentStartPicId::",value, _pageXML.Pic.length(), _currentStartPicId);
			//
			reloadAllSmallPicFrom(_currentStartPicId);
		}
		
		private function changeSmallPic(e:MouseEvent):void
		{
			if (e.target.name == "toLSmall")
			{
				currentStartPicId--;
			}else {
				//trace("SSSSSSSSSSSSSSSS");
				currentStartPicId++;
			}
		}
		
		
		
		private function reloadAllSmallPicFrom($startId:int):void {
			//trace(_pageXML)
			var btId:int=$startId-1;
			for (var i = $startId-1; i < $startId+MAX_PICS-1; i++ )
			{
				trace("III::", i);
				//trace(_pageXML.Pic[i].Url);
				smallConArr[i - btId].selected=false;
				smallConArr[i-btId].loadPic(_pageXML.Pic[i].Url, _pageXML.Pic[i].Content);
				smallConArr[i-btId].removeEventListener(MouseEvent.CLICK, onChooseSmallPic);
				smallConArr[i-btId].addEventListener(MouseEvent.CLICK, onChooseSmallPic);
			}
		}
		/*
		 * 
		 * parse sub xml and init upgrade page
		 * */
		private function parseXmlAndInitPic(xml:XML):void 
		{
			_pageXML = xml;
			trace(xml)
			smallPicLen = xml.Pic.length() >= MAX_PICS
			?MAX_PICS:xml.Pic.length();
			
			if (smallPicLen < MAX_PICS)
			{
				toLSmall.visible = toRSmall.visible = false;
				//btAddListeners();
			}else {
				//TODO remove and addListener
				toLSmall.visible = toRSmall.visible = true;
				btAddListeners();
			}
			for (var i = 0; i < smallPicLen; i++ )
			{
				//trace(xml.Pic[i].Url,smallConArr[i],smallConArr[i]);
				smallConArr[i].loadPic(xml.Pic[i].Url,xml.Pic[i].Content);
				smallConArr[i].addEventListener(MouseEvent.CLICK, onChooseSmallPic);
			}			
			loadMainPic(xml.Pic[0].Url);
			intro.text = xml.Pic[0].Content;
			_currentStartPicId = 1;
		}
		
		private function loadMainPic($loadUrl:String):void
		{	
			_mainPageUrl = $loadUrl;
			loadingMark.visible = true;
			intro.visible=
			blackAni.visible = false;
			_loader.unload();
			_loader.load( new URLRequest($loadUrl));
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadPicCompleteHandler);
		}
		
		private function progressHandler(evt:ProgressEvent):void 
		{
			
		}
		private function loadPicCompleteHandler(event:Event):void 
		{
			loadingMark.visible = false;
			var flashmo_bm:Bitmap = new Bitmap
			flashmo_bm = Bitmap(event.target.content);	
			trace(flashmo_bm.width, flashmo_bm.height );
			//TODO resize the pics
			_loader.x =_loader.y= 0;
			
			if (flashmo_bm.width < PIC_WIDTH)
			{
				//_loader.width = PIC_WIDTH;
				_loader.x = (PIC_WIDTH >> 1) - (flashmo_bm.width >> 1);
				_loader.width = flashmo_bm.width;
				
			}else {
				_loader.width = PIC_WIDTH;
			}
			if (flashmo_bm.height < PIC_HEIGHT)
			{
				_loader.y = (PIC_HEIGHT >> 1) - (flashmo_bm.height >> 1);
				_loader.height = flashmo_bm.height;
			}
			else{			
				_loader.height = PIC_HEIGHT;
			}
			
			playBlackAni();
			//var flashmo_bm:Bitmap = new Bitmap();
			//flashmo_bm = Bitmap(event.target.content);		
			
		}
		
		private function playBlackAni():void
		{			
			blackAni.visible = true;
			blackAni.scaleX = 0;
			var tweenObj = {
				scaleX:1,
				ease:Bounce.easeOut,
				onComplete:function() {
						TweenLite.killTweensOf(this);
						intro.visible = true;
				}
			}
			_blackTween = new TweenLite(blackAni, .8, tweenObj);
			_blackTween.play();
		}
		
	}

}
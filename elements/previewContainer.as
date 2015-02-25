package elements 
{
	import Events.MyEvent;
	import flash.display.Sprite;
	import fl.controls.ScrollBarDirection;
	import fl.controls.UIScrollBar;	
	import fl.events.ScrollEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;	
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author jeff
	 */
	public class previewContainer extends Sprite 
	{
		protected var mask_mc:Sprite;
		protected var target_mc:Sprite;
		
		internal const HOR_PIC_NUM:uint = 4;
		internal const HOR_GAP:int =2;
		internal const VER_GAP:int = 20;
		
		internal var picReviewVec:Vector.<picPreviewer> = new Vector.<picPreviewer>;
		
		private var loadxml//=new URLLoader(new URLRequest("data/Main.xml"))
		public function previewContainer() 
		{
			super();
			mask_mc = masker;
			target_mc = container;
			//target_mc.mask = mask_mc;
			var scrollbar = new UIScrollBar();
			
			scrollbar.direction = ScrollBarDirection.VERTICAL;
			scrollbar.height = mask_mc.height;
			scrollbar.x = mask_mc.width-scrollbar.width;
			//scrollbar.move( masker.width, 0 );
			addChild(scrollbar);
			//mask_mc = masker;
			//target_mc = container;
			//container.mask = masker;
			scrollbar.setScrollProperties(mask_mc.height, 0, target_mc.height - mask_mc.height, 30)
			scrollbar.addEventListener(ScrollEvent.SCROLL, onScroll);
			function onScroll(event:ScrollEvent):void
			{
				target_mc.y = mask_mc.y - event.position;  
			} 
			
		}
		
		public function getPicsInfo(dataUrl:String):void
		{
			trace("GETPICINFO", dataUrl);
			removeContainerChildrens();
			loadxml = new URLLoader(new URLRequest(dataUrl));
			loadxml.addEventListener(Event.COMPLETE, xmlComplete);
			
		}
		
		private function removeContainerChildrens():void
		{
			if (picReviewVec.length > 0)
			{
				for each(var picReview:picPreviewer in picReviewVec)
				{
					picReview.removeEventListener(MouseEvent.CLICK, onClickPic);
					//trace(picReview);
					target_mc.removeChild(picReview);
				}
				picReviewVec = new Vector.<picPreviewer>;
				picReviewVec.length = 0;
			}
		}
		
		private function onClickPic(e:MouseEvent):void
		{
			trace((e.currentTarget as picPreviewer).dataXmlUrl);
			
			dispatchEvent(new MyEvent(MyEvent.CLICK_ALBUMBT, (e.currentTarget as picPreviewer).dataXmlUrl));
		}
		
		private function xmlComplete(e:Event)
		{
			var _myalbumXml:XML = XML(e.target.data);
			trace(_myalbumXml.pics.length());
			var len:int = _myalbumXml.pics.length();
			var _picPreviewer:picPreviewer;
			for (var i:int = 0; i < len; i++)
			{				
				//trace("sub::",subLen);
				//mk.addBtToContainer(_naviXml.nav[i].@title);
				var title:String = _myalbumXml.pics[i].@title;
				var picUrl:String = _myalbumXml.pics[i].@picUrl;
				var dataUrlXml:String = _myalbumXml.pics[i];
				_picPreviewer = new picPreviewer(title,picUrl,dataUrlXml);
				target_mc.addChild(_picPreviewer);
				picReviewVec.push(_picPreviewer);
				//_picPreviewer
				_picPreviewer.addEventListener(MouseEvent.CLICK, onClickPic);
				_picPreviewer.x = i % HOR_PIC_NUM*(_picPreviewer.width+HOR_GAP);
				_picPreviewer.y = int( i / HOR_PIC_NUM)*(_picPreviewer.height+VER_GAP);
			}
		}	
		
	}

}
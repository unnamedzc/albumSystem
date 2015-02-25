package elements 
{
	import Events.MyEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import fl.controls.ScrollBarDirection;
	import fl.controls.UIScrollBar;	
	import fl.events.ScrollEvent;
	
	import elements.subMenuBt;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class makserContainer extends Sprite 
	{		
		protected var mask_mc:Sprite;
		protected var target_mc:Sprite;
		private var scrollbar = new UIScrollBar();
		
		private var navBtsVec:Vector.<navigationBt> = new Vector.<navigationBt>;
		public function makserContainer() 
		{
			super();
			mask_mc = masker;
			target_mc = container;
			target_mc.mask = mask_mc;
			
			this.scaleX = 1.3;
			scrollbar.direction = ScrollBarDirection.VERTICAL;
			
			scrollbar.setSize(mask_mc.width,mask_mc.height)
			//scrollbar.height = mask_mc.height;
			scrollbar.x = mask_mc.width;
			//scrollbar.move( masker.width, 0 );
			addChild(scrollbar);
			//mask_mc = masker;
			//target_mc = container;
			//container.mask = masker;
			
			scrollbar.addEventListener(ScrollEvent.SCROLL, onScroll);
			function onScroll(event:ScrollEvent):void
			{
				//trace(target_mc.y);
				target_mc.y = mask_mc.y - event.position;  
			} 
			
			
			//initContainerElements();
			
		}
		
		public function destroy():void
		{
			for each(var tempBt:navigationBt in navBtsVec)
			{
				container.removeChild(tempBt);
				tempBt.removeEventListener(MouseEvent.CLICK, ontempBtClick);
			}
			
			navBtsVec = new Vector.<navigationBt>;
			navBtsVec.length = 0;
		}
		
		public function addBtToContainer(str:String,isAlbum:Boolean=false,albumUrl:String=""):void
		{
			var tempBt:navigationBt = new navigationBt(str,albumUrl);
			container.addChild(tempBt);
			navBtsVec.push(tempBt);
			tempBt.y = (navBtsVec.length - 1) * tempBt.height;
			tempBt.isSubMenu = isAlbum;
			tempBt.addEventListener(MouseEvent.CLICK, ontempBtClick);
		}
		
		public function updateScrollBar():void
		{
			target_mc.y = 0;
			scrollbar.setScrollProperties(mask_mc.height, 0, target_mc.height - mask_mc.height, 30)
		}
		
		private function ontempBtClick(e:MouseEvent):void
		{
			trace((e.currentTarget).albumUrl);
			var albumUrl:String=(e.currentTarget).albumUrl
			dispatchEvent(new MyEvent(MyEvent.CLICK_NAVBT, albumUrl));
		}
		
		//init elements by xml
		private function initContainerElements():void
		{
			var tempBt:navigationBt;
			for (var i = 0; i < 120; i++ )
			{
				tempBt=new navigationBt("tttttt")
				container.addChild(tempBt);
				tempBt.y = i * tempBt.height;
				
				/*if (i == 2)
				{
					tempBt.isSubMenu = true;
				}*/
				
			}
			/*var scr:phhui_ScrollBar=new phhui_ScrollBar();
			scr._type=1;
			scr._obj=container;
			scr._mask=masker;
			scr._h=955;
			scr._v=50;
			scr._scroll=mscr;
			scr.init();*/
			scrollbar.setScrollProperties(mask_mc.height, 0, target_mc.height - mask_mc.height, 30)
		}
		
	}

}
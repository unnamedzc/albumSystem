package elements 
{
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import elements.makserContainer;
	import flash.events.MouseEvent;
	
	import Events.MyEvent;
	import flash.system.IME;
	/**
	 * ...
	 * @author jeff
	 */
	public class Navigation extends Sprite 
	{
		private var mk:makserContainer;		
		private var _naviXml:XML;
		
		public function Navigation() 
		{
			super();
			//var mk = new makserContainer();
			//addChild(mk);
			mk = maskerContainer;
			mk.x = 24;
			mk.y = 100;
			
			addListeners();
			flash.system.IME.enabled = true;
		}
		
		private function addListeners():void
		{
			//this.addEventListener(MyEvent.GET_NAVDATA, onGetNavData);
			this.addEventListener(MyEvent.UPDATA_NAVDATA, onUpdataNavData);
			
			mk.addEventListener(MyEvent.CLICK_NAVBT, onNavEleClicked);
			
			searchBt.addEventListener(MouseEvent.CLICK, onSearch);
		}
		
		private function pushElementToNav():void
		{
			
		}
		
		private function onUpdataNavData(e:MyEvent):void
		{
			
		}
		
		public function getNavData(data:XML):void
		{			
			_naviXml = XML(data);
			initMks();
		}
		
		private function initMks():void
		{
			var len:int = _naviXml.nav.length();
			var subLen:int;
			
			for (var i:int = 0; i < len; i++ )
			{
				subLen = _naviXml.nav[i].album.length();
				//trace("sub::",subLen);
				mk.addBtToContainer(_naviXml.nav[i].@title);
				for (var j:int = 0; j < subLen; j++ )
				{
					//trace(_naviXml.nav[i].pics[j].@title);
					mk.addBtToContainer(_naviXml.nav[i].album[j].@title, true,_naviXml.nav[i].album[j]);
				}
			}
			mk.updateScrollBar();
		}
		
		private function onNavEleClicked(e:MyEvent):void
		{
			//should dispatch event here
			//trace("CallBack::", e.data);
			dispatchEvent(new MyEvent(MyEvent.SHOW_SELECTED_ALBUMS_IN_PIC_CON, e.data));
			
		}
		
		private function onSearch(e:MouseEvent):void
		{
			const str=searchIndex.text
			if (str!= "")
			{				
				var reg:RegExp = new RegExp(str, "\g");
				var len:int = _naviXml.nav.length();
				var subLen:int;
				var addSubBt:Boolean = false;
				var compareStr:String;
				mk.destroy();
				for (var i:int = 0; i < len; i++ )
				{
					subLen = _naviXml.nav[i].album.length();
					addSubBt = false;
					//trace("sub::",subLen);
					//mk.addBtToContainer(_naviXml.nav[i].@title);
					for (var j:int = 0; j < subLen; j++ )
					{
						compareStr = _naviXml.nav[i].album[j].@title;
						trace(compareStr, compareStr.search(reg),str);
						if (compareStr.search(reg)==0)
						{
							if (false == addSubBt)
							{
								mk.addBtToContainer(_naviXml.nav[i].@title);
								addSubBt = true;
							}
							mk.addBtToContainer(_naviXml.nav[i].album[j].@title, true,_naviXml.nav[i].album[j]);
						}
						//mk.addBtToContainer(_naviXml.nav[i].album[j].@title, true,_naviXml.nav[i].album[j]);
					}
					
					mk.updateScrollBar();
				}				
			}else
			{
				mk.destroy();
				initMks();
			}
		}
		
	}

}
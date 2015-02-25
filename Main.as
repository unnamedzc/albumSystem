package  
{
	import elements.MainPage;
	import elements.Navigation;
	import elements.popUp;
	import elements.previewContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.ui.ContextMenu;
	import Events.MyEvent;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	/**
	 * ...
	 * @author jeff
	 */
	public class Main extends MovieClip 
	{
		private var str:int=0;
		private var _debug:Boolean = false;		
		
		private var _soundBg = new soundBg();
		private var _soundChanel:SoundChannel;
		
		private var _mode:String;
		
		internal const NAV_MODE:String = "NAV_MODE";
		internal const MAIN_PAGE_MODE:String = "MAIN_PAGE_MODE";
		
		//private var _popUp:popUp;
		
		public function Main() 
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP;
			
			//添加到菜单
			var customContextMenu:ContextMenu = new ContextMenu();
			customContextMenu.hideBuiltInItems();

			this.contextMenu = customContextMenu;
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.addEventListener(Event.COMPLETE, completeHandler);			
		}
		
		private function progressHandler(evt:ProgressEvent):void {
			var loaded:uint = evt.bytesLoaded;
			var total:uint = evt.bytesTotal;
			str=Math.floor((loaded/total)*100);
			loading.per.text="load:"+String(str) + "%";
			loading.gotoAndStop(str);
		}
		private function completeHandler(event:Event):void {
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			loading.visible = false;
			
			//_popUp = new popUp();
			//popUpContainer.addChild(_popUp);
			
			if(_debug){
				this.switchFrame(3);
			}else{
				this.switchFrame(2);
			}			
		}
		
		private function switchFrame($frame:int):void
		{
			this.gotoAndStop($frame);
			removeListeners();
			switch($frame)
			{
				case 2:
					//_soundBg.close();
					addLoginPageListeners();
					break;
				case 3:
					_soundChanel=_soundBg.play(0,int.MAX_VALUE);
					//load navigation xml
					//_soundBg.play();
					var loadxml=new URLLoader(new URLRequest("data/Main.xml"))
					loadxml.addEventListener(Event.COMPLETE, xmlComplete);
					
					(getChildByName("mainpage") as MainPage).visible = false;
					
					addMainPageListeners();
					
					break;
				/*case 4:
					(getChildByName("mainpage") as MainPage).loadXML("data/Content.xml");
					getChildByName("mainpage").addEventListener(MyEvent.LOGOUT,onLogOut)
					break;*/
			}
		}	
		
		private function addLoginPageListeners():void
		{
			getChildByName("LoginElements").addEventListener(MyEvent.LOGIN, onLogin);
			
			getChildByName("LoginElements").addEventListener(MyEvent.LOGIN_FAILED, onLoginFailed);
		}
		
		
		private function addMainPageListeners():void
		{
			//(getChildByName("mainpage") as MainPage).addEventListener(MyEvent.LOGOUT, onLogOut);
			getChildByName("logout").addEventListener(MouseEvent.CLICK, onLogOut);
			
			
			(getChildByName("navigation") as Navigation).addEventListener(MyEvent.SHOW_SELECTED_ALBUMS_IN_PIC_CON, onShowAlbums);
			(getChildByName("picContainer") as previewContainer).addEventListener(MyEvent.CLICK_ALBUMBT, onClickAlbumBt);
		}
		
		private function removeListeners():void
		{
			if(getChildByName("LoginElements"))
				getChildByName("LoginElements").removeEventListener(MyEvent.LOGIN, onLogin);
			if(getChildByName("logout"))
				getChildByName("logout").removeEventListener(MouseEvent.CLICK, onLogOut);
			if(getChildByName("picContainer"))
				(getChildByName("picContainer") as previewContainer).removeEventListener(MyEvent.CLICK_ALBUMBT, onClickAlbumBt);
			if(getChildByName("navigation"))
				(getChildByName("navigation") as Navigation).removeEventListener(MyEvent.SHOW_SELECTED_ALBUMS_IN_PIC_CON, onShowAlbums);
		}
		
		private function onClickAlbumBt(e:MyEvent):void
		{
			Mode = MAIN_PAGE_MODE;
			(mainpage as MainPage).loadXML(String(e.data));
		}
		
		private function onShowAlbums(e:MyEvent):void
		{
			Mode = NAV_MODE;
			(getChildByName("picContainer") as previewContainer).getPicsInfo(String(e.data));
		}
		
		private function xmlComplete(e:Event):void
		{			
			(getChildByName("navigation") as Navigation).getNavData(XML(e.target.data));
			
			
		}
		
		private function onLoginFailed(e:MyEvent):void
		{
			//_popUp.startPopUp("用户名或密码错误");
		}
		
		private function onLogin(e:MyEvent):void
		{
			//todo login data;
			switchFrame(3);
		}
		
		private function onLogOut(e:MouseEvent):void
		{
			//todo login data;
			_soundChanel.stop();
			switchFrame(2);
			
			//todo remove all;
		}
		
		private function set Mode(value:String):void
		{
			if (value == _mode)
			{
				return;
			}
			_mode = value;
			if (MAIN_PAGE_MODE==value)
			{
				(getChildByName("picContainer") as previewContainer).visible = false;
				mainpage.visible = true;
			}else
			{
				(getChildByName("picContainer") as previewContainer).visible = true;
				mainpage.visible = false;
				(mainpage as MainPage).disposeAll();
			}
		}
		
	}

}
package elements 
{
	import Events.MyEvent;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class navigationBt extends Sprite 
	{
		private var _menuId:int;
		private var _isSubMenu:Boolean;
		private var _albumUrl:String;
		public function set isSubMenu(value)
		{
			_isSubMenu = value;
			this.btName.x =value?
				 20:0;
			
		}
		public function set menuId(value)
		{
			_menuId = value;
		}
		public function get menuId():int
		{
			return _menuId;
		}
		public function navigationBt(str:String,url:String="") 
		{
			super();		
			//this.mouseEnabled = true;
			this.btName.text = str;
			_albumUrl = url;
			
			//bt.addEventListener(MouseEvent.CLICK,onClickBt)
		}		
		
		public function get albumUrl():String
		{
			return _albumUrl;
		}
		
		
	}

}
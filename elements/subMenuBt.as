package elements 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class subMenuBt extends MovieClip 
	{
		private var _menuId:int;
		public function set menuId(value)
		{
			_menuId = value;
		}
		public function get menuId():int
		{
			return _menuId;
		}
		public function subMenuBt(str:String) 
		{
			super();		
			//this.mouseEnabled = true;
			this.btName.text = str;
		}		
		
	}

}
package Events
{

	import flash.events.Event;

	public class MyEvent extends Event
	{	public var data:Object
		public static const Refresh_Size:String = "refreshsize";
		public static const LOGIN:String = "LOGIN";
		
		public static const LOGIN_FAILED:String = "LOGIN_FAILED";
		public static const LOGIN_TIME_OUT:String = "LOGIN_TIME_OUT";
		
		public static const UPDATA_NAVDATA:String = "UPDATA_NAVDATA";
		
		public static const CLICK_NAVBT:String = "CLICK_NAVBT";
		public static const SHOW_SELECTED_ALBUMS_IN_PIC_CON:String = "SHOW_SELECTED_ALBUMS";
		
		public static const CLICK_ALBUMBT:String = "CLICK_ALBUMBT";
		
		public function MyEvent(type:String, _data:Object=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type);
			this.data = _data;
		}
	}
}
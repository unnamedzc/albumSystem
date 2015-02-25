package pages 
{
	import Events.MyEvent;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.events.*;
	
	/**
	 * ...
	 * @author jeff
	 */
	public class loginPage extends Sprite 
	{
		
		public function loginPage() 
		{
			super();
			pass.displayAsPassword = true;
			
			login.addEventListener(MouseEvent.CLICK, onLogin);
			regist.addEventListener(MouseEvent.CLICK, onRegist);
		}
		
		private function onLogin(e:MouseEvent):void
		{
			this.dispatchEvent(new MyEvent(MyEvent.LOGIN));
		}
		
		private function onRegist(e:MouseEvent):void
		{
			//this.dispatchEvent(new MyEvent(MyEvent.LOGIN_FAILED));
			info.text="*用户名或密码错误";
		}
		
	}

}
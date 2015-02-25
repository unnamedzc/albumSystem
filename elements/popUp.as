package elements 
{
	import flash.display.Sprite;
	import com.greensock.TweenLite;
	
	import flash.events.MouseEvent;
	import flash.display.SimpleButton;
	
	import fl.motion.easing.Bounce;

	/**
	 * ...
	 * @author jeff
	 */
	public class popUp extends Sprite 
	{
		private var _myTween:TweenLite;
		public function popUp() 
		{
			super();
			//(masker as SimpleButton).buttonMode = false;
			_popUp.y = 0 - _popUp.height;
			//_popUp.visible = false;
			this.visible = false;
			
			_popUp.okBt.addEventListener(MouseEvent.CLICK,onClikcOk)
		}
		
		public function startPopUp(desCrip:String)
		{
			//_popUp.des.text = desCrip;
			this.visible = true;
			//_popUp.visible = true;
			//trace(desCrip);
			_popUp.y = 0 - _popUp.height;
			var tweenObj = {
				y:373,
				ease:Bounce.easeInOut,
				onComplete:function() {
					TweenLite.killTweensOf(this);
					this.visible = false;
				}
			}
			_myTween = new TweenLite(_popUp, .5, tweenObj);
			_myTween.play();
		}
		
		private function onClikcOk(e:MouseEvent):void
		{
			this.visible = false;
			_popUp.y = 0 -_popUp.height;
			TweenLite.killTweensOf(this);
		}
		
	}

}
package myMvc
{
	import flash.events.EventDispatcher;
	import flash.events.Event;  
	
	/**
	 * ...
	 * @author 张弛
	 */
	public class ModelLocator extends EventDispatcher 
	{
		
		private var _step:uint;//判断整体拆装到了哪一步
		private var _objArray:Array;
		public function ModelLocator() 
		{
			
		}
		public function get step():uint{ 
            return _step; 
        }
		 public function set step(value:uint):void{ 
            _step = value;
        } 
		
		public function setObjArr(obj:*):void {
			_objArray=new Array()
			for (var i:uint = 0; i < obj.numChildren; i++) {					
					_objArray[i] = obj.getChildAt(i);
			}
		}
		public function getObjArr(i:int = -1):*{
			if (i == -1) return _objArray;
			else return _objArray[i];
		}         
	}
}
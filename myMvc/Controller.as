package myMvc 
{
	/**
	 * ...
	 * @author 张弛
	 */
	public class Controller 
	{
		private var _model:ModelLocator; 
		public function Controller(model:ModelLocator):void
		{
			_model = model; 
		}		
	}
}
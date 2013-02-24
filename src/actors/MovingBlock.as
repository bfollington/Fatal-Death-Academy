package actors
{
	import constants.IMG;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class MovingBlock extends ExtEntity
	{
		public function MovingBlock(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			
			//Some weirdness with the 2X scaling makes these numbers odd
			width = 48;
			height = 48;
			originX = 4;
			originY = 4;
			
			graphic = new Image(IMG.MBLOCK_IMAGE);
			type = "kill";
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!_paused)
			{
				y += _yspeed;
			
				_ticker++;
			}
			
			if (_ticker > 60)
			{
				_ticker = 0;
				_yspeed *= -1;
				
			}
		}
		
		override public function send_message(msg:String, params:Object=null):void
		{
			if (msg == "pause")
			{
				_paused = true;
			}
			
			if (msg == "unpause")
			{
				_paused = false;
			}
		}
		
		public var Name:String = "MovingBlock";
		private var _ticker:int = 0;
		private var _yspeed:int = 1;
		private var _paused:Boolean = false;
	}
}
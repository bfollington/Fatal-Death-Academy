package actors
{
	import constants.IMG;
	
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Entity;
	
	public class Slider extends Entity
	{
		public function Slider(makex:uint, makey:uint, ticker:int=0)
		{
			//Get our global setup
			super();
			
			x = makex;
			y = makey + 8;
			
			_ticker = ticker;
			
			_sprMap = new Spritemap(IMG.SLIMER_IMAGE, 24, 24);
			_sprMap.add("right", [0, 1, 2, 3, 4, 5, 6], 0.4, true);
			_sprMap.add("left", [7, 8, 9, 10, 11, 12, 13], 0.4, true);
			graphic = _sprMap;
			_sprMap.play("right");
			
			type = "kill";
			
			setHitbox(16, 16, -4, -8);
		}
		
		override public function update():void 
		{
			//Get our physics
			super.update();
			
			_ticker++;
			x += _xspeed;
			
			if (_ticker > 150) 
			{
				_xspeed *= -1;
				_ticker = 0;
			}
			
			if (_xspeed > 0) 
			{
				_sprMap.play("right");
			} else {
				_sprMap.play("left");
			}

		}
		
		private var _ticker:Number = 0;
		private var _sprMap:Spritemap = null;
		private var _xspeed:Number = 1.5;
		
	}
}
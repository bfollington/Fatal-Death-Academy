package actors
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;

	public class Camera extends Entity
	{
		
		private var _target:Entity = null;
		private var _x:int;
		private var _y:int;
		public var shakeX:int = 0;
		public var shakeY:int = 0;
		private var _timer:int = 0;
		private var _pow:int = 0;
		
		public function Camera(ix:int, iy: int)
		{
			super();
			_x = ix;
			_y = iy;
		}
		
		override public function update():void
		{
			super.update();
			
			//Scroll the camera to us
			_x += int((-1*_x + (_target.x - 320/2)) / 2);
			_y += int(((_target.y - 240/2) - _y) / 30.0);
			
			//Update actual camera
			FP.camera.x = _x + shakeX;
			FP.camera.y = _y + shakeY;
			
			//Handle screenshake
			if (_timer > 0)
			{
				_timer--;
				shakeX = int(Math.random()*_pow) - _pow / 2;
				shakeY = int(Math.random()*_pow) - _pow / 2;
			}
			if (_timer == 0) shakeX = shakeY = 0;
			
		}
		
		public function setTarget(e:Entity):void
		{
			_target = e;
		}
		
		public function screenShake(pow:int, duration:int):void
		{
			_pow = pow;
			_timer = duration;
		}
	}
}
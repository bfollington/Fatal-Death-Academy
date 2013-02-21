package actors
{
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class BasicObject extends Entity
	{
		//Movement toggle
		public var freezeMovement:Boolean = false;
		//Physics variables
		public var velocity:Point;
		public var acceleration:Point;
		public var friction:Point;
		public var maxSpeed:Point;
		public var name:String;
		public var onGround:Boolean;
		//Flags for if an object is currently colliding
		private var _hitBottom:Boolean;
		private var _hitRight:Boolean;
		private var _hitLeft:Boolean;
		private var _hitTop:Boolean;
		
		public function BasicObject()
		{
			//Initialise
			super();
			velocity = new Point(1, 0);
			acceleration = new Point(0, 0.2);
			friction = new Point(1.15, 1);
			maxSpeed = new Point(5, 5);
			name = "NoName";
		}
		
		public function collisionLeft():Boolean
		// Collision test functions check the edges of a bounding box object
		{
			_hitLeft = false;
			
			if (collide("level", x - 1, y))
			{
				_hitLeft = true;
				return true;
			}
			
			return false;
		}
		
		public function collisionRight():Boolean
		{
			_hitRight = false;
			
			if (collide("level", x + 1, y))
			{
				_hitRight = true;
				return true;
			}
			
			return false;
		}

		public function collisionTop():Boolean
		{
			_hitTop = false;
			
			if (collide("level", x, y - 1))
			{
				_hitTop = true;
				return true;
			}
			
			return false;
		}
		
		public function collisionBottom():Boolean
		{
			_hitBottom = false;
			onGround = false;
			
			if (collide("level", x, y + 1))
			{
				_hitBottom = true;
				onGround = true;
				return true;
			}
			
			return false;
		}
		
		public function moveObject():void
		{
			for (var i:Number = 0; i < Math.abs(velocity.x); i++)
			{
				if (velocity.x > 0.1)
				{
					if (collisionRight())
					{
						velocity.x = 0;
						break;
					}
					x++;
				}
				else if (velocity.x < -0.1)
				{
					if (collisionLeft())
					{
						velocity.x = 0;
						break;
					}
					x--;
				}
			}
			
			for (var j:Number = 0; j < Math.abs(velocity.y); j++)
			{
				if (velocity.y > 0.1)
				{
					if (collisionBottom())
					{
						velocity.y = 0;
						break;
					}
					y++;
				}
				else if (velocity.y < -0.1)
				{
					if (collisionTop())
					{
						velocity.y = 0;
						break;
					}
					y--;
				}
			}
		}
		
		override public function update():void
		{			
			super.update();
			
			//Handle basic physics
			if (!freezeMovement) {
				velocity.x += acceleration.x;
				velocity.y += acceleration.y;
				velocity.x /= friction.x;
				velocity.y /= friction.y;
			}
			
			//Check for standing on ground
			collisionBottom();
			
			//Apply velocity to object
			if (!freezeMovement) moveObject();
			
			//Restrict speed to acceptable values
			clampSpeed();
			
		}
		
		private function clampSpeed():void 
		{
			//Clamp X speeds to within maxSpeed
			if (velocity.x > 0) {
				velocity.x = Math.min(velocity.x, maxSpeed.x);
			} else {
				velocity.x = Math.max(velocity.x, maxSpeed.x*-1);
			}
			
			//Same for Y
			if (velocity.y > 0) {
				velocity.y = Math.min(velocity.y, maxSpeed.y);
			} else {
				velocity.y = Math.max(velocity.y, maxSpeed.y*-1);
			}
		}

	}
}
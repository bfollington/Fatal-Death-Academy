package actors
{
	import net.flashpunk.Entity;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import constants.IMG;
	
	public class Explosion extends Entity
	{
		public function Explosion(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			originX = originY = 32;
			
			_sprMap = new Spritemap(IMG.EXPLODE_IMAGE, 64, 64);
			_sprMap.add("default", [0, 1, 2, 3, 4, 5, 6, 7, 8], 0.5, false);
			graphic = _sprMap;
			_sprMap.play("default");
			FP.world.bringToFront(this);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_sprMap.complete) world.remove(this);
		}
		
		private var _sprMap:Spritemap = null;
	}
}
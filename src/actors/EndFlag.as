package actors
{
	import net.flashpunk.Entity;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import constants.IMG;
	
	public class EndFlag extends Entity
	{
		public function EndFlag(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			width = 16;
			height = 64;
			originX = -16;
			
			_sprMap = new Spritemap(IMG.EFLAG_IMAGE, 32, 64);
			_sprMap.add("default", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 0.4, true);
			graphic = _sprMap;
			_sprMap.play("default");
			
			type = "end";
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private var _sprMap:Spritemap = null;
	}
}
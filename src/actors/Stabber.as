package actors
{
	import constants.CONST;
	import constants.IMG;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Stabber extends Entity
	{
		public function Stabber(x:Number=0, y:Number=0, dir:Number=CONST.TOP)
		{
			
			var mx:int = 0;
			var my:int = 0;
			
			if (dir == CONST.TOP) {
				mx = x + 6;
				my = y + 11;
			} else {
				mx = x + 6;
				my = y;
			}
			
			super(mx, my);
			
			switch (dir)
			{				
				case CONST.TOP:
					_sprMap = new Spritemap(IMG.USTABBER_IMAGE, 13, 21);
					_sprMap.add("default", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22], 0.4, true);
					graphic = _sprMap;
					_sprMap.play("default");
					break;
				
				case CONST.BOTTOM:
					_sprMap = new Spritemap(IMG.DSTABBER_IMAGE, 13, 21);
					_sprMap.add("default", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22], 0.4, true);
					graphic = _sprMap;
					_sprMap.play("default");
					break;
				
				
				
			}
			
			type = "kill";
			
		}
		
		override public function update():void
		{
			if ((_sprMap.frame >= 0) && (_sprMap.frame < 8)) type = "kill";
			if ((_sprMap.frame >= 8) && (_sprMap.frame <= 20)) type = "none";
			if ((_sprMap.frame >= 20) && (_sprMap.frame <= 22 )) type = "kill";
		}

		private var _sprMap:Spritemap = null;
		
	}
}
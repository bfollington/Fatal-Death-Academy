package actors
{
	import constants.IMG;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx;
	
	
	public class MuteButton extends Entity
	{
		
		public var muted:int = 0;
		
		public function MuteButton(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			width = 16;
			height = 16;
			
			_sprMap = new Spritemap(IMG.MUTE_IMAGE, 16, 16);
			_sprMap.add("on", [0], 0.4, true);
			_sprMap.add("off", [1], 0.4, true);
			graphic = _sprMap;
			_sprMap.play("on");
		}
		
		override public function update():void 
		{
			super.update();
			
			if (isMouseOverlapping(Input.mouseX, Input.mouseY, x, y, width, height)) 
			{
				if (Input.mousePressed)
				{
					muted = 1 - muted;
				}
			}
			
			if (muted == 1)
			{
				FP.volume = 0;
				_sprMap.play("off");
			} else {
				FP.volume = 1;
				_sprMap.play("on");
			}
			
		}
		
		public function isMouseOverlapping(mx:int, my:int, objx:int, objy:int, width:int, height:int):Boolean
		{
			if ((mx >= objx) && (mx <= objx + width ) && (my >= objy) && (my <= objy + height))
			{
				return true;
			}
			
			return false;
		}
		
		private var _sprMap:Spritemap = null;
	}
}
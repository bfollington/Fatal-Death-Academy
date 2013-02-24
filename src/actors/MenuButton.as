package actors
{
	import constants.IMG;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import SoundController;
	
	import worlds.*;
	
	public class MenuButton extends Entity
	{
		
		public var paused:int = 0;
		private var _sndCtrl:SoundController;
		
		public function MenuButton(mx:int, my:int, sndCtrl:SoundController)
		{
			super();
			
			x = mx;
			y = my;
			width = 16;
			height = 16;
			
			_sndCtrl = sndCtrl;
			
			graphic = new Image(IMG.MENU_IMAGE);
			graphic.scrollX = graphic.scrollY = 0;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (isMouseOverlapping(Input.mouseX, Input.mouseY, x, y, width, height)) 
			{
				if (Input.mousePressed)
				{
					FP.world = new TitleScreen(true, _sndCtrl);
				}
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
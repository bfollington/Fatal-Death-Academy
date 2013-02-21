package actors
{
	import constants.IMG;
	
	import flash.geom.Point;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class Button extends Entity
	{
		
		public var Name:String = "Button";
		private var _blockList:Array = [];
		private var _sprMap:Spritemap;
		
		public function Button(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			
			_sprMap = new Spritemap(IMG.BUTTON_IMAGE, 32, 32);
			_sprMap.add("default", [0], 1, true);
			_sprMap.add("pushed", [1], 1, true);
			graphic = _sprMap;
			_sprMap.play("default", true);
			
			width = 16;
			height = 16;
			originX = -8;
			originY = -16;
			
			type = "button";
			
			trace("Button in da haus");
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function destroyPurpleBlocks():void
		{
			_sprMap.play("pushed");
			
			world.getClass(ButtonBlock, _blockList);
			for each(var block:ButtonBlock in _blockList)
			{
				block.destroy();
			}
		}
	}
}
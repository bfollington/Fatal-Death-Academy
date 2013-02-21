package actors
{
	import net.flashpunk.Entity;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import constants.IMG;
	
	public class ButtonBlock extends Entity
	{
		public function ButtonBlock(mx:int, my:int)
		{
			super();
			
			x = mx-5;
			y = my;
			
			//Some weirdness with the 2X scaling makes these numbers odd
			width = 40;
			height = 32;
			originX = 3;
			
			graphic = new Image(IMG.BBLOCK_IMAGE);
			type = "kill";
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public function destroy():void
		{
			if (world) world.remove(this);
		}
		
		public var Name:String = "ButtonBlock";
	}
}
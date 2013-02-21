package actors
{
	import net.flashpunk.Entity;
	import flash.geom.Point;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import constants.IMG;
	
	public class TNT extends Entity
	{
		public function TNT(mx:int, my:int)
		{
			super();
			
			x = mx;
			y = my;
			width = height = 32;
			
			graphic = new Image(IMG.TNT_IMAGE);

			FP.console.log("TNT Initialised at", x, ",", y);
			
			type = "TNT"
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		public var Name:String = "TNT";
	}
}
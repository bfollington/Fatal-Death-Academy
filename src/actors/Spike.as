package actors
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import constants.IMG;
	import constants.CONST;
	
	public class Spike extends Entity
	{
		public function Spike(x:Number=0, y:Number=0, dir:Number=1)
		{
			super(x, y);
			
			switch (dir)
			{
				case CONST.RIGHT:
					graphic = new Image(IMG.RSPIKE_IMAGE);
					setHitbox(6, 28, 0, -2);
					break;
					
				case CONST.LEFT:
					graphic = new Image(IMG.LSPIKE_IMAGE);
					setHitbox(6, 28, -26, -2);
					break;
					
				case CONST.TOP:
					graphic = new Image(IMG.TSPIKE_IMAGE);
					setHitbox(28, 6, -2, -26);
					break;
				
				case CONST.BOTTOM:
					graphic = new Image(IMG.BSPIKE_IMAGE);
					setHitbox(28, 6, -2, 0);
					break;
			}
			
			type = "kill";
			
			
		}
	}
}
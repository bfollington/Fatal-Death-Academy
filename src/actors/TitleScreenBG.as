package actors
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import constants.*;
	
	public class TitleScreenBG extends Entity
	{
		public function TitleScreenBG(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			graphic = new Image(IMG.TITLEBG_IMAGE);
		}
		
		override public function update():void
		{
			super.update();
		}
	}
}
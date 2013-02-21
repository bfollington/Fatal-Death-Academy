package actors
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	public class TextBox extends Entity
	{
		public function TextBox(x:Number=0, y:Number=0, lives:int=0, white:Boolean=true, graphic:Graphic=null, mask:Mask=null)
		{
			display  = new Text("Lives: " + lives.toString());
			display.scrollX = display.scrollY = 0;
			if (white) display.color = 0xFFFFFF;
			else display.color = 0x000000;
			
			graphic = display;
			
			super(x, y, graphic, mask);
			
		}
		
		public var display:Text;
	}
}
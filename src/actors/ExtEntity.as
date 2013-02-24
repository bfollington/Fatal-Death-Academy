package actors
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class ExtEntity extends Entity
	{
		public function ExtEntity(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function send_message(msg:String, params:Object=null):void
		{
			
		}
	}
}
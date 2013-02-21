package worlds
{
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	
	public class WorldBase extends World
	{
		
		public var sndCtrl:SoundController;
		
		public function WorldBase()
		{
			super();
		}
		
		public function createTextWithShadow(msg:String, x:int, y:int, size:int, center:Boolean):void
		{
			Text.size = size;
			var t:Text = new Text(msg);
			var e:Entity;
			t.scrollX = t.scrollY = 0;
			t.color = 0x000000;
			if (center) e = new Entity(320 / 2 - t.width / 2, y - 1, t);
			else e = new Entity( x, y - 1, t);
			add(e);
			t = new Text(msg);
			t.scrollX = t.scrollY = 0;
			if (center) e = new Entity(320 / 2 - t.width / 2, y, t);
			else e = new Entity( x, y, t);
			add(e);
		}
	}
}
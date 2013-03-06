package worlds
{
	import net.flashpunk.World;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import constants.*;
	import net.flashpunk.utils.Input;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class SiteLocker extends WorldBase
	{
		public function SiteLocker()
		{
			super();
			
			createTextWithShadow("This game can only be played on:", 0, 100, 16, true);
			
			var _sponsor:Entity = new Entity(0, 137, new Image(IMG.SPONSOROTHERLOGO));
			_sponsor.x = 100;
			add(_sponsor);
		}
		
		override public function update():void
		{
			
			super.update();
			
			if (Input.mousePressed)
			{
				var request:URLRequest = new URLRequest("http://www.addictinggames.com/");
				navigateToURL(request, "_blank");
			}
		}
	}
}
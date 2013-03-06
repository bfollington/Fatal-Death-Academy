package worlds
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.ByteArray;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.utils.Input;
	
	import worlds.TitleScreen;
	
	public class SponsorState extends World
	{
		[Embed(source = "../assets/AddictingGamesStinger.swf")] private var swfSplash:Class;
		
		private var _splashIntro:MovieClip;
		private var _loader:Loader;
		private var _logo:ByteArray;
		private var _fileLoaded:Boolean = false;
		private var _sndCtrl:SoundController;
		private var countDown:int = 0;
		
		public function SponsorState(sndCtrl:SoundController)
		{
			super();
			
			_sndCtrl = sndCtrl;
			_splashIntro = new swfSplash() as MovieClip;
			_splashIntro.width = 720;
			_splashIntro.x -= 40;
			_splashIntro.height = 480;
			FP.stage.addChild(_splashIntro);
			_splashIntro.buttonMode = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if (countDown > 350)
			{
				FP.stage.removeChild(_splashIntro);
				
				if (testSiteLock())
				{
					FP.world = new TitleScreen(false, _sndCtrl);
				} else
				{
					FP.world = new SiteLocker();
				}

			}
		
			countDown++;
			
			if (Input.mousePressed)
			{
				var request:URLRequest = new URLRequest("http://www.addictinggames.com/");
				navigateToURL(request, "_blank");
			}
		}
		
		private function testSiteLock():Boolean
		{
			var siteLock:RegExp = /^(http|https):\/\/([-a-zA-Z0-9\.])+\.(shockwave|addictinggames|mtvi)\.com(\/|$)/;
			return ( siteLock.test ( FP.stage.loaderInfo.url ));
		}
	
	}

}
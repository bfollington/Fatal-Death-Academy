package worlds 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.display.DisplayObjectContainer;
	
	public class SponsorSplash extends World
	{
		public function SponsorSplash()
		{
			super();
			init();
		}
		
		[Embed(source='assets/AddictingGamesStinger.swf', mimeType='application/octet-stream')] private var sponsorLogoSwf:Class;
		private var _sponsorLogo:Loader;
		
		private var _sponsorLogoMc:MovieClip;
	
		private var _sponsorButtonClicked:Boolean;
		
		public function init():void
		{
			
			_sponsorLogo = new Loader();
			_sponsorLogo.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_sponsorLogo.contentLoaderInfo.addEventListener(Event.COMPLETE, sponsorLogoLoaded);
			_sponsorLogo.loadBytes(new sponsorLogoSwf());
			
			FP.frameRate = 30;
			_sponsorLogo.addEventListener(Event.DEACTIVATE, focusLost);
			_sponsorLogo.addEventListener(Event.ACTIVATE, focusGained);
			
			_sponsorButtonClicked = false;
		}
		
		private function sponsorLogoLoaded(e:Event):void
		{
			_sponsorLogo.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_sponsorLogo.contentLoaderInfo.removeEventListener(Event.COMPLETE, sponsorLogoLoaded);
			_sponsorLogoMc = ((_sponsorLogo.content as MovieClip).getChildAt(1) as MovieClip);
			//add(_sponsorLogo);
			
			FP.stage.addChild(_sponsorLogo);
			
		}
		
		private function onError(e:Event):void
		{
			trace(e);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_sponsorLogoMc != null)
			{
				if (_sponsorLogoMc.currentFrame == _sponsorLogoMc.totalFrames)
				{
					FP.stage.removeChild(_sponsorLogo);
					_sponsorLogo.removeEventListener(Event.DEACTIVATE, focusLost);
					_sponsorLogo.removeEventListener(Event.ACTIVATE, focusGained);
					_sponsorLogo = null;
					_sponsorLogoMc = null;
					FP.world = new TitleScreen(false, null);
				}
			}
		}
		
		private function btnSponsorClick():void { 
			if (!_sponsorButtonClicked)
			{
				var request:URLRequest = new URLRequest("http://www.yoursponsorurl.com/");
				navigateToURL(request, "_blank");
				_sponsorButtonClicked = true;
			}
			else
			{
				_sponsorButtonClicked = false;
			}
		}
		
		private function focusLost(e:Event):void
		{
			_sponsorLogoMc.stop();
		}
		
		private function focusGained(e:Event):void
		{
			_sponsorLogoMc.play();
		}
		
	}
	
}


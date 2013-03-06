package worlds
{
	import actors.*;
	
	import constants.*;
	
	import core.tiled.*;
	
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class TitleScreen extends WorldBase
	{
		
		private var _logo:Entity;
		private var _bg1:Entity, _bg2:Entity, _sponsor:Entity, _moregames:Entity;
		
		public function TitleScreen(forceMusic:Boolean, soundController:SoundController)
		{
			super();
			
			sndCtrl = soundController;
			sndCtrl.start();
			if (forceMusic) sndCtrl.play_title_track();
			
		}
		
		override public function begin():void
		{
			super.begin();
			
			_bg1 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 0);
			_bg2 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 256);
			
			
			_logo = addGraphic(new Image(IMG.LOGO_IMAGE), 0, 320 / 2 - 288 / 2, -200);
			
			_sponsor = new Entity(0, 137, new Image(IMG.SPONSOROTHERLOGO));
			_sponsor.x = 100;
			add(_sponsor);
			
			_moregames = new Entity(0, 205, new Image(IMG.MOREGAMES));
			_moregames.x = 125;
			add(_moregames);
			
			var muteButton:MuteButton = new MuteButton(5, 220);
			add(muteButton);

			var titleTween:VarTween = new VarTween();
			titleTween.tween(_logo, "y", 30, 80, Ease.bounceOut);
			addTween(titleTween, true);
	
			createTextWithShadow("Press space to begin!", 0, 218, 16, true);
			
			Text.size = 8;
			
			var e:Entity = new Entity(5, 5, new Text("A Game by Ben Follington"));
			add(e);
			e = new Entity(5, 15, new Text("Voltic Games 2013"));
			add(e);
			
			e = new Entity(250, 5, new Text("Music by _twc"));
			add(e);
			e = new Entity(222, 15, new Text("twc-3 on SoundCloud"));
			add(e);
			
		}
		
		override public function update():void
		{
			super.update();
			
			_bg1.y++;
			_bg2.y++;
			
			if (_bg2.y >= 256) _bg2.y = -255;
			
			if (_bg1.y >= 256) _bg1.y = -255;
			
			if (isMouseOverlapping(Input.mouseX, Input.mouseY, 100, 137, 120, 72))
			{
				if (Input.mousePressed)
				{
					var request:URLRequest = new URLRequest("http://www.addictinggames.com/");
					navigateToURL(request, "_blank");
				}
				
			}
			
			
			if (Input.pressed(Key.SPACE))
			{
				sndCtrl.play_ingame_track();
				FP.world = new IntroScreen(sndCtrl);
			}
		}
		
		
		public function isMouseOverlapping(mx:int, my:int, objx:int, objy:int, width:int, height:int):Boolean
		{
			if ((mx >= objx) && (mx <= objx + width ) && (my >= objy) && (my <= objy + height))
			{
				return true;
			}
			
			return false;
		}
	}
}
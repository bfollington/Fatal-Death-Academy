package worlds
{
	import actors.*;
	
	import constants.*;
	
	import core.tiled.*;
	
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
		private var _bg1:Entity, _bg2:Entity;
		
		public function TitleScreen(forceMusic:Boolean, soundController:SoundController)
		{
			super();
			
			sndCtrl = soundController;
			if (forceMusic) sndCtrl.play_title_track();
			
		}
		
		override public function begin():void
		{
			super.begin();
			
			_bg1 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 0);
			_bg2 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 256);
			
			
			_logo = addGraphic(new Image(IMG.LOGO_IMAGE), 0, 320 / 2 - 288 / 2, -200);

			var titleTween:VarTween = new VarTween();
			titleTween.tween(_logo, "y", 50, 80, Ease.bounceOut);
			addTween(titleTween, true);
	
			createTextWithShadow("Press space to begin!", 0, 200, 16, true);
			
			Text.size = 8;
			
			var e:Entity = new Entity(5, 5, new Text("A Game by Ben Follington"));
			add(e);
			e = new Entity(5, 15, new Text("Voltic Games 2012 (@VolticGames)"));
			add(e);
			
			e = new Entity(250, 5, new Text("Music by _twc"));
			add(e);
			e = new Entity(175, 15, new Text("https://soundcloud.com/twc-3/"));
			add(e);
			
		}
		
		override public function update():void
		{
			super.update();
			
			_bg1.y++;
			_bg2.y++;
			
			if (_bg2.y >= 256) _bg2.y = -255;
			
			if (_bg1.y >= 256) _bg1.y = -255;
			
			
			if (Input.pressed(Key.SPACE))
			{
				sndCtrl.play_ingame_track();
				FP.world = new IntroScreen(sndCtrl);
			}
		}
	}
}
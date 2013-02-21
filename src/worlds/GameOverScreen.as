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
	
	public class GameOverScreen extends WorldBase
	{
		
		private var _logo:Entity;
		private var _bg1:Entity, _bg2:Entity;
		
		public function GameOverScreen(soundController:SoundController)
		{
			super();
			
			sndCtrl = soundController;
			
		}
		
		override public function begin():void
		{
			super.begin();
			
			_bg1 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 0);
			_bg2 = addGraphic(new Image(IMG.TITLEBG_IMAGE), 0, 0, 256);
			
			
			_logo = addGraphic(new Image(IMG.GOVER_IMAGE), 0, 320 / 2 - 288 / 2, -200);

			var titleTween:VarTween = new VarTween();
			titleTween.tween(_logo, "y", 50, 80, Ease.bounceOut);
			addTween(titleTween, true);
			
			this.createTextWithShadow("Press space to retry!", 0, 200, 16, true);

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
				FP.world = new DefaultWorld(MAPS.Levels[0], 0, 20, sndCtrl);
			}
		}
	}
}
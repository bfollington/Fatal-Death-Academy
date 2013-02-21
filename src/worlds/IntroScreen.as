package worlds
{
	import actors.*;
	
	import constants.*;
	
	import core.tiled.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class IntroScreen extends WorldBase
	{
		
		private var _introArray:Array;
		private var _count:int = 0;
		private var _soundPlayed:Boolean = false;
		
		[Embed(source = 'sound/fataldeathacademy.mp3')] private const FDA_SOUND:Class;
		private var fdaSound:Sfx = new Sfx(FDA_SOUND);
		
		[Embed(source = 'sound/death.mp3')] private const DEATH_SOUND:Class;
		private var deathSound:Sfx = new Sfx(DEATH_SOUND);
		

		
		public function IntroScreen(soundController:SoundController)
		{
			super();
			
			_introArray = [addGraphic(new Image(IMG.INTRO1_IMAGE), 0, 0, 0), 
							addGraphic(new Image(IMG.INTRO2_IMAGE), 0, 0, 0), 
							addGraphic(new Image(IMG.INTRO3_IMAGE), 0, 0, 0), 
							addGraphic(new Image(IMG.INTRO4_IMAGE), 0, 0, 0), 
							addGraphic(new Image(IMG.INTRO5_IMAGE), 0, 0, 0)]
			
			sndCtrl = soundController;
		}
		
		override public function begin():void
		{
			super.begin();
			
			for each(var e:Entity in _introArray)
			{
				add(e);
				e.visible = false;
			}
			
			createTextWithShadow("Press space to advance", 0, 228, 8, true);
			
			_introArray[0].visible = true;
			
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				_count++;
			}
			
			if (_count < 5) (_introArray[_count] as Entity).visible = true;

			if (_count == 4) 
			{
				if (!_soundPlayed)
				{
					_soundPlayed = true;
					fdaSound.play(1);
				}
				FP.camera.x = Math.random()*20 - 10;
				FP.camera.y = Math.random()*20 - 10;
			}
			if (_count == 5)
			{
				FP.world = new DefaultWorld(MAPS.Levels[0], 0, 20, sndCtrl);
				deathSound.play();
			}
			
		}
				
	}
}

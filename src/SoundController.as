package
{
	import constants.SND;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	
	public class SoundController extends Entity
	{
		
		private var track1:Sfx;
		private var track2:Sfx;
		
		[Embed(source = 'sound/abm.mp3')] private const MUS1:Class;
		[Embed(source = 'sound/se.mp3')] private const MUS2:Class;
		
		public function SoundController(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			super(x, y, graphic, mask);
			
			trace("sound is on");
			
			//var tracks:Vector.<Sfx> = Vector.<Sfx>([new Sfx(SND.MUS1)]);
			track1 = new Sfx(MUS1);
			track2 = new Sfx(MUS2);
			FP.volume = 1;
			
		}
		
		public function start():void
		{
			track1.play(1, 0);
		}
		
		public function play_ingame_track():void
		{
			track1.stop();
			track2.loop();
		}
		
		public function play_title_track():void
		{
			
			track2.stop();
			track1.loop();
		}

	}
}
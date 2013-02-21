package
{
	import constants.*;
	
	import net.flashpunk.Engine;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Key;
	
	import worlds.*;
	
	[Frame(factoryClass="Loader")]
	public class MacFlash extends Engine
	{
		public function MacFlash()
		{
			super(320, 240, 60, true);
			FP.screen.scale = 2;
			//FP.console.enable();
			//FP.console.toggleKey = Key.TAB;
			soundController = new SoundController();
			
		}
		
		override public function init():void
		{
			FP.world = new TitleScreen(false, soundController);
			trace("World", currentLevel, "created");	
		}
		
		public var currentLevel:Class = MAPS.LEVEL1;
		public var soundController:SoundController;
	}
}
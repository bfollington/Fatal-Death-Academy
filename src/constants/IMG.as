package constants
{
	public class IMG
	{
		[Embed(source = 'assets/tiles2.png')] public static const COLLISION_TILES:Class;
		[Embed(source = 'assets/SOMETILES.png')] public static const VISUAL_TILES:Class;
		[Embed(source = 'assets/pinktiles.png')] public static const VISUAL_TILES_PINK:Class;
		[Embed(source = 'assets/bluetiles.png')] public static const VISUAL_TILES_BLUE:Class;
		[Embed(source = 'assets/greentiles.png')] public static const VISUAL_TILES_GREEN:Class;
		[Embed(source = 'assets/lightbluetiles.png')] public static const VISUAL_TILES_LBLUE:Class;
		[Embed(source = 'assets/redtiles.png')] public static const VISUAL_TILES_RED:Class;
		[Embed(source = 'assets/player.png')] public static const PLAYER_IMAGE:Class;
		[Embed(source = 'assets/TNT.png')] public static const TNT_IMAGE:Class;
		[Embed(source = 'assets/LeftSpike.png')] public static const LSPIKE_IMAGE:Class;
		[Embed(source = 'assets/RightSpikes.png')] public static const RSPIKE_IMAGE:Class;
		[Embed(source = 'assets/TopSpikes.png')] public static const TSPIKE_IMAGE:Class;
		[Embed(source = 'assets/BottomSpike.png')] public static const BSPIKE_IMAGE:Class;
		[Embed(source = 'assets/Slider.png')] public static const SLIDER_IMAGE:Class;
		[Embed(source = 'assets/Slimer.png')] public static const SLIMER_IMAGE:Class;
		[Embed(source = 'assets/UpStabber.png')] public static const USTABBER_IMAGE:Class;
		[Embed(source = 'assets/DownStabber.png')] public static const DSTABBER_IMAGE:Class;
		[Embed(source = 'assets/ButtonBlock.png')] public static const BBLOCK_IMAGE:Class;
		[Embed(source = 'assets/Button.png')] public static const BUTTON_IMAGE:Class;
		[Embed(source = 'assets/MovingBlock.png')] public static const MBLOCK_IMAGE:Class;
		[Embed(source = 'assets/EndFlag.png')] public static const EFLAG_IMAGE:Class;
		[Embed(source = 'assets/logo.png')] public static const LOGO_IMAGE:Class;
		[Embed(source = 'assets/gameover.png')] public static const GOVER_IMAGE:Class;
		[Embed(source = 'assets/success.png')] public static const WIN_IMAGE:Class;
		[Embed(source = 'assets/FadeIn.png')] public static const TRANSITION_IMAGE:Class;
		[Embed(source = 'assets/FadeOut.png')] public static const REVERSETRANSITION_IMAGE:Class;
		[Embed(source = 'assets/Boom.png')] public static const EXPLODE_IMAGE:Class;
		[Embed(source = 'assets/TitleBG.png')] public static const TITLEBG_IMAGE:Class;
		[Embed(source = 'assets/intro1.png')] public static const INTRO1_IMAGE:Class;
		[Embed(source = 'assets/intro2.png')] public static const INTRO2_IMAGE:Class;
		[Embed(source = 'assets/intro3.png')] public static const INTRO3_IMAGE:Class;
		[Embed(source = 'assets/intro4.png')] public static const INTRO4_IMAGE:Class;
		[Embed(source = 'assets/intro5.png')] public static const INTRO5_IMAGE:Class;
		
		public static var tilesets:Array = [VISUAL_TILES, VISUAL_TILES_BLUE, VISUAL_TILES_GREEN, VISUAL_TILES_PINK, VISUAL_TILES_LBLUE, VISUAL_TILES_RED];
		
		public function IMG()
		{
		}
	}
}
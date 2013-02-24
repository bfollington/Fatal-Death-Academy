package worlds
{
	import actors.*;
	
	import constants.CONST;
	
	import core.tiled.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	public class DefaultWorld extends WorldBase
	{
		
		//Object definitions
		private var text:Text;
		private var player:Player;
		private var level:MapData;
		private var background:MapData;
		private var display:MapData;
		private var foreground:MapData;
		private var colgrid:CollisionData;
		private var sky:MapData;
		private var objects:ObjectData;
		private var _map:Class;
		private var _level:int;
		private var _lives:int;
		public var cam:Camera;
		
		public function DefaultWorld(Map:Class, level:int, lives:int, soundController:SoundController)
		{
			super();
			_map = Map;
			_level = level;
			_lives = lives;
			sndCtrl = soundController;
			
		}
		
		public function createTransition(fadein:Boolean):void
		{
			var trans:TransitionTile = null;
			for (var i:int = 0; i < 10; i++)
			{
				for (var j:int = 0; j < 8; j++)
				{
					trans = new TransitionTile(i*32, j*32, fadein);
					FP.world.add(trans);
				}
			}
		}
		
		override public function begin():void
		{
			super.begin();
			
			//Load object data
			objects = new ObjectData(_map);
			
			//Set up collision grid
			colgrid = new CollisionData(_map);
			add(colgrid);
			
			//Add sky layer
			sky = new MapData(_map, "SKY");
			sky.graphic.scrollX = 0.5;
			add(sky);
			
			//Add background layer
			background = new MapData(_map, "BACKGROUND");
			add(background);
			
			//Load all objects
			loadObjects(objects);
			
			//Setup camera
			cam = new Camera(player.x, player.y);
			add(cam);
			cam.setTarget(player);

			//Load ground layer
			display = new MapData(_map, "GROUND");
			add(display);
			
			//Add the score display objects
			Text.size = 16;
			
			var shadow:TextBox = new TextBox(11, 11, _lives, false);
			add(shadow);
			var lives:TextBox = new TextBox(10, 10, _lives, true);
			add(lives);
			
			var t:Text = new Text("Level "+(_level + 1).toString());
			t.scrollX = t.scrollY = 0;
			t.color = 0x000000;
			var e:Entity = new Entity(251, 11, t);
			add(e);
			t = new Text("Level "+(_level + 1).toString());
			t.scrollX = t.scrollY = 0;
			e = new Entity(250, 10, t);
			add(e);
			
			//If the level is level 1, display the instructional text
			
			
			
			//Create the fade in transition to begin a level
			createTransition(true);
		}
		
		override public function update():void
		{
			
			super.update();
			
		}
		
		public function loadObjects(objData:ObjectData):void
		{
			
			var obj:TMXObject = null;
			
			//Pretty self explanatory what's going on here, loop through the loaded list of objects from the
			//TMX file, and respond accordingly to them
			for each(obj in objects.getObjects())
			{
				var spike:Spike = null;
				var slider:Slider = null;
				var stabber:Stabber = null;
				var buttonblock:ButtonBlock = null;
				var button:Button = null;
				var mblock:MovingBlock = null;
				var eflag:EndFlag = null;
				
				switch(obj.m_iGid)
				{
					case CONST.PLAYER_START:
						player = new Player(obj.m_iX, obj.m_iY, _map, _level, _lives, sndCtrl);			
						add(player);
						break;
					
					case CONST.TNT:
						var TNTobj:TNT = new TNT(obj.m_iX, obj.m_iY);
						add(TNTobj);
						break;
					
					case CONST.LEFT_SPIKES:
						spike = new Spike(obj.m_iX, obj.m_iY, CONST.LEFT);
						add(spike);
						break;
					
					case CONST.RIGHT_SPIKES:
						spike = new Spike(obj.m_iX, obj.m_iY, CONST.RIGHT);
						add(spike);
						break;
					
					case CONST.TOP_SPIKES:
						spike = new Spike(obj.m_iX, obj.m_iY, CONST.TOP);
						add(spike);
						break;
					
					case CONST.BOTTOM_SPIKES:
						spike = new Spike(obj.m_iX, obj.m_iY, CONST.BOTTOM);
						add(spike);
						break;
					
					case CONST.SLIDER:
						slider = new Slider(obj.m_iX, obj.m_iY, obj.m_tProperties.GetPropertyAsInt("ticker"));
						add(slider);
						break;
					
					case CONST.UP_STABBER:
						stabber = new Stabber(obj.m_iX, obj.m_iY, CONST.TOP);
						add(stabber);
						break;
					
					case CONST.DOWN_STABBER:
						stabber = new Stabber(obj.m_iX, obj.m_iY, CONST.BOTTOM);
						add(stabber);
						break;
					
					case CONST.BUTTON_BLOCK:
						buttonblock = new ButtonBlock(obj.m_iX, obj.m_iY);
						add(buttonblock);
						break;
					
					case CONST.BUTTON:
						button = new Button(obj.m_iX, obj.m_iY);
						add(button);
						break;
					
					case CONST.MOVING_BLOCK:
						mblock = new MovingBlock(obj.m_iX, obj.m_iY);
						add(mblock);
						break;
					
					case CONST.ENDFLAG:
						eflag = new EndFlag(obj.m_iX, obj.m_iY);
						add(eflag);
						break;
							
				}
			}
			
		}
	}
}
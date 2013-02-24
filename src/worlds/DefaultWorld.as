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
	import net.flashpunk.utils.Key;
	
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
		private var _temptext:Vector.<Entity>;
		private var paused:Boolean;
		private var _tempList:Array;
		private var _listOfPausableObjects:Array = [];
		
		public function DefaultWorld(Map:Class, level:int, lives:int, soundController:SoundController)
		{
			super();
			_map = Map;
			_level = level;
			_lives = lives;
			sndCtrl = soundController;
			
			Input.define("P", Key.P);
			
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
			
			var shadow:TextBox = new TextBox(11, 23, _lives, false);
			add(shadow);
			var lives:TextBox = new TextBox(10, 22, _lives, true);
			add(lives);
			
			var t:Text = new Text("Level "+(_level + 1).toString());
			t.scrollX = t.scrollY = 0;
			t.color = 0x000000;
			var e:Entity = new Entity(251, 23, t);
			add(e);
			t = new Text("Level "+(_level + 1).toString());
			t.scrollX = t.scrollY = 0;
			e = new Entity(250, 22, t);
			add(e);
			
			//If the level is level 1, display the instructional text
			if (_level == 0) 
			{
				_temptext = createTextWithShadowRet("Press space to start the level, and to jump!", 180, 200, 8, true, _temptext);
			}
			
			e = new PauseButton(5, 5);
			add(e);
			e = new MenuButton(285, 8, sndCtrl);
			add(e);
			
			//Create the fade in transition to begin a level
			createTransition(true);
		}
		
		override public function update():void
		{
			
			super.update();
			
			if (_level == 0) 
			{
				if (player.x == 551) 
				{
					_temptext = createTextWithShadowRet("Hitting spikes will kill you!", 600, 200, 8, true, _temptext);
				}
				
				if (player.x == 751) 
				{
					_temptext = createTextWithShadowRet("Actually, anything will kill you...", 600, 200, 8, true, _temptext);
				}
				
				if (player.x == 1701) 
				{
					_temptext = createTextWithShadowRet("Except flags, those mark the end of the test.", 600, 200, 8, true, _temptext);
				}
			}
			
		}
		
		public function pause():void
		{
			paused = true;

			sendMessageToList("pause", _listOfPausableObjects);
			
		}
		
		public function unpause():void
		{
			paused = false;
			
			sendMessageToList("unpause", _listOfPausableObjects);
		}
		
		private function sendMessageToList(msg:String, list:Array, params:Object=null):void
		{
			if (list != null) 
			{
				for(var i:int=0; i < list.length; i++)
				{
					if (list[i] is ExtEntity) list[i].send_message(msg, params);
				}
			}
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
						_listOfPausableObjects = _listOfPausableObjects.concat(player);
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
						_listOfPausableObjects = _listOfPausableObjects.concat(slider);
						break;
					
					case CONST.UP_STABBER:
						stabber = new Stabber(obj.m_iX, obj.m_iY, CONST.TOP);
						add(stabber);
						_listOfPausableObjects = _listOfPausableObjects.concat(stabber);
						break;
					
					case CONST.DOWN_STABBER:
						stabber = new Stabber(obj.m_iX, obj.m_iY, CONST.BOTTOM);
						add(stabber);
						_listOfPausableObjects = _listOfPausableObjects.concat(stabber);
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
						_listOfPausableObjects = _listOfPausableObjects.concat(mblock);
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
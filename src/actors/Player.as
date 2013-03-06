package actors
{
	import constants.*;
	
	import flash.display.BlendMode;
	import flash.geom.Point;
	
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.*;
	
	import worlds.DefaultWorld;
	import worlds.GameOverScreen;
	import worlds.GameWonScreen;
	
	public class Player extends BasicObject
	{
		private const RIGHT:int = 0;
		private const LEFT:int = 1;
		private var _moving:Boolean = false;
		private var _startedLevel:Boolean = false;
		private var _facing:int;
		private var _map:Class;
		public var transitionInOver:Boolean = false;
		public var transitionOutOver:Boolean = false;
		private var _resettingLevel:Boolean = false;
		private var _dead:Boolean = false;
		private var _level:int;
		private var _lives:int;
		private var _deathEmitter:Emitter;
		private var _endPointList:Array = [];
		private var _button:Button;
		private var _sndCtrl:SoundController;
		
		//Import our spritemap
		private var _playerSpriteMap:Spritemap = new Spritemap(IMG.PLAYER_IMAGE, 32, 32);

		[Embed(source = 'sound/death.mp3')] private const DEATH_SOUND:Class;
		private var deathSound:Sfx = new Sfx(DEATH_SOUND);
		
		[Embed(source = 'sound/jump.mp3')] private const JUMP_SOUND:Class;
		private var jumpSound:Sfx = new Sfx(JUMP_SOUND);
		
		public function Player(makex:uint, makey:uint, map:Class, level:int, lives:int, soundController:SoundController)
		{
			//Get our global setup
			super();
			
			x = makex;
			y = makey;
			
			//We need to know the current map for resetting it
			_map = map;
			_level = level;
			_lives = lives;
			_sndCtrl = soundController;
			
			//Define our emitter
			//_deathEmitter = new Emitter(new BitmapData());
			
			//Define our animation sequences
			_playerSpriteMap.add("run", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], 0.4, true);
			_playerSpriteMap.add("jump", [3], 0, true);
			_playerSpriteMap.originX = _playerSpriteMap.originY = 16;
			
			graphic = new Graphiclist(_playerSpriteMap);
			
			maxSpeed = new Point(1,7);
			
			type = "player";
			name = "player";
			
			setHitbox(9, 32, -11, 0);
			
			Input.define("Right", Key.RIGHT);
			Input.define("Left", Key.LEFT);
			Input.define("Jump",Key.SPACE);
			Input.define("Skip",Key.BACKSPACE);
			
			FP.console.log(name, "initialised");
			trace(name, "initialised");
		}
		
		override public function update():void 
		{
			//Get our physics
			super.update();
			
			//Controls
			if (_moving)
			{
				if (_facing == RIGHT)
				{
					acceleration.x = 0.7;
				}
				else if (_facing == LEFT)
				{
					acceleration.x = -0.7;
				}
			} else {
				acceleration.x = 0;
			}
			
			//Convoluted way of checking if we beat the level
			world.getClass(EndFlag, _endPointList);
			
			//Hitting the end flag
			if ((x > _endPointList[0].x + 10) && _moving)
			{
				_moving = false;
				resetLevel(false);
				
			}
			
			//Getting killed by deadly objects
			if ((collide("kill", x, y) && !_dead) || (collide("TNT", x, y) && !_dead))
			{
				var explode:Explosion = new Explosion(x,y);
				deathSound.play();
				(world as DefaultWorld).cam.screenShake(10, 50);
				world.add(explode);
				_lives--;
				_dead = true;
				freezeMovement = true;
				if (!_resettingLevel)
				{
					_resettingLevel = true;
					resetLevel(false);
				}
			}
			
			//Handle buttons
			_button = collide("button", x, y) as Button;
			if (_button)
			{
				_button.destroyPurpleBlocks();
				(world as DefaultWorld).cam.screenShake(10, 30);
			}
			
			//Jumping
			if (Input.check("Jump") && onGround && _startedLevel && _moving)
			{
				velocity.y = -5.2;
				jumpSound.play();
			}
			
			//Animation controls
			if (!onGround)
			{
				_playerSpriteMap.play("jump");
				
				//Spin in the air until we do a 360
				if (!freezeMovement) if (_playerSpriteMap.angle > -360) _playerSpriteMap.angle -= 15;
			}
			
			//Landing on the ground after a jump
			if (onGround && _playerSpriteMap.currentAnim == "jump")
			{
				_playerSpriteMap.play("run");
				_playerSpriteMap.angle = 0;
				var exp:Explosion = new Explosion(x,y);
				world.add(exp);
			}
			
			//First press to activate level
			if (!_startedLevel && Input.released("Jump") && transitionInOver)
			{
				_moving = true;
				_startedLevel = true;
				_playerSpriteMap.play("run");
			}
			
			//Reset the level
			if (transitionOutOver && _dead)
			{
				if (_lives >= 0) FP.world = new DefaultWorld(_map, _level, _lives, _sndCtrl);
				else FP.world = new worlds.GameOverScreen(_sndCtrl);
			} else if (transitionOutOver && !_dead)
			{
				_level++;
				if (_level < MAPS.Levels.length)
				{
					_map = MAPS.Levels[_level];
					FP.world = new DefaultWorld(_map, _level, _lives, _sndCtrl);
				} else {
					FP.world = new worlds.GameWonScreen(_sndCtrl);
				}
			}
			
			if (Input.check("Skip"))
			{
				resetLevel(false);
			}
			
		}
		
		override public function send_message(msg:String, params:Object=null):void
		{
			super.send_message(msg, params);
			
			if (msg == "pause")
			{
				_playerSpriteMap.frame = _playerSpriteMap.frame;
			}
			
			if (msg == "unpause")
			{
				_playerSpriteMap.play("run");
			}
			
		}
		
		public function resetLevel(fadein:Boolean):void
		{
			//Create the transition effect
			_moving = false;
			var _temp:DefaultWorld = FP.world as DefaultWorld;
			_temp.createTransition(fadein);
		}
	}
}
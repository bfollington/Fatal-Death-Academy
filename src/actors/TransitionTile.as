package actors
{
	import constants.CONST;
	import constants.IMG;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	public class TransitionTile extends Entity
	{
		
		private var _ticker:int = 0;
		private var _playerList:Array = [];
		private var _fadein:Boolean;
		private var _sprMap:Spritemap;
		
		public function TransitionTile(x:Number=0, y:Number=0, fadein:Boolean=true)
			//set fadein to false for a fadeout
		{
			super(x, y);
			
			if (fadein)
			{
				_sprMap = new Spritemap(IMG.TRANSITION_IMAGE, 32, 32);
				_sprMap.add("fade", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], 1, false);
				graphic = _sprMap;
				_sprMap.play("fade");
			} else {
				_sprMap = new Spritemap(IMG.REVERSETRANSITION_IMAGE, 32, 32);
				_sprMap.add("fade", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17], 1, false);
				graphic = _sprMap;
				_sprMap.play("fade");
			}
			
			graphic.scrollX = graphic.scrollY = 0;
			
			_fadein = fadein;
			
		}
		
		override public function update():void
		{
			_ticker++;
			
			if (_ticker == 25)
			{
				world.getClass(Player, _playerList);
				
				if (_fadein) _playerList[0].transitionInOver = true;
				else _playerList[0].transitionOutOver = true;
				
				world.remove(this);
			}
		}
	}
}
package
{
	
	import core.tiled.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.FP;
	import constants.IMG;
	
	public class CollisionData extends Entity
	{
		
		public function CollisionData(DataFile:Class)
		{
			super();
			
			//Set up the tilemap to display the visual collision data
			_tiles = new Tilemap(IMG.COLLISION_TILES, 82*32, 25*32, 32, 32);
			graphic = _tiles;
			
			//Set up the grid to hold the actual collisions
			_grid = new Grid(82*32, 25*32, 32, 32, 0, 0);
			mask = _grid;
			
			//This is probably unneccessary
			type = "level";
			
			_dataFile = DataFile;
			
			loadLevel();
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
		private function loadLevel():void
		{
			var aMap:TMXMap = new TMXMap( _dataFile );
			
			FP.console.log("Loading Coldata Layer");
			trace("Coldata initialised");
			
			aMap.GetLayer( "COLLISION" ).FillTileMap( _tiles, aMap.GetTiles("tiles2").GetGID(), _grid );
			
		}
		
		private var _tiles:Tilemap;
		private var _grid:Grid;
		private var _dataFile:Class;
		
	}
}
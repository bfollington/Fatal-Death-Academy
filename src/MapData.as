package
{
	
	import constants.IMG;
	
	import core.tiled.*;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class MapData extends Entity
	{
		
		public function MapData(DataFile:Class, layer:String)
		{
			super();
			
			var rand:int = Math.random()*6;
			_tiles = new Tilemap(IMG.tilesets[rand], 82*32, 25*32, 32, 32);
			graphic = _tiles;
			_dataFile = DataFile;
			loadLevel(layer);
			
		}
		
		override public function update():void
		{
			super.update();
		}
		
		
		private function loadLevel(layer:String):void
		{

			var aMap:TMXMap = new TMXMap(_dataFile);
			
			FP.console.log("Loading", layer, "layer");
			trace("Loading", layer, "layer");
			
			aMap.GetLayer( layer ).FillTileMap( _tiles, aMap.GetTiles("SOMETILES").GetGID() );
			
		}
		
		private var _tiles:Tilemap;
		private var _dataFile:Class;
		
	}
}
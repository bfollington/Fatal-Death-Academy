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
	
	public class ObjectData
	{
		
		public function ObjectData(DataFile:Class)
		{
	
			_dataFile = DataFile;
			loadLevel();
			
		}
		
		private function loadLevel():void
		{
			FP.console.log("Loading object layer");
			trace("Loading object layer");
			
			mapData = new TMXMap( _dataFile );
			
		}
		
		public function getObjects():Array
		{
			return mapData.GetObjects();
		}

		public var mapData:TMXMap;
		private var _dataFile:Class;
		
	}
}
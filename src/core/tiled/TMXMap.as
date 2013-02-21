package core.tiled 
{
	/////////////////////////////////////////////////
	// Tiled Class by Trevor (Drak)
	// -------------------------------------------
	// Based on PixelPracht work
	//
	//
	
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	
	import net.flashpunk.World;
	
	public class TMXMap 
	{
		private var m_sVersion:String;
		private var m_sType:String;
		
		private var m_iWorldHeight:uint; // amount of tiles up/down
		private var m_iWorldWidth:uint; // amount of tiles left/right
		private var m_iTileWidth:uint; 
		private var m_iTileHeight:uint;
		
		private var m_tProperties:TMXProperty = null;
		private var m_tLayers:Object = { };
		private var m_tTileSets:Object = { };
		private var m_tObjects:Array = [];
		
		public function TMXMap( WorldFile:Class )
		{
			if ( WorldFile == null ) throw Error( "NULL WorldFile" );
			
			var RawData:ByteArray = new WorldFile;
			var DataString:String = RawData.readUTFBytes( RawData.length );
			var File:XML = new XML( DataString );
			
			// File Header
			m_sVersion = File.@version ? File.@version : "unknown";
			m_sType = File.@orientation ? File.@orientation : "unknown";
			
			m_iWorldHeight = File.@height;
			m_iWorldWidth = File.@width;
			m_iTileHeight = File.@tileheight;
			m_iTileWidth = File.@tilewidth;
			
			if ( m_sVersion == "unknown" || m_sType == "unknown" ) 
				throw Error( "Invalid Version ( " + m_sVersion + " ) or Invalid Orientation ( " + m_sType + " )" );
			
			var XMLNode:XML = null;
			var SubNode:XML = null;
			
			// Load World Properties
			for each( XMLNode in File.properties )
				m_tProperties = m_tProperties ? m_tProperties.AddProperty( XMLNode ) : new TMXProperty( XMLNode );
			
			// Load Layers
			for each( XMLNode in File.layer )
			{
				m_tLayers[ XMLNode.@name ] = new TMXLayer( XMLNode, this );
			
			}
			
			for each( XMLNode in File.objectgroup )
			{
				for each( SubNode in  XMLNode.object )
				{
					
					m_tObjects.push(new TMXObject(SubNode, this));

				}
			}
				
			// Load Tilesets
			for each( XMLNode in File.tileset )
			{
				m_tTileSets[ XMLNode.@name ] = new TMXTileSet( XMLNode, this );
			}
		}
		
		public function GetProperty():TMXProperty
		{
			return m_tProperties as TMXProperty;
		}
		
		public function GetLayer( Name:String ):TMXLayer
		{
			return m_tLayers[ Name ] as TMXLayer;
		}
		
		public function GetTiles( Name:String ):TMXTileSet
		{
			return m_tTileSets[ Name ] as TMXTileSet;
		}
		
		public function GetObjects():Array
		{
			return m_tObjects;
		}
		
		// returns the size of the world in pixels.
		public function GetPixelRes():Array
		{
			return [ ( m_iWorldWidth * m_iTileWidth ), ( m_iWorldHeight * m_iTileHeight ) ];
		}
	}
}
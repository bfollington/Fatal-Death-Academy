package core.tiled 
{
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class TMXLayer 
	{
		private var m_tWorld:TMXMap;
		private var m_sName:String;
		
		private var m_iWidth:uint
		private var m_iHeight:uint;
		
		private var m_tProperties:TMXProperty = null;
		private var m_sLayerData:XML;
		
		public function TMXLayer( Source:XML, ParentWorld:TMXMap ) 
		{
			m_tWorld = ParentWorld;
			m_sName = Source.@name;
			m_sLayerData = Source;
			
			m_iWidth = Source.@width;
			m_iHeight = Source.@height;
			
			switch( Source.@encoding )
			{
			}

			// Load Layer Properties
			var XMLNode:XML = null;
			for each( XMLNode in Source.properties )
				m_tProperties = m_tProperties ? m_tProperties.AddProperty( XMLNode ) : new TMXProperty( XMLNode );
		}
		
		public function GetPropertyInfo():TMXProperty
		{
			return m_tProperties as TMXProperty;
		}
		
		// Fills a tilemap will the layer loaded
		// Offset is the difference between FP and Tiled textureid. You can get the offset with GetGID();
		// Send a grid mask to make all filled in tiles, fill in a grid also
		public function FillTileMap( TileMap:Tilemap, Offset:Number, GridMask:Grid = null ):void
		{
			var Node:XML = null;
			var a:uint = 0,b:uint = 0,derp:uint = 0
			for each( Node in m_sLayerData.data.tile )
			{
				if ( int( Node.@gid ) != 0 )
				{
					TileMap.setTile( a, b, int( Node.@gid ) - Offset );
					if ( GridMask != null ) 
					{
						GridMask.setTile( a, b );
					}
				}
				if ( a++ >= m_iWidth - 1 )
				{
					a = 0;
					b++;
				}
			}
		}
	}
}
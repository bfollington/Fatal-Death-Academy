package core.tiled 
{
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	public class TMXObject
	{
		private var m_tWorld:TMXMap;
		public var m_sName:String;
		
		public var m_iGid:int;
		public var m_iX:int;
		public var m_iY:int;
		public var m_iWidth:uint
		public var m_iHeight:uint;
		
		public var m_tProperties:TMXProperty = null;

		public function TMXObject( Source:XML, ParentWorld:TMXMap ) 
		{
			m_tWorld = ParentWorld;
			m_sName = Source.@name;
			m_iGid = Source.@gid;

			m_iX = Source.@x;
			m_iY = Source.@y - 32;
			m_iWidth = Source.@width;
			m_iHeight = Source.@height;
			
			switch( Source.@encoding )
			{
			}
			
			m_tProperties = new TMXProperty();
			
			// Load Layer Properties
			var XMLNode:XML = null;
			for each( XMLNode in Source.properties )
			m_tProperties = m_tProperties ? m_tProperties.AddProperty( XMLNode ) : new TMXProperty( XMLNode );
		}
		
		public function setPropertyInfo():TMXProperty
		{
			return m_tProperties as TMXProperty;
		}
	}
}
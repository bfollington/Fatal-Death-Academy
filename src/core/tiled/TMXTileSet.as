package core.tiled 
{
	public class TMXTileSet 
	{
		private var m_sImageFile:String;
		private var m_sName:String;
		private var m_iFirstGID:uint;
		private var m_iWidth:uint;
		private var m_iHeight:uint;
		
		public function TMXTileSet( Source:XML, WorldParent:TMXMap )
		{
			m_iFirstGID = Source.@firstgid;
			m_sImageFile = Source.image.@source;
			m_sName = Source.@name;
		}
		
		public function GetGID():uint
		{
			return m_iFirstGID;
		}
	}
}
package core.tiled 
{
	public class TMXProperty 
	{
		private var m_aProps:Array
		
		public function TMXProperty( Source:XML=null ) 
		{
			if( m_aProps == null ) m_aProps = new Array();
			AddProperty( Source );
		}
		
		private function PropertyExists( Key:String ):Boolean
		{
			var aKey:String
			for( aKey in m_aProps )
			{
				if ( aKey == Key )
					return true;
			}
			return false;
		}
		
		public function AddProperty( Source:XML ):TMXProperty
		{
			var XMLNode:XML = null;
			var Name:String;
			
			if (Source) {
				for each( XMLNode in Source.property )
				{
					Name = XMLNode.@name;
					if( Name.length > 0 )
						m_aProps[Name] = XMLNode.@value;
				}
					
				return this
			} else {
				return null;
			}
		}
		
		public function GetPropertyAsString( Key:String ):String
		{
			if ( !PropertyExists( Key ) ) return null;
			return m_aProps[Key];
		}
		
		public function GetPropertyAsInt( Key:String ):uint
		{
			if ( !PropertyExists( Key ) ) return null;
			return uint( m_aProps[Key] );
		}
		
		public function GetPropertyAsBool( Key:String ):Boolean
		{
			if ( !PropertyExists( Key ) ) return false;
			
			var sReturnedValue:String = m_aProps[Key];
			
			switch( sReturnedValue.toLowerCase() )
			{
				case "false": return false;
				case "true": return true;
				case "1": return true;
				case "0": return false;
				default: throw Error( "Unable to identify string as bool. String: " + sReturnedValue );
			}
			
			return false;
		}
	}
}
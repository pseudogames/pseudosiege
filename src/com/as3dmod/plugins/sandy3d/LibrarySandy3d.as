package com.as3dmod.plugins.sandy3d {
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.plugins.Library3d;	

	public class LibrarySandy3d extends Library3d {
		
		public function LibrarySandy3d() {
			// This is just to force the import of this classes
			var m:MeshProxy = new Sandy3dMesh();
			var v:VertexProxy = new Sandy3dVertex();
		}
		
		override public function get id():String {
			return "sandy3d";
		}
		
		override public function get meshClass():String {
			return "com.as3dmod.plugins.sandy3d.Sandy3dMesh";
		}
		
		override public function get vertexClass():String {
			return "com.as3dmod.plugins.sandy3d.Sandy3dVertex";
		}
	}
}
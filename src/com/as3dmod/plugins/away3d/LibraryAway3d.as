package com.as3dmod.plugins.away3d {
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.plugins.Library3d;	

	public class LibraryAway3d extends Library3d {
		
		public function LibraryAway3d() {
			// This is just to force the import of this classes
			var m:MeshProxy = new Away3dMesh();
			var v:VertexProxy = new Away3dVertex();
		}
		
		override public function get id():String {
			return "away3d";
		}
		
		override public function get meshClass():String {
			return "com.as3dmod.plugins.away3d.Away3dMesh";
		}
		
		override public function get vertexClass():String {
			return "com.as3dmod.plugins.away3d.Away3dVertex";
		}
	}
}



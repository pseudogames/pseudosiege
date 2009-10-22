package com.as3dmod.plugins.alternativa3d {
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.plugins.Library3d;	

	public class LibraryAlternativa3d extends Library3d {
		
		public function LibraryAlternativa3d() {
			// This is just to force the import of this classes
			var m:MeshProxy = new Alternativa3dMesh();
			var v:VertexProxy = new Alternativa3dVertex();
		}
		
		override public function get id():String {
			return "alternativa3d";
		}
		
		override public function get meshClass():String {
			return "com.as3dmod.plugins.alternativa3d.Alternativa3dMesh";
		}
		
		override public function get vertexClass():String {
			return "com.as3dmod.plugins.alternativa3d.Alternativa3dVertex";
		}
	}
}



package com.as3dmod.plugins.alternativa3d {
	import com.as3dmod.core.MeshProxy;
	
	import alternativa.engine3d.core.Mesh;
	import alternativa.types.Set;		

	public class Alternativa3dMesh extends MeshProxy {
		
		private var awm:Mesh;
		
		public function Alternativa3dMesh() {
			
		}
		
		override public function setMesh(mesh:*):void {
			awm = mesh as Mesh;

			var vs:Set = awm.vertices.toSet();

			while (!vs.isEmpty()) {
				var nv:Alternativa3dVertex = new Alternativa3dVertex();
				nv.setVertex(vs.take());
				vertices.push(nv);
			}
		}
	}
}
package com.as3dmod.plugins.pv3d {
	import org.papervision3d.core.geom.renderables.Vertex3D;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.as3dmod.core.MeshProxy;	

	public class Pv3dMesh extends MeshProxy {
		
		private var do3d:DisplayObject3D;
		
		override public function setMesh(mesh:*):void {
			do3d = mesh as DisplayObject3D;
			
			var vs:Array = do3d.geometry.vertices;
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var nv:Pv3dVertex = new Pv3dVertex();
				nv.setVertex(vs[i] as Vertex3D);
				vertices.push(nv);
			}
		}
	}
}
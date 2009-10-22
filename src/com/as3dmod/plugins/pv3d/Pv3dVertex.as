package com.as3dmod.plugins.pv3d {
	import org.papervision3d.core.geom.renderables.Vertex3D;
	
	import com.as3dmod.core.VertexProxy;	

	public class Pv3dVertex extends VertexProxy {
		
		private var vx:Vertex3D;
		
		public function Pv3dVertex() {
		}
		
		override public function setVertex(vertex:*):void {
			vx = vertex as Vertex3D;
			ox = vx.x;
			oy = vx.y;
			oz = vx.z;
		}
		
		override public function get x():Number {
			return vx.x;
		}
		
		override public function get y():Number {
			return vx.y;
		}
		
		override public function get z():Number {
			return vx.z;
		}
		
		override public function set x(v:Number):void {
			vx.x = v;
		}
		
		override public function set y(v:Number):void {
			vx.y = v;
		}
		
		override public function set z(v:Number):void {
			vx.z = v;
		}
	}
}
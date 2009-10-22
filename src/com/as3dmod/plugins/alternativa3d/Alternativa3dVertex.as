package com.as3dmod.plugins.alternativa3d {
	import com.as3dmod.core.VertexProxy;
	
	import alternativa.engine3d.core.Vertex;	

	public class Alternativa3dVertex extends VertexProxy {
		
		private var vx:Vertex;
		
		public function Alternativa3dVertex() {
			
		}
		
		override public function setVertex(vertex:*):void {
			vx = vertex as Vertex;
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
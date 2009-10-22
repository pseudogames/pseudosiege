package com.as3dmod.plugins.away3d {
	import com.as3dmod.core.VertexProxy;
	
	import away3d.core.base.Vertex;	

	public class Away3dVertex extends VertexProxy {
		
		private var vx:Vertex;
		
		public function Away3dVertex() {
			
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
			//Debug.log("Away3dvertext.z");
			vx.z = v;
		}
	}
}
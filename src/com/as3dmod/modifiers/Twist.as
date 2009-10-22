package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Matrix3D;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.Vector3D;
	import com.as3dmod.core.VertexProxy;		

	/**
	 * <b>Twist modifier.</b>
	 * 
	 * Adapted from the Twist modifier for PV3D. 
	 * More info here: <a href="http://blog.zupko.info/?p=140" target="_blank">http://blog.zupko.info/?p=140</a>.
	 */
	public class Twist extends Modifier implements IModifier {

		private var _vector:Vector3D = new Vector3D(0, 1, 0);
		private var _angle:Number;
		public var center:Vector3D = new Vector3D();

		public function Twist(a:Number = 0) {
			_angle = a;
		}

		public function get angle():Number { 
			return _angle; 
		}

		public function set angle(value:Number):void { 
			_angle = value; 
		}

		public function get vector():Vector3D { 
			return _vector; 
		}

		public function set vector(value:Vector3D):void { 
			_vector = value; 
		}

		public function apply():void {
			_vector.normalize();
			
			var dv:Vector3D = new Vector3D(mod.maxX / 2, mod.maxY / 2, mod.maxZ / 2);
			var d:Number = -Vector3D.dot(_vector, center);

			for(var i:int = 0;i < mod.getVertices().length; i++) {
				var vertex:VertexProxy = mod.getVertices()[i];
				var dd:Number = Vector3D.dot(new Vector3D(vertex.x, vertex.y, vertex.z), _vector) + d;
				twistPoint(vertex, (dd / dv.modulo) * _angle);
			}
		}

		private function twistPoint(v:VertexProxy, a:Number):void {
			var mat:Matrix3D = Matrix3D.translationMatrix(v.x, v.y, v.z);	
			mat = Matrix3D.multiply(Matrix3D.rotationMatrix(_vector.x, _vector.y, _vector.z, a), mat);	
			v.x = mat.n14;
			v.y = mat.n24;
			v.z = mat.n34;
		}
	}
}
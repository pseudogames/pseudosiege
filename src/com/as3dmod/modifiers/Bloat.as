package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;	

	/**
	 * <b>Bloat modifier.</b>
	 * 
	 * Bloats your stuff by forcing vertices out of specified sphere.
	 * @author makc
	 */
	public class Bloat extends Modifier implements IModifier {

		private var _x:Number = 0;
		public function get x ():Number { return _x; }
		public function set x (v:Number):void { _x = v; }

		private var _y:Number = 0;
		public function get y ():Number { return _y; }
		public function set y (v:Number):void { _y = v; }

		private var _z:Number = 0;
		public function get z ():Number { return _z; }
		public function set z (v:Number):void { _z = v; }

		private var _r:Number = 0;
		public function get r ():Number { return _r; }
		public function set r (v:Number):void { _r = Math.max (0, v); }

		private var _a:Number = 1e-2;
		public function get a ():Number { return _a; }
		public function set a (v:Number):void { _a = Math.max (0, v); }

		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = VertexProxy (vs [i]);

				// get distance and unit vector towards vertex
				var ux:Number = v.x - _x;
				var uy:Number = v.y - _y;
				var uz:Number = v.z - _z;
				var ur:Number = Math.sqrt (ux * ux + uy * uy + uz * uz);
				if (ur > 0) {
					ux /= ur; uy /= ur; uz /= ur;
				} else {
					ux = 1.0;
				}

				// change ur to ur + r * exp (-a * ur)
				ur += _r * Math.exp ( -ur * _a);

				// move vertex accordingly
				v.x = _x + ux * ur;
				v.y = _y + uy * ur;
				v.z = _z + uz * ur;
			}
		}

	}
	
}
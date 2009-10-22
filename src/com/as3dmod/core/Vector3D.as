package com.as3dmod.core {

	/**
	 * Code adapted from the org.papervision3d.core.math.Number3D class
	 */
	public class Vector3D {

		public var x:Number;
		public var y:Number;
		public var z:Number;

		public function Vector3D( x:Number = 0, y:Number = 0, z:Number = 0 ) {
			this.x = x;
			this.y = y;
			this.z = z;
		}

		public function get modulo():Number {
			return Math.sqrt(this.x * this.x + this.y * this.y + this.z * this.z);
		}

		public function normalize():void {
			var mod:Number = this.modulo;

			if( mod != 0 && mod != 1) {
				this.x /= mod;
				this.y /= mod;
				this.z /= mod;
			}
		}

		public static function dot( v:Vector3D, w:Vector3D ):Number {
			return ( v.x * w.x + v.y * w.y + w.z * v.z );
		}
	}
}

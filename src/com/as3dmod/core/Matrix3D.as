package com.as3dmod.core {

	/**
	 * Code adapted from sandy.core.data.Matrix4 and org.papervision3d.core.math.Matrix3D classes
	 */
	public class Matrix3D {

		public var n11:Number;
		public var n12:Number;
		public var n13:Number;
		public var n14:Number;
		public var n21:Number;
		public var n22:Number;
		public var n23:Number;
		public var n24:Number;
		public var n31:Number;
		public var n32:Number;
		public var n33:Number;
		public var n34:Number;
		public var n41:Number;
		public var n42:Number;
		public var n43:Number;
		public var n44:Number;

		public function Matrix3D(
					pn11:Number = 1, pn12:Number = 0 , pn13:Number = 0 , pn14:Number = 0,
					pn21:Number = 0, pn22:Number = 1 , pn23:Number = 0 , pn24:Number = 0,
					pn31:Number = 0, pn32:Number = 0 , pn33:Number = 1 , pn34:Number = 0,
					pn41:Number = 0, pn42:Number = 0 , pn43:Number = 0 , pn44:Number = 1 ) {
			n11 = pn11; 
			n12 = pn12; 
			n13 = pn13; 
			n14 = pn14;
			n21 = pn21; 
			n22 = pn22; 
			n23 = pn23; 
			n24 = pn24;
			n31 = pn31; 
			n32 = pn32; 
			n33 = pn33; 
			n34 = pn34;
			n41 = pn41; 
			n42 = pn42; 
			n43 = pn43; 
			n44 = pn44;
		}

		public static function translationMatrix( x:Number, y:Number, z:Number ):Matrix3D {
			var m:Matrix3D = new Matrix3D();
			m.n14 = x;
			m.n24 = y;
			m.n34 = z;
			return m;
		}

		public static function scaleMatrix( x:Number, y:Number, z:Number ):Matrix3D {
			var m:Matrix3D = new Matrix3D();
			m.n11 = x;
			m.n22 = y;
			m.n33 = z;
			return m;
		}

		public static function rotationMatrix( x:Number, y:Number, z:Number, rad:Number, targetmatrix:Matrix3D = null ):Matrix3D {
			
			var m:Matrix3D;
			if(!targetmatrix) m = new Matrix3D();
			else m = targetmatrix; 
			
			var nCos:Number = Math.cos(rad);
			var nSin:Number = Math.sin(rad);
			var scos:Number = 1 - nCos;
	
			var sxy:Number = x * y * scos;
			var syz:Number = y * z * scos;
			var sxz:Number = x * z * scos;
			var sz:Number = nSin * z;
			var sy:Number = nSin * y;
			var sx:Number = nSin * x;
	
			m.n11 = nCos + x * x * scos;
			m.n12 = -sz + sxy;
			m.n13 = sy + sxz;
			m.n14 = 0;
			
			m.n21 = sz + sxy;
			m.n22 = nCos + y * y * scos;
			m.n23 = -sx + syz;
			m.n24 = 0;
			
			m.n31 = -sy + sxz;
			m.n32 = sx + syz;
			m.n33 = nCos + z * z * scos;
			m.n34 = 0;
			
			return m;
		}

		public function calculateMultiply( a:Matrix3D, b:Matrix3D ):void {
			var a11:Number = a.n11; 
			var b11:Number = b.n11;
			var a21:Number = a.n21; 
			var b21:Number = b.n21;
			var a31:Number = a.n31; 
			var b31:Number = b.n31;
			var a12:Number = a.n12; 
			var b12:Number = b.n12;
			var a22:Number = a.n22; 
			var b22:Number = b.n22;
			var a32:Number = a.n32; 
			var b32:Number = b.n32;
			var a13:Number = a.n13; 
			var b13:Number = b.n13;
			var a23:Number = a.n23; 
			var b23:Number = b.n23;
			var a33:Number = a.n33; 
			var b33:Number = b.n33;
			var a14:Number = a.n14; 
			var b14:Number = b.n14;
			var a24:Number = a.n24; 
			var b24:Number = b.n24;
			var a34:Number = a.n34; 
			var b34:Number = b.n34;

			this.n11 = a11 * b11 + a12 * b21 + a13 * b31;
			this.n12 = a11 * b12 + a12 * b22 + a13 * b32;
			this.n13 = a11 * b13 + a12 * b23 + a13 * b33;
			this.n14 = a11 * b14 + a12 * b24 + a13 * b34 + a14;

			this.n21 = a21 * b11 + a22 * b21 + a23 * b31;
			this.n22 = a21 * b12 + a22 * b22 + a23 * b32;
			this.n23 = a21 * b13 + a22 * b23 + a23 * b33;
			this.n24 = a21 * b14 + a22 * b24 + a23 * b34 + a24;

			this.n31 = a31 * b11 + a32 * b21 + a33 * b31;
			this.n32 = a31 * b12 + a32 * b22 + a33 * b32;
			this.n33 = a31 * b13 + a32 * b23 + a33 * b33;
			this.n34 = a31 * b14 + a32 * b24 + a33 * b34 + a34;
		}

		public static function multiply( a:Matrix3D, b:Matrix3D ):Matrix3D {
			var m:Matrix3D = new Matrix3D();
			m.calculateMultiply(a, b);
			return m;
		}

		public static function multiplyVector( m:Matrix3D, v:Vector3D ):void {
			var vx:Number = v.x;
			var vy:Number = v.y;
			var vz:Number = v.z;

			v.x = vx * m.n11 + vy * m.n12 + vz * m.n13 + m.n14;
			v.y = vx * m.n21 + vy * m.n22 + vz * m.n23 + m.n24;
			v.z = vx * m.n31 + vy * m.n32 + vz * m.n33 + m.n34;
		}
	}
}

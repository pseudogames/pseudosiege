package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Matrix3D;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.Vector3D;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.XMath;		

	/**
	 * 	<b>Taper modifier.</b>
	 * 	
	 * 	The taper modifier displaces the vertices on two 
	 * 	axes proportionally to their position on the third axis.
	 * 	
	 * 	@author Bartek Drozdz
	 */
	public class Taper extends Modifier implements IModifier
	{
		private var frc:Number;		private var pow:Number;
		
		private var start:Number = 0;
		private var end:Number = 1;

		public function Taper(f:Number) {
			frc = f;
			pow = 1;
		}
		
		public function setFalloff(start:Number=0, end:Number=1):void {
			this.start = start;
			this.end = end;
		}
		
		public function set force(value:Number):void {
			frc = value;
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function get power():Number { 
			return pow; 
		}
		
		public function set power(value:Number):void { 
			pow = value; 
		}

		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;

				var ar:Number = Math.pow(XMath.normalize(start, end, v.getRatio(mod.maxAxis)), pow);				var sc:Number = frc * ar;
				
				var m:Matrix3D = Matrix3D.scaleMatrix(1+sc, 1+sc, 1);
				var n:Vector3D = new Vector3D(v.getValue(mod.minAxis), v.getValue(mod.midAxis), v.getValue(mod.maxAxis));
				Matrix3D.multiplyVector(m, n);
				
				v.setValue(mod.minAxis, n.x);				v.setValue(mod.midAxis, n.y);
			}
		}
	}
}








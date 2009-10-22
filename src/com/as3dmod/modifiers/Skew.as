package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;		

	/**
	 * 	<b>Skew modifier.</b> 
	 * 
	 *  Skew acts just like classic 2d skew function
	 *  
	 *  @author Bartek Drozdz
	 */
	public class Skew extends Modifier implements IModifier
	{
		private var frc:Number;
		
		public function Skew(f:Number) {
			f = force;
		}
		
		public function set force(f:Number):void {
			frc = f;
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				// Matrix version
//				var vl:Number = force * v.getRatio(mod.maxAxis);
//				var m:Matrix3D = Matrix3D.translationMatrix(vl, vl, 0);
//				var n:Number3D = new Number3D(v.getValue(mod.minAxis), v.getValue(mod.midAxis), v.getValue(mod.maxAxis));
//				Matrix3D.multiplyVector(m, n);
//				
//				v.setValue(mod.minAxis, n.x);
				
				// No matrix version
				var vl:Number = v.getValue(mod.minAxis) + force * Math.pow(v.getRatio(mod.maxAxis), 2);
				v.setValue(mod.minAxis, vl);
			}
		}
	}
}









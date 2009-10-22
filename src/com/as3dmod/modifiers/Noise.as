package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.ModConstant;	

	/**
	 * 	<b>Noise modifier.</b>
	 * 
	 *  Randomly displaces each vertex in all 3 axes 
	 *  (or less if constraintAxes() is used). 
	 */
	public class Noise extends Modifier implements IModifier {
		
		private var frc:Number;
		private var axc:int = ModConstant.NONE;
		
		private var start:Number = 0;
		private var end:Number = 0;

		public function Noise(f:Number=0) {
			this.frc = f;
		}
		
		public function set force(f:Number):void {
			frc = f;
		}
		
		public function get force():Number {
			return frc;
		}
		
		public function constraintAxes(c:int):void {
			this.axc = c;
		}
		
		public function setFalloff(start:Number=0, end:Number=1):void {
			this.start = start;
			this.end = end;
		}

		public function apply():void {
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;

			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				var r:Number = (Math.random() * force) - (force / 2);
				
				var p:Number = v.getRatio(mod.maxAxis);
				if(start < end) {
					if (p < start) p = 0;
					if (p > end) p = 1;
				} else if(start > end) {
					p = 1 - p;
					if (p > start) p = 0;
					if (p < end) p = 1;
				} else {
					p = 1;
				}

				if (!(axc & 1)) v.x += r * p;
				if (!(axc >> 1 & 1)) v.y += r * p;
				if (!(axc >> 2 & 1)) v.z += r * p;
			}
		}
	}
}
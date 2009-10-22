package com.as3dmod.modifiers {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;
	import com.as3dmod.util.ModConstant;	

	/**
	 * 	<b>Bend modifier.</b>
	 * 	
	 * 	Bends an object along an axis
	 * 	
	 * 	@author Bartek Drozdz
	 */
	public class Bend extends Modifier implements IModifier {
		
		private var frc:Number;
		private var ofs:Number;
		private var cst:int = ModConstant.NONE;
		
		private var maa:int = ModConstant.NONE;
		private var mia:int = ModConstant.NONE;

		/**
		 * @param	f force. May be modified later with the force attribute
		 * @param	o offset. May be modified later with the offset attribute
		 */
		public function Bend(f:Number=0, o:Number=.5) {
			force = f;
			offset = o;
		}
		
		/**
		 *  Set the force of the bend.
		 * 
		 *  0 = no bend, 1 = 180 deg, 2 = 360 deg, etc..
		 * 
		 *  Negative values may also be used.
		 */
		public function set force(f:Number):void {
			frc = f;
		}
		
		/**
		 *  Set the offset for the bend.
		 * 
		 *  An offset is a value between 0 and 1, where 1 is the 
		 *  leftmost edge of the object, and 0 - the rightmost.
		 * 
		 *  The bending will start where the offset is set. 
		 *  The default value is .5 which means that the bending
		 *  will start in the middle of the object. 
		 */
		public function set offset(o:Number):void {
			ofs = o;
			ofs = Math.max(0, o);
			ofs = Math.min(1, o);
		}
		
		/**
		 *  Takes 3 values: 
		 * 
		 *  ModConstraint.NONE (default) - vertices are bent on both side of the offset
		 *  ModConstraint.LEFT - all vertices to the left of the offset will be left unaffected
		 *  ModConstraint.RIGHT - all vertices to the right of the offset will be left unaffected
		 */
		public function set constraint(c:int):void {
			cst = c; 
		}
		
		/**
		 *  The current force of the bend
		 */
		public function get force():Number {
			return frc;
		}
		
		/**
		 *  The current offset of the bend
		 */
		public function get offset():Number {
			return ofs;
		}
		
		/**
		 *  The current value of the constraint parameter
		 */
		public function get constraint():int {
			return cst; 
		}
		
		/**
		 *  The axis along which the bending takes place 
		 * 
		 *  ModConstraint.X 
		 *  ModConstraint.Y
		 *  ModConstraint.Z
		 * 
		 *  By default the axis used will be the on that 
		 *  has the biggest span between vertices.
		 */
		public function set bendAxis(a:int):void {
			maa = a;
		}
		
		/**
		 *  The axis on which the point around 
		 *  which the bend is done will be placed.
		 * 
		 *  ModConstraint.X 
		 *  ModConstraint.Y
		 *  ModConstraint.Z
		 * 
		 *  
		 */
		public function set pointAxis(a:int):void {
			mia = a;
		}
		
		/**
		 *  Applies the modifier to the mesh
		 */
		public function apply():void {	
			if(force == 0) return;
			
			
			if (maa == ModConstant.NONE) maa = mod.maxAxis;
			if (mia == ModConstant.NONE) mia = mod.minAxis;
			
			var pto:Number = mod.getMin(maa);
			var ptd:Number = mod.getMax(maa) - pto;	

			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			var distance:Number = pto + ptd * offset;
			var radius:Number = ptd / Math.PI / force;
			var angle:Number = Math.PI * 2 * (ptd / (radius * Math.PI * 2));
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
				var p:Number = v.getRatio(maa);
				if (constraint == ModConstant.LEFT && p <= offset) continue;
				if (constraint == ModConstant.RIGHT && p >= offset) continue;
				
				var fa:Number = ((Math.PI / 2) - angle * offset) + (angle * p);
				var op:Number = Math.sin(fa) * (radius + v.getValue(mia)) - radius;
				var ow:Number = distance - Math.cos(fa) * (radius + v.getValue(mia));
				v.setValue(mia, op);
				v.setValue(maa, ow);
			}
		}
	}
}




package com.as3dmod.core {
	import com.as3dmod.util.ModConstant;		

	public class VertexProxy 
	{
		
		private var _ratioX:Number;
		private var _ratioY:Number;
		private var _ratioZ:Number;
		
		protected var ox:Number;
		protected var oy:Number;
		protected var oz:Number;

		public function VertexProxy() {
		}
		
		public function setVertex(vertex:*):void {
			
		}
		
		public function setRatios(rx:Number, ry:Number, rz:Number):void {
			_ratioX = rx;
			_ratioY = ry;
			_ratioZ = rz;
		}
		
		public function setOriginalPosition(ox:Number, oy:Number, oz:Number):void {
			this.ox = ox;
			this.oy = oy;
			this.oz = oz;
		}
		
		public function get x():Number {
			return 0;
		}
		
		public function get y():Number {
			return 0;
		}
		
		public function get z():Number {
			return 0;
		}
		
		public function set x(v:Number):void {
			
		}
		
		public function set y(v:Number):void {
			
		}
		
		public function set z(v:Number):void {
			
		}
		
		public function getValue(axis:int):Number {
			switch(axis) {
				case ModConstant.X: return x;
				case ModConstant.Y: return y;
				case ModConstant.Z: return z;
			}
			return 0;
		}
		
		public function setValue(axis:int, v:Number):void {
			switch(axis) {
				case ModConstant.X: x = v; break;
				case ModConstant.Y: y = v; break;
				case ModConstant.Z: z = v; break;
			}
		}
		
		public function get ratioX():Number {
			return _ratioX;
		}
		
		public function get ratioY():Number {
			return _ratioY;
		}
		
		public function get ratioZ():Number {
			return _ratioZ;
		}
		
		public function getRatio(axis:int):Number {
			switch(axis) {
				case ModConstant.X: return _ratioX;
				case ModConstant.Y: return _ratioY;
				case ModConstant.Z: return _ratioZ;
			}
			return -1;
		}
		
		public function get originalX():Number {
			return ox;
		}
		
		public function get originalY():Number {
			return oy;
		}
		
		public function get originalZ():Number {
			return oz;
		}
		
		public function getOriginalValue(axis:int):Number {
			switch(axis) {
				case ModConstant.X: return ox;
				case ModConstant.Y: return oy;
				case ModConstant.Z: return oz;
			}
			return 0;
		}
		
		public function reset():void {
			x = ox;
			y = oy;
			z = oz;
		}
		
		public function collapse():void {
			ox = x;
			oy = y;
			oz = z;
		}
	}
}
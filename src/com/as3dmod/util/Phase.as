package com.as3dmod.util {

	public class Phase {
		
		private var v:Number;
		
		public function Phase() {
			v = 0;
		}
		
		public function get value():Number {
			return v;
		}
		
		public function set value(v:Number):void {
			this.v = v;
		}
		
		public function get phasedValue():Number {
			return Math.sin(v);
		}
		
		public function get absPhasedValue():Number {
			return Math.abs(phasedValue);
		}
	}
}
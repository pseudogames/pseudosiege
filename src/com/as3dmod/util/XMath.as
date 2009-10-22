package com.as3dmod.util {

	public class XMath {
	
		public static function normalize(start:Number, end:Number, val:Number):Number
		{
			var range:Number = end - start;
			var normal:Number;
		 
			if (range == 0) {
				normal = 1;
			} else {
				normal = (Math.min (Math.max ((val - start) / end, 0.0), 1.0));
			}
	
			return normal;
		}
	}
}

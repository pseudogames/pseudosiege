package com.as3dmod.modifiers {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.geom.Point;
	
	import com.as3dmod.IModifier;
	import com.as3dmod.core.Modifier;
	import com.as3dmod.core.VertexProxy;	
	
	/**
	 * 	<b>Perlin modifier.</b>
	 * 
	 *  Generates a perlin noise bitmap and displaces vertices 
	 *  based on the color value of each pixel of the noise map.
	 */
	public class Perlin extends Modifier implements IModifier {
		
		private var b:BitmapData = null;
		private var off:Number;
		private var frc:Number;
		private var seed:Number;
		
		private var start:Number = 0;
		private var end:Number = 0;
		
		public function Perlin(f:Number=1) {
			frc = f;
			b = new BitmapData(25, 11);
			off = 0;
			seed = Math.random() * 1000;
		}
		
		public function setFalloff(start:Number=0, end:Number=1):void {
			this.start = start;
			this.end = end;
		}
		
		public function set force(f:Number):void {
			frc = f;
		}
		
		/**
		 * Returns a previes of the perlin noise source bitmapData
		 * 
		 * @deprecated
		 * @param s blAH
		 * @return bitmap Bitmap object that can be attached to a display list. Contains the bitmapData used a the perlin noise source.
		 */
		public function get previev():Bitmap {
			var pr:Bitmap = new Bitmap(b);
			pr.scaleX = pr.scaleY = 4;
			return pr;
		}
		
		public function get force():Number {
			return frc;
		}
		
		/**
		 * Returns a previes of the perlin noise source bitmapData
		 * 
		 * @deprecated
		 * @param s blAH
		 * @return bitmap Bitmap object that can be attached to a display list. Contains the bitmapData used a the perlin noise source.
		 */
		public function apply():void {
			var p:Point = new Point(off++, 0);
			b.perlinNoise(25, 11, 1, seed, false, true, BitmapDataChannel.RED, true, [p, p, p]);
			
			var vs:Array = mod.getVertices();
			var vc:int = vs.length;
			
			for (var i:int = 0; i < vc; i++) {
				var v:VertexProxy = vs[i] as VertexProxy;
				
                var py:int = Math.round(v.getRatio(mod.maxAxis) * 24);
                var px:int = Math.round(v.getRatio(mod.midAxis) * 10);

                var vzpos:Number = b.getPixel(py, px) & 0xff;
				
				var fa:Number = v.getRatio(mod.maxAxis);
				if(start < end) {
					if (fa < start) fa = 0;
					if (fa > end) fa = 1;
				} else if(start > end) {
					fa = 1 - fa;
					if (fa > start) fa = 0;
					if (fa < end) fa = 1;
				} else {
					fa = 1;
				}
				
                v.setValue(mod.minAxis, v.getValue(mod.minAxis) + (128 - vzpos) * frc * fa);
            }
		}
	}
}
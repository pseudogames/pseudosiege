/* 
 * PROJECT: FLARManager
 * http://transmote.com/flar
 * Copyright 2009, Eric Socolofsky
 * --------------------------------------------------------------------------------
 * This work complements FLARToolkit, developed by Saqoosha as part of the Libspark project.
 *	http://www.libspark.org/wiki/saqoosha/FLARToolKit
 * FLARToolkit is Copyright (C)2008 Saqoosha,
 * and is ported from NYARToolkit, which is ported from ARToolkit.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this framework; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 * 
 * For further information please contact:
 *	<eric(at)transmote.com>
 *	http://transmote.com/flar
 * 
 */

package com.transmote.flar.utils.geom {
	
	import alternativa.types.Matrix3D;
	
	import org.libspark.flartoolkit.core.types.matrix.FLARDoubleMatrix34;
	
	/**
	 * @author	Eric Socolofsky
	 * @url		http://transmote.com/flar
	 */
	public class FLARAlternativaGeomUtils {
		
		/**
		 * convert a FLARToolkit matrix to an Alternativa3D matrix.
		 * @param	fm			FLARToolkit FLARDoubleMatrix34 to convert.
		 * @param	bMirror		if true, this method will flip the resultant matrix horizontally (along the y-axis).
		 * @return				Alternativa Matrix3D generated from the FLARToolkit matrix.
		 */
		public static function convertFLARMatrixToAlternativaMatrix (fm:FLARDoubleMatrix34, bMirror:Boolean=true) :Matrix3D {
			if (bMirror) {
				return new alternativa.types.Matrix3D(
					-fm.m00,	fm.m01,		-fm.m02,	-fm.m03,
					fm.m10,		-fm.m11,	fm.m12,		fm.m13,
					fm.m20,		-fm.m21,	fm.m22,		fm.m23
				);
			} else {
				return new alternativa.types.Matrix3D(
					fm.m00,		fm.m01,		fm.m02,		fm.m03,
					fm.m10,		fm.m11,		fm.m12,		fm.m13,
					fm.m20,		fm.m21,		fm.m22,		fm.m23
				);
			}
		}
		
		public function FLARAlternativaGeomUtils () {}
	}
}
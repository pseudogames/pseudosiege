/**
 * WOW-Engine AS3 3D Physics Engine, http://www.wow-engine.com
 * Copyright (c) 2007-2008 Seraf ( Jerome Birembaut ) http://seraf.mediabox.fr
 * 
 * Based on APE by Alec Cove , http://www.cove.org/ape/
 *       & Sandy3D by Thomas Pfeiffer, http://www.flashsandy.org/
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * 
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 
 * 1. The origin of this software must not be misrepresented; you must not
 * claim that you wrote the original software. If you use this software
 * in a product, an acknowledgment in the product documentation would be
 * appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 * misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
*/

package fr.seraf.wow.structure
{
	import fr.seraf.wow.primitive.WParticle;
	
	/**
	* ParticleNode class
	*
	* @author Thomas Pfeiffer - kiroukou
	* @version 0.1
	* @date 22 March 2008
	**/
	public final class ParticleNode
	{
		public var particle:WParticle;
		public var next:ParticleNode = null;
		//public var previous:ParticuleNode = null;
	
		public function ParticleNode( p_oValue:WParticle, p_oNext:ParticleNode )
		{
			particle = p_oValue;
			next = p_oNext;
		}
		
		public function toString():String
		{
			return "particle:"+particle+", next:"+next;
		}
	}
}
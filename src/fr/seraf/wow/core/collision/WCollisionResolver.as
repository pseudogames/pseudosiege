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
/*
* TODO : handle collision
*/
package fr.seraf.wow.core.collision {

	import fr.seraf.wow.core.collision.WCollision;
	import fr.seraf.wow.primitive.WParticle;
	import fr.seraf.wow.core.data.WVector;
	import fr.seraf.wow.math.WVectorMath;
		import fr.seraf.wow.events.WOWEvent;
		

	// NEED TO EXCLUDE VELOCITY CALCS BASED ON collisionResponseMode
	internal final class WCollisionResolver {
		
		internal static function resolveParticleParticle(
				pa:WParticle, 
				pb:WParticle, 
				normal:WVector, 
				depth:Number):void {
				
			pa.curr.copy(pa.samp);
     		pb.curr.copy(pb.samp);
     		
			var mtd:WVector = WVectorMath.scale(normal,depth);
			var te:Number = pa.elasticity + pb.elasticity;
			 var sumInvMass:Number = pa.invMass + pb.invMass;
			  
			// the total friction in a collision is combined but clamped to [0,1]
		   // the total friction in a collision is combined but clamped to [0,1]
            var tf:Number = clamp(1 - (pa.friction + pb.friction), 0, 1);
		
			// get the total mass, and assign giant mass to fixed particles
		
			
			
			// get the collision components, vn and vt
			var ca:WCollision = pa.getComponents(normal);
			var cb:WCollision = pb.getComponents(normal);
		 
		 	// calculate the coefficient of restitution based on the mass  
			var vnA:WVector =WVectorMath.divEquals(WVectorMath.addVector(WVectorMath.scale(cb.vn,(te + 1) * pa.invMass),WVectorMath.scale(ca.vn,pb.invMass - te * pa.invMass)),sumInvMass);	
			var vnB:WVector =WVectorMath.divEquals(WVectorMath.addVector(WVectorMath.scale(ca.vn,(te + 1) * pb.invMass),WVectorMath.scale(cb.vn,pa.invMass - te * pb.invMass)),sumInvMass);	
			// apply friction to the tangental component
			ca.vt=WVectorMath.scale(ca.vt,tf);
			cb.vt=WVectorMath.scale(cb.vt,tf);
			
			// scale the mtd by the ratio of the masses. heavier particles move less
			var mtdA:WVector =WVectorMath.scale(mtd,pa.invMass / sumInvMass);

			var mtdB:WVector =WVectorMath.scale(mtd,-pb.invMass / sumInvMass);
			
			  // add the tangental component to the normal component for the new velocity 
            vnA=WVectorMath.addVector(vnA,ca.vt);
            vnB=WVectorMath.addVector(vnB,cb.vt);
            
			if (! pa.fixed) pa.resolveCollision(mtdA, vnA, normal, depth, -1);
			if (! pb.fixed) pb.resolveCollision(mtdB, vnB, normal, depth,  1);
			//
			var e:WOWEvent=new WOWEvent(WOWEvent.ON_COLLISION);
			e.particuleA=pa;
			e.particuleB=pb;
			e.normal=normal;
			e.depth=depth;
			pa.collisionHandler.dispatchEvent(e);
			pb.collisionHandler.dispatchEvent(e);
		}
		static function clamp(input:Number, min:Number, max:Number):Number {
        	if (input > max) return max;	
            if (input < min) return min;
            return input;
        } 
	}
}


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
package fr.seraf.wow.constraint{
	import fr.seraf.wow.primitive.WParticle;
	import fr.seraf.wow.core.data.WVector;
	import fr.seraf.wow.math.WVectorMath;

	/**
	 * A dynamic constraint class. 
	 * 
	 */
	public class WConstraint extends WBaseConstraint {

		//these should be private, but i am still testing it :)
		public var cType:String;
		public var p1:WParticle;
		public var p2:WParticle;
		public var minDist:Number;
		public var maxDist:Number;

		public var _breakpoint:Number;
		public var _broken:Boolean;
		public var restLen:Number;
		public var diff:Number;
		public var massAffect:Boolean;
		public var delta:WVector;
		public var deltaLength:Number;
		public var _stiffness:Number;





		/** 
		 *  WConstraint(type,p1:WParticles,p2:WParticles,ranges:Array)
		 *@param type valid values are ['rigid'|'spring'|'sticky'|'brakable']
		 *'rigid' uses params 'minDist' and 'maxDist' or simply 'dist'(which assisis to both min and max dist),
		  *
		 *note: the bigger rest distance will always be the max and the smaller the min
		 *
		 *WConstraint("spring",p1:WParticles,p2:WParticles,distance1:Number=currentdist, distance2:Number = distance1,stiffness:Number=.5)
		 *@param distance1 the rest distance
		 *@param distance2 the 2nd rest distance
		 *@param stiffness The strength of the spring. Valid values are between 0 and 1. Lower values
		 * result in softer springs. Higher values result in stiffer, stronger springs.
		 *note: the bigger distance will always be the max and the smaller the min
		*
		 *note: use swap() to swap out the WParticles, may be usefull in the future.
		 *
		 */
		public function WConstraint(type:String,p1:WParticle,p2:WParticle) {
			this.p1=p1;
			this.p2=p2;
			this.cType = type;
			super(.5);

			/*
			switch (type) {
			case "rigid" :
			_stiffness = 1;
			break;
			case "spring" :
			_stiffness = .5;
			break;
			case "breakable" :
			_stiffness = .8;
			break;
			case "sticky" :
			_stiffness = .5;
			break;
			default :
			type="rigid";
			_stiffness = 1;
			}
			*/
			this.deltaLength=WVectorMath.distance(p1.curr,p2.curr);
			this.minDist=deltaLength;
			this.maxDist=deltaLength;
			this.massAffect = false;
			//the break point is 1/10 of the current distance because it had to be something and this seemed good enough
			this._breakpoint=10000000000;
			this._broken=false;
			this.delta=WVectorMath.sub(p1.curr,p2.curr);
			this.deltaLength=deltaLength;
			checkParticlesLocation();
		}

		/**
		 * The stiffness of the constraint. Higher values result in result in 
		 * stiffer constraints. Values should be greater than 0 and less than or 
		 * equal to 1. Depending on the situation, setting constraints to very high 
		 * values may result in instability or unwanted energy.
		 */
		public function get rotation():Number {
			return Math.atan2(delta.y,delta.x);
		}
		public function get rotationZ():Number {
			return Math.atan2(delta.x,delta.y);
		}
		public function get contraintType():String {
			return cType;
		}
		public function set contraintType(t:String):void {
			cType = t;
			if (cType == 'rigid' ||cType == 'spring') {
				_broken = false;
			}
		}
		public function get rotationY():Number {
			return Math.atan2(delta.x,delta.z);
		}
		public function get rotationX():Number {
			return Math.atan2(delta.y,delta.z);
		}
		public function get center():WVector {

			return WVectorMath.divEquals(WVectorMath.addVector(p1.curr,p2.curr),2);
		}
		/* The x position of this particle 1
		 */
		public function get pxp1():Number {
			return p1.px;
		}
		/* The y position of this particle 1
		 */
		public function get pyp1():Number {
			return p1.py;
		}
		/* The z position of this particle 1
		 */
		public function get pzp1():Number {
			return p1.pz;
		}
		/* The x position of this particle 1
		 */
		public function get pxp2():Number {
			return p2.px;
		}
		/* The y position of this particle 1
		 */
		public function get pyp2():Number {
			return p2.py;
		}
		/* The z position of this particle 1
		 */
		public function get pzp2():Number {
			return p2.pz;
		}
		/**
		 * The <code>restLength</code> property sets the length of SpringConstraint. This value will be
		 * the distance between the two particles unless their position is altered by external forces. The
		 * SpringConstraint will always try to keep the particles this distance apart.
		 */
		public function get max():Number {
			return this.maxDist;
		}
		public function set max(r:Number) {
			// saftey feature to swap min and max distances

			if (r < minDist) {
				maxDist = minDist;
				minDist = r;
			} else {
				maxDist=r;
			}
		}
		public function get min():Number {
			return this.minDist;
		}
		public function set min(r:Number) {

			// saftey feature to swap min and max distances

			if (r > maxDist) {
				minDist = maxDist;
				maxDist = r;
			} else {
				minDist=r;
			}
		}
		public override function get stiffness():Number {
			return this._stiffness;
		}

		public override function set stiffness(s:Number):void {
			this._stiffness=s;
		}

		public function get breakpoint():Number {
			return this._breakpoint;
		}
		public function set breakpoint(s:Number):void {
			this._breakpoint=s;
		}
		public function get broken():Boolean {
			return this._broken;
		}
		public function set broken(s:Boolean):void {
			this._broken=s;
		}
		/**
		 */
		public function get massAffected():Boolean {
			return this.massAffect;
		}
		/**
		 */
		public function set massAffected(r:Boolean):void {
			this.massAffect=r;
		}
		/**
		 * Returns true if the passed particle is one of the particles specified in the constructor.
		 */
		public function isConnectedTo(p:WParticle):Boolean {
			return (p == p1 || p == p2);
		}

		public function swap():void {
			var t=p1;
			p1=p2;
			p2=t;
		}
		public override function resolve():void {
			if (p1.fixed && p2.fixed) {
				return;
			}
			if (_broken && this.cType != "sticky") {
				return;
			}
			delta=WVectorMath.sub(p1.curr,p2.curr);
			deltaLength=WVectorMath.distance(p1.curr,p2.curr);

			if (deltaLength > maxDist) {
				restLen=maxDist;
			} else if (deltaLength < minDist) {
				restLen=minDist;
			} else {
				return;
			}
			if (this.cType == "breakable" || this.cType == "sticky" ) {
				if (Math.abs(deltaLength-restLen) > _breakpoint) {
					_broken = true;
					return;
				} else if (this.cType == "sticky") {
					_broken = false;
				}
			}
			//var d2: Number = stiffness * ( d1 - restLength ) / d1;
			if (cType != "rigid") {
				diff  =_stiffness * ( deltaLength - restLen ) / deltaLength;

				//dx *= d2;
				//dy *= d2;
				var dmd:WVector=WVectorMath.scale(delta,diff);
				var invM1:Number=p1.invMass;
				var invM2:Number=p2.invMass;
				var sumInvMass:Number=invM1 + invM2;
				if (! p1.fixed) {
					if (massAffect) {
						dmd=WVectorMath.scale(dmd,invM1 / sumInvMass);
					}
					p1.curr=WVectorMath.sub(p1.curr,dmd);
				}
				if (! p2.fixed ) {
					if (massAffect) {
						dmd=WVectorMath.scale(dmd,invM2 / sumInvMass);
					}
					p2.curr=WVectorMath.addVector(p2.curr,dmd);
				}
			} else {
				delta = WVectorMath.sub(p1.curr,p2.curr);
				var d:Number=WVectorMath.distance(p1.curr,p2.curr);
				diff=restLen/d;
				if (! p1.fixed && ! p2.fixed) {
					var d2:WVector = WVectorMath.scale(WVectorMath.scale(delta,-diff),.5);
					var c:WVector=center;
					p1.curr=WVectorMath.sub(c,d2);
					p2.curr=WVectorMath.addVector(c,d2);
					return;
				}
				if ( p1.fixed) {
					p2.curr=WVectorMath.sub(p1.curr,WVectorMath.scale(delta,diff));
					return;
				}
				if ( p2.fixed) {
					p1.curr=WVectorMath.addVector(p2.curr,WVectorMath.scale(delta,diff));
				}
			}
		}
		private function checkParticlesLocation():void {
			if (minDist > maxDist) {
				throw new Error("Min cannot be less than the max. Perhaps you should make 2 constraints.");
			}
			if (p1.curr.x == p2.curr.x && p1.curr.y == p2.curr.y&& p1.curr.z == p2.curr.z) {
				if (minDist > 0) {
					throw new Error("The two particles specified for a SpringContraint can't be at the same location AND a minDist > 0");
				}
			}
		}

	}
}
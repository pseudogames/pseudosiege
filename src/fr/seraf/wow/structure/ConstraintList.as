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
	import fr.seraf.wow.constraint.WBaseConstraint;
	
	/**
	* ConstraintList class
	*
	* @author Thomas Pfeiffer - kiroukou
	* @version 0.1
	* @date 22 March 2008
	**/
	public final class ConstraintList
	{
		public var head:ConstraintNode;
		
		public function ConstraintList()
		{
			head = null;
		}
		
		public function add( p_oElt:WBaseConstraint ):ConstraintNode
		{
        	head = new ConstraintNode( p_oElt, head );
        	return head;
    	}
    	
    	public function toArray():Array
    	{
    		var l_aList:Array = new Array();
    		var l_oNode:ConstraintNode = head;
			while( l_oNode != null ) 
			{
			    l_aList.push( l_oNode.constraint );
			    l_oNode = l_oNode.next;
			}
			// --
			return l_aList;
    	}
    	
    	public function removeNode( p_oElt:ConstraintNode ):Boolean
    	{
    		if( p_oElt == head )
    		{
    			head = head.next;
    			return true;
    		}
    		else
    		{
    			var l_oPrevious:ConstraintNode = null;
    			var l_oNode:ConstraintNode = head;
				while( l_oNode != null ) 
				{
				    if( l_oNode == p_oElt )
				    {
				    	if( l_oNode.next )
				    		l_oPrevious.next = l_oNode.next;
				    	else
				    		l_oPrevious.next = null;
				    	// --
				    	return true;
				    }
				    // --
				    l_oPrevious = l_oNode;
				    l_oNode = l_oNode.next;
				}
    		}
    		return false;
    	}
    	
    	public function removeValue( p_oElt:WBaseConstraint ):Boolean
    	{
    		if( p_oElt == head.constraint )
    		{
    			head = head.next;
    			return true;
    		}
    		else
    		{
    			var l_oPrevious:ConstraintNode = null;
    			var l_oNode:ConstraintNode = head;
				while( l_oNode != null ) 
				{
				    var l_oElt:WBaseConstraint = l_oNode.constraint;
				    // --
				    if( l_oElt == p_oElt )
				    {
				    	if( l_oNode.next )
				    		l_oPrevious.next = l_oNode.next;
				    	else
				    		l_oPrevious.next = null;
				    	// --
				    	return true;
				    }
				    // --
				    l_oPrevious = l_oNode;
				    l_oNode = l_oNode.next;
				}
    		}
    		return false;
    	}
	}
}
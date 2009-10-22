package com.as3dmod {
	import com.as3dmod.core.MeshProxy;		

	public interface IModifier {

		function setModifiable(mod:MeshProxy):void;

		function apply():void;
	}
}
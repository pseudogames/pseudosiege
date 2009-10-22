package com.as3dmod.plugins {
	import flash.utils.getDefinitionByName;
	
	import com.as3dmod.core.MeshProxy;	

	public class PluginFactory {

		public static function getMeshProxy(lib3d:Library3d):MeshProxy {
			var MeshProxyClass:Class = getDefinitionByName(lib3d.meshClass) as Class;
			return new MeshProxyClass();
		}
	}
}
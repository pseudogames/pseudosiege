package com.as3dmod.plugins {

	/**
	 * 	Library 3D represents a 3D engine inside AS3Dmod. 
	 *  This class should be extended so that its properties 
	 *  return correct values for the given engine.
	 * 
	 * 	@see com.as3dmod.ModifierStack
	 */
	public class Library3d {
		
		/**
		 *  The id of the 3d engine. Usually the name: Papervision3d, Away3d, etc...
		 */
		public function get id():String {
			return "";
		}
		
		/**
		 * 	The qualified class name that represents a mesh in the 3d engine
		 */
		public function get meshClass():String {
			return "";
		}
		
		/**
		 * 	The qualified class name that represents a vertex in the 3d engine
		 */
		public function get vertexClass():String {
			return "";
		}
	}
}
/**
 * Copyright (c) 2008 Bartek Drozdz (http://www.everydayflash.com)
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * Same license applies to every file in this package and its subpackages.  
 */
package com.as3dmod {
	import com.as3dmod.IModifier;
	import com.as3dmod.core.MeshProxy;
	import com.as3dmod.plugins.Library3d;
	import com.as3dmod.plugins.PluginFactory;	

	/**
	 * <p><h2>Modifier Stack</h2>
	 * 
	 * <p>The Modifier Stack is the base of AS3Dmod. It hold a reference to the mesh being modified and an array of modifiers. 
	 * 
	 * <p>Author: <a href="http://www.everydayflash.com">Bartek Drozdz</a>
	 * 
	 * <p>Version: 0.1
	 */
	public class ModifierStack  {
		
		private var lib3d:Library3d;
		private var baseMesh:MeshProxy;
		private var stack:Array;
		
		/**
		 * @param	lib3d A instance of a class implementing com.as3dmod.plugins.Library3d for the specific engine
		 * @param	mesh A mesh. The type of the mesh will be depending on the library used. 
		 * 			Example: for PV3D it should be an instance of com.as3dmod.plugins.pv3d.Pv3dMesh or of one of its subclasses.  
		 */
		public function ModifierStack(lib3d:Library3d, mesh:*) {
			this.lib3d = lib3d;
			baseMesh = PluginFactory.getMeshProxy(lib3d);
			baseMesh.setMesh(mesh);
			baseMesh.analyzeGeometry();
			stack = new Array();
		}
		
		/**
		 * The mesh that this stack is operating on. 
		 * 
		 * @see	com.as3dmod.core.MeshProxy
		 */
		public function get mesh():MeshProxy {
			return baseMesh;
		}
		
		/**
		 * 
		 * @param	mod A modifier. Modifiers are applied in the order they are added to the stack. 
		 * 			The first one added will be the first one applied to the mesh.
		 */
		public function addModifier(mod:IModifier):void {
			mod.setModifiable(baseMesh);
			stack.push(mod);
		}
		
		/**
		 * 	Applies all the modifiers in the stack to the mesh. 
		 * 
		 * 	Each time <code>apply()</code> is invoked, all the changes to the mesh geometry made by a former 
		 * 	call to this method are cleared and the modifiers are applied again to the original mesh or the 
		 * 	mesh resulting from the last call of the <code>collapse()</code> method.
		 * 
		 * 	@see #collapse()
		 */
		public function apply():void {
			baseMesh.resetGeometry();
			for (var i:int = 0; i < stack.length; i++) {
				(stack[i] as IModifier).apply();
			}
		}
		
		/**
		 * 	Collapses the stack. 
		 * 
		 * 	Collapsing means that all the modifiers are applied and then removed from the stack. 
		 * 	The geometry of the mesh is thus modified permanently, and there is now way to get back
		 * 	to it's original shape.
		 */
		public function collapse():void {
			apply();
			baseMesh.collapseGeometry();
			stack = new Array();
		}
		
		/**
		 * 	Clears the stack. 
		 * 
		 * 	Removes all the elements from the stack.
		 */
		public function clear():void {
			stack = new Array();
		}
	}
}






















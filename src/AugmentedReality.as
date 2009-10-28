package {
	import com.transmote.flar.FLARManager;
	import com.transmote.flar.marker.FLARMarker;
	import com.transmote.flar.marker.FLARMarkerEvent;
	import com.transmote.flar.utils.geom.FLARPVGeomUtils;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.libspark.flartoolkit.support.pv3d.FLARCamera3D;
	import org.papervision3d.lights.PointLight3D;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.parsers.DAE;
	import org.papervision3d.render.LazyRenderEngine;
	import org.papervision3d.scenes.Scene3D;
	import org.papervision3d.view.Viewport3D;

    import org.papervision3d.objects.primitives.Cube;
	import org.papervision3d.materials.shadematerials.FlatShadeMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	
	/**
	 * FLARManager_Tutorial3D demonstrates how to display a Collada-formatted model
	 * using FLARManager, FLARToolkit, and Papervision3D. 
	 * see the accompanying tutorial writeup here:
	 * http://words.transmote.com/wp/flarmanager/inside-flarmanager/loading-collada-models/
	 * 
	 * the collada model used for this example, scout.dae, was produced by Tom Tallian:
	 * http://tomtallian.com
	 * 
	 * @author	Eric Socolofsky
	 * @url		http://transmote.com/flar
	 */
	public class AugmentedReality extends Sprite {
		private var flarManager:FLARManager;
		
		private var scene3D:Scene3D;
		private var camera3D:FLARCamera3D;
		private var viewport3D:Viewport3D;
		private var renderEngine:LazyRenderEngine;
		private var pointLight3D:PointLight3D;
		
		private var models:Vector.<DisplayObject3D>;
        private var num_markers:int;
		
		
		public function AugmentedReality () {
			// pass the path to the FLARManager xml config file into the FLARManager constructor.
			// FLARManager creates and uses a FLARCameraSource by default.
			// the image from the first detected camera will be used for marker detection.
			this.flarManager = new FLARManager();
			
			// pass the path to the FLARManager config file into FLARManager.initFromFile.
			this.flarManager.initFromFile("marker/flarConfig.xml");

            this.num_markers = 12; // markers on the config // FIXME pick from this.flarManager somehow
            this.models = new Vector.<DisplayObject3D>();
            this.flarManager.markerRemovalDelay = 12; // frames
			
			// add FLARManager.flarSource to the display list to display the video capture.
			this.addChild(Sprite(this.flarManager.flarSource));
			
			// begin listening for FLARMarkerEvents.
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_ADDED, this.onMarkerChange);
			//this.flarManager.addEventListener(FLARMarkerEvent.MARKER_UPDATED, this.onMarkerChange);
			this.flarManager.addEventListener(FLARMarkerEvent.MARKER_REMOVED, this.onMarkerChange);
			
			// wait for FLARManager to initialize before setting up Papervision3D environment.
			this.flarManager.addEventListener(Event.INIT, this.onFlarManagerInited);
		}
		
		private function onFlarManagerInited (ev:Event) :void {
			this.flarManager.removeEventListener(Event.INIT, this.onFlarManagerInited);
			
			this.scene3D = new Scene3D();
			
			// initialize FLARCamera3D with parsed camera parameters.
			this.camera3D = new FLARCamera3D(this.flarManager.cameraParams);
			
			this.viewport3D = new Viewport3D(this.stage.stageWidth, this.stage.stageHeight);
			this.addChild(this.viewport3D);
			
			this.renderEngine = new LazyRenderEngine(this.scene3D, this.camera3D, this.viewport3D);
			
			this.pointLight3D = new PointLight3D();
			this.pointLight3D.x = 1000;
			this.pointLight3D.y = 1000;
			this.pointLight3D.z = -1000;
			
/*
			// load the model.
			// (this model has to be scaled and rotated to fit the marker; every model is different.)
			var base_model:DAE = new DAE(true, "model", true);
			base_model.load("model/scout.dae");
			base_model.rotationX = 90;
			base_model.rotationZ = 90;
			base_model.scale = 0.5;
            var model:DisplayObject3D = new DisplayObject3D();
            model.addChild(base_model);
            model.visible = false;
            this.models.push(model);
            this.scene3D.addChild(model);
*/

			// create a container for the model, that will accept matrix transformations.
            for(var i:int=0; i<num_markers; ++i)
            {
                var fmat:FlatShadeMaterial = new FlatShadeMaterial( this.pointLight3D, 
                    Math.floor(Math.random()*0xffffff), 
                    Math.floor(Math.random()*0xffffff)
                ); 					
				var cube:Cube = new Cube( new MaterialsList( {all: fmat} ) , 20 , 20 , 20 ); 
                cube.z = 10;

                var model:DisplayObject3D = new DisplayObject3D();
                model.addChild(cube);
                model.visible = false;

                this.models.push(model);
                this.scene3D.addChild(model);
            }
			
			this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		private function onMarkerChange (ev:FLARMarkerEvent) :void {
			trace("["+ev.marker.patternId+"] "+ev.type);
			this.models[ev.marker.patternId].visible = ev.type !=  FLARMarkerEvent.MARKER_REMOVED;
		}
		
		private function onEnterFrame (ev:Event) :void {
			// apply the FLARToolkit transformation matrix to the Cube.
            for(var i:int=0; i<this.flarManager.activeMarkers.length; ++i)
            {
				this.models[
                    this.flarManager.activeMarkers[i].patternId
                ].transform = FLARPVGeomUtils.convertFLARMatrixToPVMatrix(
                    this.flarManager.activeMarkers[i].transformMatrix
                );
			}
			
			// update the Papervision3D view.
			this.renderEngine.render();
		}
	}
}

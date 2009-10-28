package {
	import flash.display.Sprite;
	import AugmentedReality;

	[SWF(width="320", height="240", frameRate="12", backgroundColor="#000000")]

	public class PseudoSiege extends Sprite {
		
		public function PseudoSiege () {
			this.addChild(new AugmentedReality());
		}
	}
}

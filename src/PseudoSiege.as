package {
	import flash.display.Sprite;
	import AugmentedReality;

	[SWF(width="640", height="480", frameRate="30", backgroundColor="#FFFFFF")]

	public class PseudoSiege extends Sprite {
		
		public function PseudoSiege () {
			this.addChild(new AugmentedReality());
		}
	}
}

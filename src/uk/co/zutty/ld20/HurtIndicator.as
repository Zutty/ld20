package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class HurtIndicator extends Entity {
		
		private const MAX_ALPHA:Number = 0.6;
		
		private var img:Image;
		
		public function HurtIndicator() {
			super();
			x = 0;
			y = 0;
			img = Image.createRect(FP.width, FP.height, 0xFF0000);
			graphic = img;
			img.alpha = 0;
			img.scrollX = 0;
			img.scrollY = 0;
		}
		
		public function setHurtPct(h:Number):void {
			img.alpha = MAX_ALPHA * h;
		}
	}
}
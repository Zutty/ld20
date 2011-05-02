package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	public class ScreenFade extends Entity {
		
		private const FADE_TIME:Number = 90;
		
		private var img:Image;
		private var diff:Number;
		
		public function ScreenFade() {
			super();
			x = 0;
			y = 0;
			img = Image.createRect(FP.width, FP.height, 0x000000);
			graphic = img;
			img.alpha = 0;
			img.scrollX = 0;
			img.scrollY = 0;
			diff = 0;
		}
		
		public function fadeIn():void {
			img.alpha = 1.0;
			diff = -1.0/FADE_TIME;
		}

		public function fadeOut():void {
			img.alpha = 0.0;
			diff = 1.0/FADE_TIME;
		}
		
		override public function update():void {
			if(diff != 0) {
				img.alpha += diff;
				if(img.alpha < 0) {
					img.alpha = 0;
				}
				if(img.alpha > 1) {
					img.alpha = 1;
				}
			}
		}
	}
}
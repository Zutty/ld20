package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class WinScreen extends World {
		public function WinScreen() {
			super();
			
			// Bg color
			var bg:Entity = new Entity();
			bg.graphic = Image.createRect(FP.width, FP.height, 0x9eaad5);
			add(bg);
			
			// Title text
			add(new GlowyText(FP.width/2, 200, "You escaped!", 48));
			
			// Continue text
			add(new GlowyText(FP.width/2, 380, "Press X to continue", 24));

		}
		
		override public function update():void {
			super.update();
			if(Input.pressed(Key.X)) {
				FP.world = new TitleScreen();
			}
		}
	}
}
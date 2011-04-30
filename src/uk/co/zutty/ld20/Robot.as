package uk.co.zutty.ld20
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Robot extends LD20Entity {

		private const SPEED:Number = 3;
		
		[Embed(source = '/data/robot.png')]
		private const ROBOT_IMAGE:Class;
		
		private var spritemap:Spritemap;

		public function Robot() {
			super();
			spritemap = new Spritemap(ROBOT_IMAGE, 32, 48);
			spritemap.add("up", [0]);
			spritemap.add("down", [1]);
			spritemap.add("left", [2]);
			spritemap.add("right", [3]);
			graphic = spritemap;
			spritemap.play("right");
			setHitbox(30, 30, -1, -17);
			type = "solid";
		}
	}
}
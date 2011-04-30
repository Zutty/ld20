package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends LD20Entity {
		
		private const SPEED:Number = 3;
		
		[Embed(source = '/data/man.png')]
		private const MAN_IMAGE:Class;
		
		private var spritemap:Spritemap;

		public function Player() {
			spritemap = new Spritemap(MAN_IMAGE, 32, 48);
			spritemap.add("up", [0]);
			spritemap.add("down", [1]);
			spritemap.add("left", [2]);
			spritemap.add("right", [3]);
			graphic = spritemap;
			spritemap.play("right");
			setHitbox(32, 48);
		}
		
		override public function update():void {
			if(Input.check(Key.LEFT)) {
				spritemap.play("left");
				moveBy(-SPEED, 0, "walls");
			} else if(Input.check(Key.RIGHT)) {
				spritemap.play("right");
				moveBy(SPEED, 0, "walls");
			}
			if(Input.check(Key.UP)) {
				spritemap.play("up");
				moveBy(0, -SPEED, "walls");
			} else if(Input.check(Key.DOWN)) {
				spritemap.play("down");
				moveBy(0, SPEED, "walls");
			}
		}
		
		/*private function moveBy(dx:Number, dy:Number):void {
			if(!collide("walls", x+dx, y+dy)) {
				x += dx;
				y += dy;
			}
		}*/
	}
}
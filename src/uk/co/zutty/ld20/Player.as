package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
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
			setHitbox(30, 30, -1, -17);
			//type = "solid";
		}
		
		override public function update():void {
			if(Input.check(Key.LEFT)) {
				spritemap.play("left");
				move(-SPEED, 0);
			} else if(Input.check(Key.RIGHT)) {
				spritemap.play("right");
				move(SPEED, 0);
			}
			if(Input.check(Key.UP)) {
				spritemap.play("up");
				move(0, -SPEED);
			} else if(Input.check(Key.DOWN)) {
				spritemap.play("down");
				move(0, SPEED);
			}
		}
		
		private function move(dx:Number, dy:Number):void {
			if(!collide("solid", x+dx, y+dy)) {
				x += dx;
				y += dy;
			}
		}
	}
}
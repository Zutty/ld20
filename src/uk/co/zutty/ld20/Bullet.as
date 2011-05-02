package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Bullet extends LD20Entity {
		
		private const SPEED:Number = 20;
		private const DAMAGE:Number = 2; 

		[Embed(source = '/data/bullet.png')]
		private const BULLET_IMAGE:Class;

		private var direction:Vector2D;
		private var spritemap:Spritemap;
		
		public function Bullet(x:Number, y:Number, dir:Vector2D) {
			super();
			this.x = x;
			this.y = y;
			direction = dir;

			spritemap = new Spritemap(BULLET_IMAGE, 6, 6);
			spritemap.add("bullet", [0, 1, 2, 3], 5, true);
			
			graphic = spritemap;
			spritemap.play("bullet");
			setHitbox(6, 6);
			type = "bullet";
		}
		
		override public function update():void {
			var e:Entity = collide("solid", x, y);
			if(e && !(e is Robot)) {
				destroy();
				if(e is Character) {
					(e as Character).hurt(DAMAGE);
				}
			}

			x += direction.x * SPEED;
			y += direction.y * SPEED;
		}
	}
}
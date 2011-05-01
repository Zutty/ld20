package uk.co.zutty.ld20
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Cat extends Character {
		
		[Embed(source = '/data/cat.png')]
		private const CAT_IMAGE:Class;
		
		private const STATE_CARRIED:Number = 0;
		private const STATE_SLEEP:Number = 1;
		private const STATE_SAT:Number = 2;
		
		private var spritemap:Spritemap;
		private var state:Number;

		public function Cat() {
			super();
			spritemap = new Spritemap(CAT_IMAGE, 32, 32);
			spritemap.add("sit", [8, 9, 10, 11], .07, true);
			spritemap.add("sleep", [12, 13, 14, 15], .05, true);
			
			graphic = spritemap;
			state = STATE_SLEEP;
			spritemap.play("sleep");
			setHitbox(30, 30, -1, -1);
			type = "cat";
		}
		
		public function pickUp():void {
			state = STATE_CARRIED;
			collidable = false;
			visible = false;
		}

		public function putDown(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
			spritemap.play("sit");
			state = STATE_SAT;
			collidable = true;
			visible = true;
		}
	}
}
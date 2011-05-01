package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Character extends LD20Entity {
		
		public function Character(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
		}
		
		protected function move(dx:Number, dy:Number):void {
			var c:Entity = collide("solid", x+dx, y+dy);
			if(!c || c == this) {
				x += dx;
				y += dy;
			}
		}
	}
}
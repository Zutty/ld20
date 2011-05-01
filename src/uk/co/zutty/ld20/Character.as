package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Character extends LD20Entity {
		
		protected var _health:Number;
		protected var _dead:Boolean;
		
		public function Character(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
			_health = 0;
		}
		
		protected function move(dx:Number, dy:Number):void {
			var c:Entity = collide("solid", x+dx, y+dy);
			if(!c || c == this) {
				x += dx;
				y += dy;
			}
		}
		
		public function get dead():Boolean {
			return _dead;	
		}
		
		public function die():void {}
		
		public function get health():Number {
			return _health;
		}
		
		public function hurt(dmg:Number):Boolean {
			_health -= dmg;
			
			if(_health <= 0) {
				_health = 0;
				_dead = true;
				die();
				return true;
			}
			return false;
		}
	}
}
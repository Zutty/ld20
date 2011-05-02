package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	
	public class Character extends LD20Entity {
		
		protected var _health:Number;
		protected var _dead:Boolean;
		protected var _speechBubble:SpeechBubble;
		
		public function Character(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) {
			super(x, y, graphic, mask);
			_health = 0;
		}
		
		protected function move(dx:Number, dy:Number, moveCb:Function = null):void {
			if(!_dead) {
				var c:Entity = collide("solid", x+dx, y+dy);
				if(!c || c == this) {
					x += dx;
					y += dy;
				} else if(c && moveCb != null) {
					moveCb(c);
				}
			}
		}
		
		public function message(str:String):void {
			doSpeechBubble(str, 100, 0xd6c756);
		}

		public function say(str:String, duration:uint = 80):void {
			doSpeechBubble(str, duration, 0xFFFFFF);
		}
		
		public function sayAny(strs:Array):void {
			say(strs[Math.round(Math.random() * strs.length)] as String);
		}

		private function doSpeechBubble(str:String, duration:uint, color:uint):void {
			if(_speechBubble == null) {
				_speechBubble = new SpeechBubble(this, str, duration, color)
				FP.world.add(_speechBubble);
			} else {
				_speechBubble.reset(str, duration, color);
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
				die();
				_dead = true;
				return true;
			}
			return false;
		}
	}
}
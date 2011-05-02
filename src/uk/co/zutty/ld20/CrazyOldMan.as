package uk.co.zutty.ld20
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class CrazyOldMan extends Character {
		
		private const ACTIVATION_RANGE:Number = 90;
		private const GREETING_RANGE:Number = 120;
		private const SCRIPT_DELAY:uint = 200;
		private const PRE_SCRIPT:Array = ["Psst", "Hey, you", "Over here"];
		private const SCRIPT:Array = ["I'm just a crazy old man", "You've got to escape", "You can't go alone, its dangerous", "but I'm too old and too crazy", "Take the kitty in cell 4", "the Deathbots love cats", "but dont let them touch you", "", "Go!"];
		
		[Embed(source = '/data/crazyoldman.png')]
		private const CRAZYOLDMAN_IMAGE:Class;
		
		private var spritemap:Spritemap;
		private var preActivate:Boolean;
		private var activated:Boolean;
		private var greeted:Boolean;
		private var scriptTick:uint;
		private var scriptPos:int;
		
		public function CrazyOldMan() {
			super();
			
			spritemap = new Spritemap(CRAZYOLDMAN_IMAGE, 32, 48);
			spritemap.add("up", [0]);
			spritemap.add("down", [1]);
			spritemap.add("left", [2]);
			spritemap.add("right", [3]);
			graphic = spritemap;
			spritemap.play("right");
			setHitbox(30, 30, -1, -17);
			type = "solid";

			preActivate = true;
			activated = false;
			scriptTick = SCRIPT_DELAY*2/5;
		}
		
		public function trigger():void {
			preActivate = false;
			activated = true;
			scriptPos = -1;
			scriptTick = 0;
		}
		
		override public function update():void {
			super.update();
			scriptTick++;
			
			if(gameworld) {
				var p:Player = gameworld.player;
				var dx:Number = p.x - x;
				var dy:Number = p.y - y;
				face(Vector2D.unitVector(x, y, p.x, p.y));
				
				if(!greeted && Math.sqrt(dx*dx + dy*dy) <= GREETING_RANGE) {
					p.say("Who are you?");
					greeted = true;
				}
				if(!activated && Math.sqrt(dx*dx + dy*dy) <= ACTIVATION_RANGE) {
					trigger();
				}
			}
			
			if(preActivate) {
				if(scriptTick >= SCRIPT_DELAY) {
					scriptTick = 0;
					sayAny(PRE_SCRIPT);
				}
			}
			
			if(activated) {
				if(Math.floor(scriptTick / SCRIPT_DELAY) > scriptPos) {
					scriptPos++;
					say(SCRIPT[scriptPos], 180);
				}
			}
		}
		
		private function face(dir:Vector2D):void {
			if(Math.abs(dir.x) > Math.abs(dir.y)) {
				if(dir.x < 0) {
					spritemap.play("left");
				} else {
					spritemap.play("right");
				}
			} else {
				if(dir.y < 0) {
					spritemap.play("up");
				} else {
					spritemap.play("down");
				}
			}
		}
	}
}
package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends Character {
		
		private const MOVE_EXPLN_TIME:uint = 200;
		
		private const SPEED:Number = 3;
		private const MAX_HEALTH:Number = 5;
		private const HEALTH_RECHARGE:Number = 0.01;
		
		[Embed(source = '/data/man.png')]
		private const MAN_IMAGE:Class;
		[Embed(source = '/data/deadguy.png')]
		private const DEAD_IMAGE:Class;
		
		private var spritemap:Spritemap;
		private var deadSprite:Image;
		private var stopAnim:String;
		private var _kitty:Cat;
		private var gKeyExplained:Boolean;
		private var moveExplained:Boolean;
		private var moveExplnTick:uint;

		public function Player() {
			spritemap = new Spritemap(MAN_IMAGE, 32, 48);
			// Standing
			spritemap.add("up_stand", [0]);
			spritemap.add("down_stand", [5]);
			spritemap.add("left_stand", [10]);
			spritemap.add("right_stand", [15]);

			// Walking
			spritemap.add("up_walk", [1,2,3,4], 0.25, true);
			spritemap.add("down_walk", [6,7,8,9], 0.25, true);
			spritemap.add("left_walk", [11,12,13,14], 0.25, true);
			spritemap.add("right_walk", [16,17,18,19], 0.25, true);
			
			// Standing with kitty
			spritemap.add("up_stand_kitty", [20]);
			spritemap.add("down_stand_kitty", [25]);
			spritemap.add("left_stand_kitty", [30]);
			spritemap.add("right_stand_kitty", [35]);
			
			// Walking with kitty
			spritemap.add("up_walk_kitty", [21,22,23,24], 0.25, true);
			spritemap.add("down_walk_kitty", [26,27,28,29], 0.25, true);
			spritemap.add("left_walk_kitty", [31,32,33,34], 0.25, true);
			spritemap.add("right_walk_kitty", [36,37,38,39], 0.25, true);

			// Dead
			deadSprite = new Image(DEAD_IMAGE);

			graphic = spritemap;
			stopAnim = "right_stand";
			spritemap.play(stopAnim);
			setHitbox(30, 30, -1, -17);
			type = "solid";
			_kitty = null;
			_health = MAX_HEALTH;
			gKeyExplained = false;
			moveExplained = false;
			moveExplnTick = 0;
		}

		public function get kitty():Cat {
			return _kitty;
		}
		
		public function set kitty(k:Cat):void {
			_kitty = k;
		}
		
		public function respawn():void {
			graphic = spritemap;
			_dead = false;
			_health = MAX_HEALTH;
		}
		
		override public function die():void {
			if(gameworld && !dead) {
				x -= 8;
				y += 16;
				graphic = deadSprite;
				if(_kitty) {
					dropKitty();
					_kitty = null;
				}
				gameworld.triggerRespawn();
			}
		}
		
		override public function update():void {
			super.update();
			
			// Health indicator
			_health = Math.min(MAX_HEALTH, _health + HEALTH_RECHARGE);
			if(gameworld) {
				gameworld.hurtIndicator.setHurtPct(1 - (_health / MAX_HEALTH));
			}			
			
			// Win condition
			if(collide("exit", x, y)) {
				gameworld.endLevel();
			}
			
			// Arrow key tutorial
			if(!moveExplained && ++moveExplnTick >= MOVE_EXPLN_TIME) {
				message("Use arrow keys to move");
				moveExplained = true;
			}

			// G key tutorial
			if(!gKeyExplained && collide("cat", x, y)) {
				message("Press G to pick up/drop kitty");
				gKeyExplained = true;
			}

			// Movement/animations
			var nextAnim:String = stopAnim;
			if(Input.check(Key.LEFT)) {
				moveExplained = true;
				nextAnim = "left_walk";
				stopAnim = "left_stand";
				move(-SPEED, 0);
			} else if(Input.check(Key.RIGHT)) {
				moveExplained = true;
				nextAnim = "right_walk";
				stopAnim = "right_stand";
				move(SPEED, 0);
			}
			if(Input.check(Key.UP)) {
				moveExplained = true;
				nextAnim = "up_walk";
				stopAnim = "up_stand";
				move(0, -SPEED);
			} else if(Input.check(Key.DOWN)) {
				moveExplained = true;
				nextAnim = "down_walk";
				stopAnim = "down_stand";
				move(0, SPEED);
			}
			
			// Apply the kitty if we have one
			if(_kitty) {
				nextAnim += "_kitty";
			}
			
			// Play the next anim
			spritemap.play(nextAnim);
			
			// Pick up/put down kitty
			if(Input.pressed(Key.G)) {
				var c:Cat = collide("cat", x, y) as Cat;
				if(!_kitty && c) {
					_kitty = c;
					c.pickUp();
				} else if(_kitty) {
					dropKitty();
					_kitty = c;
					if(c) {
						c.pickUp();
					}
				}
			}
		}
		
		private function dropKitty():void {
			_kitty.putDown(Math.round(x/32)*32, Math.round((y+16)/32)*32);;	
		}
	}
}
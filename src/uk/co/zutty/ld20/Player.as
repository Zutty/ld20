package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class Player extends Character {
		
		private const SPEED:Number = 3;
		private const MAX_HEALTH:Number = 5;
		private const HEALTH_RECHARGE:Number = 0.01;
		
		[Embed(source = '/data/man.png')]
		private const MAN_IMAGE:Class;
		
		private var spritemap:Spritemap;
		private var _kitty:Cat;

		public function Player() {
			spritemap = new Spritemap(MAN_IMAGE, 32, 48);
			spritemap.add("up", [0]);
			spritemap.add("down", [1]);
			spritemap.add("left", [2]);
			spritemap.add("right", [3]);
			graphic = spritemap;
			spritemap.play("right");
			setHitbox(30, 30, -1, -17);
			type = "solid";
			_kitty = null;
			_health = MAX_HEALTH;
		}

		public function get kitty():Cat {
			return _kitty;
		}
		
		public function set kitty(k:Cat):void {
			_kitty = k;
		}
		
		public function respawn():void {
			_dead = false;
			visible = true;
			collidable = true;
			_health = MAX_HEALTH;
		}
		
		override public function die():void {
			if(FP.world is GameWorld) {
				(FP.world as GameWorld).respawnPlayer();
				if(_kitty) {
					dropKitty();
				}
			}
		}
		
		override public function update():void {
			super.update();
			var gw:GameWorld = (FP.world is GameWorld) ? FP.world as GameWorld : null;
			
			_health = Math.min(MAX_HEALTH, _health + HEALTH_RECHARGE);
			if(gw) {
				gw.hurtIndicator.setHurtPct(1 - (_health / MAX_HEALTH));
			}			
			
			if(collide("exit", x, y)) {
				gw.endLevel();
			}
			
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
			_kitty.putDown(Math.round(x/32)*32, Math.round((y-16)/32)*32);;	
		}
	}
}
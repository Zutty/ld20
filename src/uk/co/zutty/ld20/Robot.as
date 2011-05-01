package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Robot extends Character {

		private const SPEED:Number = 1.5;
		private const WEAPON_RANGE:Number = 90;
		
		[Embed(source = '/data/robot.png')]
		private const ROBOT_IMAGE:Class;
		
		private var spritemap:Spritemap;
		private var waypoint:Waypoint;
		private var direction:Vector2D;
		private var targetting:Boolean;

		public function Robot() {
			super();
			spritemap = new Spritemap(ROBOT_IMAGE, 32, 48);
			spritemap.add("up", [0]);
			spritemap.add("down", [1]);
			spritemap.add("left", [2]);
			spritemap.add("right", [3]);
			graphic = spritemap;
			spritemap.play("right");
			setHitbox(30, 30, -1, -17);
			type = "solid";
			targetting = false;
		}
		
		public function goTo(waypoint:Waypoint):void {
			this.waypoint = waypoint;
			direction = Vector2D.unitVector(x, y, waypoint.x, waypoint.y);
			face(direction);
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

		override public function update():void {
			super.update();
			var shouldMove:Boolean = true;
			
			var t:LD20Entity = getTarget();
			if(t) {
				targetting = true;
				var tdir:Vector2D = Vector2D.unitVector(x, y, t.x, t.y);
				face(tdir);
				
				if(t is Player && (t as Player).kitty) {
					direction = tdir; 	
				} else {
					shouldMove = false;
				}
			} else {
				if(targetting) {
					goTo(waypoint);
					targetting = false;
				}
			}
			
			if(shouldMove) {
				if(waypoint != null) {
					if(waypoint.distanceTo(x, y) <= SPEED) {
						x = waypoint.x;
						y = waypoint.y;
						goTo(waypoint.next);
					} else {
						move(direction.x * SPEED, direction.y * SPEED);
					}
				}
			}
		}
		
		private function getTarget():LD20Entity {
			if(FP.world is GameWorld) {
				var w:GameWorld = (FP.world) as GameWorld;
				var player:Player = w.player;
				var dx:Number = player.x - x;
				var dy:Number = player.y - y;
				var inRange:Boolean = Math.sqrt(dx*dx + dy*dy) <= WEAPON_RANGE; 
				return inRange ? player : null;
			}
			return null;
		}
		
		/**
		 * Robots can only be in the robot area, defined by a mask with 
		 * collision type "robot_area".
		 */
		override protected function move(dx:Number, dy:Number):void {
			if(collide("robot_area", x+dx, y+dy)) {
				super.move(dx, dy);
			}
		}
	}
}
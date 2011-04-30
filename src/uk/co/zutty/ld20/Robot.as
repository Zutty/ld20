package uk.co.zutty.ld20
{
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Robot extends LD20Entity {

		private const SPEED:Number = 1.5;
		
		[Embed(source = '/data/robot.png')]
		private const ROBOT_IMAGE:Class;
		
		private var spritemap:Spritemap;
		private var waypoint:Waypoint;
		private var direction:Vector2D;

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
		}
		
		public function goTo(waypoint:Waypoint):void {
			this.waypoint = waypoint;
			direction = Vector2D.unitVector(x, y, waypoint.x, waypoint.y);
			if(Math.abs(direction.x) > Math.abs(direction.y)) {
				if(direction.x < 0) {
					spritemap.play("left");
				} else {
					spritemap.play("right");
				}
			} else {
				if(direction.y < 0) {
					spritemap.play("up");
				} else {
					spritemap.play("down");
				}
			}
		}

		override public function update():void {
			super.update();
			
			if(waypoint != null) {
				if(waypoint.distanceTo(x, y) <= SPEED) {
					x = waypoint.x;
					y = waypoint.y;
					goTo(waypoint.next);
				} else {
					x += direction.x * SPEED;
					y += direction.y * SPEED;
				}
			}
		}
	}
}
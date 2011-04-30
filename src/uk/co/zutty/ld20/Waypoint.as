package uk.co.zutty.ld20
{
	public class Waypoint extends Vector2D {
		
		public var next:Waypoint;
		
		public function Waypoint(x:Number, y:Number, next:Waypoint = null) {
			super(x, y);
			this.next = next;
		}
		
		public function distanceTo(px:Number, py:Number):Number {
			var dx:Number = px - x;
			var dy:Number = py - y;
			return Math.sqrt(dx*dx + dy+dy);
		}
	}
}
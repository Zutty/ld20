package uk.co.zutty.ld20
{
	public class Vector2D {
		
		public var x:Number;
		public var y:Number;
		
		public function Vector2D(x:Number, y:Number) {
			this.x = x;
			this.y = y;
		}
		
		public static function unitVector(ax:Number, ay:Number, bx:Number, by:Number):Vector2D {
			var x:Number = bx - ax;
			var y:Number = by - ay;
			var mag:Number = Math.sqrt(x*x + y*y);
			
			return new Vector2D(x/mag, y/mag);
		}
	}
}
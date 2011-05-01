package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class TitleScreen extends World {
		public function TitleScreen() {
			super();
			var e:Entity = new Entity();
			e.graphic = new Text("Press X to begin");
			add(e);
		}
		
		override public function update():void {
			if(Input.pressed(Key.X)) {
				FP.world = new GameWorld();
			}
		}
	}
}
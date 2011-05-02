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
			var et:Text = new Text("DEATHBOT LOVE");
			et.size = 48;
			e.graphic = et;
			e.width = et.width;
			e.height = et.height;
			e.x = (FP.width - e.width) / 2;
			e.y = 200;
			add(e);
			
			// Continue text
			var f:Entity = new Entity();
			var ft:Text = new Text("Press X to begin");
			ft.size = 20;
			f.graphic = ft;
			f.width = ft.width;
			f.height = ft.height;
			f.x = (FP.width - ft.width) / 2;
			f.y = 400;
			add(f);
		}
		
		override public function update():void {
			if(Input.pressed(Key.X)) {
				FP.world = new GameWorld();
			}
		}
	}
}
package uk.co.zutty.ld20
{
	import net.flashpunk.World;
	
	public class GameWorld extends World {
		
		private var player:Player;
		
		public function GameWorld() {
			var lvl:Level1 = new Level1();
			add(lvl.getLayer("floor"));
			add(lvl.getLayer("walls", true));
			
			var spawnPoint:Vector2D = lvl.getObjectPosition("objects", "spawn");
			player = new Player();
			player.goTo(spawnPoint);
			add(player);
			
			for each(var robotSpawn:Vector2D in lvl.getObjectPositions("objects", "robot")) {
				var robot:Robot = new Robot();
				robot.goTo(robotSpawn);
				add(robot);
			}
		}
	}
}
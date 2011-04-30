package uk.co.zutty.ld20
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class GameWorld extends World {
		
		private var player:Player;
		private var level:Level1;
		
		public function GameWorld() {
			level = new Level1();
			add(level.getLayer("floor"));
			add(level.getLayer("walls", true));
			
			var spawnPoint:Vector2D = level.getObjectPosition("objects", "spawn");
			player = new Player();
			player.setPos(spawnPoint);
			add(player);
			
			for each(var robotSpawn:Waypoint in level.getObjectWaypoints("objects", "robot")) {
				var robot:Robot = new Robot();
				robot.setPos(robotSpawn);
				robot.goTo(robotSpawn.next);
				add(robot);
			}
		}
		
		override public function update():void {
			super.update();
			
			// Move the camera
			FP.camera.x = Math.max(0, Math.min(level.width - FP.width, player.x - FP.width/2-16));
			FP.camera.y = Math.max(0, Math.min(level.height - FP.height, player.y - FP.height/2-24));
		}
	}
}
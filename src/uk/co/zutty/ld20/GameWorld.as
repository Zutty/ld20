package uk.co.zutty.ld20
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class GameWorld extends World {
		
		private var _player:Player;
		private var level:Level1;
		
		public function GameWorld() {
			level = new Level1();
			add(level.getLayer("floor"));
			add(level.getLayer("walls", true));
			add(level.getMask("exit"));
			add(level.getMask("robot_area"));
			
			var spawnPoint:Vector2D = level.getObjectPosition("objects", "spawn");
			_player = new Player();
			_player.setPos(spawnPoint);
			add(_player);
			
			for each(var robotSpawn:Waypoint in level.getObjectWaypoints("objects", "robot")) {
				var robot:Robot = new Robot();
				robot.setPos(robotSpawn);
				robot.goTo(robotSpawn.next);
				add(robot);
			}
		}
		
		public function get player():Player {
			return _player;
		}
		
		override public function update():void {
			super.update();
			
			// Move the camera
			FP.camera.x = Math.max(0, Math.min(level.width - FP.width, _player.x - FP.width/2-16));
			FP.camera.y = Math.max(0, Math.min(level.height - FP.height, _player.y - FP.height/2-24));
		}
	}
}
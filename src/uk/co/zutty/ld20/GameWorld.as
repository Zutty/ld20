package uk.co.zutty.ld20
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	
	public class GameWorld extends World {
		
		private const END_TIME:uint = 130;
		private const RESPAWN_TIME:uint = 90;
		
		private var _player:Player;
		private var spawnPoint:Vector2D;
		private var _targetable:Vector.<Character>;
		private var level:Level1;
		private var _hurtInd:HurtIndicator;
		private var _scrFade:ScreenFade;
		private var respawnTick:uint;
		private var levelEnded:Boolean;
		private var levelEndTick:uint;
		private var levelStarted:Boolean;
		
		public function GameWorld() {
			level = new Level1();
			add(level.getLayer("floor"));
			add(level.getLayer("walls", true));
			add(level.getMask("exit"));
			add(level.getMask("robot_area"));
			
			_targetable = new Vector.<Character>();
			
			spawnPoint = level.getObjectPosition("objects", "spawn");
			_player = new Player();
			_player.setPos(spawnPoint);
			add(_player);
			_targetable.push(_player);
			
			var comSpawn:Vector2D = level.getObjectPosition("objects", "crazyoldman");
			var crazyOldMan:CrazyOldMan = new CrazyOldMan();
			crazyOldMan.setPos(comSpawn);
			add(crazyOldMan);

			var catSpawn:Vector2D = level.getObjectPosition("objects", "cat");
			var cat:Cat = new Cat();
			cat.setPos(catSpawn);
			add(cat);
			_targetable.push(cat);

			for each(var robotSpawn:Waypoint in level.getObjectWaypoints("objects", "robot")) {
				var robot:Robot = new Robot();
				robot.setPos(robotSpawn);
				robot.goTo(robotSpawn.next);
				add(robot);
			}

			add(level.getLayer("ceiling"));
			
			_hurtInd = new HurtIndicator();
			add(_hurtInd);
			_scrFade = new ScreenFade();
			add(_scrFade);
			_scrFade.fadeIn();
			levelStarted = true;
			levelEnded = false;
		}
		
		public function get hurtIndicator():HurtIndicator {
			return _hurtInd;
		}
		
		public function get targetable():Vector.<Character> {
			return _targetable;
		}
		
		public function get player():Player {
			return _player;
		}
		
		public function triggerRespawn():void {
			respawnTick = 0;
		}

		public function respawnPlayer():void {
			_player.x = spawnPoint.x; 
			_player.y = spawnPoint.y;
			player.respawn();
		}

		public function endLevel():void {
			if(!levelEnded) {
				_scrFade.fadeOut();
				levelEndTick = 0;
			}
			levelEnded = true;
		}
		
		override public function update():void {
			super.update();
			
			if(levelEnded && ++levelEndTick > END_TIME) {
				FP.world = new WinScreen();
			}
			
			if(levelStarted) {
				_player.sayAny(["Ow, my head", "Where am I?", "Not again!"]);
				levelStarted = false;
			}
			
			if(_player.dead) {
				respawnTick++;
				if(respawnTick >= RESPAWN_TIME) {
					respawnPlayer();
				}
			}
			
			// Move the camera
			if(!_player.dead) {
				moveCamera(_player.x, _player.y);
			} else {
			}
		}
	
		private function moveCamera(x:Number, y:Number):void {
			FP.camera.x = Math.max(0, Math.min(level.width - FP.width, x - FP.width/2-16));
			FP.camera.y = Math.max(0, Math.min(level.height - FP.height, y - FP.height/2-24));
		}
	}
}
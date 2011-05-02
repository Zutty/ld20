package uk.co.zutty.ld20
{
	import flash.filters.GlowFilter;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class TitleScreen extends World {
		
		[Embed(source = '/data/deathbot_title.png')]
		private const DEATHBOT_TITLE_IMAGE:Class;

		private var deathbot:Entity;
		private var deathbotSpritemap:Spritemap;
		private var tick:Number;
		private var blinkTimer:uint;
		private var lastBlinked:uint;
		
		public function TitleScreen() {
			super();
			
			// Bg color
			var bg:Entity = new Entity();
			bg.graphic = Image.createRect(FP.width, FP.height, 0x9eaad5);
			add(bg);
			
			deathbot = new Entity();
			deathbot.x = 340;
			deathbot.y = 90;
			deathbotSpritemap = new Spritemap(DEATHBOT_TITLE_IMAGE, 200, 300);
			deathbotSpritemap.add("normal", [0]);
			deathbotSpritemap.add("blink", [1]);
			deathbotSpritemap.play("normal");
			deathbot.graphic = deathbotSpritemap;
			add(deathbot);
			
			// Title text
			add(new GlowyText(FP.width/2, 200, "DEATHBOT LOVE", 72, 0xFFFFFF, 0xFF69B4, 12));
			
			// Continue text
			add(new GlowyText(FP.width/2, 380, "Press X to begin", 24));

			add(new GlowyText(FP.width-85, FP.height - 40, "by Zutty for LD20"));
			add(new GlowyText(FP.width-85, FP.height - 24, "www.ludumdare.com"));
			
			tick = 0;
			blinkTimer = 0;
		}
		
		override public function update():void {
			super.update();
			
			if(Input.pressed(Key.X)) {
				FP.world = new GameWorld();
			}
			
			deathbot.y = 90 + Math.sin((tick++)/20) * 3;
			
			lastBlinked++;
			
			if(blinkTimer == 0 && lastBlinked > 150 && Math.random() > 0.99) {
				blinkTimer = 7;
				lastBlinked = 0;
				deathbotSpritemap.play("blink");
			}
			
			if(blinkTimer > 0) {
				blinkTimer--;
			} else {
				deathbotSpritemap.play("normal");
			}
		}
	}
}
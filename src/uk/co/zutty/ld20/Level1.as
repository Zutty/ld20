package uk.co.zutty.ld20
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Emitter;
	
	import org.osmf.metadata.MimeTypes;
	
	import uk.co.zutty.ld20.ogmo.OgmoLevel;
	
	public class Level1 extends OgmoLevel {
		
		[Embed(source = '/data/level1.oel', mimeType = 'application/octet-stream')]
		private const LEVEL1_OEL:Class;

		[Embed(source = '/data/tiles.png')]
		private const TILES_IMAGE:Class;
		
		public function Level1() {
			super(LEVEL1_OEL, TILES_IMAGE, 32, 32);
		}
	}
}
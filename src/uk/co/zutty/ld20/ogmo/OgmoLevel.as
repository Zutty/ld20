package uk.co.zutty.ld20.ogmo
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	import uk.co.zutty.ld20.Vector2D;

	public class OgmoLevel {
		
		private var data:XML;
		private var tiles:Class;
		private var tileWidth:Number;
		private var tileHeight:Number;
		
		public function OgmoLevel(raw:Class, tiles:Class, tileWidth:Number, tileHeight:Number) {
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.tiles = tiles;
			var bytes:ByteArray = new raw();
			data = new XML(bytes.readUTFBytes(bytes.length));
			trace(data);
		}
		
		public function getLayer(name:String, solid:Boolean = false):Entity {
			var layer:Entity = new Entity();
			layer.type = name;
			
			var tilemap:Tilemap = new Tilemap(tiles, data.width, data.height, tileWidth, tileHeight);
			var grid:Grid = new Grid(data.width, data.height, tileWidth, tileHeight);

			for each(var tile:XML in data[name][0].tile) {
				var idx:uint = tilemap.getIndex(tile.@tx / tileWidth, tile.@ty / tileHeight);
				tilemap.setTile(tile.@x / tileWidth, tile.@y / tileHeight, idx);
				grid.setTile(tile.@x / tileWidth, tile.@y / tileHeight);
			}

			layer.graphic = tilemap;
			if(solid) {
				layer.mask = grid;
			}
			
			return layer;
		}
		
		public function getObjectPositions(layerName:String, objName:String):Vector.<Vector2D> {
			var ret:Vector.<Vector2D> = new Vector.<Vector2D>();
			for each(var obj:XML in data[layerName][0][objName]) {
				ret.push(new Vector2D(obj.@x, obj.@y));
			}
			return ret;
		}
		
		public function getObjectPosition(layerName:String, objName:String):Vector2D {
			var obj:XML = data[layerName][0][objName][0];
			return new Vector2D(obj.@x, obj.@y);
		}
		
		/*public function getObject(layerName:String, objName:String):Entity {
			for each(var obj:XML in data[layerName][0][objName]) {
				var entity:Entity = new Entity();
				entity.x
			}
		}*/
	}
}
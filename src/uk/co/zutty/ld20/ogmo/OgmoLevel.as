package uk.co.zutty.ld20.ogmo
{
	import flash.utils.ByteArray;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	import uk.co.zutty.ld20.Vector2D;
	import uk.co.zutty.ld20.Waypoint;

	public class OgmoLevel {
		
		private var data:XML;
		private var tileMaps:Object;
		private var tileWidth:Number;
		private var tileHeight:Number;
		
		public function OgmoLevel(raw:Class, tileMaps:Object, tileWidth:Number, tileHeight:Number) {
			this.tileWidth = tileWidth;
			this.tileHeight = tileHeight;
			this.tileMaps = tileMaps;
			var bytes:ByteArray = new raw();
			data = new XML(bytes.readUTFBytes(bytes.length));
			trace(data);
		}
		
		public function get width():Number {
			return data.width;
		}
		
		public function get height():Number {
			return data.height;
		}

		public function getLayer(name:String, solid:Boolean = false):Entity {
			var layer:Entity = new Entity();
			
			var tilemap:Tilemap = new Tilemap(tileMaps[name] as Class, data.width, data.height, tileWidth, tileHeight);
			var grid:Grid = new Grid(data.width, data.height, tileWidth, tileHeight);

			for each(var tile:XML in data[name][0].tile) {
				var idx:uint = tilemap.getIndex(tile.@tx / tileWidth, tile.@ty / tileHeight);
				tilemap.setTile(tile.@x / tileWidth, tile.@y / tileHeight, idx);
				grid.setTile(tile.@x / tileWidth, tile.@y / tileHeight);
			}

			layer.graphic = tilemap;
			if(solid) {
				layer.type = "solid";
				layer.mask = grid;
			}
			
			return layer;
		}
		
		public function getObjectWaypoints(layerName:String, objName:String):Vector.<Waypoint> {
			var ret:Vector.<Waypoint> = new Vector.<Waypoint>();
			for each(var obj:XML in data[layerName][0][objName]) {
				var first:Waypoint = new Waypoint(obj.@x, obj.@y);
				var prev:Waypoint = first;
				
				for each(var node:XML in obj.node) {
					var wp:Waypoint = new Waypoint(node.@x, node.@y);
					prev.next = wp;
					prev = wp;
				}
				prev.next = first;
				ret.push(first);
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
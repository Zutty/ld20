package uk.co.zutty.ld20
{
	import flash.filters.GlowFilter;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	public class GlowyText extends LD20Entity {
		
		private var _text:Text;
		
		public function GlowyText(cx:Number, y:Number, str:String, size:Number = 16, color:uint = 0xFFFFFF, glowColor:uint = 0x000000, outline:Number = 4) {
			super();
			Text.size = size;
			_text = new Text(str);
			_text.color = color;
			_text.alpha = 0;
			_text.field.filters = [new GlowFilter(glowColor, 1, outline, outline)];
			graphic = _text;
			this.x = cx - (_text.width / 2);
			this.y = y;
		}

		override public function update():void {
			_text.alpha = 1.0;
		}
	}
}
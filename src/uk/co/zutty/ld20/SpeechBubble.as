package uk.co.zutty.ld20
{
	import flash.filters.GlowFilter;
	
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	public class SpeechBubble extends LD20Entity {
		
		private const FADE_RATE:Number = 0.06;
		private const TEXT_OUTLINE:Number = 4;
		
		private var char:Character;
		private var _text:Text;
		private var _duration:uint;
		private var tick:uint;
		private var show:Boolean;
		
		public function SpeechBubble(char:Character, str:String, duration:uint = 80, color:uint = 0xFFFFFF) {
			super();
			this.char = char;
			reset(str, duration, color);
		}
		
		public function get text():String {
			return _text.text;
		}
		
		public function reset(str:String, duration:uint = 80, color:uint = 0xFFFFFF):void {
			_text = new Text(str);
			_text.color = color;
			_text.alpha = 0;
			_text.field.filters = [new GlowFilter(0x000000, 1, TEXT_OUTLINE, TEXT_OUTLINE)];
			graphic = _text;

			_duration = duration;
			show = true;
			visible = true;
			tick = 0;
			pos();
		}

		private function pos():void {
			this.x = char.x + (char.width / 2) - (_text.width / 2);
			this.y = char.y - 10;
		}
		
		override public function update():void {
			pos();
			
			if(show && _text.alpha < 1.0) {
				_text.alpha = Math.min(1.0, _text.alpha + FADE_RATE);
			} else if(!show && _text.alpha > 0.0) {
				_text.alpha = Math.max(0.0, _text.alpha - FADE_RATE);
			}
			
			if(++tick >= _duration) {
				show = false;
				if(_text.alpha == 0.0) {
					visible = false;
				}
			}
		}
	}
}
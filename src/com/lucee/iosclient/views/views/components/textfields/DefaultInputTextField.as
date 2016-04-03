package com.lucee.iosclient.views.views.components.textfields {
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * @author marvin
	 */
	public class DefaultInputTextField extends Sprite {
		public var _textformat : TextFormat;
		public var _textfield : TextField;
		public var _font : ElegantLux;
		private var _line : Sprite;

		public function DefaultInputTextField() {
			_font = new ElegantLux();
			_textformat = new TextFormat();
			_textfield = new TextField();

			_textformat.letterSpacing = 13;
			_textformat.size = 42;
			_textformat.align = TextFormatAlign.CENTER;

			_line = new Sprite();
			_line.graphics.beginFill(0xFFFFFF, .5);
			_line.graphics.drawRect(0, 0, 550, 2);
			_line.y = 80;
			_line.x = 100;

			initialize() ;
		}

		public function setText(string : String) : void {
			_textfield.text = string;
		}

		protected function initialize() : void {
			_textformat.font = _font.fontName;
			_textformat.color = 0xFFFFFF;

			_textfield.defaultTextFormat = _textformat;
			_textfield.type = TextFieldType.INPUT;
			_textfield.addEventListener(FocusEvent.FOCUS_IN, onTextfieldFocus);

			_textfield.selectable = false;
			_textfield.embedFonts = true;
			_textfield.width = 750;
			_textfield.height = 86;

			addChild(_textfield);
			addChild(_line);
		}

		private function onTextfieldFocus(event : FocusEvent) : void {
			_textfield.text = "";
		}

		function redraw() : void {
			_textfield.setTextFormat(_textformat);
			_textfield.defaultTextFormat = _textformat;
		}

		public function hide() : void {
			TweenLite.to(_textfield, 1.25, {autoAlpha:0, ease:Strong.easeIn});
			TweenLite.to(_line, 1.25, {transformAroundCenter:{width:0}, ease:Strong.easeIn});
		}
		// public function setRightStyle() : void {
		// _textformat.align = TextFormatAlign.RIGHT;
		// _textfield.defaultTextFormat = _textformat;
		// _textfield.setTextFormat(_textformat);
		// _textfield.width = 720;
		// _textfield.x = 0;
		// }
	}
}

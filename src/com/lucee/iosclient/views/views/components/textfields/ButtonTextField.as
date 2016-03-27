package com.lucee.iosclient.views.views.components.textfields {
	import flash.text.TextFormatAlign;

	/**
	 * @author marvin
	 */
	public class ButtonTextField extends DefaultTextfield {
		public function ButtonTextField() {
			_textformat.letterSpacing = 8;
			_textformat.size = 42;
			_textformat.align = TextFormatAlign.CENTER;
			
			initialize();
		}

		public function setSize(i : int) : void {
			_textformat.size = i;
			redraw();
		}
	}
}

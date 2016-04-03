package com.lucee.iosclient.views.views.components {
	import com.lucee.iosclient.views.views.components.textfields.MainMenuTextfield;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class MainMenuButton extends Sprite {
		private var _itemName : MainMenuTextfield;
		private var _title : String;

		public function MainMenuButton() {
			_itemName = new MainMenuTextfield();
			_itemName.setText("---");
			
			addChild(_itemName);
			
			this.mouseChildren = false;
		}

		public function set title(title : String) : void {
			_title = title;
			_itemName.setText(_title.toUpperCase());
		}

		public function get title() : String {
			return _title;
		}
	}
}

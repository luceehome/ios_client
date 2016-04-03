package com.lucee.iosclient.views.views {
	import com.lucee.iosclient.views.views.components.PresetsMenuButton;
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class PresetsView extends Sprite implements IApplicationView {
		private var _netflix : PresetsMenuButton;

		public function PresetsView() {
			_netflix = new PresetsMenuButton();
			
		}

		public function hide() : void {
			
		}

		public function show(initialDelay:int) : void {
		}
	}
}

package com.lucee.iosclient.views.views {
	import com.beautifycode.helpers.Debug;

	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {
		private var _mainMenuView : MainMenuView;
		private var _presetView : PresetsView;
		private var _bootView : BootView;
		private var _deviceView : DevicesView;
		private var _headerView : ApplicationHeaderView;
		private var _timersView : TimersView;

		public function ApplicationView() {
			Debug.log("== ApplicationView: construct()");

			_bootView = new BootView();
			_bootView.show(1);
			addChild(_bootView);
		}

		public function build() : void {
			_mainMenuView = new MainMenuView();
			_presetView = new PresetsView();
			_deviceView = new DevicesView();
			_timersView = new TimersView();
			_headerView = new ApplicationHeaderView();

			addChild(_presetView);
			addChild(_deviceView);
			addChild(_mainMenuView);
			addChild(_headerView);
		}

		private function enableSwipe() : void {
			addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
		}

		private function onSwipe(event : TransformGestureEvent) : void {
			// if (event.offsetX == 1) {
			// trace(event.stageX);
			// // User swiped towards right
			// showMainMenu(true);
			// }
		}

		public function showBoot() : void {
			trace('showBoot: ' + (showBoot));
			// _bootView.show();
		}
	}
}

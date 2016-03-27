package com.lucee.iosclient.views.views {
	import com.beautifycode.helpers.Debug;

	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {
		private var _mainMenuView : MainMenuView;
		private var _presetView : PresetView;
		private var _bootView : BootView;
		private var _applicationBackground : ApplicationBackground;
		private var _deviceView : DeviceView;
		private var _headerView : IPhoneHeaderView;

		public function ApplicationView() {
			Debug.log("== ApplicationView: construct()");

			Debug.log("== ApplicationView: showLoadingView()");
			showLoadingView();
		}

		public function build() : void {
			_mainMenuView = new MainMenuView();
			_presetView = new PresetView();
			_deviceView = new DeviceView();
			_headerView = new IPhoneHeaderView();

			addChild(_presetView);
			addChild(_deviceView);
			addChild(_mainMenuView);
			addChild(_headerView);

			// enableSwipe();
		}

		private function enableSwipe() : void {
			addEventListener(TransformGestureEvent.GESTURE_SWIPE, onSwipe);
		}

		private function onSwipe(event : TransformGestureEvent) : void {
			if (event.offsetX == 1) {
				trace(event.stageX);
				// User swiped towards right
				showMainMenu(true);
			}
		}

		private function showLoadingView() : void {
			_bootView = new BootView();
			_bootView.show(1);
			addChild(_bootView);
		}

		public function initialStart() : void {
			build();
			_bootView.hide(2);
			_mainMenuView.show(4);
		}

		public function showMainMenu(bySwipe : Boolean = false) : void {
			_presetView.hide();

			if (bySwipe) _deviceView.hideBySwipe();
			else _deviceView.hide();

			// _timersView.hide();
			_headerView.hide();
			_mainMenuView.show(1);
		}

		public function showPresets() : void {
			_mainMenuView.hide();
			_headerView.show();
			_presetView.show();
		}

		public function showTimers() : void {
		}

		public function showDevices() : void {
			_mainMenuView.hide();
			_deviceView.show(.7);
			_headerView.show();
		}
	}
}

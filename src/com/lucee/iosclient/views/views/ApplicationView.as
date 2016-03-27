package com.lucee.iosclient.views.views {
	import com.beautifycode.helpers.Debug;

	import flash.display.Sprite;
	import flash.events.TransformGestureEvent;
	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {
		private var _mainMenuView : MainMenuView;
		private var _presetView : PresetView;
		private var _bootView : BootView;
		private static var CROSSFADE_TIME : int = 1.5;
		private var _applicationBackground : ApplicationBackground;
		private var _oldInterface : OldInterfaceView;
		private var _deviceView : DeviceView;
		private var _headerView : IPhoneHeaderView;

		public function ApplicationView() {
			Debug.log("== ApplicationView: construct()");
			Debug.log("== ApplicationView: showLoadingView()");
			
			_applicationBackground = new ApplicationBackground();
			addChild(_applicationBackground);
			
			_bootView = new BootView();
			_bootView.show();
			addChild(_bootView);
		}

		public function build() : void {		
			_mainMenuView = new MainMenuView();
			_presetView = new PresetView();
			_deviceView = new DeviceView();
			_headerView = new IPhoneHeaderView();
			// _oldInterface = new OldInterfaceView();

			addChild(_mainMenuView);
			addChild(_presetView);
			addChild(_deviceView);
			addChild(_headerView);
			// addChild(_oldInterface);

			showBootScreen();
			enableSwipe();
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

		private function showBootScreen() : void {
			_bootView.show();
			setTimeout(showMainMenu, 1000);
		}

		public function showMainMenu(bySwipe:Boolean=false) : void {
			_bootView.hide();
			_presetView.hide();
			if(bySwipe) _deviceView.hideBySwipe();
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

		public function showApiError() : void {
 			_bootView.showError();
		}
	}
}

package com.lucee.iosclient.views.mediatos {
	import com.lucee.iosclient.events.MainMenuEvent;
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.views.views.MainMenuView;

	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class MainMenuMediator extends Mediator {
		 [Inject]
		 public var view:MainMenuView;
		 		 
		override public function initialize() : void {
			trace('initialize: ' + (initialize));
			view.presetsButton.addEventListener(MouseEvent.CLICK, _onPresetsBtnClick);
			view.timersButton.addEventListener(MouseEvent.CLICK, _onTimersBtnClick);
			view.devicesButton.addEventListener(MouseEvent.CLICK, _onDevicesBtnClick);
			// addContextListener(ApplicationEvent.BOOT_COMPLETE, _onBootFinished);
		}

		private function _onDevicesBtnClick(event : MouseEvent) : void {
			trace('_onDevicesBtnClick: ' + (_onDevicesBtnClick));
			eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.DEVICES_CLICKED, true, false));
		}

		private function _onTimersBtnClick(event : MouseEvent) : void {
			trace('_onTimersBtnClick: ' + (_onTimersBtnClick));
			eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.DEVICES_CLICKED, true, false));
		}

		private function _onPresetsBtnClick(event : MouseEvent) : void {
			trace('_onPresetsBtnClick: ' + (_onPresetsBtnClick));
			eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.PRESETS_CLICKED, true, false));
		}
	}
}

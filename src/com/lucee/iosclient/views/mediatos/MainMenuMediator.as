package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.events.MainMenuEvent;
	import com.lucee.iosclient.models.MainMenuModel;
	import com.lucee.iosclient.models.ViewDataModel;
	import com.lucee.iosclient.views.views.MainMenuView;

	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class MainMenuMediator extends Mediator {
		[Inject]
		public var view : MainMenuView;

		override public function initialize() : void {
			trace('initialize: ' + (initialize));
			// view.presetsButton.addEventListener(MouseEvent.CLICK, onClick);
			view.presetsButton.addEventListener(MouseEvent.CLICK, onClick);
			view.timersButton.addEventListener(MouseEvent.CLICK, onClick);
			view.devicesButton.addEventListener(MouseEvent.CLICK, onClick);

			addContextListener(ApplicationEvent.SHOW_MAIN_MENU, showView);
		}

		private function onClick(event : MouseEvent) : void {
			switch (event.target['title']) {
				case MainMenuModel.PRESETS_BTN_TITLE:
					eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.PRESETS_CLICKED, true, false));
					break;
				case MainMenuModel.TIMERS_BTN_TITLE:
					eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.TIMERS_CLICKED, true, false));
					break;
				case MainMenuModel.DEVICES_BTN_TITLE:
					eventDispatcher.dispatchEvent(new MainMenuEvent(MainMenuEvent.DEVICES_CLICKED, true, false));
					break;
			}
		}

		private function showView(event : ApplicationEvent) : void {
			view.show(ViewDataModel.SHOW_AFTER_BOOT_DELAY);
		}
	}
}

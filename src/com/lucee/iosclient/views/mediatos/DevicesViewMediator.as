package com.lucee.iosclient.views.mediatos {
	import com.lucee.iosclient.models.ViewDataModel;
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.events.DeviceMenuEvent;
	import com.lucee.iosclient.events.MainMenuEvent;
	import com.lucee.iosclient.views.views.DevicesView;

	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class DevicesViewMediator extends Mediator {
		[Inject]
		public var view : DevicesView;

		override public function initialize() : void {
			// addViewListener();
			addContextListener(MainMenuEvent.DEVICES_CLICKED, showView);
			addContextListener(ApplicationEvent.BACK_BTN_CLICKED, hideView);
		}

		private function hideView(event : ApplicationEvent) : void {
		}

		private function showView(event : MainMenuEvent) : void {
			view.show(ViewDataModel.SHOW_DELAY);
		}

		private function _onBtnClick(event : MouseEvent) : void {
			eventDispatcher.dispatchEvent(new DeviceMenuEvent(DeviceMenuEvent.STEHLAMPE_CLICKED, true, false));
		}
	}
}

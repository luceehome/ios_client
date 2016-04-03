package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.APIDataEvent;
	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.views.views.BootView;

	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class BootViewMediator extends Mediator {
		[Inject]
		public var view : BootView;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function initialize() : void {
			addContextListener(APIDataEvent.API_RESPONSE, onApiResponse);
			addContextListener(ApplicationEvent.BOOT_COMPLETE, _onBootFinished);
		}

		private function _onBootFinished(event : ApplicationEvent) : void {
			setTimeout(resolveBootScreen, 3000);
		}

		private function resolveBootScreen() : void {
			switch (apiDataModel.status) {
				case "OK":
					view.changeInfoLabel("API FOUND");
					view.changeLoadingLabel("WELCOME");
					view.hide(2);
					break;
				case "NOTOK_SERVER_DATA":
					view.changeInfoLabel("DATA MISMATCH");
					view.changeLoadingLabel("DEMO");
					view.hide(2);
					break;
				case "NOTOK_SERVER_TIMEOUT":
					view.changeInfoLabel("API TIMEOUT");
					view.changeLoadingLabel("DEMO");
					view.hide(3.5);
					break;
				case "NOTOK_SERVER_NOTFOUND":
					view.changeInfoLabel("API NOT FOUND");
					view.changeLoadingLabel("DEMO");
					view.hide(1.5);
					break;
			}
		}

		private function onApiResponse(event : APIDataEvent) : void {
//			view.changeInfoLabel(event.data);
		}
	}
}

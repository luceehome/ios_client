package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.APIDataEvent;
	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.views.views.BootView;

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
			switch(apiDataModel.status) {
				case "OK":
				break;
				
				case "NOTOK_SERVER":
				view.changeInfoLabel("RUNNING DEMO");
				break;
			}
		}

		private function onApiResponse(event : APIDataEvent) : void {
			view.changeInfoLabel(event.data);
		}
	}
}

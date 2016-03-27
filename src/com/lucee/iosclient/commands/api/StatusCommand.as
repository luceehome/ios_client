package com.lucee.iosclient.commands.api {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.events.APIDataEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.models.ApplicationModel;
	import com.lucee.iosclient.services.APIService;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class StatusCommand extends AsyncCommand {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var apiService : APIService;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function execute() : void {
			Debug.log("api.StatusCommand - init.");
			_checkApiStatus();
		}

		private function _checkApiStatus() : void {
			eventDispatcher.addEventListener(APIDataEvent.API_RESPONSE, onApiStatus);
			apiService.checkState();
		}

		private function onApiStatus(event : APIDataEvent) : void {
			apiDataModel.status = event.data;
			if (apiDataModel.status.indexOf('WAITING') < 0) {
				eventDispatcher.removeEventListener(APIDataEvent.API_RESPONSE, onApiStatus);
				_resolve();
			}
		}

		private function _resolve() : void {
			Debug.log("api.StatusCommand - done.");
			dispatchComplete(true);
		}
	}
}

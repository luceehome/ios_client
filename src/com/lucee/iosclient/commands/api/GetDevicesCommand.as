package com.lucee.iosclient.commands.api {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.events.APIDataEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.models.ApplicationModel;
	import com.lucee.iosclient.models.DevicesDataModel;
	import com.lucee.iosclient.services.APIService;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class GetDevicesCommand extends AsyncCommand {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var apiService : APIService;

		[Inject]
		public var devicesModel : DevicesDataModel;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function execute() : void {
			Debug.log("api.GetDevicesCommand - init.");

			if (apiDataModel.status == "OK") {
				_getDevices();
			}
		}

		private function _getDevices() : void {
			eventDispatcher.addEventListener(APIDataEvent.DEVICES_GET, onDevicesGet);
			apiService.getDevices();
		}

		private function onDevicesGet(event : APIDataEvent) : void {
			eventDispatcher.removeEventListener(APIDataEvent.DEVICES_GET, onDevicesGet);

			var devices : Object = event.data;
			devicesModel.setDevices(devices);
			_resolve();
		}

		private function _resolve() : void {
			Debug.log("api.GetDevicesCommand - done.");
			dispatchComplete(true);
		}
	}
}

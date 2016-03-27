package com.lucee.iosclient.models {
	import com.beautifycode.helpers.Debug;
	/**
	 * @author marvin
	 */
	public class DevicesDataModel {
		private var _devices : Array = new Array();

		public function get devices() : Array {
			return _devices;
		}

		public function set devices(devices : Array) : void {
			_devices = devices;
		}

		public function setDevices(receivedDataJson : Object) : void {
			Debug.log("== DevicesDataModel: setDevices()");

			if (!receivedDataJson) {
				Debug.log("---- that should not have ever happened ----");
				return;
			}

			for (var devices : String in receivedDataJson['data']['Results']) {
				if (isDevice(receivedDataJson['data']['Results'][devices])) {
					trace("device found, name: " + receivedDataJson['data']['Results'][devices]['Name']);
				}
			}
		}

		private function isDevice(str : Object) : Boolean {
			if (str['Internals']['CFGFN']) {
				if (str['Internals']['CFGFN'].indexOf('actors') > -1) {
					return true;
				}

				// str['Attributes']['room'] != 'hidden' &&
			}

			return false;
		}
	}
}

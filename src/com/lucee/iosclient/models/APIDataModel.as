package com.lucee.iosclient.models {
	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.events.APIDataEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class APIDataModel {
		private var _status : String;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		public function get status() : String {
			return _status;
		}

		public function set status(status : String) : void {
			if (!status) {
				_status = "NOTOK";
				eventDispatcher.dispatchEvent(new APIDataEvent(APIDataEvent.API_ERROR, true, false));
			} else _status = status;

			Debug.log("== APIDataModel, status: " + _status);
		}
	}
}

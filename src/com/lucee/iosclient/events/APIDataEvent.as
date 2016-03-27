package com.lucee.iosclient.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class APIDataEvent extends Event {
		public static const SEND_DATA : String = "sendData";
		public static const API_ERROR : String = "apiError";
		public static const API_CONNECTED : String = "apiConnected";
		public static const DEVICES_GET : String = "devicesGet";
		public static const API_RESPONSE : String = "apiResponse";
		public var data : *;

		public function APIDataEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var e:APIDataEvent = new APIDataEvent(this.type, this.bubbles, this.cancelable);
			e.data = this.data;
			
			return e;
		}
	}
}

package com.lucee.iosclient.services {
	import com.lucee.iosclient.models.DevicesDataModel;
	import com.lucee.iosclient.events.APIDataEvent;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;

	/**
	 * @author marvin
	 */
	public class APIService {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		private static const HOST_PORT : uint = 3000;
		private static const HOST_IP : String = "192.168.2.147";
		private var _urlRequest : URLRequest;
		private var _urlLoader : URLLoader;
		private var _apiDataEvent : APIDataEvent;
		private var _receivedData : String;
		private var _receivedDataJson : Object;
		


		public function APIService() : void {
			_urlRequest = new URLRequest("");
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onStateIOError); 
		}

		public function checkState() : void {
			_urlRequest.method = URLRequestMethod.GET;
			_urlRequest.url = "http://" + HOST_IP + ":" + HOST_PORT + "/api/status";
			_urlLoader.addEventListener(Event.COMPLETE, onApiCheckStateResponse);
			_urlLoader.load(_urlRequest);
		}

		public function getDevices() : void {
			_urlRequest.method = URLRequestMethod.GET;
			_urlRequest.url = "http://" + HOST_IP + ":" + HOST_PORT + "/api/devices";
			_urlLoader.addEventListener(Event.COMPLETE, onGetDevicesResponse);
			_urlLoader.load(_urlRequest);
		}

		private function onGetDevicesResponse(event : Event) : void {
			_receivedDataJson = parseJson(_urlLoader.data);
			_urlLoader.removeEventListener(Event.COMPLETE, onApiCheckStateResponse);
			
			_apiDataEvent = new APIDataEvent(APIDataEvent.DEVICES_GET, true, false);
			_apiDataEvent.data = _receivedDataJson;
			eventDispatcher.dispatchEvent(_apiDataEvent);
		}

		private function onApiCheckStateResponse(event : Event) : void {
			_receivedDataJson = parseJson(_urlLoader.data);
			_urlLoader.removeEventListener(Event.COMPLETE, onApiCheckStateResponse);
			_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
			_apiDataEvent.data = _receivedDataJson['data']['status'];
			eventDispatcher.dispatchEvent(_apiDataEvent);
		}

		private function parseJson(data : String) : Object {
			if (!data) return null;

			_receivedData = data;
			var _json : Object = JSON.parse(_receivedData);
			return _json;
		}

		private function onStateIOError(event : IOErrorEvent) : void {
			_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
			_apiDataEvent.data = "NOTOK_SERVER";
			eventDispatcher.dispatchEvent(_apiDataEvent);
		}
	}
}

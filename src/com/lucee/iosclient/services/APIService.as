package com.lucee.iosclient.services {
	import com.lucee.iosclient.events.APIDataEvent;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Timer;

	/**
	 * @author marvin
	 */
	public class APIService {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		private static const HOST_PORT : uint = 3000;
		private static const HOST_IP : String = "192.168.2.140";
		
		private var _urlRequest : URLRequest;
		private var _urlLoader : URLLoader;
		private var _apiDataEvent : APIDataEvent;
		private var _receivedData : String;
		private var _receivedDataJson : Object;
		private var _urlLoadTimer : Timer;
		private var _urlLoadTimeout : int = 0;
		private var _urlLoadMaxTimeout : int = 3;

		public function APIService() : void {
			_urlLoadTimer = new Timer(3000, 0);
			_urlRequest = new URLRequest("");
			_urlLoader = new URLLoader();
		}

		public function checkState() : void {
			_urlLoadTimer.addEventListener(TimerEvent.TIMER, onUrlLoadTimer);

			_urlRequest.method = URLRequestMethod.GET;
			_urlRequest.url = "http://" + HOST_IP + ":" + HOST_PORT + "/api/status";

			_urlLoader.addEventListener(Event.COMPLETE, onApiCheckStateResponse);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onStateIOError);
			_urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onStateSecurityError);

			try {
				_urlLoadTimer.start();
				_urlLoader.load(_urlRequest);
			} catch (e : Error) {
				_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
				_apiDataEvent.data = "NOTOK_INTERN";
				eventDispatcher.dispatchEvent(_apiDataEvent);
			}
		}

		private function onUrlLoadTimer(event : TimerEvent) : void {
			if (_urlLoadTimeout < _urlLoadMaxTimeout) {
				_urlLoadTimeout++;

				_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
				_apiDataEvent.data = "NOTOK_WAITING_" + _urlLoadTimeout + "/" + _urlLoadMaxTimeout;
				eventDispatcher.dispatchEvent(_apiDataEvent);
			} else {
				_urlLoader.close();
				_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onStateIOError);
				_urlLoadTimer.removeEventListener(TimerEvent.TIMER, onUrlLoadTimer);
				_urlLoadTimer.stop();

				_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
				_apiDataEvent.data = "NOTOK_SERVER";
				eventDispatcher.dispatchEvent(_apiDataEvent);
			}
		}

		private function onStateSecurityError(event : SecurityErrorEvent) : void {
			_urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onStateSecurityError);
			_urlLoadTimer.removeEventListener(TimerEvent.TIMER, onUrlLoadTimer);
			_urlLoadTimer.stop();

			_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
			_apiDataEvent.data = "NOTOK_SECURITY";
			eventDispatcher.dispatchEvent(_apiDataEvent);
		}

		private function onApiCheckStateResponse(event : Event) : void {
			_urlLoader.removeEventListener(Event.COMPLETE, onApiCheckStateResponse);
			_urlLoadTimer.removeEventListener(TimerEvent.TIMER, onUrlLoadTimer);
			_urlLoadTimer.stop();

			_receivedDataJson = parseJson(_urlLoader.data);
			_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
			_apiDataEvent.data = _receivedDataJson['data']['status'];
			eventDispatcher.dispatchEvent(_apiDataEvent);
		}

		private function onStateIOError(event : IOErrorEvent) : void {
			_urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onStateIOError);
			_urlLoadTimer.removeEventListener(TimerEvent.TIMER, onUrlLoadTimer);
			_urlLoadTimer.stop();

			_apiDataEvent = new APIDataEvent(APIDataEvent.API_RESPONSE, true, false);
			_apiDataEvent.data = "NOTOK_SERVER";
			eventDispatcher.dispatchEvent(_apiDataEvent);
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

		private function parseJson(data : String) : Object {
			if (!data) return null;

			_receivedData = data;
			var _json : Object = JSON.parse(_receivedData);
			return _json;
		}
	}
}

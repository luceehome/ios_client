package com.lucee.iosclient.views.views {
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.lucee.iosclient.models.AnimationModel;
	import com.lucee.iosclient.views.views.components.DeviceMenuButton;
	import com.lucee.iosclient.views.views.components.ScrollableList;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class DeviceView extends Sprite {
		private var _stehlampeDevice : DeviceMenuButton;
		private var _devices : Array = new Array();
		private var _kugellampeDevice : DeviceMenuButton;
		private var _hueDevice : DeviceMenuButton;
		private var _ledStripeDevice : DeviceMenuButton;
		private var _deviceList : Sprite;
		private var _scrollableList : ScrollableList;

		public function DeviceView() {
			_deviceList = new Sprite();
			_stehlampeDevice = new DeviceMenuButton();
			_stehlampeDevice.title = "STEHLAMPE";
			_stehlampeDevice.state = "OFF";
			_stehlampeDevice.setOnReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20on");
			_stehlampeDevice.setOffReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20off");

			_kugellampeDevice = new DeviceMenuButton();
			_kugellampeDevice.title = "KUGELLAMPE";
			_kugellampeDevice.state = "OFF";
			_kugellampeDevice.setOnReq("http://192.168.2.137:8083/fhem?cmd=set%Kugellampe%20on");
			_kugellampeDevice.setOffReq("http://192.168.2.137:8083/fhem?cmd=set%Kugellampe%20off");

			_hueDevice = new DeviceMenuButton();
			_hueDevice.title = "STEHLAMPE";
			_hueDevice.state = "OFF";
			_hueDevice.setOnReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20on");
			_hueDevice.setOffReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20off");

			_ledStripeDevice = new DeviceMenuButton();
			_ledStripeDevice.title = "LED";
			_ledStripeDevice.state = "OFF";
			_ledStripeDevice.setOnReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20on");
			_ledStripeDevice.setOffReq("http://192.168.2.137:8083/fhem?cmd=set%20Stehlampe%20off");

			_devices.push(_stehlampeDevice);
			_devices.push(_kugellampeDevice);
			_devices.push(_hueDevice);
			_devices.push(_ledStripeDevice);

			for (var i : int; i < 100; i++) {
				var tD : DeviceMenuButton = new DeviceMenuButton();
				tD.title = i + "";

				_devices.push(tD);

				_devices[i].y = 40 + (i * 160);
				_devices[i].origX = 0;
				_devices[i].origY = 40 + (i * 160);
				_devices[i].alpha = 0;
				_deviceList.addChild(_devices[i]);
			}

			_scrollableList = new ScrollableList(_deviceList, 170, 40);
			_scrollableList.y = 150;
			addChild(_scrollableList);
		}

		public function show(initialDelay : Number) : void {
			for (var i : int; i < _devices.length; i++) {
				TweenLite.to(_devices[i], AnimationModel.FADE_IN_TIME - .5, {y:_devices[i].origY - 20, autoAlpha:1, ease:Strong.easeOut, delay:initialDelay + (i / 10)});
			}
		}

		public function hide() : void {
			for (var i : int; i < _devices.length; i++) {
				TweenLite.to(_devices[i], AnimationModel.FADE_OUT_TIME, {y:_devices[i].origY - 40, autoAlpha:0, ease:Strong.easeIn, delay:(i / 6), onComplete:repositionItems, onCompleteParams:[_devices[i]]});
			}
		}

		private function repositionItems(item : DeviceMenuButton) : void {
			item.y = item.origY;
			item.x = item.origX;
		}

		public function get stehlampeDevice() : DeviceMenuButton {
			return _stehlampeDevice;
		}

		public function hideBySwipe() : void {
			for (var i : int; i < _devices.length; i++) {
				TweenLite.to(_devices[i], AnimationModel.FADE_OUT_TIME, {x:750, autoAlpha:0, ease:Strong.easeIn, delay:(i / 6), onComplete:repositionItems, onCompleteParams:[_devices[i]]});
			}
		}
	}
}

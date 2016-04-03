package com.lucee.iosclient.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class MainMenuEvent extends Event {
		public static const PRESETS_CLICKED : String = "presetsClicked";
		public static const DEVICES_CLICKED : String = "devicesClicked";
		public static const SHOW_DEVICES_VIEW : String = "showDevicesView";
		public static const TIMERS_CLICKED : String = "timersClicked";

		public function MainMenuEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		
		
	}
}

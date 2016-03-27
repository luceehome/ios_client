package com.lucee.iosclient.commands.macros {
	import com.lucee.iosclient.commands.api.StatusCommand;
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.commands.StartupCommand;
	import com.lucee.iosclient.commands.api.GetDevicesCommand;
	import com.lucee.iosclient.events.ApplicationEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class BootMacro extends SequenceMacro {
		[Inject]
		public var event : ApplicationEvent;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		override public function prepare() : void {
			Debug.log("BootMacro - init (atomic).");

			atomic = true;
			add(StartupCommand);
			add(StatusCommand);
			add(GetDevicesCommand);

			registerCompleteCallback(_onBootComplete);
		}

		private function _onBootComplete() : void {
			Debug.log("BootMacro - done.");
			Debug.log("Launching Application.");
			eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.BOOT_COMPLETE, true, false));
		}
	}
}

package com.lucee.iosclient.commands {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.models.ApplicationModel;
	import com.lucee.iosclient.services.APIService;
	import com.lucee.iosclient.views.views.ConfigurationView;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class LaunchCommand extends AsyncCommand {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var apiService : APIService;
		private var _configurationView : ConfigurationView;
		private var _applicationEvent : ApplicationEvent;
		private var _applicationBackground : ApplicationBackground;

		override public function execute() : void {
			Debug.log("LaunchCommand - init.");
			_applicationBackground = new ApplicationBackground();
			contextView.view.addChild(_applicationBackground);

			_configurationView = new ConfigurationView();
			contextView.view.addChild(_configurationView);

			_setupNativeWindow();
		}

		private function _setupNativeWindow() : void {
			applicationModel.setupNativeWindow(contextView.view.stage.nativeWindow);
			_applicationEvent = new ApplicationEvent(ApplicationEvent.BOOT, true, false);
			// eventDispatcher.dispatchEvent(_applicationEvent);
		}
	}
}

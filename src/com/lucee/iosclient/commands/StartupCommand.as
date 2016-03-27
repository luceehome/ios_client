package com.lucee.iosclient.commands {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.AIRUpdateHelper.AIRUpdateHelper;
	import com.beautifycode.helpers.Debug;
	import com.lucee.iosclient.models.ApplicationModel;
	import com.lucee.iosclient.services.APIService;
	import com.lucee.iosclient.views.views.ApplicationView;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class StartupCommand extends AsyncCommand {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var apiService : APIService;
		private var _applicationView : ApplicationView;

		override public function execute() : void {
			Debug.log("StartupCommand - init.");
			_applicationView = new ApplicationView();
			contextView.view.addChild(_applicationView);

			_setupNativeWindow();
			_resolve();

			// _checkApiStatus();
		}

		private function _setupNativeWindow() : void {
			applicationModel.setupNativeWindow(contextView.view.stage.nativeWindow);
		}

		private function _checkVersion(active : Boolean) : void {
			if (active) {
				AIRUpdateHelper.getAppInfo();
				AIRUpdateHelper.checkForUpdate("http://*.xml", _onUpdateSkip, _onFail);
			}
		}

		private function _onUpdateSkip() : void {
			Debug.log("Update skipped");
			_resolve();
		}

		private function _onFail(s : String) : void {
			Debug.log(s);
			_resolve();
		}

		private function _resolve() : void {
			Debug.log("StartupCommand - done.");
			dispatchComplete(true);
		}
	}
}

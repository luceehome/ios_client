package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.APIDataEvent;
	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.views.views.ConfigurationView;

	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class ConfigurationViewMediator extends Mediator {
		[Inject]
		public var view : ConfigurationView;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function initialize() : void {
			view.okBtn.addEventListener(MouseEvent.CLICK, onOkBtnClick);
		}

		private function onOkBtnClick(event : MouseEvent) : void {
			view.hide();
			eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.BOOT, true, false));
		}
	}
}

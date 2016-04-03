package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.events.MainMenuEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.models.ViewDataModel;
	import com.lucee.iosclient.views.views.PresetsView;

	/**
	 * @author marvin
	 */
	public class PresetsViewMediator extends Mediator {
		[Inject]
		public var view : PresetsView;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function initialize() : void {
			addContextListener(MainMenuEvent.PRESETS_CLICKED, showView);
			addContextListener(ApplicationEvent.BACK_BTN_CLICKED, hideView);
		}

		private function hideView(event:ApplicationEvent) : void {
			
		}

		private function showView(event:MainMenuEvent) : void {
			view.show(ViewDataModel.SHOW_DELAY);
		}
	}
}

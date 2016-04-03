package com.lucee.iosclient.views.mediatos {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.events.MainMenuEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.models.ViewDataModel;
	import com.lucee.iosclient.views.views.TimersView;

	/**
	 * @author marvin
	 */
	public class TimersViewMediator extends Mediator {
		[Inject]
		public var view : TimersView;

		[Inject]
		public var apiDataModel : APIDataModel;

		override public function initialize() : void {
			addContextListener(MainMenuEvent.TIMERS_CLICKED, showView);
			addContextListener(ApplicationEvent.BACK_BTN_CLICKED, hideView);
		}

		private function hideView(event:ApplicationEvent) : void {
			
		}

		private function showView(event:MainMenuEvent) : void {
			view.show(ViewDataModel.SHOW_DELAY);
		}
	}
}

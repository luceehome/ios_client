package com.lucee.iosclient.configs {
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;

	import com.lucee.iosclient.commands.LaunchCommand;
	import com.lucee.iosclient.commands.macros.BootMacro;
	import com.lucee.iosclient.controller.SocketController;
	import com.lucee.iosclient.events.ApplicationEvent;
	import com.lucee.iosclient.models.APIDataModel;
	import com.lucee.iosclient.models.ApplicationModel;
	import com.lucee.iosclient.models.DevicesDataModel;
	import com.lucee.iosclient.services.APIService;
	import com.lucee.iosclient.views.mediatos.ApplicationMediator;
	import com.lucee.iosclient.views.mediatos.BootViewMediator;
	import com.lucee.iosclient.views.mediatos.ConfigurationViewMediator;
	import com.lucee.iosclient.views.mediatos.DevicesViewMediator;
	import com.lucee.iosclient.views.mediatos.IphoneHeaderMediator;
	import com.lucee.iosclient.views.mediatos.MainMenuMediator;
	import com.lucee.iosclient.views.mediatos.PresetsViewMediator;
	import com.lucee.iosclient.views.mediatos.TimersViewMediator;
	import com.lucee.iosclient.views.views.ApplicationHeaderView;
	import com.lucee.iosclient.views.views.ApplicationView;
	import com.lucee.iosclient.views.views.BootView;
	import com.lucee.iosclient.views.views.ConfigurationView;
	import com.lucee.iosclient.views.views.DevicesView;
	import com.lucee.iosclient.views.views.MainMenuView;
	import com.lucee.iosclient.views.views.PresetsView;
	import com.lucee.iosclient.views.views.TimersView;

	import flash.desktop.NativeApplication;
	import flash.events.IEventDispatcher;
	import flash.events.InvokeEvent;

	/**
	 * @author marvin
	 */
	public class LucyConfig implements IConfig {
		[Inject]
		public var injectormap : IInjector;

		[Inject]
		public var commandmap : IEventCommandMap;

		[Inject]
		public var mediatormap : IMediatorMap;

		[Inject]
		public var context : IContext;

		[Inject]
		public var eventDispatcher : IEventDispatcher;
		private var _applicationEvent : ApplicationEvent;

		public function configure() : void {
			commandmap.map(ApplicationEvent.BOOT).toCommand(BootMacro);
			commandmap.map(ApplicationEvent.LAUNCH).toCommand(LaunchCommand);

			// var socketController = new SocketController();
			injectormap.map(ApplicationModel).asSingleton();
			injectormap.map(SocketController).asSingleton();
			injectormap.map(APIService).asSingleton();
			injectormap.map(APIDataModel).asSingleton();
			injectormap.map(DevicesDataModel).asSingleton();

			mediatormap.map(ConfigurationView).toMediator(ConfigurationViewMediator);
			mediatormap.map(ApplicationView).toMediator(ApplicationMediator);
			mediatormap.map(BootView).toMediator(BootViewMediator);

			mediatormap.map(MainMenuView).toMediator(MainMenuMediator);
			mediatormap.map(PresetsView).toMediator(PresetsViewMediator);
			mediatormap.map(TimersView).toMediator(TimersViewMediator);
			mediatormap.map(DevicesView).toMediator(DevicesViewMediator);

			mediatormap.map(ApplicationHeaderView).toMediator(IphoneHeaderMediator);

			context.afterInitializing(_init);
		}

		private function _init() : void {
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, _onAppInvoke);
		}

		private function _onAppInvoke(event : InvokeEvent) : void {
			_applicationEvent = new ApplicationEvent(ApplicationEvent.LAUNCH, true, false);
			eventDispatcher.dispatchEvent(_applicationEvent);
		}
	}
}

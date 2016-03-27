package com.lucee.iosclient.views.views {
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Strong;
	import com.lucee.iosclient.views.views.components.textfields.MainMenuTextfield;

	import flash.display.Sprite;
	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class BootView extends Sprite {
		private var _loadingTF : MainMenuTextfield;
		private var _infoTF : MainMenuTextfield;

		public function BootView() {
			_loadingTF = new MainMenuTextfield();
			_loadingTF.setText("LOADING");
			_loadingTF.y = 350;
			_loadingTF.alpha = 0;

			_infoTF = new MainMenuTextfield();
			_infoTF.setText("CONNECTING");
			_infoTF.alpha = 0;
			_infoTF.y = 550;
			_infoTF.setSize(30);

			addChild(_loadingTF);
			addChild(_infoTF);
		}

		public function show(initialDelay : int = 0) : void {
			TweenLite.to(_loadingTF, 1, {y:"-20", autoAlpha:1, ease:Strong.easeOut, delay:initialDelay});
			TweenLite.to(_infoTF, 1, {y:"-20", autoAlpha:1, ease:Strong.easeOut, delay:initialDelay + 0.5});
		}

		public function changeInfoLabel(string : String) : void {
			TweenLite.to(_infoTF, .25, {y:"-10", autoAlpha:0, ease:Strong.easeIn, onComplete:resetAndReTweenInfoLabel, onCompleteParams:[string]});
		}

		private function resetAndReTweenInfoLabel(str : String) : void {
			_infoTF.setText(str);
			_infoTF.y = 550;
			TweenLite.to(_infoTF, 1.1, {y:"-20", autoAlpha:1, ease:Strong.easeOut});
		}

		public function changeLoadingLabel(string : String) : void {
			TweenLite.to(_loadingTF, 1.25, {y:"-40", autoAlpha:0, ease:Strong.easeIn, onComplete:resetAndReTweenLoadingLabel, onCompleteParams:[string]});
		}

		private function resetAndReTweenLoadingLabel(str : String) : void {
			_loadingTF.setText(str);
			_loadingTF.y = 350;
			TweenLite.to(_loadingTF, 1.1, {y:"-20", autoAlpha:1, ease:Strong.easeOut});
		}

		public function hide(delay : int) : void {
			changeLoadingLabel("WELCOME");

			setTimeout(function() : void {
				TweenLite.to(_loadingTF, 1.7, {y:"-60", autoAlpha:0, ease:Strong.easeIn});
				TweenLite.to(_infoTF, 1.15, {y:"-40", autoAlpha:0, ease:Strong.easeIn, delay:.55});
			}, delay * 1000);
		}
	}
}

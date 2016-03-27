package com.lucee.iosclient.views.views {
	import com.beautifycode.helpers.Debug;
	import com.greensock.TweenLite;
	import com.greensock.easing.Sine;
	import com.greensock.easing.Strong;
	import com.lucee.iosclient.views.views.components.textfields.ButtonTextField;
	import com.lucee.iosclient.views.views.components.textfields.DefaultInputTextField;

	import flash.display.BlendMode;
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ConfigurationView extends Sprite {
		private var _darkOverlay : Sprite;
		private var _ipTF : DefaultInputTextField;
		private var _okBtn : ButtonTextField;

		public function ConfigurationView() {
			Debug.log("== ConfigurationView: construct()");
			_darkOverlay = new Sprite();
			_darkOverlay.graphics.beginFill(0x000000, .5);
			_darkOverlay.graphics.drawRect(0, 0, 750, 1334);
			
			addChild(_darkOverlay);

			_ipTF = new DefaultInputTextField();
			_ipTF.setText("192.168.2.140:3000");
			_ipTF.y = 450;
			addChild(_ipTF);

			_okBtn = new ButtonTextField();
			_okBtn.setText("OK");
			_okBtn.y = 750;
			_okBtn.alpha = 1;
			addChild(_okBtn);
		}

		public function show() : void {
		}

		public function get okBtn() : ButtonTextField {
			return _okBtn;
		}

		public function hide() : void {
			TweenLite.to(_ipTF, 1.25, {y:"-80", autoAlpha:0, ease:Strong.easeIn});
			TweenLite.to(_okBtn, 1.25, {y:"-20", autoAlpha:0, ease:Strong.easeIn, delay:.25});
			TweenLite.to(_darkOverlay, 1.25, {autoAlpha:0, delay:1.25, ease:Sine.easeOut});
		}
	}
}

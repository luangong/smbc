package com.customClasses
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.system.System;
	import flash.text.*;

	public class MemoryProfiler extends Sprite {

		private var _timer:Timer;
		private var _interval:Number = 5;

		public var textField:TextField;

		public function MemoryProfiler() {
			addEventListener(Event.ADDED_TO_STAGE, addedToStage, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage, false, 0, true);
			_timer = new Timer(interval * 1000);
			//removeChild(textField)
			//textField = null;
			//textField = new TextField();
			//addChild(textField);
			var tf:TextFormat = new TextFormat();
			tf.size = 20;
			textField.background = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.defaultTextFormat = tf;
		}

		[Inspectable(defaultValue = 5,name = "Sample Interval")]
		public function set interval(value:Number):void {
			_interval = Math.max(1, value);
			_timer.delay = _interval * 1000;
		}

		public function get interval():Number { return _interval; }

		[Inspectable(defaultValue = 0x000000, type = "Color", name = "Text Color")]
		public function set color(value:uint):void {
			textField.textColor = value;
		}

		public function get color():uint { return textField.textColor; }

		private function addedToStage(e:Event):void {
			_timer.addEventListener(TimerEvent.TIMER, onTimer, false, 0, true);
			_timer.start();
			onTimer(null);
		}

		private function removedFromStage(e:Event):void {
			_timer.stop();
		}

		private function onTimer(e:TimerEvent):void {
			var memoryUsed:Number = System.totalMemory/1024;
			var memoryUnit:String = "k";
			if (memoryUsed > 1024) {
				memoryUsed /= 1024;
				memoryUnit = "mb";
			}
			textField.text = memoryUsed.toFixed(1) + memoryUnit;
		}

	}

}

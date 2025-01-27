package com.smbc.projectiles
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Bowser;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.BowserFireBallSpark;
	import com.smbc.main.*;
	import com.smbc.managers.GraphicsManager;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;

	public class BowserFireBall extends Projectile
	{
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		private static const FL_FAKE_END:String = "fakeEnd";
		private static const FL_FAKE_START:String = "fakeStart";
		private var endFrameNum:int;
		private const SPEED:int = 160;
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private const UPD_OFF_SCRN_TMR_DUR:int = 400;
		private var updOffScrnTmr:CustomTimer;
		private var bowser:Bowser;
		private var yLev:int
		private var yFinal:int;

		public function BowserFireBall(_bowser:Bowser):void
		{
			super(_bowser,SOURCE_TYPE_ENEMY);
			bowser = _bowser;
			defyGrav = true;
			sx = SPEED;
			vx = -sx;
			if (vx < 0)
				scaleX = -1;
			vy = 0;
			mainAnimTmr = MAIN_ANIM_TMR;
			var rNumMax:int = 100;
			var numIntervals:int = 3;
			var rNum:Number = Math.random()*rNumMax;
			if (rNum < 33)
				yFinal = bowser.fbLev1;
			else if (rNum >= 33 && rNum < 66)
				yFinal = bowser.fbLev2;
			else if (rNum >= 66)
				yFinal = bowser.fbLev3;
			if (bowser.onScreen)
			{
				x = bowser.nx - bowser.width*.5 - width*.5;
				y = bowser.ny - bowser.hHeight;
			}
			else
			{
				x = locStgRht + width*.5;
				y = yFinal;
				updOffScrnTmr = new CustomTimer(UPD_OFF_SCRN_TMR_DUR,1);
				addTmr(updOffScrnTmr);
				updOffScrnTmr.addEventListener(TimerEvent.TIMER_COMPLETE,updOffScrnTmrHandler,false,0,true);
				updOffScrnTmr.start();
				updateOffScreen = true;
				destroyOffScreen = false;
				dosLft = true;
				dosBot = true;
				dosTop = true;
			}
			SND_MNGR.playSound(SoundNames.SFX_GAME_BOWSER_FIRE);
			GraphicsManager.INSTANCE.addEventListener( CustomEvents.ENEMY_SKIN_CHANGE, enemySkinChangeHandler, false, 0, true);
			enemySkinChangeHandler( new Event(CustomEvents.ENEMY_SKIN_CHANGE) );
			gotoAndStop( convFrameToInt(FL_END) - 1);
//			level.addToLevel( new BowserFireBallSpark(this) );
		}

		protected function enemySkinChangeHandler(event:Event):void
		{
			if ( frameIsEmpty(FL_END) )
			{
				endFrameNum = 2;
				mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
				ACTIVE_ANIM_TMRS_DCT.clear();
			}
			else
			{
				endFrameNum = 3;
				mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			}
			gotoAndStop(FL_START);
			ACTIVE_ANIM_TMRS_DCT.clear();
			ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (ny != yFinal)
			{
				var yfBuffer:int = 5;
				var yInt:int = 3;
				if (ny < yFinal - yfBuffer)
					ny += yInt;
				else if (ny > yFinal + yfBuffer)
					ny -= yInt;
				else
					ny = yFinal;
			}
		}
		private function updOffScrnTmrHandler(event:TimerEvent):void
		{
			updOffScrnTmr.stop();
			updOffScrnTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,updOffScrnTmrHandler);
			updOffScrnTmr = null;
			updateOffScreen = false;
			destroyOffScreen = true;
			if (!onScreen)
				destroy();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (updOffScrnTmr)
				updOffScrnTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,updOffScrnTmrHandler);
			GraphicsManager.INSTANCE.removeEventListener( CustomEvents.ENEMY_SKIN_CHANGE, enemySkinChangeHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (updOffScrnTmr)
				updOffScrnTmr.addEventListener(TimerEvent.TIMER_COMPLETE,updOffScrnTmrHandler,false,0,true);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			bowser.FB_DCT.removeItem(this);
		}
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			if (currentFrame == endFrameNum + 1)
			{
				level.addToLevel( new BowserFireBallSpark(this) );
				gotoAndStop(FL_START);
			}
			//super.checkFrame();
		}
	}

}

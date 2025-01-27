package com.smbc.sound
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.SoundNames;
	import com.smbc.managers.SoundManager;
	import com.smbc.projectiles.MegaManProjectile;

	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;

	public final class MegaManChargeStartSnd extends SoundContainer
	{
		private const RUSH_TMR:CustomTimer = new CustomTimer(1,1);
		private const RUSH_OFFSET:int = 1050;
		private const SFX_MEGA_MAN_CHARGE_LOOP:String = SoundNames.SFX_MEGA_MAN_CHARGE_LOOP;
		public function MegaManChargeStartSnd(soundName:String, soundData:ByteArray = null)
		{
			volType = VT_SFX;
			super(soundName,soundData);
			if (!SND_MNGR.muteSfx)
			{
				RUSH_TMR.delay = RUSH_OFFSET;
				RUSH_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,rushTmrLsr,false,0,true);
			}
		}
		override protected function playSound():void
		{
			super.playSound();
			RUSH_TMR.start();
		}
		private function rushTmrLsr(e:TimerEvent):void
		{
			SoundManager.SND_MNGR.playSound(SFX_MEGA_MAN_CHARGE_LOOP);
//			super.soundCompleteLsr(new Event(Event.SOUND_COMPLETE));
		}

		override protected function soundCompleteLsr(e:Event):void
		{
//			SoundManager.SND_MNGR.playSound(SFX_MEGA_MAN_CHARGE_LOOP);
			super.soundCompleteLsr(e);
		}


		override public function cleanUp():void
		{
			RUSH_TMR.stop();
			RUSH_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,rushTmrLsr);
			super.cleanUp();
		}
	}
}

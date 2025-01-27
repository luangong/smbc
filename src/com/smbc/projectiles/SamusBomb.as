package com.smbc.projectiles
{

	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.DamageValue;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.*;

	import flash.events.TimerEvent;

	public class SamusBomb extends Projectile
	{

		private const FL_BOMB_1:String = "bombStart";
		private const FL_BOMB_2:String = "bomb-2";
		private const FL_BOMB_3:String = "bomb-3";
		private const FL_BOMB_4:String = "bombEnd";
		private const FL_EXPLODE_START:String = "explodeStart";
		private const FL_EXPLODE_END:String = "explodeEnd";
		private const BOMB_TMR:CustomTimer = new CustomTimer(950,1);
		private const EXPLODE_WAIT_TMR:CustomTimer = new CustomTimer(200,1);
		public var hitSamus:Boolean;
		private const Y_OFFSET:int = 12;
		private var psStr:String;
		private const ANIM_FAST_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private const ANIM_SLOW_TMR:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		private var samus:Samus;
		// Private Properties:
		// Initialization:
		public function SamusBomb(samus:Samus)
		{
			this.samus = samus;
			super(samus,SOURCE_TYPE_PLAYER);
			for each (var prop:StatusProperty in Samus.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS) );
			removeProperty( PR_INVULNERABLE_AGG );
			_damageAmt = DamageValue.SAMUS_BOMB;
			stopAnim = true;
			defyGrav = true;
			psStr = samus.pState.toString();
			vx = 0;
			vy = 0;
			mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
			x = samus.nx;
			y = samus.ny - Y_OFFSET;
			gotoAndStop(FL_BOMB_1);
			addTmr(BOMB_TMR);
			BOMB_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,bombTmrLsr);
			BOMB_TMR.start();
			addTmr(EXPLODE_WAIT_TMR);
			EXPLODE_WAIT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,explodeWaitTmrHandler,false,0,true);
			SND_MNGR.playSound(SoundNames.SFX_SAMUS_BOMB_SET);
		}
		private function bombTmrLsr(e:TimerEvent):void
		{
			gotoAndStop(FL_EXPLODE_START);
			stopAnim = false;
			checkAtkRect = true;
			addHitTestableItem(HT_CHARACTER);
			hitTestTypesDct.addItem(HT_ENEMY);
			BOMB_TMR.stop();
			SND_MNGR.playSound(SoundNames.SFX_SAMUS_BOMB_EXPLODE);
			ACTIVE_ANIM_TMRS_DCT.addItem(ANIM_SLOW_TMR);
			mainAnimTmr = ANIM_SLOW_TMR;
		}
		private function explodeWaitTmrHandler(e:TimerEvent):void
		{
			destroy();
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			var bool:Boolean;
			if (stopAnim && ct == ANIM_FAST_TMR)
			{
				var cl:String = currentLabel;
				if (cl == FL_EXPLODE_END)
				{
					if (visible)
						visible = false;
					else
						visible = true;
				}
				else if (cl == FL_BOMB_1)
				{
					gotoAndStop(FL_BOMB_2);
					bool = true;
				}
				else if (cl == FL_BOMB_2)
				{
					gotoAndStop(FL_BOMB_3);
					bool = true;
				}
				else if (cl == FL_BOMB_3)
				{
					gotoAndStop(FL_BOMB_4);
					bool = true;
				}
				else if (cl == FL_BOMB_4)
				{
					gotoAndStop(FL_BOMB_1);
					bool = true;
				}
			}
			else
				bool = super.animate(ct);
			return bool;
		}
		override public function checkFrame():void
		{
			if (!stopAnim && currentFrameLabel == FL_EXPLODE_END)
			{
				stopAnim = true;
				mainAnimTmr = ANIM_FAST_TMR;
				ACTIVE_ANIM_TMRS_DCT.removeItem(ANIM_SLOW_TMR);
				EXPLODE_WAIT_TMR.start();
			}
		}
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_SAMUS_HIT_ENEMY);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (BOMB_TMR.hasEventListener(TimerEvent.TIMER_COMPLETE))
				BOMB_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,bombTmrLsr);
			EXPLODE_WAIT_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,explodeWaitTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (BOMB_TMR && !BOMB_TMR.hasEventListener(TimerEvent.TIMER_COMPLETE))
				BOMB_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,bombTmrLsr);
			EXPLODE_WAIT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,explodeWaitTmrHandler,false,0,true);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			samus.BOMB_DCT.removeItem(this);
		}
	}

}

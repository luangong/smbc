package com.smbc.projectiles
{

	import com.customClasses.*;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFreeze;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Samus;
	import com.smbc.data.DamageValue;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.graphics.SamusSimpleGraphics;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.main.*;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flxmp.Player;

	public class SamusShot extends Projectile
	{

		// Constants:
		public static const SHOT_TYPE_NORMAL:String = "normal";
		public static const SHOT_TYPE_ICE:String = "ice";
		public static const SHOT_TYPE_WAVE:String = "wave";
		public static const SHOT_TYPE_MISSILE:String = "missile";
		private const DESTROY_TMR:CustomTimer = new CustomTimer(50,1);
		private var _shotType:String;
		private var shotDist:Number = 0;
		private var angle:Number = 0;
		private var centerX:Number;
		private var centerY:Number;
		private var waveRange:Number = 30;
		private var shootUp:Boolean;
		private var waveSpeed:uint = 25;
		private var waveAngle:Number = 0;
		private var invertedWave:Boolean;
		private static const FL_NORMAL:String = "normal";
		private static const FL_ICE:String = "ice";
		private static const FL_WAVE:String = "wave";
		private static const FL_MISSILE:String = "missile";
		private var short:Boolean;
		private static  const INVERTED_WAVE_NUM:int = 1;
		private static  const NORMAL_BEAM_SPEED:int = 500;
		private static  const ICE_BEAM_SPEED:int = 500;
		private static  const WAVE_BEAM_SPEED:int = 400;
		private static  const SHORT_BEAM_DISTANCE:int = 100;
		private static const X_OFFSET:int = 25;
		private static const X_OFFSET_UP:int = 4;
		private static const Y_OFFSET_STAND:int = 44;
		private static const Y_OFFSET_STAND_UP:int = 72;
		private static const Y_OFS_WALK_GB:int = 52;
		private static const X_OFFSET_CROUCH:int = 25;
		private static const Y_OFFSET_CROUCH:int = 25;
		private static const Y_OFFSET_JUMP:int = 30;
		private var testTmr:Timer = new Timer(1000);

		private var samus:Samus;
		// Public Properties:

		// Private Properties:
		// Initialization:
		public function SamusShot(samus:Samus,forceType:String = null)
		{
			this.samus = samus;
			_shotType = forceType;
			super(samus,SOURCE_TYPE_PLAYER);
			for each (var prop:StatusProperty in Samus.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			stopAnim = true;
			mainAnimTmr = null;
			defyGrav = true;
			determineShotType();
			if (_shotType != SHOT_TYPE_WAVE)
				addAllGroundToHitTestables();
			setDir();
			DESTROY_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,destroyTmrHandler,false,0,true);
			addTmr(DESTROY_TMR);
			addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS) );
			//testTmr.addEventListener(TimerEvent.TIMER,testTmrHandler,false,0,true);
			//testTmr.start();
		}
		private function testTmrHandler(event:TimerEvent):void
		{
			gotoAndStop(currentFrame + 1);
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (short)
				checkDist();
			if (_shotType == SHOT_TYPE_WAVE)
				formWavePattern();
		}
		private function determineShotType():void
		{
			if (_shotType == SHOT_TYPE_MISSILE)
			{
				missile();
				return;
			}
			if ( !samus.upgradeIsActive(PickupInfo.SAMUS_LONG_BEAM) )
				short = true;
			if ( samus.upgradeIsActive(PickupInfo.SAMUS_ICE_BEAM) )
				iceBeam();
			else if ( samus.upgradeIsActive(PickupInfo.SAMUS_WAVE_BEAM) )
				waveBeam();
			else
				normalBeam();
		}
		private function missile():void
		{
			this.gotoAndStop(FL_MISSILE);
			_shotType = SHOT_TYPE_MISSILE;
			SND_MNGR.playSound(SoundNames.SFX_SAMUS_SHOOT_MISSILE);
			_damageAmt = DamageValue.SAMUS_MISSILE;
			speed = NORMAL_BEAM_SPEED;
			addProperty( new StatusProperty(PR_PIERCE_AGG,10) );
		}
		private function normalBeam():void
		{
			gotoAndStop(FL_NORMAL);
			_shotType = SHOT_TYPE_NORMAL;
			if (short)
			{
				if (samus.skinShootSound)
					SND_MNGR.playSound(samus.skinShootSound);
				else
					SND_MNGR.playSound(SoundNames.SFX_SAMUS_SHORT_BEAM);

			}
			else if (samus.skinShootSound)
					SND_MNGR.playSound(samus.skinShootSound);
			else
				SND_MNGR.playSound(SoundNames.SFX_SAMUS_LONG_BEAM);
			_damageAmt = DamageValue.SAMUS_SHORT_BEAM;
			speed = NORMAL_BEAM_SPEED;
		}
		private function iceBeam():void
		{
			_shotType = SHOT_TYPE_ICE;
			gotoAndStop(FL_ICE);
			if (samus.skinShootSound)
				SND_MNGR.playSound(samus.skinShootSound);
			else
				SND_MNGR.playSound(SoundNames.SFX_SAMUS_ICE_BEAM);
			_damageAmt = DamageValue.SAMUS_ICE_BEAM;
			speed = ICE_BEAM_SPEED;
			addProperty( new StatusProperty(StatusProperty.TYPE_FREEZE_AGG,0,new StatFxFreeze(null,Samus.FREEZE_DUR) ) );
		}
		private function waveBeam():void
		{
			_shotType = SHOT_TYPE_WAVE;
			gotoAndStop(FL_WAVE);
			if (samus.skinShootSound)
				SND_MNGR.playSound(samus.skinShootSound);
			else
				SND_MNGR.playSound(SoundNames.SFX_SAMUS_WAVE_BEAM);
			_damageAmt = DamageValue.SAMUS_WAVE_BEAM;
			speed = WAVE_BEAM_SPEED;
			if (samus.invertedWaveBeam)
				samus.invertedWaveBeam = false;
			else
				samus.invertedWaveBeam = true;
			invertedWave = samus.invertedWaveBeam;
		}
		override protected function setDir():void
		{
			if (samus.upBtn)
			{
				vy = -speed;
				this.rotation = 270;
				if (samus.scaleX > 0)
					x = samus.nx + X_OFFSET_UP;
				else
					x = samus.nx - X_OFFSET_UP;
				y = samus.ny - Y_OFFSET_STAND_UP;
				shootUp = true;
			}
			else if (samus.scaleX > 0)
			{
				vx = speed;
				x = samus.nx + X_OFFSET;
				if (samus.onGround)
				{
					if (samus.cState == Character.ST_CROUCH)
						y = samus.ny - Y_OFFSET_CROUCH;
					else
						y = samus.ny - Y_OFFSET_STAND + samus.skinShootHeightOffset;
				}
				else
					y = samus.ny - Y_OFFSET_JUMP;
			}
			else
			{
				vx = -speed;
				scaleX = -1;
				x = samus.nx - X_OFFSET;
				if (samus.onGround)
				{
					if (samus.cState == Character.ST_CROUCH)
						y = samus.ny - Y_OFFSET_CROUCH;
					else
						y = samus.ny - Y_OFFSET_STAND + samus.skinShootHeightOffset;
				}
				else
					y = samus.ny - Y_OFFSET_JUMP;
			}
			if ( samus.repositionWalkingBullets() )
				y = samus.ny - Y_OFS_WALK_GB;
//			trace("repositoin: "+samus.repositionWalkingBullets() );
			centerX = x;
			centerY = y;
		}
		private function formWavePattern():void
		{
			if (shootUp)
			{
				if (!invertedWave)
				{
					nx = centerX + Math.sin(waveAngle) * waveRange;
					waveAngle -= waveSpeed*dt;
				}
				else
				{
					nx = centerX + Math.sin(waveAngle) * waveRange;
					waveAngle += waveSpeed*dt;
				}
			}
			else
			{
				 if (!invertedWave)
				{
					ny = centerY + Math.sin(waveAngle) * waveRange;
					waveAngle -= waveSpeed*dt;
				}
				else
				{
					ny = centerY + Math.sin(waveAngle) * waveRange;
					waveAngle += waveSpeed*dt;
				}
			}
		}
		private function checkDist():void
		{
			shotDist += speed*dt;
			if (shotDist >= SHORT_BEAM_DISTANCE)
			{
				destroy();
			}
		}
		override public function confirmedHit(mc:IAttackable,damaged:Boolean = true):void
		{
			blowUp();
			super.confirmedHit(mc,damaged);
		}

		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_SAMUS_HIT_ENEMY);
		}

		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
			SND_MNGR.playSound(SoundNames.SFX_SAMUS_BULLET_PROOF);
		}

		override public function hitGround(ground:Ground,side:String):void
		{
			if ( !(ground is Brick) || (ground is Brick && Brick(ground).disabled) )
				blowUp();
			super.hitGround(ground,side);
		}
		public function blowUp():void
		{
			if (_shotType == SHOT_TYPE_MISSILE)
			{
				level.addToLevel(new SamusSimpleGraphics(this, SamusSimpleGraphics.TYPE_MISSILE_EXPLOSION));
				destroy();
				return;
			}
			if (DESTROY_TMR.running)
				return;
			gotoAndStop(currentFrame+1);
			vx = 0;
			vy = 0;
			stopHit = true;
			stopAnim = true;
			stopUpdate = true;
			DESTROY_TMR.start();
		}
		private function destroyTmrHandler(e:TimerEvent):void
		{
			DESTROY_TMR.stop();
			destroy();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			DESTROY_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,destroyTmrHandler);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			samus.BULLET_DCT.removeItem(this);
		}
		public function get shotType():String
		{
			return _shotType;
		}
	}

}

package com.smbc.projectiles
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Ryu;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.DamageValue;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.main.AnimatedObject;

	import flash.display.ColorCorrectionSupport;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;

	public class RyuProjectile extends Projectile
	{
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;

		private static const PAD_MID_CLIMB:int = 20;
		private static const PAD_BOT_CLIMB:int = 45;
		private static const PAD_MID_CLIMB_BACKWARDS:int = 40;
		private static const PAD_BOT_CLIMB_BACKWARDS:int = 45;
		private static const PAD_MID_CROUCH:int = 26;
		private static const PAD_BOT_CROUCH:int = 32;
		private static const PAD_MID_FALL:int = 26;
		private static const PAD_BOT_FALL:int = 42;
		private static const PAD_MID_STAND:int = 30;
		private static const PAD_BOT_STAND:int = 42;
		private static const CROUCH_LABEL:String = "crouch";
		private static const THROW_BACKWARDS_LABEL:String = "Backwards";
		private static const STR_START:String = "Start";
		private static const STR_END:String = "End";
		public static const TYPE_SHURIKEN:String = "shuriken";
		public static const TYPE_WINDMILL_SHURIKEN:String = "windmillShuriken";
		public static const TYPE_FIRE_DRAGON_BALL:String = "fireDragonBall";
		public static const TYPE_ART_OF_FIRE_WHEEL:String = "artOfFireWheel";
		private static const FL_SHURIKEN_END:String = "shurikenEnd";
		private static const FL_SHURIKEN_START:String = "shurikenStart";
		private static const FL_WINDMILL_SHURIKEN_END:String = "windmillShurikenEnd";
		private static const FL_WINDMILL_SHURIKEN_START:String = "windmillShurikenStart";
		private static const FL_FIRE_DRAGON_BALL_START:String = "fireDragonBallStart";
		private static const FL_FIRE_DRAGON_BALL_END:String = "fireDragonBallEnd";
		private static const FL_FIRE_WHEEL_START:String = "fireWheelStart";
		private static const FL_FIRE_WHEEL_END:String = "fireWheelEnd";
		private static const STAR_SMALL_THROW_SPEED:int = 600;
		private static const STAR_BIG_SPRING_AMT:Number = 2300;
		private static const STAR_BIG_VY:int = 85;
		private static const STAR_BIG_VX_MAX:int = 800;
		private static const STAR_BIG_REVERSE_SPEED:int = 800;
		private static const STAR_BIG_REVERSE_DIST:int = 50;
		private static const STAR_BIG_THROW_SPEED:int = 800;
		private static const STAR_BIG_FRICTION_X:Number = .001;
		private static const FIRE_DRAGON_BALL_SPEED:int = 600;
		private static const ART_OF_FIRE_WHEEL_SPEED:int = 600;
		public var destroyHitChar:Boolean;
		private var destroyHitCharTmr:CustomTimer;
		private static const DESTROY_HIT_CHAR_TMR_DUR:int = 300;
		private var type:String;
		private var reverse:Boolean;
		private var thrownRight:Boolean;
		private var justThrown:Boolean;
		private var onRightSide:Boolean;
		private var lastOnRightSide:Boolean;
		private var throwSpeed:Number;
		private var ryu:Ryu;
		public function RyuProjectile(ryu:Ryu,type:String)
		{
			super(ryu,SOURCE_TYPE_PLAYER);
			this.type = type;
			this.ryu = ryu;
			for each (var prop:StatusProperty in Ryu.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			defyGrav = true;
			mainAnimTmr = MAIN_ANIM_TMR;
			var ps:int = ryu.pState;
			setUpType();
			justThrown = true;
		}

		public function isType(projectileType:String):Boolean
		{
			return type == projectileType;
		}

		private function setUpType():void
		{
			switch(type)
			{
				case TYPE_ART_OF_FIRE_WHEEL:
					artOfFireWheel();
					break;
				case TYPE_FIRE_DRAGON_BALL:
					fireDragonBall();
					break;
				case TYPE_SHURIKEN:
					shuriken();
					break;
				case TYPE_WINDMILL_SHURIKEN:
					windmillShuriken();
					break;
			}

		}
		private function artOfFireWheel():void
		{
			_damageAmt = DamageValue.RYU_ART_OF_FIRE_WHEEL;
			addProperty( new StatusProperty( PR_PASSTHROUGH_DEFEAT) );
			gotoAndStop(FL_FIRE_WHEEL_START);
			throwSpeed = ART_OF_FIRE_WHEEL_SPEED;
			setDirection();
			vy = -ART_OF_FIRE_WHEEL_SPEED*.75;
			vx *= .75;
			SND_MNGR.playSound(SoundNames.SFX_RYU_ART_OF_FIRE_WHEEL);
		}
		private function fireDragonBall():void
		{
			_damageAmt = DamageValue.RYU_FIRE_DRAGON_BALL;
			addProperty( new StatusProperty( PR_PASSTHROUGH_DEFEAT) );
			addProperty( new StatusProperty( PR_PIERCE_AGG, PIERCE_STR_ARMOR_PIERCING ) );
			gotoAndStop(FL_FIRE_DRAGON_BALL_START);
			throwSpeed = FIRE_DRAGON_BALL_SPEED;
			setDirection();
			vy = FIRE_DRAGON_BALL_SPEED*.75;
			vx *= .75;
			SND_MNGR.playSound(SoundNames.SFX_RYU_FIRE_DRAGON_BALL);
		}
		private function shuriken():void
		{
			_damageAmt = DamageValue.RYU_SHURIKEN;
			throwSpeed = STAR_SMALL_THROW_SPEED;
			gotoAndStop(FL_SHURIKEN_START);
			SND_MNGR.playSound(SoundNames.SFX_RYU_THROW_SMALL_STAR);
			setDirection();
		}
		private function windmillShuriken():void
		{
			updateOffScreen = true;
			destroyOffScreen = false;
			_damageAmt = DamageValue.RYU_WINDMILL_SHURIKEN;
			throwSpeed = STAR_BIG_THROW_SPEED;
			fx = STAR_BIG_FRICTION_X;
			vxMax = STAR_BIG_VX_MAX;
			addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS) );
			addProperty( new StatusProperty( PR_PIERCE_AGG, PIERCE_STR_ARMOR_PIERCING ) );
			//reverse = true;
			Ryu(ryu).bigStar = this;
			gotoAndStop(FL_WINDMILL_SHURIKEN_START);
			SND_MNGR.playSound(SoundNames.SFX_RYU_THROW_BIG_STAR);
			destroyHitCharTmr = new CustomTimer(DESTROY_HIT_CHAR_TMR_DUR,1);
			addTmr(destroyHitCharTmr);
			destroyHitCharTmr.addEventListener(TimerEvent.TIMER_COMPLETE,destroyHitCharTmrHandler,false,0,true);
			destroyHitCharTmr.start();
			setDirection();
		}
		private function setDirection():void
		{
			var cl:String = ryu.currentLabel;
			var facingRight:Boolean = false;
			if (ryu.scaleX > 0)
				facingRight = true;
			if (ryu.cState == Ryu.ST_CLIMB)
			{
				if (cl.indexOf(THROW_BACKWARDS_LABEL) != -1) // climb and throw backward
				{
					if (facingRight)
					{
						vx = -throwSpeed;
						x = ryu.nx - PAD_MID_CLIMB_BACKWARDS;
					}
					else
					{
						vx = throwSpeed;
						x = ryu.nx + PAD_MID_CLIMB_BACKWARDS;
					}
					y = ryu.ny - PAD_BOT_CLIMB_BACKWARDS;
				}
				else // climb and throw forward
				{
					if (facingRight)
					{
						vx = throwSpeed;
						x = ryu.nx + PAD_MID_CLIMB;
					}
					else
					{
						vx = -throwSpeed;
						x = ryu.nx - PAD_MID_CLIMB;
					}
					y = ryu.ny - PAD_BOT_CLIMB;;
				}
			}
			else if (ryu.onGround)
			{
				if (cl.indexOf(CROUCH_LABEL) != -1) // crouching
				{
					if (facingRight)
					{
						vx = throwSpeed;
						x = ryu.nx + PAD_MID_CROUCH;
					}
					else
					{
						vx = -throwSpeed;
						x = ryu.nx - PAD_MID_CROUCH;
					}
					y = ryu.ny - PAD_BOT_CROUCH;
				}
				else if (ryu.onGround) // standing
				{
					if (facingRight)
					{
						vx = throwSpeed;
						x = ryu.nx + PAD_MID_STAND;
					}
					else
					{
						vx = -throwSpeed;
						x = ryu.nx - PAD_MID_STAND;
					}
					y = ryu.ny - PAD_BOT_STAND;
				}
			}
			else // falling
			{
				if (facingRight)
				{
					vx = throwSpeed;
					x = ryu.nx + PAD_MID_FALL;
				}
				else
				{
					vx = -throwSpeed;
					x = ryu.nx - PAD_MID_FALL;
				}
				y = ryu.ny - PAD_BOT_FALL;
			}
			if (vx > 0)
				thrownRight = true;
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (type == TYPE_WINDMILL_SHURIKEN)
			{
				var dx:Number = ryu.nx - nx;
				var absDx:Number = dx;
				lastOnRightSide = onRightSide;
				if (absDx < 0)
				{
					absDx = -absDx;
					onRightSide = true;
				}
				else
					onRightSide = false;
				if (lastOnRightSide !== onRightSide)
					reverse = false;
				//var absVx:Number = vx;
				//if (absVx < 0)
				//	absVx = -absVx;
				if (onRightSide)
				{
					ax = STAR_BIG_SPRING_AMT;
					if (absDx >= STAR_BIG_REVERSE_DIST)
						reverse = true;
					if (reverse)
						ax = -ax;
				}
				else
				{
					ax = -STAR_BIG_SPRING_AMT;
					if (absDx >= STAR_BIG_REVERSE_DIST)
						reverse = true;
					if (reverse)
						ax = -ax;
				}
				if (justThrown)
				{
					if (thrownRight)
					{
						if (vx < 0)
							justThrown = false;
					}
					else if (vx > 0)
						justThrown = false;
					//if (justThrown && reverse)
					//	vx *= Math.pow(fx,dt);
				}
				//trace("rightSide: "+onRightSide+" ax: "+ax+" absDx: "+absDx+" vx: "+vx+" reverse: "+reverse+" x: "+x+" nx: "+nx);
				vx += ax*dt;
				if (ryu.hMidY > ny)
					vy = STAR_BIG_VY;
				else if (ryu.hMidY < ny)
					vy = -STAR_BIG_VY;
				else
					vy = 0;
			}
		}
		override public function hitCharacter(char:Character,side:String):void
		{
			if (destroyHitChar)
			{
				destroy();
			}
			super.hitCharacter(char,side);
		}
		override public function hitEnemy(enemy:Enemy, hType:String):void
		{
			hitAttackableObject(enemy as IAttackable);
		}
		private function hitAttackableObject(mc:IAttackable):void
		{
			if ( getProperty(PR_PASSTHROUGH_ALWAYS) )
			{
				if (L_HIT_DCT[mc])
				{
					C_HIT_DCT.addItem(mc);
					return;
				}
				C_HIT_DCT.addItem(mc);
				if (mc is Enemy && Enemy(mc).hRect2)
				{
					var enemy:Enemy = mc as Enemy;
					if (enemy.MIN_HIT_DELAY_TMR.running)
						return;
					enemy.MIN_HIT_DELAY_TMR.start();
					enemy.confirmedHitProj(this);
				}
				else
					mc.confirmedHitProj(this);
//				if (mc is Enemy && mc.health > 0 && !Enemy(mc).bulletProof)
//					SND_MNGR.playSound(SoundNames.SFX_RYU_DAMAGE_ENEMY);
			}
		}

		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy && obj.health > 0)
				SND_MNGR.playSound(SoundNames.SFX_RYU_DAMAGE_ENEMY);
		}

		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_RYU_ATTACK_ARMOR);
		}


		private function destroyHitCharTmrHandler(event:TimerEvent):void
		{
			if (destroyHitCharTmr)
			{
				destroyHitCharTmr.reset();
				destroyHitCharTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,destroyHitCharTmrHandler);
				destroyHitCharTmr = null;
			}
			addHitTestableItem(HT_CHARACTER);
			hitTestTypesDct.addItem(HT_ENEMY);
			destroyHitChar = true;
		}
		override public function checkFrame():void
		{
//			var cl:String = currentLabel;
			var cf:int = currentFrame;
			var conv:Function = convFrameToInt;
			if (type == TYPE_SHURIKEN && cf == conv(FL_SHURIKEN_END) + 1)
				gotoAndStop(FL_SHURIKEN_START);
			else if (type == TYPE_WINDMILL_SHURIKEN && previousFrameLabelIs(FL_WINDMILL_SHURIKEN_END) )
				gotoAndStop(FL_WINDMILL_SHURIKEN_START);
			else if (type == TYPE_ART_OF_FIRE_WHEEL && previousFrameLabelIs(FL_FIRE_WHEEL_END) )
				gotoAndStop(FL_FIRE_WHEEL_START);
			else if (type == TYPE_FIRE_DRAGON_BALL && previousFrameLabelIs(FL_FIRE_DRAGON_BALL_END) )
				gotoAndStop(FL_FIRE_DRAGON_BALL_START);
		}
		override public function destroy():void
		{
			super.destroy();
			if (type == TYPE_WINDMILL_SHURIKEN)
				Ryu(ryu).bigStar = null;
		}
		override public function hitGround(ground:Ground,side:String):void
		{
			if (ground is IAttackable)
				hitAttackableObject(ground as IAttackable);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (destroyHitCharTmr)
				destroyHitCharTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,destroyHitCharTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (destroyHitCharTmr)
				destroyHitCharTmr.addEventListener(TimerEvent.TIMER_COMPLETE,destroyHitCharTmrHandler,false,0,true);
		}
	}
}

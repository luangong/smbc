package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.characters.Link;
	import com.smbc.characters.Mario;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.base.MarioBase;
	import com.smbc.data.DamageValue;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.data.SoundNames;
	import com.smbc.events.CustomEvents;
	import com.smbc.level.Level;
	import com.smbc.main.LevObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.projectiles.BowserFireBall;
	import com.smbc.projectiles.FireBar;
	import com.smbc.projectiles.Hammer;
	import com.smbc.utils.GameLoopTimer;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;

	public class Bowser extends Enemy
	{
		public static const ENEMY_NUM:int = EnemyInfo.Bowser;
		protected var xMin:Number;
		protected var xMax:Number;
		private const WALK_SPEED:int = 30;
		private const RUN_SPEED:int = 62;
		public static const MAX_FIREBALLS_ON_SCREEN:int = 2;
		private const MAX_HAMMERS_ON_SCREEN:int = 6;
		public const FB_TMR:CustomTimer = new CustomTimer(1, 1);
		private const FB_TMR_DUR_MIN:int = 1500;
		private const FB_TMR_DUR_MAX:int = 3500;
		private const FB_DEL_TMR:CustomTimer = new CustomTimer(450, 1);
		private const AFTER_FB_TMR:GameLoopTimer = new GameLoopTimer(300, 1);
		private const JUMP_TMR:CustomTimer = new CustomTimer(1000, 1);
		private const JUMP_TMR_DUR_MIN:int = 400;
		private const JUMP_TMR_DUR_MAX:int = 3000;
		private const THROW_HAMMER_TMR_DUR_MIN:int = 40;
		private const THROW_HAMMER_TMR_DUR_MAX:int = 200;
		private const NUM_FIREBALLS_TO_KILL:int = 5;
		private const THROW_HAMMER_TMR:CustomTimer = new CustomTimer(THROW_HAMMER_TMR_DUR_MIN, 1);
		protected var hammerType:String = Hammer.TYPE_BOWSER;
		public const FB_DCT:CustomDictionary = new CustomDictionary(true);
		public const HAMMER_DCT:CustomDictionary = new CustomDictionary(true);
		private static const FL_BREATHE_FIRE:String = "breatheFire";
		private static const FL_CLOSE_1:String = "close-1";
		private static const FL_CLOSE_2:String = "close-2";
		private static const FL_DIE:String = "die_";
		private static const FL_FALL_END:String = "fallEnd";
		private static const FL_FALL_START:String = "fallStart";
		private static const FL_JUMP:String = "jump";
		private static const FL_OPEN_1:String = "open-1";
		private static const FL_OPEN_2:String = "open-2";
		private static const FL_PREPARE_FIRE:String = "prepareFire";
		private static const FL_WALK_END:String = "walkEnd";
		private static const FL_WALK_START:String = "walkStart";
		private static const ST_BREAKING_BRIDGE:String = "breakingBridge";
		private static const ST_CHASE:String = "chase";
		protected static const ST_NORMAL:String = "normal";
		private static const BOOM_STUN_DUR:int = 1000;
		private static const ATK_STUN_DUR:int = 100;
		protected var fireBallClass:Class = BowserFireBall;
		protected var throwHammers:Boolean;
		protected var shootFireballs:Boolean;
		public var fbLev1:Number;
		public var fbLev2:Number;
		public var fbLev3:Number;
		private var stopMoving:Boolean;
		private var firstFB:Boolean = true;
		public var gotAxe:Boolean;
		private var singleFrameJump:Boolean;
		protected static const BOWSER_TYPE_FIREBALL:String = "Fireball";
		protected static const BOWSER_TYPE_HAMMER:String = "Hammer";
		protected static const BOWSER_TYPE_FIREBALL_HAMMER:String = "FireballHammer";

		public function Bowser(frameLabel:String = null):void
		{
			var bowserType:String = BOWSER_TYPE_FIREBALL;
			if (frameLabel != null)
				bowserType = Level.ExtractLevelDataProperty(frameLabel, Level.PROP_BOWSER_TYPE, true);
			determineType(bowserType);

			super();
			addProperty( new StatusProperty(PR_STOP_PAS,Simon.STOP_WATCH_STRENGTH) );
			addProperty( new StatusProperty(PR_FREEZE_PAS, 10) );
			addProperty( new StatusProperty(StatusProperty.TYPE_KNOCK_BACK_PAS, 10) );
			stompable = false;
			if ( !(this is BowserFake) )
				level.bowser = this;
			forceDefaultDeath = true;
			dropsItems = false;
			// moved fireball and hammer level settings to overwriteinitialstats()
//			BOOM_STUN_TMR.delay = BOOM_STUN_DUR;
			/*if ( !(player is Simon) )
				ATK_STUN_TMR.delay = ATK_STUN_DUR;*/
			sy = 400;
			scaleX = -1;
			vx = 0;
			vy = 0;
			removeHitTestableItem(HT_PLATFORM);
			JUMP_TMR.delay = int(Math.random() * (JUMP_TMR_DUR_MAX-JUMP_TMR_DUR_MIN) + JUMP_TMR_DUR_MIN);
			FB_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, fbTmrLsr);
			addTmr(FB_TMR);
			FB_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, fbDelTmrLsr);
			addTmr(FB_DEL_TMR);
			JUMP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, jumpTmrLsr);
			addTmr(JUMP_TMR);
			JUMP_TMR.start();
			AFTER_FB_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, afterFbTmrHandler, false, 0, true);
			stopMoving = false;
			setState(ST_NORMAL);
			GraphicsManager.INSTANCE.addEventListener( CustomEvents.ENEMY_SKIN_CHANGE, enemySkinChangeHandler, false, 0, true);
		}

		protected function enemySkinChangeHandler(event:Event):void
		{
			if (frameIsEmpty(FL_JUMP))
				singleFrameJump = false;
			else
				singleFrameJump = true;
		}
		override protected function updDirection():void
		{

		}
		override public function initiate():void
		{
			super.initiate();
			jumpPwr = 280;
//			xMin = x - TILE_SIZE * 7;
//			xMax = x + TILE_SIZE * 1;
			fbLev1 = y - TILE_SIZE * 0.5;
			fbLev2 = y - TILE_SIZE * 1.5;
			fbLev3 = y - TILE_SIZE * 2.5;
			vx = -WALK_SPEED;
		}
		protected function determineType(bowserType:String):void
		{
			switch(bowserType)
			{
				case BOWSER_TYPE_FIREBALL:
				{
					shootFireballs = true;
					break;
				}
				case BOWSER_TYPE_HAMMER:
				{
					throwHammers = true;
					break;
				}
				case BOWSER_TYPE_FIREBALL_HAMMER:
				{
					shootFireballs = true;
					throwHammers = true;
					break;
				}
			}
//			if ( level.worldNum < 6 )
//				shootFireballs = true;
//			else if ( level.worldNum == 6 || level.worldNum == 7 || (level.worldNum > 9 && level.worldNum < 14) )
//				throwHammers = true;
//			else
//			{
//				shootFireballs = true;
//				throwHammers = true;
//			}
		}
		override protected function overwriteInitialStats():void
		{
			if (throwHammers)
			{
				THROW_HAMMER_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, throwHammerTmrHandler, false, 0, true);
				addTmr(THROW_HAMMER_TMR);
			}
			if (player is MarioBase)
				_health = DamageValue.MARIO_FIRE_BALL * NUM_FIREBALLS_TO_KILL;
			else if (shootFireballs && !throwHammers)
				_health = HealthValue.BOWSER_NORMAL;
			else if (throwHammers && !shootFireballs)
				_health = HealthValue.BOWSER_HAMMER;
			else
				_health = HealthValue.BOWSER_FIREBALL_HAMMER;
			scoreAttack = ScoreValue.BOWSER_ATTACK;
			scoreBelow = ScoreValue.BOWSER_BELOW;
			scoreStar = ScoreValue.BOWSER_STAR;
			scoreStomp = ScoreValue.BOWSER_STOMP;
			super.overwriteInitialStats();
		}
		public function getXMaxMin(bridgeEnd:Number,bridgeStart:Number):void
		{
			xMax = bridgeEnd + TILE_SIZE;
			xMin = bridgeStart + TILE_SIZE * 3;
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (cState == ST_DIE)
				return;
			if (onGround && !JUMP_TMR.running)
			{
				var jumpTmrDelay:int = int(Math.random() * (JUMP_TMR_DUR_MAX - JUMP_TMR_DUR_MIN) + JUMP_TMR_DUR_MIN);
				JUMP_TMR.delay = jumpTmrDelay;
				JUMP_TMR.start();
			}
			if (onGround && player.nx > nx && !gotAxe)
			{
				vx = RUN_SPEED;
				scaleX = 1;
				setState(ST_CHASE);
			}
			else if (!gotAxe)
			{
				if (cState == ST_CHASE)
					returnToNormalStateFromChase();
				setState(ST_NORMAL);
				scaleX = -1;
				if (vx < -WALK_SPEED)
					vx = -WALK_SPEED;
				else if (vx > WALK_SPEED)
					vx = WALK_SPEED;
				if (throwHammers)
				{
					if (vx == 0 && cState != ST_DIE && !shootFireballs)
						vx = -WALK_SPEED;
					if (!THROW_HAMMER_TMR.running)
						THROW_HAMMER_TMR.start();
				}
				if (shootFireballs)
				{
					if (!FB_TMR.running && FB_DCT.length < MAX_FIREBALLS_ON_SCREEN)
						startFbTmr();
				}
			}
			if (onGround && vx != 0 && stopAnim && !AFTER_FB_TMR.running)
				setPlayFrame(FL_WALK_START);
			else if (singleFrameJump && !onGround && !stopMoving && !AFTER_FB_TMR.running && !stopAnim)
				setStopFrame(FL_JUMP);
			if (hLft <= xMin)
			{
				if (vx < 0)
				{
					vx = -vx;
				}
				nx = xMin + hWidth * 0.5;
			}
			else if (hRht >= xMax)
				pastXMax();
		}

		protected function returnToNormalStateFromChase():void
		{
			// for override
		}

		protected function pastXMax():void
		{
			if (vx > 0)
			{
				if (cState == ST_NORMAL)
					vx = -vx;
				else
					vx = 0;
			}
			nx = xMax - hWidth * 0.5;
		}
		/*override protected function stun():void
		{
			var stopStun:Boolean;
			if (BOOM_STUN_TMR.running)
				stopStun = true;
			super.stun();
			if (stopStun)
				stunTmrLsr(new TimerEvent(TimerEvent.TIMER_COMPLETE));
		}*/

		public function startFbTmr():void
		{
			if (firstFB)
				fbTmrLsr(new TimerEvent(TimerEvent.TIMER_COMPLETE));
			firstFB = false;
			var fbTmrDelay:int = int(Math.random() * (FB_TMR_DUR_MAX - FB_TMR_DUR_MIN) + FB_TMR_DUR_MIN);
			FB_TMR.reset();
			FB_TMR.delay = fbTmrDelay;
			FB_TMR.start();
		}
		private function fbTmrLsr(e:TimerEvent):void
		{
			FB_TMR.reset();
			if (onScreen)
			{
				if (cState == ST_NORMAL && shootFireballs)
				{
					if (FB_DEL_TMR.running)
						FB_DEL_TMR.reset();
					FB_DEL_TMR.start();
					stopMoving = true;
					stopAnim = true;
					vx = 0;
					setStopFrame(FL_PREPARE_FIRE);
					/*if (currentFrameLabel == FL_OPEN_1)
						gotoAndStop(FL_CLOSE_1);
					else if (currentFrameLabel == FL_OPEN_2)
						gotoAndStop(FL_CLOSE_2);*/
				}
			}
			else
			{
				if (FB_DEL_TMR.running)
					FB_DEL_TMR.reset();
				FB_DEL_TMR.start();
			}
		}
		private function fbDelTmrLsr(e:TimerEvent):void
		{
			FB_DEL_TMR.reset();
			if (onScreen)
			{
				if (cState == ST_NORMAL && FB_DCT.length < MAX_FIREBALLS_ON_SCREEN && shootFireballs)
				{
					var fb:BowserFireBall = new fireBallClass(this) as BowserFireBall;
					FB_DCT.addItem(fb);
					level.addToLevel(fb);
				}
				stopMoving = false;
				stopAnim = false;
				if (singleFrameJump)
				{
					setStopFrame(FL_BREATHE_FIRE);
					AFTER_FB_TMR.start();
				}
				else
					setPlayFrame(FL_WALK_START);
				/*if (currentFrameLabel == FL_CLOSE_1)
					gotoAndStop(FL_OPEN_1);
				else if (currentFrameLabel == FL_CLOSE_2)
					gotoAndStop(FL_OPEN_2);*/
				if (cState == ST_NORMAL)
				{
					if (Math.random() < 0.4) // left
					{
						vx = -WALK_SPEED;
					}
					else // right
					{
						vx = WALK_SPEED;
					}
				}
			}
			else if (FB_DCT.length < MAX_FIREBALLS_ON_SCREEN)
			{
				fb = new fireBallClass(this);
				FB_DCT.addItem(fb);
				level.addToLevel(fb);
			}
		}
		protected function afterFbTmrHandler(event:Event):void
		{
			if (onGround || !singleFrameJump )
				setPlayFrame(FL_WALK_START);
			else
				setStopFrame(FL_JUMP);
		}
		private function throwHammerTmrHandler(event:TimerEvent):void
		{
			if (!throwHammers)
				return;
			THROW_HAMMER_TMR.reset();
			THROW_HAMMER_TMR.delay = int(Math.random() * (THROW_HAMMER_TMR_DUR_MAX - THROW_HAMMER_TMR_DUR_MIN) + THROW_HAMMER_TMR_DUR_MIN);
			if (cState == ST_NORMAL && HAMMER_DCT.length < MAX_HAMMERS_ON_SCREEN)
			{
				var hammer:Hammer = new Hammer(hammerType, this);
				HAMMER_DCT.addItem(hammer);
				level.addToLevel(hammer);
			}
		}
		public function breakBridgeStart():void
		{
			setState(ST_BREAKING_BRIDGE);
			setStopFrame(FL_FALL_START);
			vx = 0;
			vy = 0;
			defyGrav = true;
			stopHit = true;
			gotAxe = true;
		}
		public function breakBridgeInc():void
		{
			var cl:String = currentLabel;
			if (cl == FL_FALL_END)
				setStopFrame(FL_FALL_START);
			else
				setStopFrame(FL_FALL_END);
		}
		public function breakBridgeEnd():void
		{
			defyGrav = false;
			stopAnim = true;
			SND_MNGR.playSoundNow(SoundNames.SFX_GAME_BOWSER_FALL);
		}
		private function jumpTmrLsr(e:TimerEvent):void
		{
			JUMP_TMR.reset();
			if (onGround && cState == ST_NORMAL)
				jump();
		}
		private function jump():void
		{
			vy = -jumpPwr;
			onGround = false;
			if (singleFrameJump && !AFTER_FB_TMR.running)
				setStopFrame(FL_JUMP);
		}
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			if (cf == getLabNum(FL_WALK_END) + 1)
				setPlayFrame(FL_WALK_START);
			/*else if (cState == ST_BREAKING_BRIDGE && cf == getLabNum(FL_FALL_END) + 1)
				setPlayFrame(FL_FALL_START);*/
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			FB_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE, fbTmrLsr);
			FB_DEL_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE, fbDelTmrLsr);
			JUMP_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE, jumpTmrLsr);
			AFTER_FB_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE, afterFbTmrHandler);
			if (throwHammers)
				THROW_HAMMER_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE, throwHammerTmrHandler);
			GraphicsManager.INSTANCE.removeEventListener( CustomEvents.ENEMY_SKIN_CHANGE, enemySkinChangeHandler);
		}
		override public function rearm():void
		{
			super.rearm();
			if ( !(this is BowserFake) )
				level.bowser = this;
		}
		override public function die(dmgSrc:LevObj = null):void
		{
//			stopTimers();
			super.die(dmgSrc);
			setStopFrame(FL_DIE + level.worldNum.toString() );
			vx = 0;
			SND_MNGR.playSound(SoundNames.SFX_GAME_BOWSER_FALL);
			SND_MNGR.removeStoredSound(SoundNames.SFX_GAME_KICK_SHELL);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			FB_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, fbTmrLsr);
			FB_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, fbDelTmrLsr);
			JUMP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, jumpTmrLsr);
			if (throwHammers)
				THROW_HAMMER_TMR.addEventListener(TimerEvent.TIMER_COMPLETE, throwHammerTmrHandler, false, 0, true);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (level.bowser == this)
				level.bowser = null;
		}


	}

}

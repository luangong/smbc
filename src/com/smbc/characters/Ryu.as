package com.smbc.characters
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.DamageValue;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.MusicType;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.enums.RyuSimonThrowType;
	import com.smbc.enums.RyuSpecialWeapon;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.HudAlwaysOnTop;
	import com.smbc.graphics.fontChars.FontCharRyu;
	import com.smbc.ground.Brick;
	import com.smbc.ground.Ground;
	import com.smbc.ground.Platform;
	import com.smbc.ground.SimpleGround;
	import com.smbc.ground.SpringRed;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.LevObj;
	import com.smbc.managers.TutorialManager;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.Vine;
	import com.smbc.projectiles.Projectile;
	import com.smbc.projectiles.RyuProjectile;
	import com.smbc.sound.MusicInfo;
	import com.smbc.text.TextFieldContainer;
	import com.smbc.utils.CharacterSequencer;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class Ryu extends Character
	{
		public static const CHAR_NAME:String = CharacterInfo.Ryu[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Ryu[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Ryu[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Ryu[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const IND_CI_Ryu:int = 1;
		protected static const RYU_ART_OF_FIRE_WHEEL:String = PickupInfo.RYU_ART_OF_FIRE_WHEEL;
		protected static const RYU_SHURIKEN:String = PickupInfo.RYU_SHURIKEN;
		protected static const RYU_WINDMILL_SHURIKEN:String = PickupInfo.RYU_WINDMILL_SHURIKEN;
		protected static const RYU_FIRE_DRAGON_BALL:String = PickupInfo.RYU_FIRE_DRAGON_BALL;
		protected static const RYU_JUMP_SLASH:String = PickupInfo.RYU_JUMP_SLASH;
		protected static const RYU_INFINITE_JUMP_SLASH:String = PickupInfo.RYU_INFINITE_JUMP_SLASH;
		protected static const RYU_SCROLL:String = PickupInfo.RYU_SCROLL;
		protected static const RYU_SWORD_EXTENSION:String = PickupInfo.RYU_SWORD_EXTENSION;
		public static const RYU_NINJITSU_AMMO_BIG:String = PickupInfo.RYU_NINJITSU_AMMO_BIG;
		public static const RYU_NINJITSU_AMMO_SMALL:String = PickupInfo.RYU_NINJITSU_AMMO_SMALL;
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ RYU_SWORD_EXTENSION ],
			[ RYU_SHURIKEN, RYU_ART_OF_FIRE_WHEEL, RYU_WINDMILL_SHURIKEN, RYU_FIRE_DRAGON_BALL, RYU_JUMP_SLASH, RYU_SCROLL ]
		];

		override public function get classicGetMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ RYU_SWORD_EXTENSION ]); }

		override public function get classicGetFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ RYU_SCROLL ]); }

		override public function get classicLoseFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ ]); }

		public static const MUSHROOM_UPGRADES:Array = [ ];
		public static const NEVER_LOSE_UPGRADES:Array = [ RYU_SHURIKEN, RYU_ART_OF_FIRE_WHEEL, RYU_WINDMILL_SHURIKEN, RYU_FIRE_DRAGON_BALL, RYU_JUMP_SLASH, RYU_SCROLL ];
		public static const RESTORABLE_UPGRADES:Array = [ ];
		public static const START_WITH_UPGRADES:Array = [ RYU_SHURIKEN ];
		public static const SINGLE_UPGRADES_ARR:Array = [ RYU_SHURIKEN, RYU_ART_OF_FIRE_WHEEL, RYU_WINDMILL_SHURIKEN, RYU_FIRE_DRAGON_BALL, RYU_JUMP_SLASH ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [
		];
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM, RYU_SHURIKEN ];
		private static const CLASSIC_DEFAULT_AMMO:int = 25;
		private static const NINJITSU_AMMO_MAX_DEFAULT:int = 99;
		private static const NINJITSU_AMMO_MAX_SCROLL:int = 200;
		public static const ICON_ORDER_ARR:Array = [ RYU_SHURIKEN, RYU_ART_OF_FIRE_WHEEL, RYU_WINDMILL_SHURIKEN, RYU_FIRE_DRAGON_BALL, RYU_JUMP_SLASH, RYU_SWORD_EXTENSION, RYU_SCROLL ];
		private static const AMMO_TYPE_NINJITSU:String = "ninjitsuAmmoName";
		public static const AMMO_ARR:Array = [ [ AMMO_TYPE_NINJITSU, 50, NINJITSU_AMMO_MAX_DEFAULT, 1 ] ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ RYU_SHURIKEN, 3], [ RYU_ART_OF_FIRE_WHEEL, 5], [ RYU_WINDMILL_SHURIKEN, 5], [ RYU_FIRE_DRAGON_BALL, 5], [ RYU_JUMP_SLASH, 5 ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
		public static const DROP_ARR:Array = [ [ 0, RYU_NINJITSU_AMMO_SMALL ], [ .8, RYU_NINJITSU_AMMO_BIG ] ];
		public static const WIN_SONG_DUR:int = 4000;
		private var SUBWEAPON_OVERRIDE:String = RYU_JUMP_SLASH;
		public static const CHAR_SEL_END_DUR:int = 1900;
		private const DIE_TMR_DEL_NORMAL:int = 3800;
		private const DIE_TMR_DEL_NORMAL_MAX:int = 6000;
		private const DIE_TMR_DEL_PIT:int = 3800;
		private const SECONDS_LEFT_SND:String = SoundNames.BGM_RYU_SECONDS_LEFT;
		private const SND_MUSIC_WIN:String = SoundNames.MFX_RYU_WIN;
		private static const CLR_GRAY:uint = 0xff8989a3;
		private static const CLR_SKIN:uint = 0xffffc4ea;
		private static const CLR_BROWN_OUTLINE:uint = 0xff561d00;
		private static const CLR_BLUE:uint = 0xff9290ff;
		private static const CLR_BLOOD_RED:uint = 0xffae1212;
		private static const CLR_BLACK_RED_OUTLINE:uint = 0xff2d0f00;
		private const REPL_COLOR_1_1:uint = CLR_BROWN_OUTLINE;
		private const REPL_COLOR_2_1:uint = CLR_GRAY;
		private const REPL_COLOR_3_1:uint = CLR_SKIN;
		private const REPL_COLOR_1_2:uint = CLR_BROWN_OUTLINE;
		private const REPL_COLOR_2_2:uint = CLR_BLUE;
		private const REPL_COLOR_3_2:uint = CLR_SKIN;
		private const REPL_COLOR_1_3:uint = CLR_BLACK_RED_OUTLINE;
		private const REPL_COLOR_2_3:uint = CLR_BLOOD_RED;
		private const REPL_COLOR_3_3:uint = CLR_SKIN;
		private static const FL_AMMO_ICON:String = "ninjitsuAmmo";
		private static const FL_CHECK_ATK_RECT_STAND:String = "attack-2";
		private static const FL_CHECK_ATK_RECT_FALL:String = "fallAttackStart";
		private static const FL_CHECK_ATK_RECT_CROUCH:String = "crouchAttack-2";
		private static const FL_ATTACK_START:String = "attackStart";
		private static const FL_ATTACK_END:String = "attackEnd";
		private static const FL_STAND_START:String = "standStart";
		private static const FL_STAND_END:String = "standEnd";
		public static const FL_WALK_START:String = "walkStart";
		public static const FL_WALK_END:String = "walkEnd";
		private static const FL_THROW_START:String = "throwStart";
		private static const FL_THROW_END:String = "throwEnd";
		private static const FL_CROUCH:String = "crouch";
		private static const FL_CROUCH_ATTACK_START:String = "crouchAttackStart";
		private static const FL_CROUCH_ATTACK_END:String = "crouchAttackEnd";
		private static const FL_CROUCH_THROW_START:String = "crouchThrowStart";
		private static const FL_CROUCH_THROW_END:String = "crouchThrowEnd";
		private static const FL_FALL:String = "fall";
		private static const FL_FALL_ATTACK_START:String = "fallAttackStart";
		private static const FL_FALL_ATTACK_END:String = "fallAttackEnd";
		private static const FL_FALL_THROW_START:String = "fallThrowStart";
		private static const FL_FALL_THROW_END:String = "fallThrowEnd";
		public static const FL_CLIMB_START:String = "climbStart";
		public static const FL_CLIMB_END:String = "climbEnd";
		private static const FL_CLIMB_STOP:String = "climbStop";
		private static const FL_CLIMB_THROW_START:String = "climbThrowStart";
		private static const FL_CLIMB_THROW_END:String = "climbThrowEnd";
		private static const FL_CLIMB_THROW_BACKWARDS_START:String = "climbThrowBackwardsStart";
		private static const FL_CLIMB_THROW_BACKWARDS_END:String = "climbThrowBackwardsEnd";
		public static const FL_CLIMB_THROW_BACKWARDS_PROJECTILE:String = "climbThrowBackwards-2";
		private static const FL_CLIMB_POLE_START:String = "climbPoleStart";
		private static const FL_CLIMB_POLE_END:String = "climbPoleEnd";
		public static const FL_FLIP_START:String = "flipStart";
		public static const FL_FLIP_END:String = "flipEnd";
		public static const FL_JUMP_SLASH_START:String = "jumpSlashStart";
		public static const FL_JUMP_SLASH_END:String = "jumpSlashEnd";
		private static const FL_TAKE_DAMAGE:String = "takeDamage";
		private static const FL_DIE:String = "die";
		private static const SWORD_NAME:String = "swordStg";
		private static const SWORD_WAVE_NAME:String = "swordWaveStg";
		private const CHOOSE_CHAR_SEQ:Array = [
			[ 1, pressRhtBtn ], [ 100, pressJmpBtn ], [ 1, pressUpBtn ]
		];
		private static const A_RECT_NORMAL:Rectangle = new Rectangle(16,-50,48,13);
		private static const A_RECT_WAVE_NORMAL:Rectangle = new Rectangle(16,-50,75,32);
		private static const A_RECT_CROUCH:Rectangle = new Rectangle(16,-38,48,15);
		private static const A_RECT_WAVE_CROUCH:Rectangle = new Rectangle(16,-38,79,32);
		public static const SN_RYU_ATTACK:String = SoundNames.SFX_RYU_ATTACK;
		private static const SN_GET_PICKUP:String = SoundNames.SFX_RYU_GET_PICKUP;
		private static const SN_JUMP_SLASH:String = SoundNames.SFX_RYU_JUMP_SLASH;
		public static const SN_RYU_DAMAGE_ENEMY:String = SoundNames.SFX_RYU_DAMAGE_ENEMY;
		public static const SN_RYU_JUMP:String = SoundNames.SFX_RYU_JUMP;
		public static const ST_CLIMB:String = "climb";
		public static const WALK_START_LAB:String = FL_WALK_START;
		public static const WALK_END_LAB_PLAIN:String = "walk-4";
		private static const WALK_END_LAB_HAGGLE:String = "walkEnd";
//		public static var walkEndLab:String = FL_WALK_END;
		public static const WALK_SPEED:int = 185;
		public static const JUMP_PWR:int  = 565;
		public static const JUMP_PWR_WATER:int  = 400;
		private static const CLIMB_JUMP_PWR:int = 300;
		private static const CLIMB_TOP_JUMP_PWR:int = 430;
		public static const GRAVITY:int = 1400;
		private static const GRAVITY_WATER:int = 500;
		private static const DEF_SPRING_PWR:int = 500;
		private static const BOOST_SPRING_PWR:int = 1000;
		private static const VY_MAX_PSV:int = 700;
		public static const CLIMB_SPEED:int = 120;
		private static const FLIP_MAX_VY:int = -200;
		private static const BOUNCE_POWER:int = 550;
		private static const CLIMB_GROUND_CHECK_DIST:int = 50;
		private static const CLIMB_TOP_JUMP_OFS:int = -10;
		private static const CLIMB_TOP_OFS:int = 20;
		private static const CLIMB_BOT_OFS:int = 25;
		private static const CLIMB_BOT_MAX_GRAPPLE_INCREASE:int = 10;
		private static const CLIMB_BOT_GRAPPLE_TEST_INC:int = 2;
		private const DIE_VERT_BOOST:int = 385;
		private const DIE_HORZ_BOOST:int = 150;
		public static const CLIMB_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_VERY_SLOW_TMR;
		public static const FLIP_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private static const WALK_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private static const STAND_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private static const ATTACK_ANIM_TMR:CustomTimer = new CustomTimer(45);
		public const CANCEL_GRAPPLE_TMR:CustomTimer = new CustomTimer(250,1);
		private static const FLIP_TMR:CustomTimer = new CustomTimer(400,1);
		private var haggleMan:Boolean;
		private static const ATTACK_FRAMES_DCT:CustomDictionary = new CustomDictionary();
		private static const SWORD_FRAMES_1_ARR:Array = [
			FL_ATTACK_START,"attack-2","attack-3",FL_FALL_ATTACK_START,"fallAttack-2","fallAttack-3",FL_CROUCH_ATTACK_START,"crouchAttack-2","crouchAttack-3"
		];
		private static const SWORD_FRAMES_2_ARR:Array = [
			"attack-4","attack-5","fallAttack-4","fallAttack-5","crouchAttack-4","crouchAttack-5"
		];
		private static const SWORD_WAVE_FRAMES_ARR:Array = [
			FL_ATTACK_START,"attack-2","attack-3", FL_FALL_ATTACK_START,"fallAttack-2","fallAttack-3",FL_CROUCH_ATTACK_START,"crouchAttack-2","crouchAttack-3"
		];
		private static const THROW_PROJECTILE_FRAMES_DCT:CustomDictionary = new CustomDictionary();
		private const HIT_DIST_OVER_OFFSET:int = 30;
		private static const MAX_PROJECTILES_ON_SCREEN:int = 1;
		private static const PT_STAR_BIG:String = RyuProjectile.TYPE_WINDMILL_SHURIKEN;
		private static const PT_STAR_SMALL:String = RyuProjectile.TYPE_SHURIKEN;
		private static const NINJITSU_AMMO_BIG_VALUE:int = 10;
		private static const NINJITSU_AMMO_SMALL_VALUE:int = 5;
		private var startedDeathMusic:Boolean;
		public var climbPlat:Platform;
		private const MAX_PLAT_DIST:int = 30;
		private const NSF_STR_DIE:String = MusicInfo.CHAR_STR_RYU + MusicInfo.TYPE_DIE;
		public var swordStg:MovieClip;
		public var swordWaveStg:MovieClip;
		private var sword:MovieClip;
		private var swordWave:MovieClip;
		private static var attackFramesArr:Array = [
			"attack-2","attack-3",
			"fallAttack-2","fallAttack-3",
			"crouchAttack-2","crouchAttack-3"
		];
		private static var attackFramesHaggleManArr:Array = [
			"attackStart","attack-2",
			"fallAttackStart","fallAttack-2",
			"crouchAttackStart","crouchAttack-2"
		];
		private var throwProjectileFramesArr:Array = [
			"throw-2","crouchThrow-2","fallThrow-2","climbThrow-2","climbThrowBackwards-2"
		];
		public var cancelGrappleGroundPos:Number;
		private var justCrouched:Boolean;
		private var attackedInAir:Boolean;
		private var flipping:Boolean;
		private var climbThrowing:Boolean;
		private var topJumpPos:Boolean;
		private var topClimbPos:Boolean;
		private var botClimbPos:Boolean;
		public var forceAttachToWall:Boolean;
		public var bigStar:RyuProjectile;
		private var curSubWeapon:String;
		private var jumpSlash:Boolean;
		public static const DEFAULT_PROPS_DCT:CustomDictionary = new CustomDictionary();
		public static const SKIN_PREVIEW_SIZE:Point = new Point(30,36);
		public static const SKIN_ORDER:Array = [
			SKIN_RYU_NES,
			SKIN_RYU_SNES,
			SKIN_RYU_GB,
			SKIN_RYU_SMS,
			SKIN_RYU_X1,
			SKIN_RYU_ATARI,
			SKIN_RYU_CLONE,
			SKIN_HAYATE,
			SKIN_KAEDE,
			SKIN_SHADOW_SNES,
			SKIN_HAGGLE_MAN_NES,
			SKIN_HAGGLE_MAN_SNES
		];

		public static const SKIN_RYU_NES:int = 0;
		public static const SKIN_RYU_SNES:int = 1;
		public static const SKIN_RYU_GB:int = 2;
		public static const SKIN_HAGGLE_MAN_NES:int = 3;
		public static const SKIN_HAGGLE_MAN_SNES:int = 4;
		public static const SKIN_SHADOW_SNES:int = 5;
		public static const SKIN_RYU_X1:int = 6;
		public static const SKIN_RYU_ATARI:int = 7;
		public static const SKIN_RYU_SMS:int = 8;
		public static const SKIN_RYU_CLONE:int = 9;
		public static const SKIN_HAYATE:int = 10;
		public static const SKIN_KAEDE:int = 11;

		public static const SPECIAL_SKIN_NUMBER:int = SKIN_RYU_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_RYU_ATARI;

		private var lastThrowType:RyuSimonThrowType;

		public function Ryu()
		{
			charNum = CHAR_NUM;
			super();
			poorBowserFighter = true;
			if (!DEFAULT_PROPS_DCT.length)
			{
				DEFAULT_PROPS_DCT.addItem( new StatusProperty(PR_FLASH_AGG,0, new StatFxFlash(null,AnimationTimers.DEL_FAST,400) ) );
			}
			for each (var prop:StatusProperty in DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			_canGetAmmoFromCoinBlocks = true;
			_canGetAmmoFromBricks = true;
			_charName = CHAR_NAME;
			_charNameTxt = CHAR_NAME_TEXT;
			_charNameCaps = CHAR_NAME_CAPS;
			winSongDur = WIN_SONG_DUR;
			_secondsLeftSnd = SECONDS_LEFT_SND;
			_sndWinMusic = SND_MUSIC_WIN;
			_secondsLeftSndIsBgm = true;
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			_usesHorzObjs = true;
			_usesVertObjs = true;
			boostSpringPwr = BOOST_SPRING_PWR;
			defSpringPwr = DEF_SPRING_PWR;
			walkStartLab = WALK_START_LAB;
			walkEndLab = walkEndLab;
		}
		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(SWORD_NAME,SWORD_FRAMES_1_ARR.concat(SWORD_FRAMES_2_ARR),true );
			removeObjsFromFrames(SWORD_WAVE_NAME,SWORD_WAVE_FRAMES_ARR,true );
		}
		override public function setCurrentBmdSkin(bmc:BmdSkinCont, characterInitiating:Boolean = false):void
		{
			super.setCurrentBmdSkin(bmc);
			var attackArr:Array = attackFramesArr;
			if (skinNum == 3 || skinNum == 4)
			{
				haggleMan = true;
				attackArr = attackFramesHaggleManArr;
				walkEndLab = WALK_END_LAB_HAGGLE;
			}
			else
			{
				haggleMan = false;
				walkEndLab = WALK_END_LAB_PLAIN;
			}
			if (cState == ST_WALK)
				setPlayFrame(FL_WALK_START);
			setSwordVisibility();
			ATTACK_FRAMES_DCT.clear();
			var n:int = attackArr.length;
			for (var i:int = 0; i < n; i++)
			{
				ATTACK_FRAMES_DCT.addItem(attackArr[i]);
			}
		}
		private function setSwordVisibility():void
		{
			var bool:Boolean = true;
			if ( upgradeIsActive(RYU_SWORD_EXTENSION) )
				bool = false;
			removeObjsFromFrames(SWORD_NAME,SWORD_FRAMES_2_ARR,true, int(bool) );
			removeObjsFromFrames(SWORD_WAVE_NAME,SWORD_WAVE_FRAMES_ARR,false, int(!bool) );
		}
		override public function initiate():void
		{
			super.initiate();
			var n:int = throwProjectileFramesArr.length;
			for (var i:int = 0; i < n; i++)
			{
				THROW_PROJECTILE_FRAMES_DCT.addItem(throwProjectileFramesArr[i]);
			}
			throwProjectileFramesArr = null;
		}
		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			sword = thisMc.getChildByName(SWORD_NAME) as MovieClip;
			swordWave = thisMc.getChildByName(SWORD_WAVE_NAME) as MovieClip;
		}
		override public function setStats():void
		{
			inColor1_1 = REPL_COLOR_1_1;
			inColor2_1 = REPL_COLOR_2_1;
			inColor3_1 = REPL_COLOR_3_1;
			inColor1_2 = REPL_COLOR_1_2;
			inColor2_2 = REPL_COLOR_2_2;
			inColor3_2 = REPL_COLOR_3_2;
			inColor1_3 = REPL_COLOR_1_3;
			inColor2_3 = REPL_COLOR_2_3;
			inColor3_3 = REPL_COLOR_3_3;
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			if (level.waterLevel)
			{
				defGravity = gravity;
				gravity = GRAVITY_WATER;
				defGravityWater = gravity;
				jumpPwr = JUMP_PWR_WATER;
			}
			defSpringPwr = DEF_SPRING_PWR;
			boostSpringPwr = BOOST_SPRING_PWR;
			vyMaxPsv = VY_MAX_PSV;
			//vyMaxNgv = jumpPwr;
			xSpeed = WALK_SPEED;
			vxMax = xSpeed;
			pState2 = true;
			super.setStats();
			beginIdleStance();
			/*if (SUBWEAPON_OVERRIDE)
			{
				STAT_MNGR.addCharUpgrade(charNum,MUSHROOM);
				STAT_MNGR.addCharUpgrade(charNum,SUBWEAPON_OVERRIDE);
			}*/
			tsTxt.UpdAmmoIcon(true, FL_AMMO_ICON);
			setAmmo(AMMO_TYPE_NINJITSU, getAmmo(AMMO_TYPE_NINJITSU) );
			sword.visible = false;
			swordWave.visible = false;
			ATTACK_ANIM_TMR.addEventListener(TimerEvent.TIMER,attackAnimTmrHandler,false,0,true);
			addTmr(ATTACK_ANIM_TMR);
			CANCEL_GRAPPLE_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,cancelGrappleTmrHandler,false,0,true);
			addTmr(CANCEL_GRAPPLE_TMR);
			FLIP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,flipTmrHandler,false,0,true);
			addTmr(FLIP_TMR);
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			if (GameSettings.classicMode && start && !upgradeIsActive(classicStartWeapon) && !(level is TitleLevel) )
				STAT_MNGR.addCharUpgrade(charNum, classicStartWeapon);
			setSwordVisibility();
			setCurSubWeapon();
			updMaxAmmo();
		}

		private function getClassicWeapon(weapon:RyuSpecialWeapon):String
		{
			switch(weapon)
			{
				case RyuSpecialWeapon.ArtOfFireWheel:
					return RYU_ART_OF_FIRE_WHEEL;
				case RyuSpecialWeapon.FireDragonBall:
					return RYU_FIRE_DRAGON_BALL;
				case RyuSpecialWeapon.JumpSlash:
					return RYU_JUMP_SLASH;
				case RyuSpecialWeapon.Shuriken:
					return RYU_SHURIKEN;
				case RyuSpecialWeapon.WindmillShuriken:
					return RYU_WINDMILL_SHURIKEN;
				default:
					return RYU_WINDMILL_SHURIKEN;
			}
		}

		private function get classicStartWeapon():String
		{
			return getClassicWeapon(GameSettings.ryuStartWeapon);
		}

		private function get classicExtraWeapon():String
		{
			return getClassicWeapon(GameSettings.ryuExtraWeapon);
		}

		private function updMaxAmmo():void
		{
			if (upgradeIsActive(RYU_SCROLL))
				setMaxAmmo(AMMO_TYPE_NINJITSU,NINJITSU_AMMO_MAX_SCROLL);
			else
				setMaxAmmo(AMMO_TYPE_NINJITSU,NINJITSU_AMMO_MAX_DEFAULT);
		}
		private function setCurSubWeapon():void
		{
			if ( upgradeIsActive(RYU_ART_OF_FIRE_WHEEL) )
				curSubWeapon = RYU_ART_OF_FIRE_WHEEL;
			else if ( upgradeIsActive(RYU_FIRE_DRAGON_BALL) )
				curSubWeapon = RYU_FIRE_DRAGON_BALL;
			else if ( upgradeIsActive(RYU_JUMP_SLASH) )
				curSubWeapon = RYU_JUMP_SLASH;
			else if ( upgradeIsActive(RYU_SHURIKEN) )
				curSubWeapon = RYU_SHURIKEN;
			else if ( upgradeIsActive(RYU_WINDMILL_SHURIKEN) )
				curSubWeapon = RYU_WINDMILL_SHURIKEN;
			else
				curSubWeapon = null;
		}
		override public function forceWaterStats():void
		{
			defGravity = gravity;
			gravity = GRAVITY_WATER;
			defGravityWater = gravity;
			jumpPwr = JUMP_PWR_WATER;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			gravity = GRAVITY;
			jumpPwr = JUMP_PWR;
			super.forceNonwaterStats();
		}
		override protected function checkPlatform():void
		{
			if (climbPlat)
			{
				if (scaleX > 0)
				{
					if (checkPlatDist(nx - climbPlat.hLft))
					{
						detachFromWall();
						return;
					}
					nx = climbPlat.hLft - hWidth/2;
				}
				else
				{
					if (checkPlatDist(nx - climbPlat.hRht))
					{
						detachFromWall();
						return;
					}
					nx = climbPlat.hRht + hWidth/2;
				}
				if (checkPlatDist( (ny - hHeight/2) - climbPlat.hMidY) )
				{
					detachFromWall();
					return;
				}
				ny = climbPlat.hMidY + hHeight/2;
				setHitPoints();
				function checkPlatDist(num:Number):Boolean
				{
					if (num < 0)
						num = -num;
					if (num > MAX_PLAT_DIST)
						return true;
					else
						return false;
				}
			}
			else
				super.checkPlatform();
		}
		override protected function movePlayer():void
		{
			if (cState == ST_TAKE_DAMAGE)
				return;
			if (onGround)
			{
				if (dwnBtn || cState == ST_ATTACK)
				{
					vx = 0;
					return;
				}
			}
			if (cState == ST_CLIMB)
			{
				if (climbThrowing)
					return;
				checkClimbPosition();
				if (!topClimbPos && upBtn)
					vy = -CLIMB_SPEED;
				else if (!botClimbPos && dwnBtn)
					vy = CLIMB_SPEED;
				else
					vy = 0;
				return;
			}
			else if (rhtBtn && !lftBtn && !wallOnRight)
			{
				if (stuckInWall)
					return;
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx = xSpeed;
				this.scaleX = 1;
			}
			else if (lftBtn && !rhtBtn && !wallOnLeft)
			{
				if (stuckInWall)
					return;
				if (cState == ST_VINE)
				{
					if (exitVine)
						getOffVine();
					else
						return;
				}
				vx = -xSpeed;
				this.scaleX = -1;
			}
			else if ( ( (lftBtn && rhtBtn) || (!lftBtn && !rhtBtn) ) && cState != ST_DIE)
				vx = 0;
		}
		override protected function checkState():void
		{
			checkAtkRect = false;
			hitDistOver = 0;
			if (cState == ST_VINE)
			{
				checkVineBtns();
				checkVinePosition();
				return;
			}
			else if (cState == ST_CLIMB)
			{
				if (climbThrowing)
					return;
				if (stopAnim && (upBtn || dwnBtn) )
					setPlayFrame(FL_CLIMB_START);
				else if ( (!upBtn && !dwnBtn) || (upBtn && dwnBtn) )
					setStopFrame(FL_CLIMB_STOP);
				return;
			}
			else if (cState == ST_TAKE_DAMAGE)
				return;
			else if (onGround)
			{
				jumped = false;
				climbPlat = null;
				cancelGrappleGroundPos = NaN;
				if (cState != ST_ATTACK && cState != ST_DIE)
				{
					if (dwnBtn)
					{
						setState(ST_CROUCH);
						setStopFrame(FL_CROUCH);
						justCrouched = true;
					}
					else if (vx == 0)
					{
						if (cState != ST_STAND)
							beginIdleStance();
					}
					else
					{
						if (cState != ST_WALK)
						{
							mainAnimTmr = WALK_ANIM_TMR;
							setPlayFrame(FL_WALK_START);
						}
						setState(ST_WALK);
					}
				}
				else if (cState == ST_DIE && !startedDeathMusic)
				{
					SND_MNGR.changeMusic( MusicType.DIE );
					//SND_MNGR.playSound(SoundNames.MFX_RYU_DIE);
					EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
					vx = 0;
					startedDeathMusic = true;
				}
			}
			else if (cState != ST_ATTACK) // not onGround
			{
				setState(ST_JUMP);
				if (!FLIP_TMR.running && !jumpSlash)
					setStopFrame(FL_FALL);
			}
			if (cState == ST_ATTACK)
			{
				var cl:String = currentFrameLabel;
				for each (var str:String in ATTACK_FRAMES_DCT)
				{
					if (cl === convLab(str))
					{
						checkAtkRect = true;
						var rect:Rectangle;
						var crouch:Boolean = false;
						if (cl.indexOf("crouch") != -1)
							crouch = true;
						if ( !upgradeIsActive(RYU_SWORD_EXTENSION) )
						{
							if (!crouch)
								rect = A_RECT_NORMAL;
							else
								rect = A_RECT_CROUCH;
						}
						else
						{
							if (!crouch)
								rect = A_RECT_WAVE_NORMAL;
							else
								rect = A_RECT_WAVE_CROUCH;
							hitDistOver = rect.width*2;
						}
						ahRect.x = rect.x;
						ahRect.y = rect.y;
						ahRect.width = rect.width;
						ahRect.height = rect.height;
						break;
					}
				}
			}
		}
		override protected function getMushroomEnd():void
		{
			super.getMushroomEnd();
			if (GameSettings.tutorials)
				TutorialManager.TUT_MNGR.gotPowerUp(this);
		}
		override public function hitEnemy(enemy:Enemy,side:String):void
		{
			if (!starPwr && jumpSlash)
				landAttack(enemy);
			else
				super.hitEnemy(enemy,side);
		}
		override public function hitGround(mc:Ground,hType:String):void
		{
			if (jumpSlash && mc is IAttackable)
				landAttack(mc as IAttackable);
			if (!mc.destroyed)
				super.hitGround(mc,hType);
		}
		private function checkClimbPosition():void
		{
			topClimbPos = true;
			botClimbPos = true;
			topJumpPos = true;
			var topPos:Number;
			var botPos:Number;
			var tjPos:Number;
			if (climbPlat)
			{
				/*topPos = hTop + CLIMB_TOP_OFS;
				botPos = hBot - CLIMB_BOT_OFS;
				tjPos = hTop + CLIMB_TOP_JUMP_OFS;
				if (topPos >= climbPlat.hTop && topPos <= climbPlat.hBot)
					topClimbPos = false;
				if (botPos >= climbPlat.hTop && botPos <= climbPlat.hBot)
					botClimbPos = false;
				if (tjPos >= climbPlat.hTop && tjPos <= climbPlat.hBot)
					topJumpPos = false;*/
				return;
			}
			// if (!climbPlat)
			for each (var ground:Ground in level.GROUND_STG_DCT)
			{
				if (!ground.onScreen || !ground.visible)
					continue;
				if ( (scaleX > 0 && ground.hLft == hRht) || (scaleX < 0 && ground.hRht == hLft) )
				{
					topPos = hTop + CLIMB_TOP_OFS;
					botPos = hBot - CLIMB_BOT_OFS;
					tjPos = hTop + CLIMB_TOP_JUMP_OFS;
					if (topPos >= ground.hTop && topPos <= ground.hBot)
						topClimbPos = false;
					if (botPos >= ground.hTop && botPos <= ground.hBot)
						botClimbPos = false;
					if (tjPos >= ground.hTop && tjPos <= ground.hBot)
						topJumpPos = false;
				/*
					if (hTop - SLIDE_TOP_OFS <= ground.hBot && hBot - SLIDE_BOT_OFS > ground.hTop && hLft < ground.hRht && hRht >= ground.hLft)
					{
						ceilingAboveSlide = true;
						break;
					}
				*/
				}
			}
		}
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hadFireFlower:Boolean = upgradeIsActive(FIRE_FLOWER);
			super.hitPickup(pickup,showAnimation);
			if (pickup.mainType == PickupInfo.MAIN_TYPE_UPGRADE)
			{
				setCurSubWeapon();
				switch(pickup.type)
				{
					case RYU_SWORD_EXTENSION:
					{
						setSwordVisibility();
						break;
					}
					case RYU_SCROLL:
					{
						updMaxAmmo();
						break;
					}
					case MUSHROOM:
					{
						setSwordVisibility();
						break;
					}
					case FIRE_FLOWER:
					{
						setSwordVisibility();
						if (hadFireFlower)
							increaseAmmoByValue(AMMO_TYPE_NINJITSU, NINJITSU_AMMO_SMALL_VALUE * 3);
						else
							updMaxAmmo();
						break;
					}
				}
			}
			else
			{
				switch(pickup.type)
				{
					case RYU_NINJITSU_AMMO_BIG:
					{
						increaseAmmoByValue(AMMO_TYPE_NINJITSU,NINJITSU_AMMO_BIG_VALUE);
						break;
					}
					case RYU_NINJITSU_AMMO_SMALL:
					{
						increaseAmmoByValue(AMMO_TYPE_NINJITSU,NINJITSU_AMMO_SMALL_VALUE);
						break;
					}
				}
			}
			if (!pickup.playsRegularSound && pickup.mainType != PickupInfo.MAIN_TYPE_FAKE && showAnimation)
			{
				if (pickup.type == RYU_SCROLL)
					SND_MNGR.playSound(SoundNames.SFX_RYU_GET_SCROLL);
				else
					SND_MNGR.playSound(SN_GET_PICKUP);
			}
		}
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
			var lastClimbPlat:Platform = climbPlat;
			if (cState == ST_CLIMB && !climbThrowing)
			{
				if (dwnBtn)
					detachFromWall();
				else if ( (scaleX < 0 && rhtBtn) || (scaleX > 0 && lftBtn) || topJumpPos)
				{
					detachFromWall();
					vy = -CLIMB_JUMP_PWR;
					setState(ST_JUMP);
					startFlip();
					SND_MNGR.playSound(SN_RYU_JUMP);
					if (topJumpPos && ( lastClimbPlat || (scaleX < 0 && !rhtBtn) || (scaleX > 0 && !lftBtn) ) )
					{
						vy = -CLIMB_TOP_JUMP_PWR;
						if (CANCEL_GRAPPLE_TMR.running)
							CANCEL_GRAPPLE_TMR.reset();
						CANCEL_GRAPPLE_TMR.start();
					}
				}
			}
			else if (onGround)
			{
				onGround = false;
				vy = -jumpPwr;
				setState(ST_JUMP);
				lState = ST_STAND;
				jumped = true;
				startFlip();
				SND_MNGR.playSound(SN_RYU_JUMP);
			}
//			else if (!onGround && cState == ST_JUMP && upgradeIsActive(RYU_INFINITE_JUMP_SLASH) && !jumpSlash)
//				jumpSlashStart();
			super.pressJmpBtn();
		}
		public function detachFromWall():void
		{
			onGround = false;
			vy = 0;
			setState(ST_JUMP);
			setStopFrame(FL_FALL);
			lState = ST_CLIMB;
			jumped = true;
			defyGrav = false;
			if (climbPlat)
			{
				climbPlat.charOnPlat = false;
				climbPlat = null;
			}
			brickState = BRICK_BOUNCER;
		}
		override public function pressAtkBtn():void
		{
			if (upBtn && GameSettings.classicSpecialInput)
			{
				pressedSpecialButton();
				return;
			}
			if (cState == ST_VINE || cState == ST_CLIMB)
			{
				if (cState == ST_CLIMB && canThrowCurWeapon(RyuSimonThrowType.Default))
					throwStar(RyuSimonThrowType.Default);
				return;
			}
			super.pressAtkBtn();
			if (cState != ST_ATTACK && !jumpSlash)
			{
				if (onGround)
				{
					if (dwnBtn)
						setPlayFrame(FL_CROUCH_ATTACK_START);
					else
						setPlayFrame(FL_ATTACK_START);
				}
				else
				{
					setPlayFrame(FL_FALL_ATTACK_START);
					attackedInAir = true;
					flipping = false;
				}
				setState(ST_ATTACK);
				mainAnimTmr = ATTACK_ANIM_TMR;
				SND_MNGR.playSound(SN_RYU_ATTACK);
				ATTACK_ANIM_TMR.start();
				checkState();
			}
		}
		override protected function getOnVine(_vine:Vine):void
		{
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			super.getOnVine(_vine);
			setStopFrame(FL_CLIMB_POLE_START);
			mainAnimTmr = CLIMB_ANIM_TMR;
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
			setPlayFrame(FL_CLIMB_POLE_START);
			nx = level.flagPole.hMidX;
			mainAnimTmr = CLIMB_ANIM_TMR;
		}
		override public function pressSpcBtn():void
		{
			super.pressSpcBtn();
			pressedSpecialButton();
		}

		private function pressedSpecialButton():void
		{
			if (cState == ST_VINE || cState == ST_ATTACK)
				return;
			if (cState == ST_JUMP && curSubWeapon == RYU_JUMP_SLASH && !jumpSlash && hasEnoughAmmo(AMMO_TYPE_NINJITSU,RYU_JUMP_SLASH) )
				jumpSlashStart();
			else if (canThrowCurWeapon(RyuSimonThrowType.Default) )
				throwStar(RyuSimonThrowType.Default);
		}

		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (cState == ST_VINE || cState == ST_ATTACK || !GameSettings.classicMode || !upgradeIsActive(FIRE_FLOWER) )
				return;

//			trace("extra: " + classicExtraWeapon);
			if (cState == ST_JUMP && classicExtraWeapon == RYU_JUMP_SLASH && !jumpSlash && hasEnoughAmmo(AMMO_TYPE_NINJITSU,RYU_JUMP_SLASH) )
				jumpSlashStart();
			else if (canThrowCurWeapon(RyuSimonThrowType.Extra) )
				throwStar(RyuSimonThrowType.Extra);
		}

		override protected function getDefaultAmmo(ammoType:String):int
		{
			if (GameSettings.classicMode)
				return CLASSIC_DEFAULT_AMMO;
			else
				return super.getDefaultAmmo(ammoType);
		}

		private function jumpSlashStart():void
		{
			if (!FLIP_TMR.running)
				startFlip();
			if ( !upgradeIsActive(RYU_INFINITE_JUMP_SLASH) )
				decAmmo(AMMO_TYPE_NINJITSU,RYU_JUMP_SLASH);
			var num1:int = convFrameToInt(FL_FLIP_START);
			var num2:int = convFrameToInt(FL_JUMP_SLASH_START);
			var ofs:int = num2 - num1;
			gotoAndStop(currentFrame + ofs);
			jumpSlash = true;
			SND_MNGR.playSound(SN_JUMP_SLASH);
		}
		override public function relAtkBtn():void
		{
			super.relAtkBtn();
			if (GS_MNGR.gameState != GS_PLAY || cState == ST_ATTACK || cState == ST_VINE || pState < 1)
				return;
		}
		override public function pressLftBtn():void
		{
			super.pressLftBtn();
			if (forceAttachToWall)
				forceAttachToWall = false;
		}
		override public function pressRhtBtn():void
		{
			super.pressRhtBtn();
			if (forceAttachToWall)
				forceAttachToWall = false;
		}
		private function throwStar(throwType:RyuSimonThrowType):void
		{
			if (cState != ST_CLIMB)
			{
				lastThrowType = throwType;
				if (onGround)
				{
					if (dwnBtn)
						setPlayFrame(FL_CROUCH_THROW_START);
					else
						setPlayFrame(FL_THROW_START);
				}
				else
					setPlayFrame(FL_FALL_THROW_START);
				setState(ST_ATTACK);
				mainAnimTmr = ATTACK_ANIM_TMR;
				ATTACK_ANIM_TMR.start();
			}
			else if (!climbThrowing) // && cState == ST_CLIMB)
			{
				lastThrowType = throwType;
				if ( (scaleX < 0 && rhtBtn) || (scaleX > 0 && lftBtn) )
					setPlayFrame(FL_CLIMB_THROW_BACKWARDS_START);
				else
					setPlayFrame(FL_CLIMB_THROW_START);
				climbThrowing = true;
				vy = 0;
				mainAnimTmr = ATTACK_ANIM_TMR;
				ATTACK_ANIM_TMR.start();
			}
		}
		private function canThrowCurWeapon(throwType:RyuSimonThrowType):String
		{
			var weaponToThrow:String = curSubWeapon;
			if (throwType == RyuSimonThrowType.Extra && GameSettings.classicMode)
				weaponToThrow = classicExtraWeapon;
			var projectileType:String = getRyuProjectileTypeFromPickupType(weaponToThrow);
			if (projectileType == null || getProjectileCountForType(projectileType) >= MAX_PROJECTILES_ON_SCREEN)
				return null;
			else
				return projectileType;
		}

		private function getProjectileCountForType(projectileType:String):int
		{
			var count:int = 0;
			for each(var projectile:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (projectile is RyuProjectile && RyuProjectile(projectile).isType(projectileType) )
					count++;
			}
			return count;
		}

		private function getRyuProjectileTypeFromPickupType(pickupType:String):String
		{
			switch(pickupType)
			{
				case RYU_ART_OF_FIRE_WHEEL:
					return RyuProjectile.TYPE_ART_OF_FIRE_WHEEL;
				case RYU_FIRE_DRAGON_BALL:
					return RyuProjectile.TYPE_FIRE_DRAGON_BALL;
				case RYU_SHURIKEN:
					return RyuProjectile.TYPE_SHURIKEN;
				case RYU_WINDMILL_SHURIKEN:
					return RyuProjectile.TYPE_WINDMILL_SHURIKEN;
				default:
					return null;
			}
		}

		private function getPickupTypeFromProjectileType(projectileType:String):String
		{
			switch(projectileType)
			{
				case RyuProjectile.TYPE_ART_OF_FIRE_WHEEL:
					return RYU_ART_OF_FIRE_WHEEL;
				case RyuProjectile.TYPE_FIRE_DRAGON_BALL:
					return RYU_FIRE_DRAGON_BALL;
				case RyuProjectile.TYPE_SHURIKEN:
					return RYU_SHURIKEN;
				case RyuProjectile.TYPE_WINDMILL_SHURIKEN:
					return RYU_WINDMILL_SHURIKEN;
				default:
					return null;
			}
		}
		override protected function bounce(enemy:Enemy):void
		{
			if (cState == ST_CLIMB)
				return;
			super.bounce(enemy);
			if (cState != ST_ATTACK)
				startFlip();
		}
		// this function is also called from Spring when Ryu lands on it
		public function startFlip():void
		{
			if (FLIP_TMR.running)
				FLIP_TMR.reset();
			setPlayFrame(FL_FLIP_START);
			mainAnimTmr = FLIP_ANIM_TMR;
			FLIP_TMR.start();
		}

		override protected function attackObjPiercing(obj:IAttackable):void
		{
			if (jumpSlash)
				damageAmt = DamageValue.RYU_JUMP_SLASH;
			else
				damageAmt = DamageValue.RYU_SWORD;
			super.attackObjPiercing(obj);
			if (obj is Enemy && obj.health > 0)
				SND_MNGR.playSound(SN_RYU_DAMAGE_ENEMY);
		}
		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_RYU_ATTACK_ARMOR);
		}

		override protected function addAllPowerups():void
		{
			for (var i:int = 0; i < 5; i++)
			{
				hitRandomUpgrade(charNum,false);
			}
		}

		private function finishAttack():void
		{
			ATTACK_ANIM_TMR.reset();
			if (ATK_DCT.length != 0)
				ATK_DCT.clear();
			//if (FLIP_TMR.running)
			//	FLIP_TMR.reset();
		}
		override public function groundAbove(g:Ground):void
		{
			if ( (cState == ST_CLIMB && g is Platform) || (cState == ST_CLIMB && climbPlat) )
				detachFromWall();
			super.groundAbove(g);
			if (cState == ST_CLIMB )
				SND_MNGR.removeStoredSound(SND_GAME_HIT_CEILING);
		}
		override public function groundOnSide(g:Ground, side:String):void
		{
			if (cState == ST_CLIMB)
			{
				if (climbPlat)
					climbPlat.setCharOnPlat();
				return;
			}
			super.groundOnSide(g,side);
			if (dead || stuckInWall || lastStuckInWall || (GS_MNGR.gameState != GS_PLAY && !(level is CharacterSelect) ) )
				return;
			var topPos:Number = hTop + CLIMB_TOP_OFS;
			var botPos:Number = hBot - CLIMB_BOT_OFS;
			var botMaxGrapple:Number = botPos - CLIMB_BOT_MAX_GRAPPLE_INCREASE;
			var plat:Boolean = false;
			var touchingSingleGround:Boolean = true;
			if (g != null && cState != ST_CLIMB && !onGround && !lastOnGround
			&& ( (side == "left" && lftBtn) || (side == "right" && rhtBtn) || forceAttachToWall )
			)
			{
				if (g is Platform)
				{
					if (!CANCEL_GRAPPLE_TMR.running)
					{
						attachToWall(g,side);
						climbPlat = g as Platform;
						climbPlat.setCharOnPlat();
						ny = g.hMidY + hHeight/2;
					}
				}
				else if (
				(!CANCEL_GRAPPLE_TMR.running || (CANCEL_GRAPPLE_TMR.running && (side == "left" && g.hRht != cancelGrappleGroundPos) || (side == "right" && g.hLft != cancelGrappleGroundPos) ) )
				&& ( (topPos >= g.hTop && topPos <= g.hBot) || (botPos >= g.hTop && botMaxGrapple <= g.hBot) )
				)
				{
					for each (var ground:Ground in level.GROUND_STG_DCT)
					{
						//if (!ground.onScreen || !ground.visible)
						//	continue;
						if (hTop <= ground.hBot && hBot >= ground.hTop && hLft <= ground.hRht && hRht >= ground.hLft)
						{
							if (ground != g)
							{
								touchingSingleGround = false;
								break;
							}
						}
					}
					if (touchingSingleGround)
					{
						while (botPos > g.hBot)
						{
							ny -= CLIMB_BOT_GRAPPLE_TEST_INC;
							botPos = ny - CLIMB_BOT_OFS;
						}
					}

					attachToWall(g,side);
				}
			}
		}
		private function beginIdleStance():void
		{
			setState(ST_STAND);
			mainAnimTmr = STAND_ANIM_TMR;
			setPlayFrame(FL_STAND_START);
		}
		override public function groundBelow(g:Ground):void
		{
			if (cState == ST_CLIMB)
				detachFromWall();
			super.groundBelow(g);
		}
		private function attachToWall(g:Ground,side:String):void
		{
			if (side == "left")
			{
				cancelGrappleGroundPos = g.hRht;
				scaleX = -1;
			}
			else if (side == "right")
			{
				cancelGrappleGroundPos = g.hLft;
				scaleX = 1;
			}
			jumpSlash = false;
			forceAttachToWall = false;
			setState(ST_CLIMB);
			setStopFrame(FL_CLIMB_STOP);
			defyGrav = true;
			vx = 0;
			vy = 0;
			jumped = false;
			climbThrowing = false;
			if (cState == ST_ATTACK)
				finishAttack();
			checkState();
			mainAnimTmr = CLIMB_ANIM_TMR;
			SND_MNGR.playSound(SN_RYU_JUMP);
			brickState = BRICK_NONE;
		}
		override protected function landOnGround():void
		{
			super.landOnGround();
			if (cState == ST_CLIMB)
				defyGrav = false;
			else if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			forceAttachToWall = false;
			beginIdleStance();
			SND_MNGR.playSound(SN_RYU_JUMP);
			finishAttack();
			jumpSlash = false;
			checkState();
		}

		override protected function takeDamageStart(source:LevObj):void
		{
			super.takeDamageStart(source);
			damageBoost(source);
			takeNoDamage = true;
			disableInput = true;
			nonInteractive = true;
			setState(ST_TAKE_DAMAGE);
			BTN_MNGR.relPlyrBtns();
		}

		override protected function takeDamageEnd():void
		{
			disableInput = false;
			nonInteractive = false;
			setState(ST_STAND);
			alpha = TD_ALPHA;
			noDamageTmr.start();
			BTN_MNGR.sendPlayerBtns();
		}

		override public function springLaunch(spring:SpringRed):void
		{
			super.springLaunch(spring);
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			if (cState != Character.ST_ATTACK)
				startFlip();
		}

		override protected function bouncePit():void
		{
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			return super.bouncePit();
		}

		override protected function setAmmo(ammoType:String, value:int):void
		{
			super.setAmmo(ammoType, value);
			tsTxt.UpdAmmoText(true, getAmmo(ammoType) );
		}

		override public function revivalBoost():void
		{
			super.revivalBoost();
			hitPickup( new Pickup(RYU_NINJITSU_AMMO_BIG), false );
			hitPickup( new Pickup(RYU_NINJITSU_AMMO_BIG), false );
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			damageBoost(source);
			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL_MAX);
			lockFrame = true;
		}
		private function damageBoost(source:LevObj = null):void
		{
			if (cState == ST_CLIMB || defyGrav)
				detachFromWall();
			var dir:int = 1;
			if (source)
			{
				if (source.nx > nx)
					dir = -1;
			}
			else
			{
				if (scaleX > 0)
					dir = -1;
			}
			vy = -DIE_VERT_BOOST;
			vx = dir*DIE_HORZ_BOOST;
			scaleX = -dir;
			onGround = false;
			setStopFrame(FL_TAKE_DAMAGE);
			SND_MNGR.playSound(SoundNames.SFX_RYU_TAKE_DAMAGE);
		}
		override protected function enterPipeHorz():void
		{
			super.enterPipeHorz();
			mainAnimTmr = WALK_ANIM_TMR;
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
//			SND_MNGR.changeMusic(MusicType.DIE);
			super.initiatePitDeath();
			SND_MNGR.changeMusic( MusicType.DIE );
		}
		private function attackAnimTmrHandler(event:TimerEvent):void
		{
			animate(ATTACK_ANIM_TMR);
		}
		private function cancelGrappleTmrHandler(event:TimerEvent):void
		{
			CANCEL_GRAPPLE_TMR.reset();
		}
		private function flipTmrHandler(event:TimerEvent):void
		{
			FLIP_TMR.reset();
		}

		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			var seq:CharacterSequencer = new CharacterSequencer();
			seq.startNewSequence(CHOOSE_CHAR_SEQ);
			var curY:int = GLOB_STG_TOP - TILE_SIZE;
			var endY:int = GLOB_STG_BOT - TILE_SIZE*2;
			var groundX:Number = level.getNearestGrid( player.nx + TILE_SIZE*3,-1);
			var groundDct:CustomDictionary = new CustomDictionary(true);
			while (curY != endY)
			{
				var brick:SimpleGround = new SimpleGround(SimpleGround.BN_BLOCK);
				brick.x = groundX;
				brick.y = curY;
				level.addToLevel(brick);
				curY += TILE_SIZE;
				groundDct.addItem(brick);
			}
			level.addObj();
			for each (brick in groundDct)
			{
				brick.checkNearbyGround();
			}
		}
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_TAKE_DAMAGE);
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			var bool:Boolean = super.animate(ct);
			if (ct == ATTACK_ANIM_TMR && mainAnimTmr == ATTACK_ANIM_TMR)
				checkFrame();
			return bool;
		}
		private function addProjectile(type:String):void
		{
			var weapon:String = getPickupTypeFromProjectileType(type);
			if (weapon == null)
				return;
			if ( hasEnoughAmmo(AMMO_TYPE_NINJITSU, weapon) )
			{
				level.addToLevel( new RyuProjectile(this,type) );
				decAmmo(AMMO_TYPE_NINJITSU, weapon);
			}
		}
		override public function checkFrame():void
		{
			var cl:String = currentLabel;
			var cf:int = currentFrame;
			var projType:String;
			if ( cState == ST_STAND && cl == convLab(FL_STAND_END) )
				setPlayFrame(FL_STAND_START);
			if ((cState == ST_WALK || cState == ST_PIPE) && cl == convLab(walkEndLab) )
				setPlayFrame(FL_WALK_START);
			else if (cState == ST_JUMP)
			{
				if (cl == convLab(FL_FLIP_END))
					setPlayFrame(FL_FLIP_START);
				else if (cl == convLab(FL_JUMP_SLASH_END))
					gotoAndStop(FL_JUMP_SLASH_START);
			}
			else if (cState == ST_ATTACK)
			{
				projType = canThrowCurWeapon(lastThrowType);
				if (projType && GS_MNGR.gameState == GS_PLAY)
				{
					for each (var str:String in THROW_PROJECTILE_FRAMES_DCT)
					{
						if (cl == convLab(str))
						{
							addProjectile(projType);
							return;
						}
					}
				}
				if (cl == convLab(FL_ATTACK_END) || cl == convLab(FL_THROW_END))
				{
					if (onGround)
					{
						beginIdleStance();
						finishAttack();
					}
					else
					{
						setState(ST_JUMP);
						finishAttack();
						setStopFrame(FL_FALL );
					}
				}
				else if (cl == convLab(FL_CROUCH_ATTACK_END) || cl == convLab(FL_CROUCH_THROW_END))
				{
					setState(ST_CROUCH);
					setStopFrame(FL_CROUCH);
					finishAttack();
				}
				else if (cl == convLab(FL_FALL_ATTACK_END) || cl == convLab(FL_FALL_THROW_END))
				{
					setState(ST_JUMP);
					setStopFrame(FL_FALL);
					finishAttack();
				}
			}
			else if (cState == ST_CLIMB)
			{
				projType = canThrowCurWeapon(lastThrowType);
				if (climbThrowing && projType && GS_MNGR.gameState == GS_PLAY)
				{
					for each (str in THROW_PROJECTILE_FRAMES_DCT)
					{
						if (cl == convLab(str))
						{
							addProjectile(projType);
							return;
						}
					}
				}
				if (cl == convLab(FL_CLIMB_END))
					setPlayFrame(FL_CLIMB_START);
				else if (cl == convLab(FL_CLIMB_THROW_END) || cl == convLab(FL_CLIMB_THROW_BACKWARDS_END))
				{
					setState(ST_CLIMB);
					setStopFrame(FL_CLIMB_STOP);
					climbThrowing = false;
					mainAnimTmr = CLIMB_ANIM_TMR;
					finishAttack();
				}
			}
			else if (cState == ST_VINE || cState == ST_FLAG_SLIDE)
			{
				if (cl == convLab(FL_CLIMB_POLE_END))
					setPlayFrame(FL_CLIMB_POLE_START);
			}
			super.checkFrame();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			ATTACK_ANIM_TMR.removeEventListener(TimerEvent.TIMER,attackAnimTmrHandler);
			CANCEL_GRAPPLE_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelGrappleTmrHandler);
			FLIP_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,flipTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			ATTACK_ANIM_TMR.addEventListener(TimerEvent.TIMER,attackAnimTmrHandler,false,0,true);
			CANCEL_GRAPPLE_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,cancelGrappleTmrHandler,false,0,true);
			FLIP_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,flipTmrHandler,false,0,true);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			tsTxt.UpdAmmoIcon(false);
			tsTxt.UpdAmmoText(false);
		}

		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_RYU_GET_PICKUP);
		}
	}
}

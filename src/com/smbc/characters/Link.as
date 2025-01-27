package com.smbc.characters
{

	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxKnockBack;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxStop;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.DamageValue;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.enemies.KoopaGreen;
	import com.smbc.enums.LinkWeapon;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.CastleFlag;
	import com.smbc.graphics.HudAlwaysOnTop;
	import com.smbc.graphics.LinkShield;
	import com.smbc.graphics.LinkSword;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.PaletteSheet;
	import com.smbc.graphics.TopScreenText;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.graphics.fontChars.FontCharLink;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.LevObj;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.messageBoxes.GridMenuBox;
	import com.smbc.pickups.LinkPickup;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.Vine;
	import com.smbc.projectiles.*;
	import com.smbc.text.TextFieldContainer;
	import com.smbc.utils.GameLoopTimer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;

	public class Link extends Character
	{
		public static const CHAR_NAME:String = CharacterInfo.Link[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Link[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Link[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Link[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const WIN_SONG_DUR:int = 4200;
		public static const CHAR_SEL_END_DUR:int = 1700;
		public static const SUFFIX_VEC:Vector.<String> = Vector.<String>(["","",""]);
		private static const DIE_TMR_DEL_NORMAL:int = 650;
		private static const DIE_TMR_DEL_PIT:int = 3200;
		private var palRow:int;
		private static var ctr:int = -1;
		public static const IND_CI_Link:int = 1;
		public static const IND_CI_Portrait:int = 6;
		public static const IND_CI_LinkSword:int = 7;
		public static const IND_CI_LinkEnemyExplosion:int = 8;
		private static const PAL_ROW_GREEN_TUNIC:int = 1;
		private static const PAL_ROW_BLUE_TUNIC:int = 2;
		private static const PAL_ROW_RED_TUNIC:int = 3;

		private static const SKIN_APPEARANCE_NUM_GREEN_TUNIC:int = 0;
		private static const SKIN_APPEARANCE_NUM_BLUE_TUNIC:int = 1;
		private static const SKIN_APPEARANCE_NUM_RED_TUNIC:int = 2;

		private static const PAL_ROW_BLACK_AND_WHITE:int = 4;
		protected static const LINK_STEP_LADDER:String = PickupInfo.LINK_LADDER;
		protected static const LINK_BOW:String = PickupInfo.LINK_BOW;
		protected static const LINK_BOMB:String = PickupInfo.LINK_BOMB;
		protected static const LINK_BOMB_BAG:String = PickupInfo.LINK_BOMB_BAG;
		protected static const LINK_BLUE_RING:String = PickupInfo.LINK_BLUE_RING;
		protected static const LINK_SHORT_BOOMERANG:String = PickupInfo.LINK_SHORT_BOOMERANG;
		protected static const LINK_MAGIC_BOOMERANG:String = PickupInfo.LINK_MAGIC_BOOMERANG;
		protected static const LINK_MAGIC_SHIELD:String = PickupInfo.LINK_MAGIC_SHIELD;
		protected static const LINK_MAGIC_SWORD:String = PickupInfo.LINK_MAGIC_SWORD;
		protected static const LINK_RED_RING:String = PickupInfo.LINK_RED_RING;
		protected static const LINK_QUIVER:String = PickupInfo.LINK_QUIVER;
		protected static const LINK_ARROW_AMMO:String = PickupInfo.LINK_ARROW_AMMO;
		protected static const LINK_BOMB_AMMO:String = PickupInfo.LINK_BOMB_AMMO;
		private static const CLASSIC_BOMB_AMMO_DEFAULT:int = 3;
		private static const CLASSIC_BOW_AMMO_DEFAULT:int = 5;
		private static const AMMO_SUFFIX:String = "Ammo";
		private static const SW_BOOMERANG:String = "boomerang";
		private static const SW_BOMB:String = "bomb";
		private static const SW_BOW:String = "bow";
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ LINK_MAGIC_BOOMERANG, LINK_BOW, LINK_RED_RING, LINK_MAGIC_SWORD ],
			[ LINK_BOMB_BAG, LINK_QUIVER ]
		];
//			[ MUSHROOM ],
//			[ LINK_BOMB, LINK_BOW, LINK_MAGIC_BOOMERANG ],
//			[ LINK_BLUE_RING, LINK_MAGIC_SWORD ],
//			[ LINK_RED_RING ],
//			[ LINK_BOMB_BAG, LINK_QUIVER ]

		// get
		override public function get classicGetMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ LINK_BLUE_RING, classicWeaponPickupType ]); }

		override public function get classicLoseMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ LINK_BLUE_RING ]); }

		override public function get classicGetFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ LINK_RED_RING, LINK_MAGIC_BOOMERANG, LINK_MAGIC_SWORD, LINK_BOMB_BAG, LINK_QUIVER ]); }

		override public function get classicLoseFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ LINK_RED_RING, LINK_MAGIC_BOOMERANG, LINK_MAGIC_SWORD ]); }

		public static const MUSHROOM_UPGRADES:Array = [ LINK_BLUE_RING ];
		public static const NEVER_LOSE_UPGRADES:Array = [ LINK_BOW, LINK_BOMB, LINK_QUIVER, LINK_BOMB_BAG, LINK_MAGIC_SWORD ];
		public static const RESTORABLE_UPGRADES:Array = [ LINK_MAGIC_BOOMERANG ];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ [ ] ];
		private static const AMMO_BOMBS_MAX_DEF:int = 20;
		private static const AMMO_ARROWS_MAX_DEF:int = 20;
		private static const AMMO_BOMBS_MAX_BOMB_BAG:int = 40;
		private static const AMMO_ARROWS_MAX_QUIVER:int = 40;
		public static const ICON_ORDER_ARR:Array = [ LINK_MAGIC_BOOMERANG, LINK_BOMB, LINK_BOMB_BAG, LINK_BOW, LINK_QUIVER, LINK_BLUE_RING, LINK_RED_RING, LINK_MAGIC_SWORD ];  // LINK_MAGIC_SWORD, LINK_BOMB_BAG, LINK_QUIVER
		public static const AMMO_ARR:Array = [ [ SW_BOMB, 3, 20, 1 ], [ SW_BOW, 10, 20, 1 ] ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ SW_BOMB, 1 ], [ SW_BOW, 1 ] ];
//		public static const DROP_ARR:Array = [];
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM ];
		private static const DROP_ARR_BOMBS:Array = [ [ 0, LINK_BOMB_AMMO ] ];
		private static const DROP_ARR_ARROWS:Array = [ [ 0, LINK_ARROW_AMMO ] ];
		private static const DROP_ARR_BOTH:Array = [ [ 0, LINK_ARROW_AMMO ], [ .5, LINK_BOMB_AMMO ] ];
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		private static const MAX_BOMBS_ON_SCREEN:int = 3;
		private static const REPL_COLOR_1_1:uint = 0xFF8AD901;
		private static const REPL_COLOR_2_1:uint = 0xFF974E00;
		private static const REPL_COLOR_3_1:uint = 0xFFFFA044;
		private static const REPL_COLOR_1_2:uint = 0xFFB8B8F8;
		private static const REPL_COLOR_2_2:uint = REPL_COLOR_2_1;
		private static const REPL_COLOR_3_2:uint = REPL_COLOR_3_1;
		private static const REPL_COLOR_1_3:uint = 0xFFdc4316;
		private static const REPL_COLOR_2_3:uint = REPL_COLOR_2_1;
		private static const REPL_COLOR_3_3:uint = REPL_COLOR_3_1;
		private static const FL_ATTACK_2:String = "attack-2";
		private static const FL_ATTACK_END_GROUND:String = "attackEndGround";
		private static const FL_ATTACK_END_JUMP:String = "attackEndJump";
		public static const FL_ATTACK_START:String = "attackStart";
		private static const FL_ATTACK_DOWN_2:String = "attackDown2";
		private static const FL_ATTACK_UP_2:String = "attackUp2";
		private static const FL_ATTACK_DOWN_END:String = "attackDownEnd";
		private static const FL_ATTACK_UP_END:String = "attackUpEnd";
		public static const FL_ATTACK_DOWN_START:String = "attackDownStart";
		public static const FL_ATTACK_UP_START:String = "attackUpStart";
		private static const FL_DIE_DWN:String = "dieDwn";
		private static const FL_DWN_THRUST_END:String = "dwnThrustEnd";
		private static const FL_DWN_THRUST_START:String = "dwnThrustStart";
		private static const FL_UP_THRUST_END:String = "upThrustEnd";
		private static const FL_UP_THRUST_START:String = "upThrustStart";
		private static const FL_RAISE_ARMS:String = "raiseArms";
		private static const FL_JUMP_START:String = "jumpStart";
		private static const FL_JUMP_END:String = "jumpEnd";
		private static const FL_STAND:String = "stand";
		private static const FL_SWORD:String = "sword";
		private static const FL_SHIELD_DOWN:String = "down";
		private static const FL_SHIELD_FRONT:String = "front";
		private static const FL_SHIELD_SIDE:String = "side";
		private static const FL_SHIELD_UP:String = "up";
		private static const FL_WALK_END:String = "walkEnd";
		//private const FL_STAND_DOWN:String = "standDown";
		//private const FL_STAND_UP:String = "standUp";
//		private static const FL_THROW_END_GROUND:String = "throwEndGround";
//		private static const FL_THROW_END_JUMP:String = "throwEndJump";
//		private static const FL_THROW_START:String = "throwStart";
		private static const FL_WALK:String = "walk";
		private static const SWORD_REMAIN_ARR:Array = [ FL_ATTACK_START, FL_ATTACK_2, FL_ATTACK_END_GROUND,
			FL_ATTACK_END_JUMP, FL_ATTACK_DOWN_START, FL_ATTACK_DOWN_2, FL_ATTACK_DOWN_END, FL_ATTACK_UP_START,
			FL_ATTACK_UP_2, FL_ATTACK_UP_END, FL_UP_THRUST_END, FL_DWN_THRUST_END
		];
		private static const SHIELD_REMOVE_ARR:Array = [ FL_ATTACK_START,, FL_ATTACK_UP_2, FL_ATTACK_UP_END, FL_UP_THRUST_START, FL_RAISE_ARMS ];
		public static const SFX_LINK_DIE:String = SoundNames.SFX_LINK_DIE;
		public static const SFX_LINK_HIT_ENEMY:String = SoundNames.SFX_LINK_HIT_ENEMY;
		public static const SFX_LINK_STAB:String = SoundNames.SFX_LINK_STAB;
		private static const SN_GET_ITEM:String = SoundNames.SFX_LINK_GET_ITEM;
		private static const SN_GET_HEART:String = SoundNames.SFX_LINK_GET_HEART;
		private static const SN_SELECT_ITEM:String = SoundNames.SFX_LINK_SELECT_ITEM;
		private static const SN_TAKE_DAMAGE:String = SoundNames.SFX_LINK_TAKE_DAMAGE;
//		private const SECONDS_LEFT_SND:String = SoundNames.SFX_LINK_SECONDS_LEFT;
		private static const DAMAGE_BOOST_SPEED:int = 500;
		private static const DAMAGE_BOOST_DIST:int = 64;
		private var damageBoostEndX:Number;
		private var damageBoostDir:int;
		private const SND_MUSIC_WIN:String = SoundNames.MFX_LINK_WIN;
		private const WALK_START_LAB:String = "walkStart";
		private const WALK_END_LAB:String = "walkEnd";
		private var atkTmr:CustomTimer;
		private const ATK_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		private const MAIN_ANIM_TMR_DEF:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
//		private const MAIN_ANIM_TMR_JUMP:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private const THROW_GROUND_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_MIN_FAST_TMR;
		private const THROW_JUMP_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOW_TMR;
		private const ATK_DUR:int = 150;
		private const WALK_SPEED:int = 175;
		private const GRAVITY:int = 1300;
		private const GRAVITY_WATER:int = 500;
		private const JUMP_PWR:int = 600;
		private const JUMP_PWR_WATER:int = 500;
		private const DEF_SPRING_PWR:int = 450;
		private const BOOST_SPRING_PWR:int = 950;
		private const VY_MAX_PSV:int = 800;
		private const VY_MAX_PSV_WATER:int = 500;
		private const BOUNCE_PWR:int = 325;
		/**
		 *Controlled by shooting sword and sword explosion
		 */
		public var canShootSword:Boolean = true;
		//private const BOUNCE_PWR_BOOST:int = 450;
		public var uThrust:Boolean;
		public var dThrust:Boolean;
		private const DEATH_ANIMATION_TIMER:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private const NUM_FLASH_FRAMES:int = 8;
		private const NUM_SPINS:int = 4;
		private const NUM_WAIT_FRAMES:int = 4;
		private const NUM_GRAY_FRAMES:int = 8;
		private var frameCtr:int;
		private var spinCtr:int;
		private var deathPhase:String = "flash";
		public var boomerang:LinkBoomerang;
		private var sword:LinkSword;
		private var shield:LinkShield;
		private var pickupCurrentlyLifting:Pickup;
		private var swordLevel:int;
		public var shieldLevel:int;
		private static const TOTAL_SELECTABLE_WEAPONS:int = 3;
		private var subWeaponsVec:Vector.<String> = new Vector.<String>();
		private var curSubWeaponName:String;
		private var curSubWeaponInd:int;
		private static const AMMO_HUD_X:int = 6;
		private static const AMMO_HUD_Y:int = 68;
		private static const BOMB_AMMO_VALUE:int = 2;
		private static const ARROW_AMMO_VALUE:int = 2;
		public static const BOOMERANG_STUN_DUR:int = 3000;
		public static const DEFAULT_PROPS_DCT:CustomDictionary = new CustomDictionary();
		public static var knockBackProp:StatusProperty;
		private static var knockBackFx:StatFxKnockBack;
		private var finishedFlip:Boolean;
		private var flipTmr:GameLoopTimer;
		private static const FLIP_TMR_DEL:int = 140;
		private var takeDamageTmr:GameLoopTimer;
		private var TAKE_DAMAGE_TMR_DUR:int = 1200;
		public static const SKIN_PREVIEW_SIZE:Point = new Point(21,21);
		public static const SKIN_APPEARANCE_STATE_COUNT:int = 3;
		public static const SKIN_ORDER:Array = [
			SKIN_LINK_NES,
			SKIN_LINK_SNES,
			SKIN_LINK_GB,
			SKIN_LINK_X1,
			SKIN_LINK_ATARI,
			SKIN_DARK_LINK_NES,
			SKIN_DARK_LINK_SNES,
			SKIN_DARK_LINK_GB,
			SKIN_ZELDA_NES,
			SKIN_ZELDA_SNES,
			SKIN_ZELDA_GB,
			SKIN_RALPH,
			SKIN_OLD_MAN_NES,
			SKIN_OLD_MAN_SNES,
			SKIN_OLD_MAN_GB,
			SKIN_HERO_SNES,
			SKIN_HEROINE_SNES,
			SKIN_CHRISTINE,
			SKIN_ERDRICK,
			SKIN_ROTO,
			SKIN_LOTO,
			SKIN_CECIL_DARK_KNIGHT,
			SKIN_CECIL_PALADIN,
			SKIN_BARTZ,
			SKIN_BENJAMIN
		];

		public static const SKIN_LINK_NES:int = 0;
		public static const SKIN_LINK_SNES:int = 1;
		public static const SKIN_LINK_GB:int = 2;
		public static const SKIN_DARK_LINK_NES:int = 3;
		public static const SKIN_DARK_LINK_SNES:int = 4;
		public static const SKIN_DARK_LINK_GB:int = 5;
		public static const SKIN_OLD_MAN_NES:int = 6;
		public static const SKIN_ZELDA_NES:int = 7;
		public static const SKIN_HERO_SNES:int = 8;
		public static const SKIN_HEROINE_SNES:int = 9;
		public static const SKIN_CHRISTINE:int = 10;
		public static const SKIN_LINK_ATARI:int = 11;
		public static const SKIN_BENJAMIN:int = 12;
		public static const SKIN_ERDRICK:int = 13;
		public static const SKIN_LINK_X1:int = 14;
		public static const SKIN_ZELDA_SNES:int = 15;
		public static const SKIN_RALPH:int = 16;
		public static const SKIN_ZELDA_GB:int = 17;
		public static const SKIN_LOTO:int = 18;
		public static const SKIN_ROTO:int = 19;
		public static const SKIN_OLD_MAN_SNES:int = 20;
		public static const SKIN_OLD_MAN_GB:int = 21;
		public static const SKIN_CECIL_PALADIN:int = 22;
		public static const SKIN_CECIL_DARK_KNIGHT:int = 23;
		public static const SKIN_BARTZ:int = 24;

		public static const SPECIAL_SKIN_NUMBER:int = SKIN_LINK_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_LINK_ATARI;

		// Initialization:
		public function Link()
		{
			charNum = CHAR_NUM;
			recolorsCharSkin = true;
			super();
			if (!DEFAULT_PROPS_DCT.length)
			{
				DEFAULT_PROPS_DCT.addItem( new StatusProperty(PR_FLASH_AGG,0, new StatFxFlash(null,AnimationTimers.DEL_FAST,400) ) );
				DEFAULT_PROPS_DCT.addItem( new StatusProperty(PR_STOP_AGG, 0, new StatFxStop(null,400) ) );
				knockBackFx = new StatFxKnockBack(null,null);
//				knockBackProp = new StatusProperty(StatusProperty.TYPE_KNOCK_BACK_AGG, 0, knockBackFx );
//				DEFAULT_PROPS_DCT.addItem( knockBackProp );
			}
//			if (!cancelKnockBackProp)
//				cancelKnockBackProp = new StatusProperty(StatusProperty.TYPE_CANCEL_KNOCK_BACK);
			for each (var prop:StatusProperty in DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
			_canGetAmmoFromBricks = true;
			_charName = CHAR_NAME;
			_charNameTxt = CHAR_NAME_TEXT;
			_charNameCaps = CHAR_NAME_CAPS;
			suffixVec = SUFFIX_VEC.concat();
//			_secondsLeftSnd = SECONDS_LEFT_SND;
			_sndWinMusic = SND_MUSIC_WIN;
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			winSongDur = WIN_SONG_DUR;
			_usesHorzObjs = true;
			_usesVertObjs = true;
			walkStartLab = WALK_START_LAB;
			walkEndLab = WALK_END_LAB;
			level.LEV_OBJ_FINAL_CHECK.addItem(this);
			for (var i:int = 0; i < numChildren; i++)
			{
				var mc:DisplayObject = getChildAt(i) as DisplayObject;
				if (mc is LinkSword)
					sword = mc as LinkSword;
				else if (mc is LinkShield)
					shield = mc as LinkShield;
			}
		}
		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(sword,SWORD_REMAIN_ARR,true);
			removeObjsFromFrames(shield,SHIELD_REMOVE_ARR);
		}

		override protected function get currentSkinAppearanceNum():int
		{
			if ( upgradeIsActive(LINK_RED_RING) )
				return SKIN_APPEARANCE_NUM_RED_TUNIC;
			else if ( upgradeIsActive(LINK_BLUE_RING) )
				return SKIN_APPEARANCE_NUM_BLUE_TUNIC;
			else
				return SKIN_APPEARANCE_NUM_GREEN_TUNIC;
		}

		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			var oldSword:MovieClip;
			var oldShield:MovieClip;
			sword = new LinkSword( this, new MovieClipInfo.LinkSwordMc() );
			shield = new LinkShield( this, new MovieClipInfo.LinkShieldMc() );
			for (var i:int = 0; i < thisMc.numChildren; i++)
			{
				var dObj:DisplayObject = thisMc.getChildAt(i);
				if (dObj is MovieClip)
				{
					var mc:MovieClip = dObj as MovieClip;
					var num:int = mc.totalFrames;
					if (num == sword.totalFrames)
						oldSword = mc;
					else if (num == shield.totalFrames)
						oldShield = mc;
				}
			}
			mcReplaceArr = [ oldSword, sword, oldShield, shield ];
		}
		// SETSTATS sets statistics and initializes character
		override public function setStats():void
		{
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			vxMaxDef = DAMAGE_BOOST_SPEED;
			vyMaxPsv = VY_MAX_PSV;
			vxMax = vxMaxDef;
			vxMin = 5;
			bouncePwr = BOUNCE_PWR;
			if (level.waterLevel)
			{
				jumpPwr = JUMP_PWR_WATER;
				defGravity = gravity;
				gravity = GRAVITY_WATER;
				defGravityWater = gravity;
				vyMaxPsv = VY_MAX_PSV_WATER;
			}
			defSpringPwr = DEF_SPRING_PWR;
			boostSpringPwr = BOOST_SPRING_PWR;
			//ax = 600;
			//fx = .0000001;
			fy = .0001;
			pState2 = true;
			updSubWeapons(false,STAT_MNGR.getSubWeapon(charNum));
			super.setStats();
			vineAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			shield.setStopFrame(FL_SHIELD_SIDE);
			// set timers
			atkTmr = new CustomTimer(ATK_DUR,1);
			atkTmr.addEventListener(TimerEvent.TIMER_COMPLETE,atkTmrLsr);
			addTmr(atkTmr);
			flipTmr = new GameLoopTimer(FLIP_TMR_DEL);
			flipTmr.addEventListener(TimerEvent.TIMER,flipTmrHandler,false,0,true);
			addTmr(flipTmr);
//			STAT_MNGR.addCharUpgrade(charNum,LINK_BOW);
//			STAT_MNGR.addCharUpgrade(charNum,LINK_MAGIC_SWORD);
//			STAT_MNGR.addCharUpgrade(charNum,LINK_MAGIC_BOOMERANG);
		}

		protected function flipTmrHandler(event:Event):void
		{
			gotoAndStop(currentFrame + 1);
			checkFrame();
		}

		override protected function getOnVine(_vine:Vine):void
		{
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			super.getOnVine(_vine);
			if (flipTmr && flipTmr.running)
				flipTmr.stop();
		}

		override protected function getOffVine():void
		{
			super.getOffVine();
			finishedFlip = true;
			setStopFrame(FL_JUMP_END);
		}

		private function updSubWeapons(change:Boolean = false, forceWeapon:String = null):void
		{
			subWeaponsVec.length = 0;
			subWeaponsVec.push(SW_BOOMERANG);
			if ( upgradeIsActive(LINK_BOW) )
				subWeaponsVec.push(SW_BOW);
			if ( upgradeIsActive(LINK_BOMB) )
				subWeaponsVec.push(SW_BOMB);
			if (change)
			{
				curSubWeaponInd++;
				if (subWeaponsVec.length > 1)
					SND_MNGR.playSound(SN_SELECT_ITEM);
			}
			if (forceWeapon)
				curSubWeaponInd = subWeaponsVec.indexOf(forceWeapon);
			if (curSubWeaponInd >= subWeaponsVec.length || curSubWeaponInd < 0)
				curSubWeaponInd = 0;
			curSubWeaponName = subWeaponsVec[curSubWeaponInd];
			var iconFl:String = curSubWeaponName;
			if (curSubWeaponName == SW_BOOMERANG)
			{
				if (upgradeIsActive(LINK_MAGIC_BOOMERANG))
					iconFl = LINK_MAGIC_BOOMERANG;
				else
					iconFl = LINK_SHORT_BOOMERANG;
				iconFl = iconFl.substr(PickupInfo.UPGRADE_STR.length);
				tsTxt.UpdAmmoIcon( true, iconFl + AMMO_SUFFIX, TopScreenText.AMMO_ICON_X_ALIGNED );
				tsTxt.UpdAmmoText(false);
			}
			else
				tsTxt.UpdAmmoText(true, getAmmo(curSubWeaponName) );
			STAT_MNGR.setSubWeapon(charNum,curSubWeaponName);
			if (GameSettings.classicMode)
			{
				var show:Boolean = upgradeIsActive(classicWeaponPickupType);
				tsTxt.UpdAmmoIcon(show, classicWeaponSubWeaponType + AMMO_SUFFIX );
				tsTxt.UpdAmmoText(show, getAmmo(classicWeaponSubWeaponType) );
			}
			else
				tsTxt.UpdAmmoIcon( true, iconFl + AMMO_SUFFIX );
		}
		override protected function setAmmo(ammoType:String, value:int):void
		{
			super.setAmmo(ammoType, value);
			if (GameSettings.classicMode)
			{
				if ( upgradeIsActive(LINK_BOMB) || upgradeIsActive(LINK_BOW) )
					TopScreenText.instance.UpdAmmoText( true, getAmmo(ammoType) );
			}
			else if (ammoType == curSubWeaponName)
				TopScreenText.instance.UpdAmmoText( true, getAmmo(ammoType) );
		}
		private function setSwordType():void
		{
			if (upgradeIsActive(LINK_MAGIC_SWORD) )
			{
				swordLevel = 3;
				if ( skinNum == SKIN_ZELDA_NES || skinNum == SKIN_ZELDA_SNES || skinNum == SKIN_ZELDA_GB )
					damageAmt = 350;
				else
					damageAmt = DamageValue.LINK_SWORD_3;
			}
			else if ( upgradeIsActive(MUSHROOM) )
			{
				swordLevel = 2;
				if ( skinNum == SKIN_ZELDA_NES || skinNum == SKIN_ZELDA_SNES || skinNum == SKIN_ZELDA_GB )
					damageAmt = 225;
				else
					damageAmt = DamageValue.LINK_SWORD_2;
			}
			else // ( !upgradeIsActive(MUSHROOM) && !(GameSettings.difficulty == Difficulties.VERY_EASY && STAT_MNGR.getObtainedUpgradesDct(charNum).length) ) // no mushroom
			{
				swordLevel = 1;
				if ( skinNum == SKIN_ZELDA_NES || skinNum == SKIN_ZELDA_SNES || skinNum == SKIN_ZELDA_GB )
					damageAmt = 150;
				else
					damageAmt = DamageValue.LINK_SWORD_1;
			}

			sword.gotoAndStop( FL_SWORD + "_" + swordLevel.toString() );
		}
		private function setShieldType():void
		{
			if ( !upgradeIsActive(LINK_MAGIC_SHIELD) )
				shieldLevel = 1;
			else
				shieldLevel = 2;
			shield.setStopFrame( shield.currentLabel.substr(0,shield.currentLabel.length - 2) );
		}

		private function get classicWeaponSubWeaponType():String
		{
			switch(GameSettings.linkWeapon)
			{
				case LinkWeapon.Bomb:
					return SW_BOMB;
				case LinkWeapon.BowAndArrow:
					return SW_BOW;
				default:
					return SW_BOMB;
			}
		}

		private function get classicWeaponPickupType():String
		{
			switch(GameSettings.linkWeapon)
			{
				case LinkWeapon.Bomb:
					return LINK_BOMB;
				case LinkWeapon.BowAndArrow:
					return LINK_BOW;
				default:
					return LINK_BOMB;
			}
		}

		override protected function lastCharacterCheck():void
		{
			// for link and whoever else needs it
		}
		override public function forceWaterStats():void
		{
			jumpPwr = JUMP_PWR_WATER;
			defGravity = gravity;
			gravity = GRAVITY_WATER;
			defGravityWater = gravity;
			vyMaxPsv = VY_MAX_PSV_WATER;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			jumpPwr = JUMP_PWR;
			gravity = GRAVITY;
			defGravity = gravity;
			vyMaxPsv = VY_MAX_PSV;
			super.forceNonwaterStats();
		}
		override protected function movePlayer():void
		{
			if (cState == ST_TAKE_DAMAGE)
				return;
			if ( !(cState == ST_ATTACK && onGround) )
			{
				if (rhtBtn && !lftBtn && !wallOnRight)
				{
					if (stuckInWall)
						return;
					if (cState == "vine")
					{
						if (exitVine)
							getOffVine();
						else
							return;
					}
					//vx += ax*dt;
					vx = WALK_SPEED;
					this.scaleX = 1;
				}
				if (lftBtn && !rhtBtn && !wallOnLeft)
				{
					if (stuckInWall)
						return;
					if (cState == "vine")
					{
						if (exitVine)
							getOffVine();
						else
							return;
					}
					//vx -= ax*dt;
					vx = -WALK_SPEED;
					this.scaleX = -1;
				}
			}
			//if (onGround)
			//{
				if (lftBtn && rhtBtn)
				{
					vx = 0;
					//vx *= Math.pow(fx,dt);
				}
				else if (!lftBtn && !rhtBtn)
				{
					vx = 0;
					//vx *= Math.pow(fx,dt);
				}
				else if (onGround && cState == ST_ATTACK)
				{
					vx = 0;
					//vx *= Math.pow(fx,dt);
				}
			//}
		}
		override public function setCurrentBmdSkin(bmc:BmdSkinCont, characterInitiating:Boolean = false):void
		{
			super.setCurrentBmdSkin(bmc);
			changeTunicColor();
			setSwordType();
			updSubWeapons(false, STAT_MNGR.getSubWeapon(charNum) );
		}
		private function changeTunicColor(newRow:int = -1):void
		{
			if ( upgradeIsActive(LINK_RED_RING) )
				palRow = PAL_ROW_RED_TUNIC;
			else if ( upgradeIsActive(LINK_BLUE_RING) )
				palRow = PAL_ROW_BLUE_TUNIC;
			else
				palRow = PAL_ROW_GREEN_TUNIC;
			if ( newRow >= 0 )
				palRow = newRow;

//			if (GridMenuBox.instance != null)
//				graphicsMngr.recolorCharacterSheet(charNum,PAL_ROW_GREEN_TUNIC,[IND_CI_Link]);
//			else
				graphicsMngr.recolorCharacterSheet(charNum,palRow,[IND_CI_Link,IND_CI_Portrait]);
		}
		override protected function prepareDrawCharacter(skinAppearanceState:int = -1):void
		{
			if (skinAppearanceState >= 0)
				changeTunicColor(skinAppearanceState + 1);
			else
				changeTunicColor();
			super.prepareDrawCharacter(skinAppearanceState);
		}

		override public function setState(_nState:String):void
		{
			super.setState(_nState);
			if (cState == ST_ATTACK)
				shield.setStopFrame(FL_SHIELD_SIDE);
		}

		// Public Methods:
		// JUMP
		override protected function jump():void
		{
			onGround = false;
			vy = -jumpPwr;
			setStopFrame(FL_JUMP_START);
			setState("jump");
			flipTmr.start();
			jumped = true;
			releasedJumpBtn = false;
			frictionY = false;
			finishedFlip = false;
			SND_MNGR.playSound(SoundNames.SFX_LINK_JUMP);
		}
		// CHECKSTATE
		override protected function checkState():void
		{
			if (cState == "vine")
			{
				checkVineBtns();
				checkVinePosition();
				return;
			}
			else if (cState == ST_TAKE_DAMAGE)
			{

				if ( (damageBoostDir > 0 && nx > damageBoostEndX) || (damageBoostDir < 0 && nx < damageBoostEndX) )
				{
					nx = damageBoostEndX;
					takeDamageEnd();
				}
				return;
			}
			if (onGround)
			{
				if (mainAnimTmr != MAIN_ANIM_TMR_DEF && cState != ST_ATTACK)
					mainAnimTmr = MAIN_ANIM_TMR_DEF;
				jumped = false;
				flipTmr.stop();
				finishedFlip = false;
				uThrust = false;
				dThrust = false;
				if (cState != ST_ATTACK)
				{
					if (vx == 0 && !lftBtn && !rhtBtn)
					{
					/*	if (upBtn)
							setStopFrame(FL_STAND_UP);
						else if (dwnBtn)
							setStopFrame(FL_STAND_DOWN);
						else*/
							setStopFrame(FL_STAND);
						setState("stand");
					}
					else
					{
						if (cState != ST_WALK)
						{
							if (!lastOnGround)
								setPlayFrame(FL_WALK_END);
							else
								setPlayFrame(WALK_START_LAB);
						}
						setState(ST_WALK);
					}
				}
			}
			else
			{
				if (frictionY)
				{
					if (vy < 0)
						vy *= Math.pow(fy,dt);
					else
						frictionY = false;
				}
				if (cState != ST_ATTACK) // && !onGround
				{
					setState(ST_JUMP);
					var cl:String = currentLabel;
					if (upBtn)
					{
						dThrust = false;
						if (cl != convLab(FL_UP_THRUST_START) && cl != convLab(FL_UP_THRUST_END))
							thrustStart();
						else if (cl == convLab(FL_UP_THRUST_START))
						{

							setStopFrame(FL_UP_THRUST_END);
							uThrust = true;
						}
						else
							uThrust = true;
					}
					else if (dwnBtn)
					{
						uThrust = false;
						if (cl != convLab(FL_DWN_THRUST_START) && cl != convLab(FL_DWN_THRUST_END) )
							thrustStart();
						else if (cl == convLab(FL_DWN_THRUST_START) )
						{
							setStopFrame(FL_DWN_THRUST_END);
							dThrust = true;
						}
						else
							dThrust = true;
					}
					else // !upThrust && !dThrust
					{

						uThrust = false;
						dThrust = false;
						if (finishedFlip)
							setStopFrame(FL_JUMP_END);
						else if (lastOnGround)
						{
							flipTmr.start();
							setStopFrame(FL_JUMP_START);
							noAnimThisCycle = true;
						}
					}
				}
			}
			// check if attack rec is active
			cl = currentLabel;
			if (sword.visible && cState != ST_TAKE_DAMAGE && ( cl == convLab(FL_ATTACK_START) || cl == convLab(FL_ATTACK_UP_START) || cl == convLab(FL_ATTACK_DOWN_START)
			|| cl == convLab("upThrustEnd") || cl == convLab("dwnThrustEnd") ) )
				checkAtkRect = true;
			else
				checkAtkRect = false;
		}
		private function thrustStart():void
		{
			flipTmr.stop();
			mainAnimTmr = ATK_ANIM_TMR;
			dThrust = false;
			uThrust = false;
			finishedFlip = true;
			sword.visible = true;
			if (upBtn)
			{
				setStopFrame(FL_UP_THRUST_START);
				knockBackFx.setDir( StatFxKnockBack.DIR_UP );
			}
			else if (dwnBtn)
			{
				setStopFrame(FL_DWN_THRUST_START);
				knockBackFx.setDir( StatFxKnockBack.DIR_DOWN );
			}
		}
		private function attackStart(throwing:Boolean = false,allowVertical:Boolean = true):void
		{
			if (!throwing && !onGround && (upBtn || dwnBtn) ) // can't attack while thrusting
				return;
			flipTmr.stop();
			sword.visible = !throwing;
			if (allowVertical && (upBtn || dwnBtn) )
			{
				if (dwnBtn)
				{
					knockBackFx.setDir( StatFxKnockBack.DIR_DOWN );
					setStopFrame(FL_ATTACK_DOWN_START);
				}
				else if (upBtn)
				{
					knockBackFx.setDir( StatFxKnockBack.DIR_UP );
					setStopFrame(FL_ATTACK_UP_START);
				}
			}
			else
			{
				knockBackFx.setDir( null );
				setStopFrame(FL_ATTACK_START);

			}
			ATK_DCT.clear();
			setState(ST_ATTACK);
			if (cState == ST_ATTACK)
			{
				atkTmr.start();
				mainAnimTmr = ATK_ANIM_TMR;
				if (sword.visible)
					SND_MNGR.playSound(SFX_LINK_STAB);
				uThrust = false;
				dThrust = false;
			}
		}

		override public function hitProj(proj:Projectile):void
		{
			super.hitProj(proj);
//			if ( !upgradeIsActive(LINK_BLUE_RING) && !starPwr && proj is LinkProjectile && (proj as LinkProjectile).type == LinkProjectile.TYPE_BOMB)
//				takeDamage(proj);
		}
		override protected function hitIsAllowed(mc:IAttackable):Boolean
		{
			if (cState == ST_ATTACK && ATK_DCT[mc])
				return false;
			return super.hitIsAllowed(mc);
		}
		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hadFireFlower:Boolean = upgradeIsActive(FIRE_FLOWER);
			var hadClassicWeapon:Boolean = upgradeIsActive(classicWeaponPickupType);
			super.hitPickup(pickup,showAnimation);
			var mainType:String = pickup.mainType;
			if (mainType == PickupInfo.MAIN_TYPE_UPGRADE)
			{
				switch(pickup.type)
				{
					case MUSHROOM:
					{
						setSwordType();
						setShieldType();
						changeTunicColor();
						updDrops();
						if (!pickup.destroyed)
							pickup.destroy();
						if (GameSettings.classicMode && !hadClassicWeapon)
						{
							if (classicWeaponSubWeaponType == SW_BOMB)
								setAmmo(SW_BOMB, CLASSIC_BOMB_AMMO_DEFAULT);
							else
								setAmmo(SW_BOW, CLASSIC_BOW_AMMO_DEFAULT);
						}
						break;
					}
					case FIRE_FLOWER:
					{
						setSwordType();
						setShieldType();
						changeTunicColor();
						if (hadFireFlower)
						{
							if (classicWeaponSubWeaponType == SW_BOMB)
								increaseAmmoByValue(SW_BOMB, CLASSIC_BOMB_AMMO_DEFAULT);
							else
								increaseAmmoByValue(SW_BOW, CLASSIC_BOW_AMMO_DEFAULT);
						}
						else
							updAmmoMax();
						if (!pickup.destroyed)
							pickup.destroy();
						break;
					}
					case LINK_BOMB:
					{
						updDrops();
						break;
					}
					case LINK_BOW:
					{
						updDrops();
						break;
					}
					case LINK_BLUE_RING:
					{
						changeTunicColor();
						break;
					}
					case LINK_RED_RING:
					{
						changeTunicColor();
						setSwordType();
						break;
					}
					case LINK_MAGIC_SWORD:
					{
						setSwordType();
						break;
					}
					case LINK_MAGIC_SHIELD:
					{
						setShieldType();
						break;
					}
					case LINK_BOMB_BAG:
					{
						updAmmoMax();
						break;
					}
					case LINK_QUIVER:
					{
						updAmmoMax();
						break;
					}
				}

				if (!pickup.playsRegularSound && showAnimation)
					getUpgradeStart(pickup);
				updSubWeapons();
			}
			else if (mainType == PickupInfo.MAIN_TYPE_REGULAR)
			{
				switch(pickup.type)
				{
					case LINK_BOMB_AMMO:
					{
						increaseAmmoByValue(SW_BOMB,BOMB_AMMO_VALUE);
						if (!upgradeIsActive(LINK_BOMB))
						{
							STAT_MNGR.addCharUpgrade(charNum,LINK_BOMB);
							if (showAnimation)
								getUpgradeStart(pickup);
						}
						else
						{
							if (showAnimation)
								SND_MNGR.playSound(SN_GET_HEART);
							pickup.destroy();
						}
						break;
					}
					case LINK_ARROW_AMMO:
					{
						increaseAmmoByValue(SW_BOW,ARROW_AMMO_VALUE);
						if (showAnimation)
							SND_MNGR.playSound(SN_GET_HEART);
						break;
					}
				}
			}
		}
		override public function revivalBoost():void
		{
			super.revivalBoost();
//			if ( upgradeIsActive(LINK_BOMB) )
//			{
				hitPickup( new Pickup(LINK_BOMB_AMMO), false );
				hitPickup( new Pickup(LINK_BOMB_AMMO), false );
//			}
//			if ( upgradeIsActive(LINK_BOW) )
//			{
				hitPickup( new Pickup(LINK_ARROW_AMMO), false );
				hitPickup( new Pickup(LINK_ARROW_AMMO), false );
//			}
		}
		override protected function getUpgradeStart(upgrade:Pickup):void
		{
			if (pickupCurrentlyLifting != null)
				getUpgradeEnd();
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
			setDamageInfoArr();
			setState(ST_GET_UPGRADE);
			setStopFrame(FL_RAISE_ARMS);
			upgrade.nx = nx;
			upgrade.ny = ny - height;
			upgrade.stopHit = true;
			pickupCurrentlyLifting = upgrade;
			freezeGame();
			SND_MNGR.playSound(SN_GET_ITEM);
		}

		override protected function getUpgradeEnd():void
		{
			getDataFromDamageInfoArr();
			pickupCurrentlyLifting.destroy();
			pickupCurrentlyLifting = null;
		}



		override public function groundOnSide(g:Ground, side:String):void
		{
			super.groundOnSide(g, side);
			if (cState == ST_TAKE_DAMAGE)
			{
				if ( (damageBoostDir < 0 && side == Ground.HT_LEFT) || ( damageBoostDir > 0 && side == Ground.HT_RIGHT ) )
					takeDamageEnd();
			}
		}
		/*public function landAttack(obj:IAttackable):void
		{
			if ( !hitIsAllowed(obj) )
				return;
			if ( !obj.isSusceptibleToProperty( getProperty(PR_PIERCE_AGG) ) )
				attackObjNonPiercing(obj);
			else
				attackObjPiercing(obj);
		}*/
		override public function hitEnemy(enemy:Enemy,side:String):void
		{
			if (GS_MNGR.gameState != GS_PLAY || enemy.cState == ST_DIE)
				return;
			if (starPwr || (enemy is KoopaGreen && (KoopaGreen(enemy).cState == "shell" || KoopaGreen(enemy).NO_HIT_SHELL_TMR.running)))
			{
				// do nothing
			}
			else if ( (side == "bottom" && dThrust && !nonInteractive) || (side == "top" && uThrust && !nonInteractive) )
			{
				C_HIT_DCT.clear();
				L_HIT_DCT.clear();
				landAttack(enemy);
			}
			else if (side == "bottom" && enemy.stompable && canStomp && !nonInteractive)
				bounce(enemy);
			else if (!takeNoDamage)
				takeDamage(enemy);
		}
		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (cState == ST_ATTACK)
				ATK_DCT.addItem(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SFX_LINK_HIT_ENEMY);
			if (dThrust)
			{
				if (obj is Enemy)
					bounce(obj as Enemy);
				else
				{
					vy = -bouncePwr;
					jumped = true;
					if (obj is Ground)
					{
						if (ny > Ground(obj).hTop)
							ny = Ground(obj).hTop;
						setHitPoints();
					}
				}
			}
			else if (uThrust && vy < 0)
				vy = 0;
		}
		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (dThrust)
			{
				if (obj is Enemy)
					bounce(obj as Enemy);
				else
				{
					vy = -bouncePwr;
					jumped = true;
					if (obj is Ground)
					{
						if (ny > Ground(obj).hTop)
							ny = Ground(obj).hTop;
						setHitPoints();
					}
				}
			}
			else if (uThrust && vy < 0)
				vy = 0;
			SND_MNGR.playSound(SoundNames.SFX_LINK_HIT_ENEMY_ARMOR);
		}

		// PRESSJMPBTN
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
			if (onGround)
			{
				if (cState != ST_ATTACK)
					jump();
			}
			super.pressJmpBtn();
		}

		// RELJUMPBTN
		override public function relJmpBtn():void
		{
			super.relJmpBtn();
			if (!releasedJumpBtn)
			{
				frictionY = true;
				releasedJumpBtn = true;
			}
		}
		// PRESSSPECIALBTN
		override public function pressSpcBtn():void
		{
			if (cState == ST_VINE || cState == ST_ATTACK)
				return;
			super.pressSpcBtn();
			if ( curSubWeaponName == SW_BOOMERANG || ( !upgradeIsActive(LINK_BOMB) && !upgradeIsActive(LINK_BOW) ) )
			{
				if (level.PLAYER_PROJ_DCT.length == 0 || (level.PLAYER_PROJ_DCT.length == 1 && !boomerang) )
				{
					var boom:LinkBoomerang;
					boom = new LinkBoomerang(this);
					level.addToLevel(boom);
					attackStart(true,false);
				}
			}
			else if (curSubWeaponName == SW_BOW)
				shootArrowIfPossible();
			else if (curSubWeaponName == SW_BOMB)
				setBombIfPossible();
		}

		private function shootArrowIfPossible():void
		{
			if ( !upgradeIsActive(LINK_BOW) || !hasEnoughAmmo(SW_BOW) || cState == ST_VINE || cState == ST_ATTACK)
				return;

			level.addToLevel( new LinkProjectile(this,LinkProjectile.TYPE_ARROW) );
			decAmmo(SW_BOW);
//			tsTxt.UpdAmmoText(true, getAmmo(SW_BOMB) );
			attackStart(true);
		}

		private function setBombIfPossible():void
		{
			if (!upgradeIsActive(LINK_BOMB) || !hasEnoughAmmo(SW_BOMB) || numProjectilesOfType(LinkProjectile.TYPE_BOMB) >= MAX_BOMBS_ON_SCREEN || cState == ST_VINE || cState == ST_ATTACK)
				return;

				level.addToLevel( new LinkProjectile(this,LinkProjectile.TYPE_BOMB) );
				decAmmo(SW_BOMB);
				attackStart(true,false);
		}
		private function numProjectilesOfType(type:String):int
		{
			var ctr:int;
			for each (var proj:Projectile in level.PLAYER_PROJ_DCT)
			{
				if (proj is LinkProjectile)
				{
					var linkProj:LinkProjectile = proj as LinkProjectile;
					if (linkProj.type == type)
					{
//						if (type != LinkProjectile.TYPE_BOMB || !ccproj.bombExploded)
						ctr++;
					}
				}
			}
			return ctr;
		}

		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (GameSettings.classicMode)
			{
				if (classicWeaponSubWeaponType == SW_BOMB)
					setBombIfPossible();
				else
					shootArrowIfPossible();
			}
			else
				updSubWeapons(true);
		}
		// PRESSATTACKBTN
		override public function pressAtkBtn():void
		{
			if (cState == ST_VINE || cState == ST_ATTACK)
				return;
			super.pressAtkBtn();
			attackStart();
			if (!onGround && (upBtn || dwnBtn) )
				checkAddShootingSword();
		}
		// ATKTMRLSR
		private function atkTmrLsr(e:TimerEvent):void
		{
			var cfl:String = currentFrameLabel;
			atkTmr.reset();
			checkAddShootingSword();
			ATK_DCT.clear();
			if (cfl == convLab(FL_ATTACK_START) )
				setPlayFrame(FL_ATTACK_2);
			else if (cfl == convLab(FL_ATTACK_UP_START) )
				setPlayFrame(FL_ATTACK_UP_2);
			else if (cfl == convLab(FL_ATTACK_DOWN_START) )
				setPlayFrame(FL_ATTACK_DOWN_2);

			if (currentLabel == FL_ATTACK_DOWN_2)
				shield.setStopFrame(FL_SHIELD_FRONT);
		}
		private function checkAddShootingSword():void
		{
			if (canShootSword && sword.visible && upgradeIsActive(LINK_RED_RING) )
				level.addToLevel(new LinkProjectile(this, LinkProjectile.TYPE_SHOOTING_SWORD));
		}

		override protected function takeDamageEnd():void
		{
			disableInput = false;
			nonInteractive = false;
			setState(ST_NEUTRAL);
//			alpha = TD_ALPHA;
			noDamageTmr.start();
			BTN_MNGR.sendPlayerBtns();
			checkState();
		}
		override protected function noDamageTmrLsr(e:TimerEvent):void
		{
			super.noDamageTmrLsr(e);
			if (!starPwr)
				endReplaceColor();
		}

		override public function resetColor(useCleanBmd:Boolean=false):void
		{
			super.resetColor(useCleanBmd);
			shield.resetColor(useCleanBmd);
		}
		override protected function takeDamageStart(source:LevObj):void
		{
			if (pickupCurrentlyLifting != null)
				getUpgradeEnd();
			super.takeDamageStart(source);
			updDrops();
			if (flipTmr && flipTmr.running)
				flipTmr.stop();
			takeNoDamage = true;
			disableInput = true;
			nonInteractive = true;
			dThrust = false;
			uThrust = false;
			setState(ST_TAKE_DAMAGE);
			if (currentLabel != FL_STAND)
				setStopFrame(FL_WALK);
			else
				stopAnim = true;
			startReplaceColor();
			damageBoostDir = 1;
			if (source.nx > nx)
				damageBoostDir = -1;
			vx = DAMAGE_BOOST_SPEED*damageBoostDir;
			SND_MNGR.playSound(SN_TAKE_DAMAGE);
			scaleX = -damageBoostDir;
			damageBoostEndX = nx + DAMAGE_BOOST_DIST*damageBoostDir;
			BTN_MNGR.relPlyrBtns();
			if (takeDamageTmr)
				takeDamageTmr.stop();
			else
			{
				takeDamageTmr = new GameLoopTimer(TAKE_DAMAGE_TMR_DUR,1);
				takeDamageTmr.addEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler,false,0,true);
			}
			takeDamageTmr.start();
		}

		protected function takeDamageTmrHandler(event:Event):void
		{
			takeDamageTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler);
			takeDamageTmr = null;
			if (cState == ST_TAKE_DAMAGE)
				takeDamageEnd();
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
			if (!start)
				changeTunicColor();
			setSwordType();
			setShieldType();
			updSubWeapons();
			updAmmoMax();
			updDrops();
		}

		private function updAmmoMax():void
		{
			if (upgradeIsActive(LINK_BOMB_BAG))
				setMaxAmmo(SW_BOMB,AMMO_BOMBS_MAX_BOMB_BAG);
			else
				setMaxAmmo(SW_BOMB,AMMO_BOMBS_MAX_DEF);
			if (upgradeIsActive(LINK_QUIVER))
				setMaxAmmo(SW_BOW,AMMO_ARROWS_MAX_QUIVER);
			else
				setMaxAmmo(SW_BOW,AMMO_ARROWS_MAX_DEF);
		}
		private function updDrops():void
		{
			if (GameSettings.classicMode)
			{
				if ( upgradeIsActive(LINK_BOMB) )
					dropArr = DROP_ARR_BOMBS;
				else if ( upgradeIsActive(LINK_BOW) )
					dropArr = DROP_ARR_ARROWS;
				else
					dropArr = [];
			}
			else
			{
				if ( upgradeIsActive(LINK_BOW) )
					dropArr = DROP_ARR_BOTH;
				else
					dropArr = DROP_ARR_BOMBS;
			}
		}

		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			checkFrameDuringStopAnim = true;
			stopUpdate = true;
			stopHit = true;
			stopAnim = true;
			changeTunicColor(PAL_ROW_GREEN_TUNIC);
			setStopFrame("dieFlash-1");
			mainAnimTmr = DEATH_ANIMATION_TIMER;
			scaleX = 1;
		}
		override protected function initiatePitDeath():void
		{
			_dieTmrDel = DIE_TMR_DEL_PIT;
			super.initiatePitDeath();
			SND_MNGR.playSound(SFX_LINK_DIE);
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
			nx = level.flagPole.hMidX;
			setPlayFrame("climbStart");
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			if (onGround)
			{
				setStopFrame(FL_STAND);
				setState(ST_STAND);
			}
			else
			{
				setStopFrame(FL_JUMP_START);
				setState(ST_JUMP);
			}
		}

		override public function chooseCharacter():void
		{
			super.chooseCharacter();
//			SND_MNGR.playSound(SoundNames.SFX_LINK_GET_ITEM);
			cancelCheckState = true;
			setStopFrame(FL_RAISE_ARMS);
		}
		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_DIE_DWN);
		}

		/*override protected function flagDelayTmrLsr(e:TimerEvent):void
		{
			super.flagDelayTmrLsr(e);
			setState("walk");
			onGround = true;
		}*/
		override public function animate(ct:ICustomTimer):Boolean
		{
			var bool:Boolean;
			if (!dead)
				bool = super.animate(ct);
			else if (ct == mainAnimTmr && !stopAnim && !lockFrame)
			{
				ANIMATOR.animate(this);
				bool = true;
			}
			return bool;
		}
		// CHECKFRAME
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			var cfl:String = currentFrameLabel;
			if ( (cState == ST_WALK || cState == ST_PIPE) && previousFrameLabelIs(WALK_END_LAB) )
				setPlayFrame(WALK_START_LAB);
			else if (cState == ST_TAKE_DAMAGE && cf == getLabNum("takeDamageEnd") + 1)
				setPlayFrame("takeDamageStart");
			else if ( !onGround && previousFrameLabelIs(FL_JUMP_END) )
			{
				gotoAndStop(FL_JUMP_START);
			}
			else if (cState == ST_ATTACK)
			{
				// attack frames
				if (cfl == convLab(FL_ATTACK_END_GROUND) && !onGround)
					setPlayFrame(FL_ATTACK_END_JUMP);
				else if (previousFrameLabelIs(FL_ATTACK_END_GROUND) || previousFrameLabelIs(FL_ATTACK_UP_END) || previousFrameLabelIs(FL_ATTACK_DOWN_END) )
				{
					setState(ST_STAND);
					if (onGround)
						setStopFrame(FL_STAND);
					else if (upBtn || dwnBtn)
						thrustStart();
					else
					{
						finishedFlip = true;
						setStopFrame(FL_JUMP_END);
					}
				}
				else if ( previousFrameLabelIs(FL_ATTACK_END_JUMP) )
				{
					setState(ST_JUMP);
					finishedFlip = true;
					setStopFrame(FL_JUMP_END);
				}
			}
			else if (cState == "flagSlide" || cState == "vine")
			{
				if (cf == getLabNum("climbEnd") + 1)
					setPlayFrame("climbStart");
			}
			else if (cState == "die" && !fellInPit)
			{
				var cl:String = currentLabel;
				if (deathPhase == "flash")
				{
					if (cl == convLab("dieFlash-1"))
						setStopFrame("dieFlash-2");
					else
						setStopFrame("dieFlash-1");
					frameCtr++;
					if (frameCtr > NUM_FLASH_FRAMES) // it's > because last frame isn't shown
					{
						frameCtr = 0;
						setStopFrame(FL_DIE_DWN);
						deathPhase = "wait";
					}
				}
				else if (deathPhase == "wait")
				{
					frameCtr++;
					if (frameCtr == NUM_WAIT_FRAMES)
					{
						frameCtr = 0;
						deathPhase = "spin";
						SND_MNGR.playSound(SFX_LINK_DIE);
					}
				}
				else if (deathPhase == "spin")
				{
					if (cl == convLab("dieDwn"))
						setStopFrame("dieRht");
					else if (cl == convLab("dieRht"))
						setStopFrame("dieUp");
					else if (cl == convLab("dieUp"))
						setStopFrame("dieLft");
					else if (cl == convLab("dieLft"))
					{
						setStopFrame("dieDwn");
						spinCtr++;
					}
					if (spinCtr == NUM_SPINS)
					{
						deathPhase = "gray";
						if (GameSettings.getCharacterPaletteLimited() == 0)
						{
							var bmpVec:Vector.<Bitmap> = getBmpsFromFrame();
							var GM:GraphicsManager = GraphicsManager.INSTANCE;
							for each (var bmp:Bitmap in bmpVec)
							{
								var bmd:BitmapData = bmp.bitmapData.clone();
								bmp.bitmapData = bmd;
								GM.recolorSingleBitmap(bmd,defColors,paletteMain,palRow,PAL_ROW_BLACK_AND_WHITE);
//								GM.recolorToStanGbPalette(bmd,bmd.rect);
//								GM.recolorStanGbPalToCurGbPalSingle(bmd,masterBmdSkinCont.type,GraphicsManager.GB_PAL_OBJ1,10);
							}
						}
					}
				}
				else if (deathPhase == "gray")
				{
//					if (cl != convLab("dieGray"))
//						setStopFrame("dieGray");
					frameCtr++;
					if (frameCtr > NUM_GRAY_FRAMES)
					{
						frameCtr = 0;
						resetColor();
						setPlayFrame("dieCross-1");
						deathPhase = "cross";
						SND_MNGR.playSound(SoundNames.SFX_LINK_SHOOT_ARROW);
					}
				}
				else if (deathPhase == "cross")
				{
					if (currentFrame == getLabNum("dieCross-2") + 1)
					{
						visible = false;
						EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
					}
				}
			}
			super.checkFrame();
		}

		override protected function getAllDroppedUpgrades():void
		{
			hitPickup(new LinkPickup( LINK_BOMB), false);
		}

		override public function finalCheck():void
		{
			super.finalCheck();
			var cl:String = currentLabel;
			var cv:Function = convLab;
			var ssf:Function = shield.setStopFrame;
			if (cState != ST_ATTACK)
				ssf(FL_SHIELD_SIDE);
			if ( cl == FL_ATTACK_DOWN_START || cl == FL_DWN_THRUST_END )
				ssf(FL_SHIELD_DOWN);
			else if (cl == FL_ATTACK_DOWN_2)
				ssf(FL_SHIELD_FRONT);
			else if ( cl == FL_ATTACK_UP_START || cl == FL_UP_THRUST_END )
				ssf(FL_SHIELD_UP);
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (atkTmr && atkTmr.hasEventListener(TimerEvent.TIMER_COMPLETE)) atkTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,atkTmrLsr);
			flipTmr.removeEventListener(TimerEvent.TIMER,flipTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (atkTmr && !atkTmr.hasEventListener(TimerEvent.TIMER_COMPLETE))
				atkTmr.addEventListener(TimerEvent.TIMER_COMPLETE,atkTmrLsr);
			if (takeDamageTmr)
				takeDamageTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,takeDamageTmrHandler);
			flipTmr.addEventListener(TimerEvent.TIMER,flipTmrHandler,false,0,true);
		}
		override public function destroy():void
		{
			if (level)
				level.LEV_OBJ_FINAL_CHECK.removeItem(this);
			super.destroy();
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (fellInPit)
				changeTunicColor();
			tsTxt.UpdAmmoIcon(false);
			tsTxt.UpdAmmoText(false);
		}

		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_LINK_GET_ITEM);
		}
	}

}

package com.smbc.characters
{

	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.*;
	import com.smbc.level.CharacterSelect;
	import com.smbc.projectiles.*;

	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;

	public final class MegaMan extends MegaManBase
	{
		public static const CHAR_NAME:String = CharacterInfo.MegaMan[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.MegaMan[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.MegaMan[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.MegaMan[ CharacterInfo.IND_CHAR_NUM ];
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP, MegaManBase.PAL_TYPE_CHARGE, MegaManBase.PAL_TYPE_CHARGE_FIRE_POWER ];
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER ]
//			[ MUSHROOM ],
//			[ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_WATER_SHIELD, MM_RUSH_COIL ], //MM_MAGMA_BAZOOKA
//			[ MM_ENERGY_BALANCER ] // MM_RUSH_JET, MM_MAN_RUSH_MARINE
		];

		public static const START_WITH_UPGRADES:Array = [ MM_RUSH_COIL ];
		public static const MUSHROOM_UPGRADES:Array = [ MM_CHARGE_SHOT ];
		public static const NEVER_LOSE_UPGRADES:Array = [ MM_RUSH_COIL, MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER, MM_ENERGY_BALANCER ];
		public static const RESTORABLE_UPGRADES:Array = [ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER ]; // actually gets half of these
		public static const SINGLE_UPGRADES_ARR:Array = [ ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [
			[ MM_SUPER_ARM, MM_ENERGY_BALANCER ], [ MM_METAL_BLADE, MM_ENERGY_BALANCER ], [ MM_HARD_KNUCKLE, MM_ENERGY_BALANCER ],
			[ MM_PHARAOH_SHOT, MM_ENERGY_BALANCER ], [ MM_CHARGE_KICK, MM_ENERGY_BALANCER ], [ MM_FLAME_BLAST, MM_ENERGY_BALANCER ],
			[ MM_MAGMA_BAZOOKA, MM_ENERGY_BALANCER ], [ MM_WATER_SHIELD, MM_ENERGY_BALANCER ], [ MM_SCREW_CRUSHER, MM_ENERGY_BALANCER ],
			[ MM_RUSH_COIL, MM_ENERGY_BALANCER ]
		];
		public static const ICON_ORDER_ARR:Array = [ MM_SUPER_ARM, MM_METAL_BLADE, MM_HARD_KNUCKLE, MM_PHARAOH_SHOT, MM_CHARGE_KICK, MM_FLAME_BLAST, MM_MAGMA_BAZOOKA, MM_WATER_SHIELD, MM_SCREW_CRUSHER, MM_RUSH_COIL, MM_RUSH_JET, MM_MAN_RUSH_MARINE, MM_ENERGY_BALANCER ];
		public static const AMMO_ARR:Array = [ [ MM_SUPER_ARM, MAX_WPN_ENGY, MAX_WPN_ENGY ], [ MM_METAL_BLADE, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_HARD_KNUCKLE, MAX_WPN_ENGY, MAX_WPN_ENGY ], [ MM_RUSH_COIL, MAX_WPN_ENGY, MAX_WPN_ENGY ],
			[  MM_PHARAOH_SHOT, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_CHARGE_KICK, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_FLAME_BLAST, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_MAGMA_BAZOOKA, MAX_WPN_ENGY, MAX_WPN_ENGY ],
			[ MM_RUSH_JET, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_WATER_SHIELD, MAX_WPN_ENGY, MAX_WPN_ENGY ], [  MM_SCREW_CRUSHER, MAX_WPN_ENGY, MAX_WPN_ENGY ] ];
		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const TITLE_SCREEN_UPGRADES:Array = [ MUSHROOM, MM_CHARGE_SHOT ];
		public static const AMMO_DEPLETION_ARR:Array = [ [ MM_SUPER_ARM, 8 ], [ MM_METAL_BLADE, 2 ], [ MM_HARD_KNUCKLE, 8 ], [ MM_PHARAOH_SHOT, 4], [ MM_RUSH_COIL, 4 ],
			[ MegaManProjectile.TYPE_PHARAOH_BALLOON, 8 ], [MM_CHARGE_KICK, 4 ], [MM_FLAME_BLAST, 4 ], [ MM_MAGMA_BAZOOKA, 2 ], [ MegaManProjectile.TYPE_MAGMA_BAZOOKA_CHARGE, 12 ], [ MM_WATER_SHIELD, 16 ], [ MM_SCREW_CRUSHER, 2 ] ];
		public static const DROP_ARR:Array = [
			[ 0, MM_WEAPON_ENERGY_SMALL ],
			[ .825, MM_WEAPON_ENERGY_BIG ]
		];
		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
		public static const WIN_SONG_DUR:int = 5480;
		public static const CHAR_SEL_END_DUR:int = 1700;
		public static const BULLET_Y_PAD_BOT_ON_GROUND:int = 27;
		public static const BULLET_Y_PAD_BOT_OFF_GROUND:int = 35;
		public static const SKIN_PREVIEW_SIZE:Point = new Point(33,33);
		public static const FREEZE_DUR:int = 2000;
		public static const SKIN_ORDER:Array = [
			SKIN_MEGA_MAN_NES,
			SKIN_MEGA_MAN_SNES,
			SKIN_MEGA_MAN_GB,
			SKIN_MEGA_MAN_X1,
			SKIN_MEGA_MAN_ATARI,
			SKIN_MEGA_MAN_NO_HELMET_NES,
			SKIN_MEGA_MAN_NO_HELMET_SNES,
			SKIN_MEGA_MAN_NO_HELMET_GB,
			SKIN_ROCK_NES,
			SKIN_ROCK_SNES,
			SKIN_QUINT,
			SKIN_PROTO_MAN_NES,
			SKIN_PROTO_MAN_SNES,
			SKIN_PROTO_MAN_GB,
			SKIN_BREAK_MAN_NES,
			SKIN_BREAK_MAN_SNES,
			SKIN_BREAK_MAN_GB,
			SKIN_ROLL_NES,
			SKIN_ROLL_SNES,
			SKIN_DR_LIGHT_NES,
			SKIN_CUT_MAN_NES,
			SKIN_CUT_MAN_SNES,
			SKIN_FIRE_MAN_NES,
			SKIN_ICE_MAN_NES,
			SKIN_FRANCESCA,
			SKIN_DOROPIE,
			SKIN_ROKKO_CHAN
		];

		public static const SKIN_MEGA_MAN_NES:int = 0;
		public static const SKIN_MEGA_MAN_SNES:int = 1;
		public static const SKIN_MEGA_MAN_GB:int = 2;
		public static const SKIN_PROTO_MAN_NES:int = 3;
		public static const SKIN_PROTO_MAN_SNES:int = 4;
		public static const SKIN_PROTO_MAN_GB:int = 5;
		public static const SKIN_MEGA_MAN_NO_HELMET_NES:int = 6;
		public static const SKIN_MEGA_MAN_NO_HELMET_SNES:int = 7;
		public static const SKIN_BREAK_MAN_NES:int = 8;
		public static const SKIN_BREAK_MAN_SNES:int = 9;
		public static const SKIN_ROLL_NES:int = 10;
		public static const SKIN_ROKKO_CHAN:int = 11;
		public static const SKIN_DR_LIGHT_NES:int = 12;
		public static const SKIN_CUT_MAN_NES:int = 13;
		public static const SKIN_ICE_MAN_NES:int = 14;
		public static const SKIN_MEGA_MAN_ATARI:int = 15;
		public static const SKIN_ROCK_NES:int = 16;
		public static const SKIN_ROCK_SNES:int = 17;
		public static const SKIN_MEGA_MAN_X1:int = 18;
		public static const SKIN_BREAK_MAN_GB:int = 19;
		public static const SKIN_MEGA_MAN_NO_HELMET_GB:int = 20;
		public static const SKIN_CUT_MAN_SNES:int = 21;
		public static const SKIN_ROLL_SNES:int = 22;
		public static const SKIN_QUINT:int = 23;
		public static const SKIN_FIRE_MAN_NES:int = 24;
		public static const SKIN_FRANCESCA:int = 25;
		public static const SKIN_DOROPIE:int = 26;

		public static const SPECIAL_SKIN_NUMBER:int = SKIN_MEGA_MAN_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_MEGA_MAN_ATARI;

		public static const SKIN_APPEARANCE_STATE_COUNT:int = 10;

		private var swapWeaponsTimer:CustomTimer;
		private var SWAP_WEAPONS_TIMER_DELAY:int = 350;
//		private var start:int;

		// Initialization:
		public function MegaMan()
		{
			super();
			_usesHorzObjs = true;
			_usesVertObjs = false;
			defWeapon = MM_MEGA_BUSTER;
			changesColorOnPState = true;
			showHead = true;
		}

		override public function setStats():void
		{
			super.setStats();
			if (GameSettings.classicMode)
			{
				swapWeaponsTimer = new CustomTimer(SWAP_WEAPONS_TIMER_DELAY, 1);
				swapWeaponsTimer.addEventListener(TimerEvent.TIMER_COMPLETE, swapWeaponsTimerHandler, false, 0, true);
				addTmr(swapWeaponsTimer);
			}
		}

		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			SND_MNGR.playSound(SoundNames.SFX_MEGA_MAN_TELEPORT);
			vx = 0;
			nx = CharacterSelect.PLAYER_X_POS;
			cancelCheckState = true;
			setPlayFrame(FL_TELEPORT_START);
		}

		protected function swapWeaponsTimerHandler(event:TimerEvent):void
		{
			swapWeaponsTimer.reset();
			if (secondaryWeapon != null && secondaryWeapon != MM_CHARGE_KICK)
				attackButtonsAreSwapped = !attackButtonsAreSwapped;
		}

		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (GameSettings.classicMode)
			{
//				start = getTimer();
				swapWeaponsTimer.reset();
				swapWeaponsTimer.start();
			}
		}

		override public function relSelBtn():void
		{
			super.relSelBtn();
			if (GameSettings.classicMode && swapWeaponsTimer.running)
			{
//				trace("fuck: " + ( start - getTimer() ));
				swapWeaponsTimer.reset();
				attackIfPossible(MM_RUSH_COIL);
			}
		}

		override protected function removeListeners():void
		{
			super.removeListeners();
			if (swapWeaponsTimer)
				swapWeaponsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, swapWeaponsTimerHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (swapWeaponsTimer && !swapWeaponsTimer.hasEventListener(TimerEvent.TIMER_COMPLETE))
				swapWeaponsTimer.addEventListener(TimerEvent.TIMER_COMPLETE, swapWeaponsTimerHandler);
		}
	}
}

package com.smbc.characters
{

	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.HRect;
	import com.smbc.data.MovieClipInfo;
	import com.smbc.data.PaletteTypes;
	import com.smbc.data.PickupInfo;
	import com.smbc.data.SoundNames;
	import com.smbc.enums.BillWeapon;
	import com.smbc.graphics.BillLegs;
	import com.smbc.graphics.BillTorso;
	import com.smbc.graphics.Palette;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.main.LevObj;
	import com.smbc.pickups.Pickup;
	import com.smbc.pickups.PipeTransporter;
	import com.smbc.projectiles.*;
	import com.smbc.utils.GameLoopTimer;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	public class Bill extends Character
	{
		public static const CHAR_NAME:String = CharacterInfo.Bill[ CharacterInfo.IND_CHAR_NAME ];
		public static const CHAR_NAME_CAPS:String = CharacterInfo.Bill[ CharacterInfo.IND_CHAR_NAME_CAPS ];
		public static const CHAR_NAME_TEXT:String = CharacterInfo.Bill[ CharacterInfo.IND_CHAR_NAME_MENUS ];
		public static const CHAR_NUM:int = CharacterInfo.Bill[ CharacterInfo.IND_CHAR_NUM ];
		public static const WIN_SONG_DUR:int = 3730;
		public static const CHAR_SEL_END_DUR:int = 1950;
		public static const PAL_ORDER_ARR:Array = [ PaletteTypes.FLASH_POWERING_UP ];
		public static const IND_CI_Bill:int = 1;
		public static const IND_CI_BillWeaponUpgrade:int = 6;
		protected static const BILL_FLARE:String = PickupInfo.BILL_FLARE;
		protected static const BILL_LASER:String = PickupInfo.BILL_LASER;
		protected static const BILL_MACHINE:String = PickupInfo.BILL_MACHINE;
		protected static const BILL_RAPID_1:String = PickupInfo.BILL_RAPID_1;
		protected static const BILL_RAPID_2:String = PickupInfo.BILL_RAPID_2;
		protected static const BILL_SPREAD:String = PickupInfo.BILL_SPREAD;

		private static const SWAPPED_STRING:String = BILL_RAPID_1;
		public static const OBTAINABLE_UPGRADES_ARR:Array = [
			[ BILL_LASER, BILL_FLARE, BILL_MACHINE, BILL_SPREAD ]
//			[ BILL_RAPID_1 ],
//			[ BILL_LASER, BILL_FLARE ],
//			[ BILL_RAPID_2, BILL_MACHINE ],
//			[ BILL_SPREAD ]
		];

		override public function get classicGetMushroomUpgrades():Vector.<String>
		{ return Vector.<String>([ classicMushroomWeapon]); }

		override public function get classicGetFireFlowerUpgrades():Vector.<String>
		{ return Vector.<String>([ classicFireFlowerWeapon ]); }

		public static const MUSHROOM_UPGRADES:Array = [ ];
		public static const NEVER_LOSE_UPGRADES:Array = [ BILL_RAPID_1, BILL_RAPID_2 ];
		public static const START_WITH_UPGRADES:Array = [ ];
		public static const RESTORABLE_UPGRADES:Array = [ ];
		public static const SINGLE_UPGRADES_ARR:Array = [ BILL_LASER, BILL_FLARE, BILL_MACHINE, BILL_SPREAD ];
		public static const REPLACEABLE_UPGRADES_ARR:Array = [ [ BILL_LASER, BILL_RAPID_1 ], [ BILL_FLARE, BILL_RAPID_1 ],
			[ BILL_MACHINE, BILL_RAPID_1 ], [ BILL_SPREAD, BILL_RAPID_1 ], [ BILL_RAPID_1, BILL_RAPID_2 ] ];
		public static const ICON_ORDER_ARR:Array = [ BILL_RAPID_1, BILL_RAPID_2, BILL_LASER, BILL_FLARE, BILL_MACHINE, BILL_SPREAD ];
//		public static const AMMO_ARR:Array = [ [ null, 0, 0 ] ];
//		public static const AMMO_DEPLETION_ARR:Array = [ [ null, 0 ] ];
//		public static const AMMO_DEPLETION_DCT:CustomDictionary = new CustomDictionary();
//		public static const AMMO_DCT:CustomDictionary = new CustomDictionary();
		public static const TITLE_SCREEN_UPGRADES:Array = [ ];
		public static const SKIN_PREVIEW_SIZE:Point = new Point(35,38);
		private const ANIM_TMR_FOR_GROUND:CustomTimer = AnimationTimers.ANIM_VERY_SLOW_TMR;
		private const ANIM_TMR_FOR_FLIPPING:CustomTimer = AnimationTimers.ANIM_MODERATE_TMR;
		private const SECONDS_LEFT_SND:String = SoundNames.SFX_BILL_SECONDS_LEFT;
		private const SND_MUSIC_WIN:String = SoundNames.MFX_BILL_WIN;
		private static const MAIN_FRAMES_ARR:Array = ["main"];
		private var mGunTmr:CustomTimer;
		private var mGunTmrDur:int = 110;
		private const DIE_BOOST:int = 300;
		private const DIE_TMR_DEL_NORMAL:int = 1500;
		private const DIE_TMR_DEL_NORMAL_MAX:int = 6000;
		private const DIE_TMR_DEL_PIT:int = 2500;
		private static const STR_SHOOT:String = "Shoot";
		private static const FL_DIE_END:String = "dieEnd";
		private static const FL_ELECTROCUTE_START:String = "electrocuteStart";
		private static const FL_ELECTROCUTE_END:String = "electrocuteEnd";
		private var doneDying:Boolean;
		public var legs:BillLegs;
		private var _torso:BillTorso;
		private var _torsoDefY:Number;
		private var _torsoDwnY:Number;
		private const CROUCH_DEF_Y:int = 0;
		private const CROUCH_DWN_Y:int = 2;
		public var torsoDown:Boolean;
		private const WALK_SPEED:int = 150;
		private const MAX_NORMAL_BULLETS:int = 4;
		private const MAX_MACHINE_GUN_BULLETS:int = 6;
		private const MAX_SPREAD_BULLETS:int = 10;
		private const TORSO_Y_DIF_MOVING:int = 1;
		public static const SFX_BILL_DIE:String = SoundNames.SFX_BILL_DIE;
		public static const SFX_BILL_LAND:String = SoundNames.SFX_BILL_LAND;
		private static const SN_GET_ITEM:String = SoundNames.SFX_BILL_GET_ITEM;
		private const TD_TMR_DUR:int = 60; // moves torso down
		public const TD_TMR:CustomTimer = new CustomTimer(TD_TMR_DUR,1);
		private const SHOOT_TMR:CustomTimer = new CustomTimer(250,1);
		private var numMchShotsCtr:int;
		private const MAX_M_SHOTS_BEFORE_DELAY:int = 6;
		private static const NUM_FLARE_SHOTS_ALLOWED:int = 3*2; // one fake shot is made for every real one
		private const M_GUN_MAX_DEL_TMR:CustomTimer = new CustomTimer(50,1);
		// sometimes controlled by Legs class
		private const TORSO_Y_DIF:int = 2;
		private const REPL_COLOR_1_1:uint = 0xFF19398b;
		private const REPL_COLOR_2_1:uint = 0xFFF83800;
		private const REPL_COLOR_3_1:uint = 0xFFFFCEC6;
		private const REPL_COLOR_1_2:uint = 0xFF0058f8;
		private const REPL_COLOR_2_2:uint = REPL_COLOR_2_1;
		private const REPL_COLOR_3_2:uint = REPL_COLOR_3_1;
		private const REPL_COLOR_1_3:uint = 0xFFFF0000;
		private const REPL_COLOR_2_3:uint = REPL_COLOR_2_1;
		private const REPL_COLOR_3_3:uint = REPL_COLOR_3_1;
		private const WALK_START_LAB:String = null;
		private const WALK_END_LAB:String = null;

		public static const SKIN_ORDER:Array = [
			SKIN_BILL_NES,
			SKIN_BILL_SUPER_C,
			SKIN_BILL_SNES,
			SKIN_BILL_16_BIT,
			SKIN_BILL_GB,
			SKIN_BILL_X1,
			SKIN_BILL_ATARI,
			SKIN_LANCE_NES,
			SKIN_LANCE_SUPER_C,
			SKIN_LANCE_SNES,
			SKIN_LANCE_16_BIT,
			SKIN_LANCE_GB,
			SKIN_LANCE_X1,
			SKIN_LANCE_ATARI,
			SKIN_RD_008_NES,
			SKIN_RD_008_GB,
			SKIN_RC_011_NES,
			SKIN_RC_011_GB
		];

		public static const SKIN_BILL_NES:int = 0;
		public static const SKIN_BILL_SNES:int = 1;
		public static const SKIN_BILL_GB:int = 2;
		public static const SKIN_LANCE_NES:int = 3;
		public static const SKIN_LANCE_SNES:int = 4;
		public static const SKIN_LANCE_GB:int = 5;
		public static const SKIN_RD_008_NES:int = 6;
		public static const SKIN_RC_011_NES:int = 7;
		public static const SKIN_BILL_16_BIT:int = 8;
		public static const SKIN_LANCE_16_BIT:int = 9;
		public static const SKIN_BILL_ATARI:int = 10;
		public static const SKIN_BILL_X1:int = 11;
		public static const SKIN_RD_008_GB:int = 12;
		public static const SKIN_RC_011_GB:int = 13;
		public static const SKIN_LANCE_ATARI:int = 14;
		public static const SKIN_BILL_SUPER_C:int = 15;
		public static const SKIN_LANCE_SUPER_C:int = 16;
		public static const SKIN_LANCE_X1:int = 17;

		public static const SPECIAL_SKIN_NUMBER:int = SKIN_BILL_X1;
		public static const ATARI_SKIN_NUMBER:int = SKIN_BILL_ATARI;

		private var electrocuteTmr:GameLoopTimer;
		private static const ELECTROCUTE_TMR_DEL:int = 25;
		private static const NO_DAMAGE_TMR_DEL:int = 2000;

		public function Bill()
		{
			charNum = CHAR_NUM;
			super();
			_charName = CHAR_NAME;
			_charNameTxt = CHAR_NAME_TEXT;
			_charNameCaps = CHAR_NAME_CAPS;
			_secondsLeftSnd = SECONDS_LEFT_SND;
			_sndWinMusic = SND_MUSIC_WIN;
			_dieTmrDel = DIE_TMR_DEL_NORMAL;
			winSongDur = WIN_SONG_DUR;
			//hidesBmps = true;
			_usesHorzObjs = true;
			_usesVertObjs = true;
			canGetMushroom = false;
			walkStartLab = WALK_START_LAB;
			walkEndLab = WALK_END_LAB;
			mainAnimTmr = ANIM_TMR_FOR_GROUND;
			ACTIVE_ANIM_TMRS_DCT.addItem(ANIM_TMR_FOR_FLIPPING);
			_torsoDefY = _torso.y;
			_torsoDwnY = _torso.y + TORSO_Y_DIF;
		}

		private function get classicMushroomWeapon():String
		{
			return getClassicWeapon(GameSettings.billFirstWeapon);
		}

		private function get classicFireFlowerWeapon():String
		{
			return getClassicWeapon(GameSettings.billSecondWeapon);
		}

		private function getClassicWeapon(weapon:BillWeapon):String
		{
			switch(weapon)
			{
				case BillWeapon.Flare:
					return PickupInfo.BILL_FLARE;
				case BillWeapon.Laser:
					return PickupInfo.BILL_LASER;
				case BillWeapon.MachineGun:
					return PickupInfo.BILL_MACHINE;
				case BillWeapon.Spread:
					return PickupInfo.BILL_SPREAD;
				default:
					return PickupInfo.BILL_MACHINE;
			}
		}

		override protected function setObjsToRemoveFromFrames():void
		{
			super.setObjsToRemoveFromFrames();
			removeObjsFromFrames(Bitmap,MAIN_FRAMES_ARR);
			removeObjsFromFrames(_torso,MAIN_FRAMES_ARR,true);
			removeObjsFromFrames(legs,MAIN_FRAMES_ARR,true);
		}
		override protected function mcReplacePrep(thisMc:MovieClip):void
		{
			var oldLegs:MovieClip;
			var oldTorso:MovieClip;
			legs = new BillLegs( this, new MovieClipInfo.BillLegsMc() );
			_torso = new BillTorso( this, new MovieClipInfo.BillTorsoMc() );
			for (var i:int = 0; i < thisMc.numChildren; i++)
			{
				var dObj:DisplayObject = thisMc.getChildAt(i);
				if (dObj is MovieClip)
				{
					var mc:MovieClip = dObj as MovieClip;
					var num:int = mc.totalFrames;
					if (num == legs.totalFrames)
						oldLegs = mc;
					else if (num == _torso.totalFrames)
						oldTorso = mc;
				}
			}
			mcReplaceArr = [ oldLegs, legs, oldTorso, _torso ];
		}
		// SETSTATS sets statistics and initializes character
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
			jumpPwr = 550;
			gravity = 1000;
			if (level.waterLevel)
			{
				defGravity = gravity;
				gravity = 500;
				defGravityWater = gravity;
			}
			defSpringPwr = 400;
			boostSpringPwr = 800;
			vyMaxPsv = 600;
			//vyMaxNgv = jumpPwr;
			xSpeed = WALK_SPEED;
			vxMax = xSpeed;
			numParFrames = 3;
			pState2 = true;
			super.setStats();
			vineAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
			setStopFrame("main");
			torso.setStopFrame("normal");
			legs.setStopFrame("stand");
			setState("stand");
			TD_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,tdTmrHandler,false,0,true);
			addTmr(TD_TMR);
			SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler,false,0,true);
			addTmr(SHOOT_TMR);
			M_GUN_MAX_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,mGunMaxDelTmrHandler,false,0,true);
			addTmr(M_GUN_MAX_DEL_TMR);
			noDamageTmr.delay = NO_DAMAGE_TMR_DEL;
		}
		override protected function startAndDamageFcts(start:Boolean = false):void
		{
			super.startAndDamageFcts(start);
		}
		override public function forceWaterStats():void
		{
			defGravity = gravity;
			gravity = 500;
			defGravityWater = gravity;
			super.forceWaterStats();
		}
		override public function forceNonwaterStats():void
		{
			gravity = 1000;
			super.forceNonwaterStats();
		}
		override protected function movePlayer():void
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
					vx = xSpeed;
					this.scaleX = 1;
				}
				else if (lftBtn && !rhtBtn && !wallOnLeft)
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
					vx = -xSpeed;
					this.scaleX = -1;
				}
				else if (lftBtn && rhtBtn) vx = 0;
				else if (onGround && !lftBtn && !rhtBtn) vx = 0;
			//}
			//else vx = 0;

		}

		// CHECKSTATE
		override protected function checkState():void
		{
			if (!TD_TMR.running && !freezeGameTmr.running)
			{
				torso.y = torsoDefY;
				torsoDown = false;
			}
			if (cState == "vine")
			{
				mainAnimTmr = vineAnimTmr;
				checkVineBtns();
				checkVinePosition();
				return;
			}
			if (onGround)
			{
				mainAnimTmr = ANIM_TMR_FOR_GROUND;
				jumped = false;
				if (!lftBtn && !rhtBtn)
				{
					if (upBtn)
					{
						setState("stand");
						if (TD_TMR.running)
							_torso.setStopFrame("upShoot");
						else
							_torso.setStopFrame("up");
						legs.setStopFrame("stand");
						setStopFrame("main");
					}
					else if (dwnBtn)
					{
						if (cState != "crouch" && TD_TMR.running)
							TD_TMR.reset();
						setState("crouch");
						if (TD_TMR.running)
							setStopFrame("crouch" + STR_SHOOT);
						else
							setStopFrame("crouch");
					}
					else
					{
						setState("stand");
						if (TD_TMR.running)
							_torso.setStopFrame("normalShoot");
						else
							_torso.setStopFrame("normal");
						legs.setStopFrame("stand");
						setStopFrame("main");
					}
				}
				else if (cState != "walk")
				{
					setStopFrame("main");
					setState("walk");
					legs.setPlayFrame("walk-1");
					if (upBtn)
						_torso.setStopFrame("diagUp");
					else if (dwnBtn)
						_torso.setStopFrame("diagDwn");
					else if (SHOOT_TMR.running)
						_torso.setStopFrame("normal");
					else
						_torso.setPlayFrame("walk-1");
				}
				else
				{
					if (upBtn)
						_torso.setStopFrame("diagUp");
					else if (dwnBtn)
						_torso.setStopFrame("diagDwn");
					else if (SHOOT_TMR.running)
						_torso.setStopFrame("normal");
					else
					{
						var clTor:String = _torso.currentLabel;
						if (clTor == "diagUp" || clTor == "diagDwn" || clTor == "normal")
						{
							var clLegs:String = legs.currentLabel;
							var fNumStr:String = clLegs.charAt(clLegs.indexOf("-")+1);
							_torso.setPlayFrame("walk-"+fNumStr);
						}
					}
					if (TD_TMR.running)
						_torso.gotoAndStop(torso.currentLabel + STR_SHOOT);
				}
			}
			else // if (!onGround)
			{
				mainAnimTmr = ANIM_TMR_FOR_FLIPPING;
				if (cState != "jump" && jumped)
				{
					setPlayFrame("jumpStart");
					setState("jump");
				}
				else if (!jumped)
				{
					setStopFrame("main");
					setState("jump");
					_torso.setStopFrame("fall");
					legs.setStopFrame("fall");
				}
			}
		}

		override public function hitPickup(pickup:Pickup,showAnimation:Boolean = true):void
		{
			var hadFireFlower:Boolean = upgradeIsActive(FIRE_FLOWER);
			super.hitPickup(pickup,showAnimation);
			if (pickup.type == FIRE_FLOWER)
			{
				if (!hadFireFlower)
				{
//					trace("hit fire flower");
					attacksAreSwapped = false;
				}
			}
			if (!pickup.playsRegularSound && pickup.mainType != PickupInfo.MAIN_TYPE_FAKE && showAnimation)
				SND_MNGR.playSound(SN_GET_ITEM);
		}

		private function get attacksAreSwapped():Boolean
		{
			if ( !GameSettings.classicMode || !upgradeIsActive(FIRE_FLOWER) )
				return false;
			else
				return STAT_MNGR.getSubWeapon(charNum) == SWAPPED_STRING;
		}

		private function set attacksAreSwapped(value:Boolean):void
		{
			if (value)
				STAT_MNGR.setSubWeapon(charNum, SWAPPED_STRING);
			else
				STAT_MNGR.setSubWeapon(charNum, null);
			stopMachineGun();
		}

//		private function swapPrimaryAndSecondaryAttacks():void
//		{
//			if (primaryAttack == classicFireFlowerWeapon)
//				primaryAttack = classicMushroomWeapon;
//			else if (primaryAttack == classicMushroomWeapon)
//				primaryAttack = classicFireFlowerWeapon;
//		}

		public function get primaryAttack():String
		{
			if (GameSettings.classicMode)
			{
				if ( upgradeIsActive(FIRE_FLOWER) )
				{
					if (attacksAreSwapped)
						return classicMushroomWeapon;
					else
						return classicFireFlowerWeapon;
				}
				else if ( upgradeIsActive(MUSHROOM) )
					return classicMushroomWeapon;
				else
					return null;
			}
			else
				return getBulletTypeFromUpgrades();
		}

		private function get secondaryAttack():String
		{
			if ( !upgradeIsActive(FIRE_FLOWER) )
				return null;

			if (attacksAreSwapped)
				return classicFireFlowerWeapon;
			else
				return classicMushroomWeapon;
		}

		private function hideBodySets():void
		{
			_torso.visible = false;
			legs.visible = false;
			showBmps = true;
			//applyBmpVisibility();
			//BMD_CONT_VEC[0].bmp.parent.visible = true;
		}
		private function showBodySets():void
		{
			_torso.visible = true;
			legs.visible = true;
			showBmps = false;
			//applyBmpVisibility();
			//BMD_CONT_VEC[0].bmp.parent.visible = false;
		}
		/*override internal function setStopFrame(_stopFrame:String):void
		{
			if (!lockFrame)
			{
				if (_stopFrame == "main")
					showBodySets();
				else
					hideBodySets();
				if (currentFrameLabel != convLab(_stopFrame))
					gotoAndStop(convLab(_stopFrame));
				stopAnim = true;
			}
		}
		override internal function setPlayFrame(_stopFrame:String):void
		{
			if (!lockFrame)
			{
				hideBodySets();
				if (currentFrameLabel != convLab(_stopFrame))
					gotoAndStop(convLab(_stopFrame));
				stopAnim = false;
			}
		}*/
		// PRESSJUMPBTN
		override public function pressJmpBtn():void
		{
			if (cState == ST_VINE)
				return;
			if (onGround)
			{
				onGround = false;
				vy = -jumpPwr;
				setPlayFrame("jumpStart");
				setState(ST_JUMP);
				lState = ST_STAND;
				jumped = true;
			}
			super.pressJmpBtn();

		}
		// PRESSATTACKBTN
		override public function pressAtkBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressAtkBtn();
			createBulletIfPossible( primaryAttack );
		}

		override public function pressSpcBtn():void
		{
			if (cState == ST_VINE)
				return;
			super.pressSpcBtn();
			if ( secondaryAttack != null )
				createBulletIfPossible(secondaryAttack);
		}

		override public function pressSelBtn():void
		{
			super.pressSelBtn();
			if (GameSettings.classicMode)
				attacksAreSwapped = !attacksAreSwapped;
		}

		private function getBulletTypeFromUpgrades():String
		{
			if ( upgradeIsActive(BILL_MACHINE) )
				return BILL_MACHINE;
			else if ( upgradeIsActive(BILL_SPREAD) )
				return BILL_SPREAD;
			else if ( upgradeIsActive(BILL_LASER) )
				return BILL_LASER;
			else if ( upgradeIsActive(BILL_FLARE) )
				return BILL_FLARE;
			else
				return null; // default bullet
		}

		private function createBulletIfPossible(weapon:String):void
		{
			if (weapon == BILL_MACHINE)
			{
				if (level.PLAYER_PROJ_DCT.length < MAX_MACHINE_GUN_BULLETS)
				{
					shoot();
					level.addToLevel(new BillBullet(this,BillBullet.TYPE_MACHINE) );
				}
				startMachineGun();
			}
			else if ( weapon == BILL_SPREAD )
			{
				if (level.PLAYER_PROJ_DCT.length >= MAX_SPREAD_BULLETS)
					return;
				var spreadName:String = BillBullet.TYPE_SPREAD;
				shoot();
				var shot1:BillBullet = new BillBullet(this,spreadName);
				var shot2:BillBullet = new BillBullet(this,spreadName);
				var shot3:BillBullet = new BillBullet(this,spreadName);
				var shot4:BillBullet = new BillBullet(this,spreadName);
				var shot5:BillBullet = new BillBullet(this,spreadName);
				if (level.PLAYER_PROJ_DCT.length <= 5)
				{
					shot1.setSpread(0);
					level.addToLevel(shot1);
					shot2.setSpread(1);
					level.addToLevel(shot2);
					shot3.setSpread(-1);
					level.addToLevel(shot3);
					shot4.setSpread(-2);
					level.addToLevel(shot4);
					shot5.setSpread(2);
					level.addToLevel(shot5);
				}
				else if (level.PLAYER_PROJ_DCT.length == 6)
				{
					shot1.setSpread(0);
					level.addToLevel(shot1);
					shot2.setSpread(1);
					level.addToLevel(shot2);
					shot3.setSpread(-1);
					level.addToLevel(shot3);
					shot4.setSpread(-2);
					level.addToLevel(shot4);
				}
				else if (level.PLAYER_PROJ_DCT.length == 7)
				{
					shot1.setSpread(0);
					level.addToLevel(shot1);
					shot2.setSpread(1);
					level.addToLevel(shot2);
					shot3.setSpread(-1);
					level.addToLevel(shot3);
				}
				else if (level.PLAYER_PROJ_DCT.length == 8)
				{
					shot1.setSpread(0);
					level.addToLevel(shot1);
					shot2.setSpread(1);
					level.addToLevel(shot2);
				}
				else if (level.PLAYER_PROJ_DCT.length == 9)
				{
					shot1.setSpread(0);
					level.addToLevel(shot1);
				}
			}
			else if ( weapon == BILL_LASER )
			{
				shoot();
				BillBullet.createLaser(this);
			}
			else if ( weapon == BILL_FLARE )
			{
				if ( level.PLAYER_PROJ_DCT.length < NUM_FLARE_SHOTS_ALLOWED)
				{
					shoot();
					level.addToLevel( new BillBullet(this,BillBullet.TYPE_FLARE) );
				}
			}
			else if (level.PLAYER_PROJ_DCT.length < MAX_NORMAL_BULLETS) // no gun upgrades
			{
				shoot();
				level.addToLevel(new BillBullet(this,BillBullet.TYPE_NORMAL))
			}
		}

		private function shoot():void
		{
			if (onGround)
			{
				if (cState != "crouch")
				{
					TD_TMR.reset();
					TD_TMR.start();
					moveTorsoDown();
					if (!(upBtn || dwnBtn))
						torso.setStopFrame("normal");
					//if ((lftBtn || rhtBtn) && (upBtn || dwnBtn || SHOOT_TMR.running))
					//	torso.y += TORSO_Y_DIF_MOVING;
				}
				else
				{
					TD_TMR.reset();
					TD_TMR.start();
				}
			}
			SHOOT_TMR.reset();
			SHOOT_TMR.start();
		}
		private function shootTmrHandler(e:TimerEvent):void
		{
			SHOOT_TMR.reset();
		}
		private function tdTmrHandler(e:TimerEvent):void
		{
			 moveTorsoUp();
		}
		public function moveTorsoDown():void
		{
			if (currentLabel == "main")
				_torso.gotoAndStop(_torso.currentLabel + STR_SHOOT);
			else if (currentLabel == "crouch")
				gotoAndStop(currentLabel + STR_SHOOT);
			torso.y = torsoDefY;
			//torso.y = torsoDwnY;
			torsoDown = true;
		}
		public function moveTorsoUp(ovRdTd:Boolean = true):void
		{
			if (torsoDown && !ovRdTd)
				return;
			if (currentLabel == "main")
			{
				var ind:int = _torso.currentLabel.indexOf(STR_SHOOT);
				_torso.gotoAndStop( _torso.currentLabel.substring(0,ind) );
			}
			else if (currentLabel == "crouchShoot")
				gotoAndStop("crouch");
			//torso.y = torsoDefY;
			torsoDown = false;
		}
		// RELATTACKBTN
		override public function relAtkBtn():void
		{
			super.relAtkBtn();
			if (secondaryAttack == null || primaryAttack == BILL_MACHINE)
				stopMachineGun();
		}

		override public function relSpcBtn():void
		{
			super.relSpcBtn();
			if (secondaryAttack == BILL_MACHINE)
				stopMachineGun();
		}

		private function stopMachineGun():void
		{
			if (mGunTmr != null)
			{
				mGunTmr.reset();
				mGunTmr.removeEventListener(TimerEvent.TIMER, mGunTmrLsr);
//				trace("stop and remove");
			}
			if (!M_GUN_MAX_DEL_TMR.running)
				numMchShotsCtr = 0;
		}

		private function startMachineGun():void
		{
			if (mGunTmr == null)
			{
				mGunTmr = new CustomTimer(mGunTmrDur);
				addTmr(mGunTmr);
			}
//			if ( !mGunTmr.hasEventListener(TimerEvent.TIMER) )
//			if (!mGunTmr.running)
//			{
//				trace("start and add event");
				mGunTmr.addEventListener(TimerEvent.TIMER,mGunTmrLsr);
				mGunTmr.start();
//			}
		}

//		private function get canFireSecondaryWeapon():Boolean
//		{
//			return GameSettings.classicMode && upgradeIsActive(FIRE_FLOWER);
//		}

		private function mGunTmrLsr(e:TimerEvent):void
		{
//			trace("running: " + mGunTmr.running);
			if (GameSettings.classicMode)
			{
				if (!upgradeIsActive(MUSHROOM) || (secondaryAttack == null && classicMushroomWeapon != BILL_MACHINE) )
				{
					stopMachineGun();
					return;
				}
			}
			else if (!upgradeIsActive(BILL_MACHINE) )
			{
				stopMachineGun();
				return;
			}

			if (level.PLAYER_PROJ_DCT.length < MAX_MACHINE_GUN_BULLETS)
			{
				if (numMchShotsCtr < MAX_M_SHOTS_BEFORE_DELAY)
				{
					level.addToLevel(new BillBullet(this,BillBullet.TYPE_MACHINE));
					shoot();
					numMchShotsCtr++;
				}
				else
				{
					if (!M_GUN_MAX_DEL_TMR.running)
					{
						M_GUN_MAX_DEL_TMR.reset();
						M_GUN_MAX_DEL_TMR.start();
					}
				}
			}
			else
			{
				numMchShotsCtr = 0;
				if (!M_GUN_MAX_DEL_TMR.running)
					M_GUN_MAX_DEL_TMR.stop();
			}
		}
		override protected function getMushroom():void
		{
			super.getMushroom();
			legs.hitFrameLabel = legs.currentLabel;
			torso.hitStopAnim = torso.stopAnim;
			legs.hitStopAnim = legs.stopAnim;
			torso.stopAnim = true;
			legs.stopAnim = true;
		}
		override protected function getMushroomEnd():void
		{
			super.getMushroomEnd();
			var lfc:String = legs.hitFrameLabel;
			var lsf:String = lfc.substr(0,lfc.length-2);
			legs.setStopFrame(lsf);
			torso.stopAnim = torso.hitStopAnim;
			legs.stopAnim = legs.hitStopAnim;
			relAtkBtn();
		}
		override protected function takeDamage(source:LevObj):void
		{
			super.takeDamage(source);
			if (!GameSettings.classicMode && !takeNoDamage)
				die(source);
			stopMachineGun();
		}
		override protected function takeDamageStart(source:LevObj):void
		{
			super.takeDamageStart(source);
			SND_MNGR.playSound(SoundNames.SFX_BILL_ELECTRECUTE);
			setDamageInfoArr();
			startReplaceColor();
			stopAnim = true;
			setState(ST_TAKE_DAMAGE);
			lockState = true;
			alpha = TD_ALPHA;
			torso.hitStopAnim = torso.stopAnim;
			legs.hitStopAnim = legs.stopAnim;
			torso.stopAnim = true;
			legs.stopAnim = true;
			freezeGame();
		}

		override protected function noDamageTmrLsr(e:TimerEvent):void
		{
			super.noDamageTmrLsr(e);
			if (!starPwr)
				endReplaceColor();
		}
		override protected function takeDamageEnd():void
		{
			super.takeDamageEnd();
			trace("take damage end");
//			endReplaceColor();
			setState(ST_NEUTRAL);
			torso.stopAnim = torso.hitStopAnim;
			legs.stopAnim = legs.hitStopAnim;
			relAtkBtn();
		}
		private function mGunMaxDelTmrHandler(e:TimerEvent):void
		{
			numMchShotsCtr = 0;
		}
		override protected function landOnGround():void
		{
			super.landOnGround();
			if (cState != "flagSlide" && !onSpring)
				SND_MNGR.playSound(SFX_BILL_LAND);
			if (cState == ST_DIE)
				EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL);
		}
		override public function slideDownFlagPole():void
		{
			super.slideDownFlagPole();
			nx = level.flagPole.hMidX;
			setStopFrame("slide");
		}
		override public function stopFlagPoleSlide():void
		{
			super.stopFlagPoleSlide();
			if (onGround)
			{
				setState(ST_STAND);
			}
			else
			{
				setPlayFrame("jumpStart");
				setState("jump");
				jumped = true;
			}

		}
		override protected function flagDelayTmrLsr(e:TimerEvent):void
		{
			super.flagDelayTmrLsr(e);
			if (onGround)
			{
				setState("walk");
				setStopFrame("main");
				torso.setPlayFrame("walk-1");
				legs.setPlayFrame("walk-1");
			}
		}
		override protected function initiateNormalDeath(source:LevObj = null):void
		{
			super.initiateNormalDeath(source);
			var dir:int = 1;
			if (source)
			{
				if (source.nx > nx)
					dir = -1;
			}
			else
			{
				if (scaleX > 0)
					dir = -1
			}
			vx = xSpeed*dir;
			scaleX = -dir;
			vy = -DIE_BOOST;
			relAtkBtn();
			onGround = false;
			setPlayFrame("dieStart");
			lockFrame = true;
			SND_MNGR.playSound(SFX_BILL_DIE);
			EVENT_MNGR.startDieTmr(DIE_TMR_DEL_NORMAL_MAX);
		}
		override protected function enterPipeVert():void
		{
			super.enterPipeVert();
			setStopFrame("main");
			torso.setStopFrame("normal");
			legs.setStopFrame("stand");
		}
		override public function exitPipeVert(pt:PipeTransporter):void
		{
			super.exitPipeVert(pt);
			setStopFrame("main");
			torso.setStopFrame("normal");
			legs.setStopFrame("stand");
		}
		override protected function enterPipeHorz():void
		{
			if (cState != "walk")
			{
				setState("walk");
				setStopFrame("main");
				legs.setPlayFrame("walk-1");
				torso.setPlayFrame("walk-1");
			}
			super.enterPipeHorz();
		}
		override protected function initiatePitDeath():void
		{
			if (fellInPit)
			{
				SND_MNGR.playSound(SFX_BILL_DIE);
				_dieTmrDel = DIE_TMR_DEL_PIT;
			}
			else
				_dieTmrDel = DIE_TMR_DEL_NORMAL;
			relAtkBtn();
			super.initiatePitDeath();
		}
		override public function drawObj():void
		{
			super.drawObj();
			if (legs.currentLabel == legs.convLab(legs.TORSO_DWN_FRM) && !TD_TMR.running)
				torso.y = torsoDwnY;
			else
				torso.y = torsoDefY;

		}
		override protected function swapPs():void
		{
			super.swapPs();
			var lcl:String = legs.currentLabel;
			var lsf:String = lcl.substr(0,lcl.length-2);
			legs.setStopFrame(lsf);
		}
		override public function manualChangePwrState():void
		{
			legs.hitStopAnim = legs.stopAnim;
			legs.hitFrameLabel = legs.currentLabel;
			super.manualChangePwrState();
			var lcl:String = legs.hitFrameLabel;
			var lsf:String = lcl.substr(0,lcl.length-2);
			legs.setStopFrame(lsf);
			legs.stopAnim = legs.hitStopAnim;
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			var bool:Boolean;
			if (cState != "die")
			{
				bool = super.animate(ct);
				if (ct == mainAnimTmr)
				{
					_torso.animate(ct);
					legs.animate(ct);
				}
			}
			else
			{
				if (!doneDying)
				{
					lockFrame = false;
					stopAnim = false;
					bool = super.animate(ct);
					if (ct == mainAnimTmr)
					{
						_torso.animate(ct);
						legs.animate(ct);
					}
					lockFrame = true;
				}
				else
				{
					bool = false;
				}
			}
			return bool;
		}
		override public function chooseCharacter():void
		{
			super.chooseCharacter();
			SND_MNGR.playSound(SoundNames.SFX_BILL_ELECTRECUTE);
			cancelCheckState = true;
			gotoAndStop(FL_ELECTROCUTE_START);
			starPwr = true;
			flashAnimTmr = STAR_PWR_FLASH_ANIM_TMR;
			startReplaceColor();
//			electrocuteTmr = new GameLoopTimer(ELECTROCUTE_TMR_DEL);
//			addTmr(electrocuteTmr);
//			electrocuteTmr.addEventListener(TimerEvent.TIMER,electrocuteTmrHandler,false,0,true);
//			electrocuteTmr.start();
		}

		override public function fallenCharSelScrn():void
		{
			super.fallenCharSelScrn();
			cancelCheckState = true;
			setStopFrame(FL_DIE_END);
		}

		override public function recolorBmps(inPalette:Palette,outPalette:Palette,inColorRow:int = 0,outColorRow:int = 0,defColorsOvrd:Palette = null):void
		{
			super.recolorBmps(inPalette, outPalette, inColorRow, outColorRow);
			torso.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
			legs.recolorBmps(inPalette, outPalette, inColorRow, outColorRow, defColors);
		}

		override protected function endReplaceColor():void
		{
			super.endReplaceColor();
			legs.resetColor();
			torso.resetColor();
		}

		protected function electrocuteTmrHandler(event:TimerEvent):void
		{
			if (currentLabel == FL_ELECTROCUTE_START)
				gotoAndStop(FL_ELECTROCUTE_END);
			else if (currentLabel == FL_ELECTROCUTE_END)
				gotoAndStop(FL_ELECTROCUTE_START);
		}
		override public function checkFrame():void
		{
			var cf:int = currentFrame;
			if (cState == "jump" && cf == getLabNum("jumpEnd") + 1)
				setPlayFrame("jumpStart");
			else if (cState == "vine")
			{
				if (cf == getLabNum("climbEnd") + 1)
					setPlayFrame("climbStart");
			}
			else if (cState == "die" && cf == getLabNum("dieEnd") + 1)
			{
				lockFrame = false;
				setStopFrame("dieEnd");
				lockFrame = true;
				doneDying = true;
			}
			super.checkFrame();
		}

		override protected function addAllPowerups():void
		{
			for (var i:int = 0; i < 7; i++)
			{
				hitRandomUpgrade(charNum,false);
			}
		}

		override protected function removeListeners():void
		{
			super.removeListeners();
			if (mGunTmr && mGunTmr.hasEventListener(TimerEvent.TIMER)) mGunTmr.removeEventListener(TimerEvent.TIMER,mGunTmrLsr);
			TD_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,tdTmrHandler);
			SHOOT_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler);
			M_GUN_MAX_DEL_TMR.removeEventListener(TimerEvent.TIMER_COMPLETE,mGunMaxDelTmrHandler);
			if (electrocuteTmr)
				electrocuteTmr.removeEventListener(TimerEvent.TIMER,electrocuteTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (mGunTmr && !mGunTmr.hasEventListener(TimerEvent.TIMER)) mGunTmr.addEventListener(TimerEvent.TIMER,mGunTmrLsr);
			TD_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,tdTmrHandler,false,0,true);
			SHOOT_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,shootTmrHandler,false,0,true);
			M_GUN_MAX_DEL_TMR.addEventListener(TimerEvent.TIMER_COMPLETE,mGunMaxDelTmrHandler,false,0,true);
		}
		public function get torsoDefY():Number
		{
			return _torsoDefY;
		}
		public function get torsoDwnY():Number
		{
			return _torsoDwnY;
		}
		public function get torso():BillTorso
		{
			return _torso;
		}

		override protected function prepareDrawCharacter(skinAppearanceState:int = -1):void
		{
			endReplaceColor();
			_torso.setStopFrame("normal");
			legs.setStopFrame("stand");
			setStopFrame("main");
			drawFrameLabel = null;
			super.prepareDrawCharacter(skinAppearanceState);
		}
		public function getOfsCharInd():int
		{
			if (skinNum == 2 || skinNum == 5 || skinNum == 12 || skinNum == 13)
				return BillBullet.OFS_CHAR_GB_IND;
//			else if (skinNum == 5)
//				return BillBullet.OFS_CHAR_LANCE_GB_IND;
			return BillBullet.OFS_CHAR_DEF_IND;
		}

		override protected function playDefaultPickupSoundEffect():void
		{
			SND_MNGR.playSound(SoundNames.SFX_BILL_GET_ITEM);
		}

//		public function set primaryAttack(value:String):void
//		{
//			_primaryAttack = value;
//		}

	}

}

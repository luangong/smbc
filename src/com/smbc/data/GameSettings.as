package com.smbc.data
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.utils.ArrayUtils;
	import com.explodingRabbit.utils.Enum;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.*;
	import com.smbc.enums.AttackStrength;
	import com.smbc.enums.BillWeapon;
	import com.smbc.enums.ClassicDamageResponse;
	import com.smbc.enums.CoinSoundType;
	import com.smbc.enums.DamageResponse;
	import com.smbc.enums.EnemySpeed;
	import com.smbc.enums.GoombaReplacementType;
	import com.smbc.enums.InitialLivesCount;
	import com.smbc.enums.ItemDropRate;
	import com.smbc.enums.LinkWeapon;
	import com.smbc.enums.MegaManSpecialWeapon;
	import com.smbc.enums.PiranhaSpawnType;
	import com.smbc.enums.PowerupMode;
	import com.smbc.enums.RyuSpecialWeapon;
	import com.smbc.enums.SamusWeapon;
	import com.smbc.enums.SimonSpecialWeapon;
	import com.smbc.enums.SophiaWeapon;
	import com.smbc.errors.IntToBooleanError;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.SkinNames;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.level.EnemySpawner;
	import com.smbc.level.Level;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.ButtonManager;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.MessageBoxManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.managers.TutorialManager;
	import com.smbc.messageBoxes.MenuBoxItems;

	public class GameSettings
	{
//		default settings need to be changed in defaultSettings()

		public static const DEBUG_MODE:Boolean = false; // false
		public static const SHOW_PALETTE_ERROR:Boolean = true;

		public static var DEFAULT_CHARACTER:int = MegaMan.CHAR_NUM;
		private static const DEFAULT_MAP_PACK:MapPack = MapPack.Smb;
		public static var FIRST_LEVEL:String = "1-1a";
		public static const hideNewStuff:Boolean = false;
		public static var callJavaScript:Boolean = false;
		public static const TURN_OFF_SOUND:Boolean = false; // false
		public static const VERSION_NUMBER:Number = Versions.V_3_121;
		public static const VERSION_SAVE_FILE_COMPAT_MIN:Number = Versions.V_3_121;
		public static var DEF_CHAR_SKIN_NUM:int = 0;
		public static const DEF_MAP_SKIN_NUM:int = BmdInfo.SKIN_NUM_SMB_NES;
		public static const INACTIVE_SKIN_NUMS:Array = GameSettingsValues.calcSkinMaxValue();
		public static const TITLE_SKINS:Array = [ 0, 1, 2, 3, 4, 5, 6, 9, 10, 11, 12, 13, 14, 15, 16 ]; // these skins will be shown at random on title level
		public static const FORCE_THEME_GROUP:ThemeGroup = null;
		public static const OVERRIDE_TIME_LEFT:int = 0;
		public static const SHOW_BMP:Boolean = false;
		public static const FORCE_NEXT_PICKUP:String = null; // PickupInfo.SAMUS_BOMB;
		public static var allUpgrades:Boolean = false; // debug only
		public static var skipLogos:Boolean = false; // debug only
		public static var skipTitleScreen:Boolean = false; // debug only
		public static var noLoading:Boolean = false; // debug only
		public static var invisiblePause:Boolean = false;
		public static var recordCharSeq:Boolean = false;
		public static const ALWAYS_DROP_ITEMS:Boolean = false;
		public static const SKIP_FAKE_LEVEL:Boolean = false;

//		simple settings
		public static var charSelIconsVisible:Boolean = true;
		//private static var _showCheats:Boolean = false; // false
		private static const FRAME_RATE_LOCKED:int = 30;
		private static const FRAME_RATE_UNLOCKED:int = 60;
		public static const SFX_VOLUME:int = 55; // 55
		public static const MUSIC_VOLUME:int = 100; // 100
		public static const MASTER_VOLUME:int = 75; // 75
//		settings that can be changed through menu
		private static var _difficulty:int = Difficulties.NORMAL; // NORMAL
		private static var _mapDifficulty:int = MapDifficulty.NORMAL; // NORMAL
		public static var powerupMode:PowerupMode = PowerupMode.Classic;
		private static var _campaignMode:int = CampaignModes.ALL_CHARACTERS; // SURVIVAL
		private static var _tutorials:Boolean = false; // true
//		public static var useNsf:Boolean = true;
		private static var _muteSfx:Boolean = false; // false
		private static var _muteMusic:Boolean = false; // false
		public static var coinSoundType:CoinSoundType = CoinSoundType.Normal;
		private static var _musicQuality:int = MusicQuality.HIGH; // MID
		private static var _musicType:int = ConsoleType.CHARACTER;
		private static var _musicSet:int = MusicSets.CHARACTER;
		public static var mapPack:MapPack = DEFAULT_MAP_PACK;
		private static var _cheatNotify:Boolean = true; // true
		private static var _lockFrameRate:Boolean = true;
		private static var _mapSkin:int = DEF_MAP_SKIN_NUM;
		public static var randomMapSkin:Boolean = false;
		private static var _enemySkin:int = SkinNames.getNum(SkinNames.USE_MAP_SKIN);
		private static var _interfaceSkin:int = SkinNames.getNum(SkinNames.USE_MAP_SKIN);
		private static var _mapPalette:int = GameBoyPalettes.OBJ[MenuBoxValues.FULL_COLOR];
		private static var _characterPalette:int = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
		private static var _enemyPalette:int = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
		private static var _interfacePalette:int = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
		private static var _paletteTarget:int = GameSettingsValues.paletteTargetAll;
		private static var _activeSkins:int = GameSettingsValues.paletteTargetAll;
		private static var _gameBoyFilter:Boolean = false;
		/**Enables/Disables up + attack for simon, ryu, and down + attack for SOPHIA */
		public static var classicSpecialInput:Boolean = false;

		// classic settings
		public static var classicDamageResponse:ClassicDamageResponse = ClassicDamageResponse.LoseCurrent;

		public static var bassWeapon:MegaManSpecialWeapon = MegaManSpecialWeapon.WaterShield;
		public static var billFirstWeapon:BillWeapon = BillWeapon.MachineGun;
		public static var billSecondWeapon:BillWeapon = BillWeapon.Spread;
		public static var linkWeapon:LinkWeapon = LinkWeapon.Bomb;
		public static var megaManWeapon:MegaManSpecialWeapon = MegaManSpecialWeapon.MetalBlade;
		public static var ryuStartWeapon:RyuSpecialWeapon = RyuSpecialWeapon.Shuriken;
		public static var ryuExtraWeapon:RyuSpecialWeapon = RyuSpecialWeapon.WindmillShuriken;
		public static var samusWeapon:SamusWeapon = SamusWeapon.WaveBeam;
		public static var simonStartWeapon:SimonSpecialWeapon = SimonSpecialWeapon.Axe;
		public static var simonExtraWeapon:SimonSpecialWeapon = SimonSpecialWeapon.Cross;
		public static var sophiaWeapon:SophiaWeapon = SophiaWeapon.TripleMissile;

		// more settings
		public static var initialLivesCount:InitialLivesCount = InitialLivesCount.Three;
		public static var attackStrength:AttackStrength = AttackStrength.Normal;
		public static var enemySpeed:EnemySpeed = EnemySpeed.Normal;
		public static var goombaReplacementType:GoombaReplacementType = GoombaReplacementType.Goomba;
		public static var damageResponse:DamageResponse = DamageResponse.LoseSomeUpgrades;
		public static var itemDropRate:ItemDropRate = ItemDropRate.Normal;
		public static var startWithMushroom:Boolean = false;
		public static var piranhaSpawnType:PiranhaSpawnType = PiranhaSpawnType.SomePipes;

		public static var onOfficialWebsiteDebug:Boolean = true;
		public static var forceOfflineDebug:Boolean = false; // also turns off onOfficialWebsite

		// inside variables only
		private static var mapSkinLimited:int;
		private static var enemySkinLimited:int;
		private static var interfaceSkinLimited:int;
		private static var mapPaletteLimited:int;
		private static var characterPaletteLimited:int;
		private static var enemyPaletteLimited:int;
		private static var interfacePaletteLimited:int;


		public static const INCREASE_SETTING_NUM:int = -1;
		public static const DECREASE_SETTING_NUM:int = -2;
		private static const IND_LOAD_SAVE_ARR_VALUE:int = 0;
		private static const IND_LOAD_SAVE_ARR_REFERENCE:int = 1;
		private static var game:SuperMarioBrosCrossover;
		private static var gsMngr:GameStateManager;
		private static var grMngr:GraphicsManager;
		private static var btnMngr:ButtonManager;
		private static var statMngr:StatManager;
		private static var scrnMngr:ScreenManager;
		private static var sndMngr:SoundManager;
		private static var eventMngr:EventManager;
		private static var msgBxMngr:MessageBoxManager;
		private static var tutMngr:TutorialManager;

		public static var showedNewVersionAvailableMessage:Boolean;

		public static function get activeSkins():int
		{
			return _activeSkins;
		}

		public static function get paletteTarget():int
		{
			return _paletteTarget;
		}

		public static function get mapSkin():int
		{
			return _mapSkin;
		}

		public static function setDefaults():void
		{
			_difficulty = Difficulties.NORMAL; // NORMAL
			_mapDifficulty = MapDifficulty.NORMAL;
			_campaignMode = CampaignModes.ALL_CHARACTERS; // MULTI_CHARACTER
			powerupMode = PowerupMode.Classic;
			_tutorials = false; // true
			_musicType = ConsoleType.CHARACTER;
			_musicSet = MusicSets.CHARACTER;
			mapPack = MapPack.Smb;
			_muteSfx = false;
			_muteMusic = false;
			coinSoundType = CoinSoundType.Normal;
			_cheatNotify = true;
			_lockFrameRate = true;
			_mapSkin = BmdInfo.SKIN_NUM_SMB_NES;
			_enemySkin = SkinNames.getNum(SkinNames.USE_MAP_SKIN);
			_interfaceSkin = SkinNames.getNum(SkinNames.USE_MAP_SKIN);
			_mapPalette = GameBoyPalettes.OBJ[MenuBoxValues.FULL_COLOR];
			_characterPalette = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
			_enemyPalette = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
			_interfacePalette = GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE];
			_paletteTarget = GameSettingsValues.paletteTargetAll;
			_activeSkins = GameSettingsValues.paletteTargetAll;
			_gameBoyFilter = false;
			classicSpecialInput = false;
			FIRST_LEVEL = "1-1a";
			DEFAULT_CHARACTER = Mario.CHAR_NUM;
			DEF_CHAR_SKIN_NUM = 0;
			resetClassicSettings();
			resetDifficultySettings();
		}

		private static function resetClassicSettings():void
		{
			classicDamageResponse = ClassicDamageResponse.LoseEverything;
			bassWeapon = MegaManSpecialWeapon.WaterShield;
			billFirstWeapon = BillWeapon.MachineGun;
			billSecondWeapon = BillWeapon.Spread;
			linkWeapon = LinkWeapon.Bomb;
			megaManWeapon = MegaManSpecialWeapon.MetalBlade;
			ryuStartWeapon = RyuSpecialWeapon.Shuriken;
			ryuExtraWeapon = RyuSpecialWeapon.WindmillShuriken;
			samusWeapon = SamusWeapon.WaveBeam;
			simonStartWeapon = SimonSpecialWeapon.Axe;
			simonExtraWeapon = SimonSpecialWeapon.Cross;
			sophiaWeapon = SophiaWeapon.TripleMissile;
		}

		public static function resetDifficultySettings():void
		{
			if (DEBUG_MODE)
				return;
			initialLivesCount = InitialLivesCount.Three;
			attackStrength = AttackStrength.Normal;
			enemySpeed = EnemySpeed.Normal;
			goombaReplacementType = GoombaReplacementType.Goomba;
			damageResponse = DamageResponse.LoseSomeUpgrades;
			piranhaSpawnType = PiranhaSpawnType.SomePipes;
			startWithMushroom = false;
			itemDropRate = ItemDropRate.Normal;
		}


		public static function activateDebugMode():void
		{
//			Cheats.unlockAllCheats();
			if (Cheats.allUnlocked)
				Cheats.activateDebugCheats();
		}
		public static function managersReady():void
		{
			game = SuperMarioBrosCrossover.game;
			grMngr = GraphicsManager.INSTANCE;
			gsMngr = GameStateManager.GS_MNGR;
			btnMngr = ButtonManager.BTN_MNGR;
			statMngr = StatManager.STAT_MNGR;
			scrnMngr = ScreenManager.SCRN_MNGR;
			sndMngr = SoundManager.SND_MNGR;
			eventMngr = EventManager.EVENT_MNGR;
			msgBxMngr = MessageBoxManager.INSTANCE;
			tutMngr = TutorialManager.TUT_MNGR;
		}
		public static function changeDifficulty(ovRd:int, temporary:int = -1):int
		{
			var newDifficulty:int = _difficulty;
			if (temporary >= 0)
				newDifficulty = temporary;
			if (ovRd == INCREASE_SETTING_NUM)
				newDifficulty++;
			else if (ovRd == DECREASE_SETTING_NUM)
				newDifficulty--;
			else
				newDifficulty = ovRd;
			newDifficulty = checkMaxMin(newDifficulty,Difficulties.MAX_VALUE,0);
			if (temporary < 0)
			{
				_difficulty = newDifficulty;
				statMngr.changeDifficulty();
			}
			return newDifficulty;
		}

		public static function changeMapDifficulty(ovRd:int, temporary:int = -1):int
		{
			var newMapDifficulty:int = _mapDifficulty;
			if (temporary >= 0)
				newMapDifficulty = temporary;
			if (ovRd == INCREASE_SETTING_NUM)
				newMapDifficulty++;
			else if (ovRd == DECREASE_SETTING_NUM)
				newMapDifficulty--;
			else
				newMapDifficulty = ovRd;
			newMapDifficulty = checkMaxMin(newMapDifficulty,MapDifficulty.MAX_VALUE,0);
			if (temporary < 0)
				_mapDifficulty = newMapDifficulty;
			return newMapDifficulty;
		}
//		public static function changeMapPack(ovRd:int, temporary:mapp = -1):int
//		{
//			var newMapPack:MapPack = _mapPack;
//			if (temporary >= 0)
//				newMapPack = temporary;
//			if (ovRd == INCREASE_SETTING_NUM)
//				newMapPack++;
//			else if (ovRd == DECREASE_SETTING_NUM)
//				newMapPack--;
//			else
//				newMapPack = ovRd;
//			newMapPack = checkMaxMin(newMapPack,MapPack.MAX_VALUE,0);
//			if (temporary < 0)
//				_mapPack = newMapPack;
//			return newMapPack;
//		}

		public static function changeCampaignMode(ovRd:int):String
		{
			if (ovRd == INCREASE_SETTING_NUM)
				_campaignMode++;
			else if (ovRd == DECREASE_SETTING_NUM)
				_campaignMode--;
			else
				_campaignMode = ovRd;
			_campaignMode = checkMaxMin(_campaignMode,CampaignModes.MAX_VALUE,0);
			return CampaignModes.swapNumAndName(_campaignMode);
		}
		public static function changeTutorials(ovRd:int = -1):void
		{
			if (ovRd > 0 && ovRd != 0 && ovRd != 1)
				throw new IntToBooleanError();
			if (ovRd < 0)
			{
				if (_tutorials)
					_tutorials = false;
				else
					_tutorials = true;
			}
			else
				_tutorials = Boolean(ovRd);
		}
		public static function changeLockFrameRate(ovRd:int = -1):Boolean
		{
			if (ovRd > 1)
				throw new IntToBooleanError();
			if (ovRd < 0)
				_lockFrameRate = !_lockFrameRate;
			else
				_lockFrameRate = Boolean(ovRd);
			if (_lockFrameRate)
				GlobVars.STAGE.frameRate = FRAME_RATE_LOCKED;
			else
				GlobVars.STAGE.frameRate = FRAME_RATE_UNLOCKED;
			return _lockFrameRate;
		}
		public static function changeGameBoyFilter(ovRd:int = -1):void
		{
			if (ovRd > 0 && ovRd != 0 && ovRd != 1)
				throw new IntToBooleanError();
			if (ovRd < 0)
			{
				if (_gameBoyFilter)
					_gameBoyFilter = false;
				else
					_gameBoyFilter = true;
			}
			else
				_gameBoyFilter = Boolean(ovRd);
			GraphicsManager.INSTANCE.updateScreenFilter();
		}



		public static function changeMuteMusic(ovRd:int = -1):void
		{
			if (ovRd > 0 && ovRd != 0 && ovRd != 1)
				throw new IntToBooleanError();
			if (ovRd < 0)
			{
				if (_muteMusic)
					_muteMusic = false;
				else
					_muteMusic = true;
			}
			else
				_muteMusic = Boolean(ovRd);
			sndMngr.changeMuteSettings();
		}
		public static function changeMuteSfx(ovRd:int = -1):void
		{
			if (ovRd > 0 && ovRd != 0 && ovRd != 1)
				throw new IntToBooleanError();
			if (ovRd < 0)
			{
				if (_muteSfx)
					_muteSfx = false;
				else
					_muteSfx = true;
			}
			else
				_muteSfx = Boolean(ovRd);
			sndMngr.changeMuteSettings();
		}
		private static function prepareLoadSave():Array
		{
			return [
//				[ difficulty, changeDifficulty ],
				[ mapDifficulty, changeMapDifficulty ],
				[ mapPack, "mapPack" ],
				[ campaignMode, changeCampaignMode ],
				[ powerupMode, "powerupMode" ],
	//			general options menu
				[ cheatNotify, "cheatNotify" ],
				[ tutorials, changeTutorials ],
				[ lockFrameRate, changeLockFrameRate ],
				// classic settings
				[ classicDamageResponse, "classicDamageResponse" ],
				[ classicSpecialInput, "classicSpecialInput" ],
				[ bassWeapon, "bassWeapon" ],
				[ billFirstWeapon, "billFirstWeapon" ],
				[ billSecondWeapon, "billSecondWeapon" ],
				[ linkWeapon, "linkWeapon" ],
				[ megaManWeapon, "megaManWeapon" ],
				[ ryuStartWeapon, "ryuStartWeapon" ],
				[ ryuExtraWeapon, "ryuExtraWeapon" ],
				[ samusWeapon, "samusWeapon" ],
				[ simonStartWeapon, "simonStartWeapon" ],
				[ simonExtraWeapon, "simonExtraWeapon" ],
				[ sophiaWeapon, "sophiaWeapon" ],
//				difficulty settings menu
				[ initialLivesCount, "initialLivesCount" ],
				[ attackStrength, "attackStrength" ],
				[ enemySpeed, "enemySpeed" ],
				[ goombaReplacementType, "goombaReplacementType" ],
				[ damageResponse, "damageResponse" ],
				[ startWithMushroom, "startWithMushroom" ],
				[ itemDropRate, "itemDropRate" ],
				[ piranhaSpawnType, "piranhaSpawnType" ],
	//			sound menu
				[ muteSfx, changeMuteSfx ],
				[ muteMusic, changeMuteMusic ],
				[ coinSoundType, "coinSoundType" ],
				[ musicType, changeMusicType ],
				[ musicSet, changeMusicSet ],
	//			graphics menu
				[ activeSkins, changeActiveSkins ],
				[ gameBoyFilter, changeGameBoyFilter ],
				[ mapSkin, changeMapSkin ],
				[ randomMapSkin, "randomMapSkin" ],
				[ enemySkin, changeEnemySkin ],
				[ interfaceSkin, changeInterfaceSkin ]
			];
		}
		public static function loadData(data:Array):void
		{
			var refArr:Array = prepareLoadSave();
			var n:int = refArr.length;
			for (var i:int; i < n; i++)
			{
				var arr:Array = refArr[i];
				var reference:* = arr[IND_LOAD_SAVE_ARR_REFERENCE];
				if (reference is Function)
					reference(data.shift()); // calls function with value
				else if (GameSettings[reference] is Enum)
					GameSettings[reference] =  Enum(GameSettings[reference]).GetAtIndex( data.shift() );
				else
					GameSettings[reference] = data.shift(); // sets property with that name to value
			}
		}
		public static function saveData():Array
		{
			var arr:Array = prepareLoadSave();
			var returnArr:Array = [];
			var n:int = arr.length;
			for (var i:int; i < n; i++)
			{
				if (arr[i][IND_LOAD_SAVE_ARR_VALUE] is Enum)
					returnArr.push( Enum(arr[i][IND_LOAD_SAVE_ARR_VALUE]).Index );
				else
					returnArr.push( int( arr[i][IND_LOAD_SAVE_ARR_VALUE]) );
			}
			return returnArr;
		}
		public static function changeMusicQuality(qualOvRdStr:int):void
		{
			_musicQuality = incValueFromOvRdNum(qualOvRdStr,_musicQuality);
			_musicQuality = checkMaxMin(_musicQuality,MusicQuality.MAX_VALUE,0);
//			sndMngr.musicPlayerMain.setPlayerQuality();
//			sndMngr.musicPlayerMinor.setPlayerQuality();
		}
		public static function changeMusicType(qualOvRdStr:int):int
		{
			_musicType = incValueFromOvRdNum(qualOvRdStr,_musicType);
			_musicType = checkMaxMin(_musicType,ConsoleType.MAX_VALUE,0);
			if (gsMngr.gameState == GameStates.PLAY)
				sndMngr.changeMusic();
			return _musicType;
		}
		public static function changeActiveSkins(ovRdNum:int):int
		{
			_activeSkins = incValueFromOvRdNum(ovRdNum,_activeSkins);
			_activeSkins = checkMaxMin(_activeSkins, GameSettingsValues.PALETTE_TARGET_MAX_VALUE, 0);
			if (!statMngr.loadingData)
				GraphicsManager.INSTANCE.changeActiveSkins();
			return _activeSkins;
		}
		private static function checkMaxMin(value:int,max:int,min:int):int
		{
			if (value > max)
				value = min;
			else if (value < min)
				value = max;
			return value;
		}
		public static function changePaletteTarget(ovRdNum:int):int
		{
			_paletteTarget = incValueFromOvRdNum(ovRdNum,_paletteTarget);
			_paletteTarget = checkMaxMin(_paletteTarget,GameSettingsValues.PALETTE_TARGET_MAX_VALUE,0);
			GraphicsManager.INSTANCE.swapGbPalette(true);
			return _paletteTarget;
		}

		public static function setTitleMapSkin():void
		{
			_mapSkin = TITLE_SKINS[ int(Math.random()*TITLE_SKINS.length) ];
		}

		public static function changeMapSkin(ovRdNum:int, allowRandom:Boolean = true):void
		{
			var lastMapSkin:int = _mapSkin;
			var maxLimited:int = GameSettingsValues.mapSkinLimitedMaxValue;
			var max:int = GameSettingsValues.mapSkinMaxValue;
			var offset:int;
			var increase:Boolean = true;
			if (ovRdNum == DECREASE_SETTING_NUM)
				increase = false;
			if (!allowRandom)
				offset = -1;
			if (ovRdNum == INCREASE_SETTING_NUM)
				_mapSkin = incSkin(_mapSkin, 1, maxLimited, max + offset);
			else if (ovRdNum == DECREASE_SETTING_NUM)
				_mapSkin = incSkin(_mapSkin, -1, maxLimited, max + offset);
			else
				_mapSkin = ovRdNum;
			_mapSkin = checkMaxMin(_mapSkin, max + offset,0);
			if (_mapSkin <= maxLimited)
			{
				if ( lastMapSkin <= maxLimited && !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_MAP[lastMapSkin]) )
					_mapSkin = 0;
				while ( !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_MAP[_mapSkin]) )
				{
					if (increase)
						_mapSkin = incSkin(_mapSkin, 1, maxLimited, max + offset);
					else
						_mapSkin = incSkin(_mapSkin, -1, maxLimited, max + offset);
					_mapSkin = checkMaxMin(_mapSkin, max,0);
					if (_mapSkin > maxLimited)
						break;
				}
			}
			getMapSkinLimited(true);
			grMngr.swapMapGraphics();
		}
		private static function incSkin(curSkin:int,inc:int, maxLimited:int, max:int):int
		{
			var arr:Array = BmdInfo.MAIN_SKIN_ORDER;
			var cInd:int = arr.indexOf(curSkin);
			var nInd:int = cInd + inc;
			if (cInd == -1) // this means it was set on random or use map skin
			{
				cInd = curSkin;
				nInd = cInd + inc;
				if (inc < 0)
				{
					if (nInd <= maxLimited)
						return arr[arr.length - 1];
					else
						return nInd;
				}
			}
			if (nInd >= 0 && nInd < arr.length)
				return arr[nInd];
			else if (nInd < 0)
				return max;
			else if (nInd > max)
				return 0;
			else if (nInd == maxLimited)
			{
				nInd += inc;
				if (nInd >= 0 && nInd < arr.length)
					return arr[nInd];
				else
					return nInd;
			}
			else if (nInd == arr.length && inc > 0) // the last index
				return maxLimited + 1;
			else if (nInd == arr.length && inc < 0)
				return maxLimited;
			return nInd;
		}
		public static function changeEnemySkin(ovRdNum:int):void
		{
			var lastEnemySkin:int = _enemySkin;
			var maxLimited:int = GameSettingsValues.enemySkinLimitedMaxValue;
			var max:int = GameSettingsValues.enemySkinMaxValue;
			var increase:Boolean = true;
			if (ovRdNum == DECREASE_SETTING_NUM)
				increase = false;
			if (ovRdNum == INCREASE_SETTING_NUM)
				_enemySkin = incSkin(_enemySkin, 1, maxLimited, max);
			else if (ovRdNum == DECREASE_SETTING_NUM)
				_enemySkin = incSkin(_enemySkin, -1, maxLimited, max);
			else
				_enemySkin = ovRdNum;
//			_enemySkin = incValueFromOvRdNum(ovRdNum,_enemySkin);
			_enemySkin = checkMaxMin(_enemySkin,max,0);
			if (_enemySkin <= maxLimited)
			{
				if ( lastEnemySkin <= maxLimited && !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_ENEMY[lastEnemySkin]) )
					_enemySkin = 0;
				while ( !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_ENEMY[_enemySkin]) )
				{
					if (increase)
						_enemySkin = incSkin(_enemySkin, 1, maxLimited, max);
					else
						_enemySkin = incSkin(_enemySkin, -1, maxLimited, max);
					_enemySkin = checkMaxMin(_enemySkin, max,0);
					if (_enemySkin > maxLimited)
						break;
				}
			}
			getEnemySkinLimited(true);
			grMngr.swapEnemyGraphics();
		}
		public static function changeInterfaceSkin(ovRdNum:int):void
		{
			var lastInterfaceSkin:int = _interfaceSkin;
			var maxLimited:int = GameSettingsValues.interfaceSkinLimitedMaxValue;
			var max:int = GameSettingsValues.interfaceSkinMaxValue;
			var increase:Boolean = true;
			if (ovRdNum == DECREASE_SETTING_NUM)
				increase = false;
			if (ovRdNum == INCREASE_SETTING_NUM)
				_interfaceSkin = incSkin(_interfaceSkin, 1, maxLimited, max);
			else if (ovRdNum == DECREASE_SETTING_NUM)
				_interfaceSkin = incSkin(_interfaceSkin, -1, maxLimited, max);
			else
				_interfaceSkin = ovRdNum;
			_interfaceSkin = checkMaxMin(_interfaceSkin,max,0);
			if (_interfaceSkin <= maxLimited)
			{
				if ( lastInterfaceSkin <= maxLimited && !grMngr.skinIsActive(grMngr.CLEAN_BMC_VEC_INTERFACE[lastInterfaceSkin]) )
					_interfaceSkin = 0;
				while ( !grMngr.skinIsActive(grMngr.CLEAN_BMC_VEC_INTERFACE[_interfaceSkin]) )
				{
					if (increase)
						_interfaceSkin = incSkin(_interfaceSkin, 1, maxLimited, max);
					else
						_interfaceSkin = incSkin(_interfaceSkin, -1, maxLimited, max);
					_interfaceSkin = checkMaxMin(_interfaceSkin, max,0);
					if (_interfaceSkin > maxLimited)
						break;
				}
			}
			getInterfaceSkinLimited(true);
			grMngr.swapInterface();
		}
		public static function changeMapPalette(ovRdNum:int):void
		{
			_mapSkin = incValueFromOvRdNum(ovRdNum,_mapSkin);
			_mapSkin = checkMaxMin(_mapPalette,GraphicsManager.NUM_GB_PALETTES + 1,0);
			mapPaletteLimited = _mapPalette;
			getMapPaletteLimited(true);
			getCharacterPaletteLimited();
			getEnemyPaletteLimited();
			getInterfacePaletteLimited();
			trace("gb palette: "+_mapPalette);
			GraphicsManager.INSTANCE.swapGbPalette();
		}
		private static function incValueFromOvRdNum(ovRdNum:int,curValue:int):int
		{
			if (ovRdNum == INCREASE_SETTING_NUM)
				curValue++;
			else if (ovRdNum == DECREASE_SETTING_NUM)
				curValue--;
			else
				curValue = ovRdNum;
			return curValue;
		}
		public static function changeCharacterPalette(ovRdNum:int):void
		{
			_characterPalette = incValueFromOvRdNum(ovRdNum,_characterPalette);
			_characterPalette = checkMaxMin(_characterPalette,GameBoyPalettes.VEC.length - 1,0);
			characterPaletteLimited = _characterPalette;
			getCharacterPaletteLimited(true);
			GraphicsManager.INSTANCE.swapGbPalette();
		}
		public static function changeEnemyPalette(ovRdNum:int):void
		{
			_enemyPalette = incValueFromOvRdNum(ovRdNum,_enemyPalette);
			_enemyPalette = checkMaxMin(_enemyPalette,GameBoyPalettes.VEC.length - 1,0);
			enemyPaletteLimited = _enemyPalette;
			getEnemyPaletteLimited(true);
			GraphicsManager.INSTANCE.swapGbPalette();
		}
		public static function changeInterfacePalette(ovRdNum:int):void
		{
			_interfacePalette = incValueFromOvRdNum(ovRdNum,_interfacePalette);
			_interfacePalette = checkMaxMin(_interfacePalette,GameBoyPalettes.VEC.length - 1,0);
			interfacePaletteLimited = _interfacePalette;
			getInterfacePaletteLimited(true);
			GraphicsManager.INSTANCE.swapGbPalette();
		}
		public static function changeMusicSet(ovRdNum:int):String
		{
			_musicSet = incValueFromOvRdNum(ovRdNum,_musicSet);
			_musicSet = checkMaxMin(_musicSet,MusicSets.MAX_VALUE,0);
			return MusicSets.convNumToStr(_musicSet);
		}
		public static function get musicQuality():int
		{
			return _musicQuality;
		}
		public static function get tutorials():Boolean
		{
			return _tutorials;
		}

		public static function get lockFrameRate():Boolean
		{
			return _lockFrameRate;
		}

		public static function get difficulty():int
		{
			return _difficulty;
		}

		public static function get mapDifficulty():int
		{
			return _mapDifficulty;
		}

		public static function get campaignMode():int
		{
			return _campaignMode;
		}


		public static function get muteSfx():Boolean
		{
			return _muteSfx;
		}

		public static function get muteMusic():Boolean
		{
			return _muteMusic;
		}

		public static function get musicSet():int
		{
			return _musicSet;
		}

		public static function get musicType():int
		{
			return _musicType;
		}

		public static function get cheatNotify():Boolean
		{
			return _cheatNotify;
		}

		public static function set cheatNotify(value:Boolean):void
		{
			_cheatNotify = value;
		}

		public static function get enemySkin():int
		{
			return _enemySkin;
		}

		public static function get mapPalette():int
		{
			return 0;
			return _mapPalette;
		}

		public static function get interfaceSkin():int
		{
			return _interfaceSkin;
		}

		public static function get characterPalette():int
		{
			return 0;
			return _characterPalette;
		}

		public static function getMapSkinLimited(regenerate:Boolean = false):int
		{
			if (regenerate && randomMapSkin)
			{
				var n:int = GameSettingsValues.mapSkinLimitedMaxValue + 1;
				do
				{
					mapSkinLimited = Math.random()*n;
				}
					while ( !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_MAP[mapSkinLimited]) || mapSkinLimited == BmdInfo.SKIN_NUM_INVISIBLE );
				_mapSkin = mapSkinLimited;
			}
			if (_mapSkin <= GameSettingsValues.mapSkinLimitedMaxValue)
				mapSkinLimited = _mapSkin;
			return mapSkinLimited;
		}
		public static function getEnemySkinLimited(regenerate:Boolean = false, readOnly:Boolean = false):int
		{
			if (!readOnly)
			{
				if (regenerate && _enemySkin == GraphicsManager.RANDOM_SKIN_NUM)
				{
					var n:int = GameSettingsValues.enemySkinLimitedMaxValue + 1;
					do
					{
						enemySkinLimited = Math.random()*n;
					}
					while ( !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_ENEMY[enemySkinLimited]) || enemySkinLimited == BmdInfo.SKIN_NUM_INVISIBLE );
				}
				else if (_enemySkin == GraphicsManager.USE_MAP_SKIN_NUM)
				{
					enemySkinLimited = getMapSkinLimited();
//					if ( !grMngr.skinIsActive(grMngr.CLEAN_BMD_VEC_ENEMY[enemySkinLimited]) )
//						changeEnemySkin(INCREASE_SETTING_NUM);
				}
			}
			if (_enemySkin <= GameSettingsValues.enemySkinLimitedMaxValue)
				enemySkinLimited = _enemySkin;
			return enemySkinLimited;
		}
		/**Advances all classic weapons by one. */
		public static function NextClassicWeapons():void
		{
			var level:Level = Level.levelInstance;
			var player:Character = level != null ? level.player : null;
			if (level == null || player == null || !player.upgradeIsActive(PickupInfo.FIRE_FLOWER) )
				return;

			var gsOvRdNum:int = GameSettings.INCREASE_SETTING_NUM;
			var charClass:Class;

			if (player is Bass)
			{
				GameSettings.bassWeapon = GameSettings.bassWeapon.GetAtIndex(gsOvRdNum) as MegaManSpecialWeapon;
				charClass = Bass;
			}
			else if (player is Bill)
			{
				GameSettings.billSecondWeapon = GameSettings.billSecondWeapon.GetAtIndex(gsOvRdNum) as BillWeapon;
				charClass = Bill;
			}
			else if (player is Link)
			{
				GameSettings.linkWeapon = GameSettings.linkWeapon.GetAtIndex(gsOvRdNum) as LinkWeapon;
				statMngr.addCharUpgrade(statMngr.curCharNum, PickupInfo.LINK_BOMB);
				statMngr.addCharUpgrade(statMngr.curCharNum, PickupInfo.LINK_BOW);
				charClass = Link;
			}
			else if (player is MegaMan)
			{
				GameSettings.megaManWeapon = GameSettings.megaManWeapon.GetAtIndex(gsOvRdNum) as MegaManSpecialWeapon;
				charClass = MegaMan;
			}
			else if (player is Ryu)
			{
				GameSettings.ryuStartWeapon = GameSettings.ryuStartWeapon.GetAtIndex(gsOvRdNum) as RyuSpecialWeapon;
				charClass = Ryu;
			}
			else if (player is Samus)
			{
				GameSettings.samusWeapon = GameSettings.samusWeapon.GetAtIndex(gsOvRdNum) as SamusWeapon;
				charClass = Samus;
			}
			else if (player is Simon)
			{
				GameSettings.simonStartWeapon = GameSettings.simonStartWeapon.GetAtIndex(gsOvRdNum) as SimonSpecialWeapon;
				charClass = Simon;
			}
			else if (player is Sophia)
			{
				GameSettings.sophiaWeapon = GameSettings.sophiaWeapon.GetAtIndex(gsOvRdNum) as SophiaWeapon;
				charClass = Sophia;
			}
			else
				return;

			if (gsMngr.gameState == GameStates.PLAY && !player.disableInput)
			{
				Character.hitRandomUpgrade(statMngr.curCharNum, false);
				level.changeChar(charClass);
				Level.levelInstance.player.setPowerState(1);
			}

		}
		public static function getInterfaceSkinLimited(regenerate:Boolean = false, readOnly:Boolean = false):int
		{
//			trace("interface start: "+_interfaceSkin);
			if (!readOnly)
			{
				if (regenerate && _interfaceSkin == GraphicsManager.RANDOM_SKIN_NUM)
				{
					var n:int = GameSettingsValues.interfaceSkinLimitedMaxValue + 1;
					do
					{
						interfaceSkinLimited = Math.random()*n;
					}
					while ( !grMngr.skinIsActive(grMngr.CLEAN_BMC_VEC_INTERFACE[interfaceSkinLimited]) || interfaceSkinLimited == BmdInfo.SKIN_NUM_INVISIBLE );
				}
				else if (_interfaceSkin == GraphicsManager.USE_MAP_SKIN_NUM)
				{
					interfaceSkinLimited = getMapSkinLimited();
//					if ( !grMngr.skinIsActive(grMngr.CLEAN_BMC_VEC_INTERFACE[interfaceSkinLimited]) )
//						changeInterfaceSkin(INCREASE_SETTING_NUM);
				}
			}
			if (_interfaceSkin <= GameSettingsValues.interfaceSkinLimitedMaxValue)
				interfaceSkinLimited = _interfaceSkin;
//			trace("interface end: "+_interfaceSkin);
			return interfaceSkinLimited;
		}
		public static function getMapPaletteLimited(regenerate:Boolean = false):int
		{
			return 0;
			if (regenerate && _mapPalette == GameBoyPalettes.OBJ[MenuBoxValues.RANDOM])
				mapPaletteLimited = Math.random()*GraphicsManager.NUM_GB_PALETTES;
			return mapPaletteLimited;
		}
		public static function getCharacterPaletteLimited(regenerate:Boolean = false,readOnly:Boolean = false):int
		{
			return 0;
			if (!readOnly)
			{
				if (regenerate && _characterPalette == GameBoyPalettes.OBJ[MenuBoxValues.RANDOM])
					characterPaletteLimited = Math.random()*GraphicsManager.NUM_GB_PALETTES;
				else if (_characterPalette == GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE])
					characterPaletteLimited = getMapPaletteLimited();
			}
			return characterPaletteLimited;
		}
		public static function getEnemyPaletteLimited(regenerate:Boolean = false,readOnly:Boolean = false):int
		{
			return 0;
			if (!readOnly)
			{
				if (regenerate && _enemyPalette == GameBoyPalettes.OBJ[MenuBoxValues.RANDOM])
					enemyPaletteLimited = Math.random()*GraphicsManager.NUM_GB_PALETTES;
				else if (_enemyPalette == GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE])
					enemyPaletteLimited = getMapPaletteLimited();
			}
			return enemyPaletteLimited;
		}
		public static function getInterfacePaletteLimited(regenerate:Boolean = false,readOnly:Boolean = false):int
		{
			return 0;
			if (!readOnly)
			{
				if (regenerate && _interfacePalette == GameBoyPalettes.OBJ[MenuBoxValues.RANDOM])
					interfacePaletteLimited = Math.random()*GraphicsManager.NUM_GB_PALETTES;
				else if (_interfacePalette == GameBoyPalettes.OBJ[MenuBoxValues.MAP_PALETTE])
					interfacePaletteLimited = getMapPaletteLimited();
			}
			return interfacePaletteLimited;
		}
		public static function getMusicConsole():int
		{
			if (_musicType == ConsoleType.CHARACTER)
				return statMngr.getCurrentBmc(statMngr.curCharNum).consoleType;
			else if (_musicType == ConsoleType.MAP)
				return grMngr.drawingBoardMapSkinCont.consoleType;
			else if (_musicType == ConsoleType.RANDOM)
				return int( Math.random()*(ConsoleType.MAX_CONSOLE_VALUE + 1) );
			else
				return _musicType;
		}
		public static function getMusicSet():int
		{
			if (_musicSet == MusicSets.RANDOM)
				return int( Math.random()*(MusicSets.MAX_NORMAL + 1) );
			else
				return _musicSet;
		}

		public static function get enemyPalette():int
		{
			return 0;
			return _enemyPalette;
		}

		public static function get interfacePalette():int
		{
			return 0;
			return _interfacePalette;
		}

		public static function get gameBoyFilter():Boolean
		{
			return _gameBoyFilter;
		}

		public static function get classicMode():Boolean
		{
			return powerupMode == PowerupMode.Classic;
		}


	}
}

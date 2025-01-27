package com.smbc.graphics
{
	import com.customClasses.MCAnimator;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.Cheats;
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.MusicType;
	import com.smbc.data.PickupInfo;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.Level;
	import com.smbc.level.LevelData;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.*;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.LevelDataManager;
	import com.smbc.managers.StatManager;
	import com.smbc.managers.TextManager;
	import com.smbc.pickups.Upgrade;
	import com.smbc.pickups.VicViperPickup;
	import com.smbc.text.TextFieldContainer;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;

	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="TopScreenText")]
	public class TopScreenText extends Sprite
	{
		//		stage vars begin
		public var level:Level = GlobVars.level;
		private static var _instance:TopScreenText;
		public static const HUD_X_OFS:int = 22; // 22
		private static const HUD_Y_OFS:int = -12; // -12
		public static const FIRST_ROW_Y:int = 26 + HUD_Y_OFS;
		public static const SECOND_ROW_Y:int = 42 + HUD_Y_OFS;
		public static const THIRD_ROW_Y:int = SECOND_ROW_Y + 18;
		private static const SPACE_BTW_ICONS:int = 16;
		private static const NAME_TXT_PNT:Point = new Point(45 + HUD_X_OFS,FIRST_ROW_Y);  // (45,26);
		private static const COIN_TXT_PNT:Point = new Point(206 + HUD_X_OFS,SECOND_ROW_Y);  // (206,42)
		private static const LIVES_TXT_PNT:Point = new Point(206 + HUD_X_OFS,FIRST_ROW_Y);  // (206,42)
		private static const WORLD_NAME_TXT_PNT:Point = new Point(285 + HUD_X_OFS,FIRST_ROW_Y);  // (285,26)
		private static const TIME_NAME_TXT_PNT:Point = new Point(398 + HUD_X_OFS,FIRST_ROW_Y);  // (398,26)
		private static const COIN_SYMBOL_PNT:Point = new Point(COIN_TXT_PNT.x - 6,COIN_TXT_PNT.y + 10);  // (185,50)
		private static const P_STATE_ICON_PNT:Point = new Point(160 + HUD_X_OFS,SECOND_ROW_Y + 2);  // (185,50)
		private static const STAR_ICON_PNT:Point = new Point(P_STATE_ICON_PNT.x + SPACE_BTW_ICONS,SECOND_ROW_Y + 2);  // (185,50)
		public static const UPG_ICONS_START_PNT:Point = new Point(48 + HUD_X_OFS,THIRD_ROW_Y);
		private static const SCORE_TXT_PNT:Point = new Point(NAME_TXT_PNT.x,SECOND_ROW_Y); // (45,42);
		private static const WORLD_NUM_TXT_PNT:Point = new Point(WORLD_NAME_TXT_PNT.x + 16,SECOND_ROW_Y);  // (301,42)
		private static const TIME_NUM_TXT_PNT:Point = new Point(TIME_NAME_TXT_PNT.x + 12,SECOND_ROW_Y);  // (414,42)
		private static const AMMO_TXT_PNT:Point = new Point(20,66); // 20, 66
		private static const AMMO_ICON_PNT:Point = new Point(6,70);
		public static const AMMO_ICON_X_ALIGNED:int = 10;
		private static const PORT_PNT:Point = new Point(-10 + HUD_X_OFS, FIRST_ROW_Y);
		private const LIVES_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var scoreDispTxt:TextField;
		private const SCORE_DISP_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var nameDispTxt:TextField;
		private const NAME_DISP_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var worldDispTxt:TextField;
		private const WORLD_DISP_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var worldNameTxt:TextField;
		private const WORLD_NAME_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var timeDispTxt:TextField;
		private const TIME_DISP_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var timeNameTxt:TextField;
		private const TIME_NAME_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		public var coinDispTxt:TextField;
		private const COIN_DISP_TFC:TextFieldContainer = new TextFieldContainer(FontCharHud.FONT_NUM);
		private static var ammoTfc:TextFieldContainer;
		private var ammoIcon:CustomMovieClip;
		public var tsTxtBg:Sprite;
		public var coinSymbol:CoinSymbol;
		private var mushroomIcon:UpgradeIcon = new UpgradeIcon(PickupInfo.MUSHROOM);
		private var starIcon:UpgradeIcon = new UpgradeIcon(PickupInfo.STAR);
		private var iconVec:Vector.<UpgradeIcon> = new Vector.<UpgradeIcon>();
		public static const COIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private var portrait:CustomMovieClip;
		private var portraitFrame:CustomMovieClip;

		//		stage vars end
		private var coinType:String;
		private var stopAnim:Boolean;
		private const ANIMATOR:MCAnimator = GlobVars.ANIMATOR;
		private const STAT_MNGR:StatManager = StatManager.STAT_MNGR;
		private const GS_MNGR:GameStateManager = GameStateManager.GS_MNGR;
		private const TXT_MNGR:TextManager = TextManager.INSTANCE;

		public function TopScreenText()
		{
			super();
//			addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler,false,0,true);
			if (_instance)
				throw new SingletonError();
			coinSymbol = CoinSymbol.getInstance();
			coinSymbol.x = COIN_SYMBOL_PNT.x;
			coinSymbol.y = COIN_SYMBOL_PNT.y;
			addChild(coinSymbol);
			replaceStageTextFields();
			updNameDispTxt();
			updWorldDispTxt();
			setUpCoinType();
			updLivesDispTxt(STAT_MNGR.numLives);
			var thing:CustomMovieClip = new CustomMovieClip(null,null,"Mushroom");
			thing.x = 240;
			thing.y = 60;
//			addChild(thing);
			//			removes black background
			removeChild(tsTxtBg);
			tsTxtBg = null;
		}

/*		protected function addedToStageHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			if (level)
				trace("break");
		}*/
		private function replaceStageTextFields():void
		{
			TXT_MNGR.replaceStageTextField(scoreDispTxt,SCORE_DISP_TFC,this);
			scoreDispTxt = null;
			TXT_MNGR.replaceStageTextField(nameDispTxt,NAME_DISP_TFC,this);
			nameDispTxt = null;
			TXT_MNGR.replaceStageTextField(worldDispTxt,WORLD_DISP_TFC,this);
			worldDispTxt = null;
			TXT_MNGR.replaceStageTextField(worldNameTxt,WORLD_NAME_TFC,this);
			worldNameTxt = null;
			TXT_MNGR.replaceStageTextField(timeDispTxt,TIME_DISP_TFC,this);
			timeDispTxt = null;
			TXT_MNGR.replaceStageTextField(timeNameTxt,TIME_NAME_TFC,this);
			timeNameTxt = null;
			TXT_MNGR.replaceStageTextField(coinDispTxt,COIN_DISP_TFC,this);
			coinDispTxt = null;

			SCORE_DISP_TFC.x = SCORE_TXT_PNT.x;
			SCORE_DISP_TFC.y = SCORE_TXT_PNT.y;
			NAME_DISP_TFC.x = NAME_TXT_PNT.x;
			NAME_DISP_TFC.y = NAME_TXT_PNT.y;
			WORLD_DISP_TFC.x = WORLD_NUM_TXT_PNT.x;
			WORLD_DISP_TFC.y = WORLD_NUM_TXT_PNT.y;
			WORLD_NAME_TFC.x = WORLD_NAME_TXT_PNT.x;
			WORLD_NAME_TFC.y = WORLD_NAME_TXT_PNT.y;
			TIME_DISP_TFC.x = TIME_NUM_TXT_PNT.x;
			TIME_DISP_TFC.y = TIME_NUM_TXT_PNT.y;
			TIME_NAME_TFC.x = TIME_NAME_TXT_PNT.x;
			TIME_NAME_TFC.y = TIME_NAME_TXT_PNT.y;
			COIN_DISP_TFC.x = COIN_TXT_PNT.x;
			COIN_DISP_TFC.y = COIN_TXT_PNT.y;
//			LIVES_TFC.x = LIVES_TXT_PNT.x;
//			LIVES_TFC.y = LIVES_TXT_PNT.y;
//			addChild(LIVES_TFC);
			if (!ammoTfc)
			{
				ammoTfc = new TextFieldContainer( FontCharHud.FONT_NUM );
				ammoTfc.x = AMMO_TXT_PNT.x;
				ammoTfc.y = AMMO_TXT_PNT.y;
			}
			HudAlwaysOnTop.INSTANCE.addChild( ammoTfc );
//			addChild(ammoTfc);
			mushroomIcon.x = P_STATE_ICON_PNT.x;
			mushroomIcon.y = P_STATE_ICON_PNT.y;
			starIcon.x = STAR_ICON_PNT.x;
			starIcon.y = STAR_ICON_PNT.y;
			addChild(mushroomIcon);
//			addChild(starIcon);  wasn't enough room after increasing max value of the score
			mushroomIcon.update();
			starIcon.update();
//			WORLD_NAME_TFC.visible = false;

		}
		public function updNameDispTxt():void
		{
			var num:int = STAT_MNGR.curCharNum;
			var name:String = CharacterInfo.CHAR_ARR[num][CharacterInfo.IND_CHAR_NAME_MENUS];
			var skinName:String = STAT_MNGR.getSkinName();
			if (skinName)
				name = skinName;
			NAME_DISP_TFC.text = name;
			if (portrait)
			{
				removeChild(portrait);
				portrait = null;
			}
			portrait = new CustomMovieClip(null,null,CharacterInfo.getCharClassName(num) + "Icon");
			portrait.x = PORT_PNT.x;
			portrait.y = PORT_PNT.y;
			if (!portraitFrame)
			{
				portraitFrame = new CustomMovieClip(null,null,PortraitSelector.CLASS_NAME);
				portraitFrame.gotoAndStop(PortraitSelector.FL_HUD_FRAME);
				portraitFrame.x = portrait.x - 2;
				portraitFrame.y = portrait.y - 2;
				addChild(portraitFrame);
			}
			addChild(portrait);
			if (GameSettings.hideNewStuff)
			{
				portrait.visible = false;
				portraitFrame.visible = false;
			}
		}
		public function updWorldDispTxt():void
		{
			WORLD_DISP_TFC.text = STAT_MNGR.currentLevelID.nameWithoutAreaDisplay;
		}
		public function updCoinDispTxt(numCoins:String):void
		{
			if (numCoins.length == 1) numCoins = "0"+numCoins;
			COIN_DISP_TFC.text = "*"+numCoins;
		}
		public function updLivesDispTxt(numLives:int):void
		{
			var str:String = numLives.toString();
			if (str.length == 1)
				str = "0"+str;
			LIVES_TFC.text = "*"+str;
		}
		public function updTimeDispTxt(_timeLeft:String):void
		{
			var len:int = _timeLeft.length;
			if (len == 2)
				_timeLeft = "0"+_timeLeft;
			else if (len == 1)
				_timeLeft = "00"+_timeLeft;
			TIME_DISP_TFC.text = _timeLeft;
		}
		public function updScoreDisp(newScore:String):void
		{
			var len:int = newScore.length;
			if (len == 6)
				newScore = "0"+newScore;
			else if (len == 5)
				newScore = "00"+newScore;
			else if (len == 4)
				newScore = "000"+newScore;
			else if (len == 3)
				newScore = "0000"+newScore;
			else if (len == 2)
				newScore = "00000"+newScore;
			else if (len == 1)
				newScore = "000000"+newScore;
			SCORE_DISP_TFC.text = newScore;
		}
		public function updateUpgIcons():void
		{
			if (GameSettings.hideNewStuff)
				return;
			mushroomIcon.update();
//			starIcon.update();
			while (iconVec.length)
			{
				iconVec[0].destroy();
				iconVec.shift();
			}
			if (GameSettings.classicMode)
				return;

			var charNum:int = STAT_MNGR.curCharNum;
//			if (charNum == VicViper.CHAR_NUM)
//			{
//				VicViperIcon.setUpIcons();
//				return;
//			}
			var iconOrderVec:Vector.<String> = STAT_MNGR.getIconOrderVec(charNum);
			var obtainedItemsDct:CustomDictionary = STAT_MNGR.getObtainedUpgradesDct(charNum);
			var forceName:String = CharacterInfo.getCharClassName(charNum) + "Icon";
			var n:int = iconOrderVec.length;
//			if (!obtainedItemsDct[PickupInfo.MUSHROOM] && charNum != Bill.CHAR_NUM && charNum != MegaMan.CHAR_NUM && GameSettings.difficulty != Difficulties.VERY_EASY) // icons will not show up if character doesn't have mushroom
//				return;
			for (var i:int = 0; i < n; i++)
			{
				var upgradeName:String = iconOrderVec[i];
				if ( obtainedItemsDct[upgradeName] )
				{
					var icon:UpgradeIcon = new UpgradeIcon(upgradeName,forceName);
					iconVec.push( icon );
					icon.x = UPG_ICONS_START_PNT.x + SPACE_BTW_ICONS*(iconVec.length - 1);
					icon.y = UPG_ICONS_START_PNT.y;
					addChild(icon);
				}
			}
//			trace("obtainedItemsDct: "+obtainedItemsDct);
		}
		public function refreshAmmoIcon():void
		{
			if (ammoIcon)
				ammoIcon.gotoAndStop(ammoIcon.currentFrame);
		}
		public function UpdAmmoIcon(show:Boolean, fLab:String = null, xPos:Number = NaN):void
		{
			if (Level.levelInstance is TitleLevel) // hides on title screen
				show = false;
			if (ammoIcon)
			{
				if (ammoIcon.parent)
					ammoIcon.parent.removeChild(ammoIcon);
				ammoIcon = null;
			}
			if (!show)
				return;
			var iconClassName:String = CharacterInfo.getCharClassName( STAT_MNGR.curCharNum ) + "Icon";
			ammoIcon = new CustomMovieClip(null,null,iconClassName);
			ammoIcon.gotoAndStop(fLab);
			if (isNaN(xPos))
				ammoIcon.x = AMMO_ICON_PNT.x;
			else
				ammoIcon.x = xPos;
			ammoIcon.y = AMMO_ICON_PNT.y;
//			addChild(ammoIcon);
			HudAlwaysOnTop.INSTANCE.addChild(ammoIcon);
		}
		public function UpdAmmoText(show:Boolean, value:int = -1):void
		{
			if (Level.levelInstance is TitleLevel) // hides on title screen
				show = false;
			if (!show)
			{
				ammoTfc.visible = false;
				return;
			}
			ammoTfc.visible = true;
			var str:String = value.toString();
			if (value < 10)
				str = "0"+str;
			ammoTfc.text = "*"+str;
		}
		public function initiateLevelHandler():void
		{
			level = Level.levelInstance;
			coinSymbol.initiateLevelHandler();
			updWorldDispTxt();
			updateUpgIcons();
			if (!Cheats.infiniteTime && !(level is CharacterSelect) && !(level is TitleLevel) )
				showTime();
			else
				hideTime();
			if (level is TitleLevel)
				visible = false;
			else
				visible = true;
		}
		public function initiateBlackScreen():void
		{
//			level = Level.levelInstance;
			updWorldDispTxt();
			x = 0;
			updTimeDispTxt( LevelDataManager.currentLevelData.gettimeLeftTot(STAT_MNGR.currentLevelID).toString() );
//			updateUpgIcons();
			if (!Cheats.infiniteTime && !(level is CharacterSelect) && !(level is TitleLevel) )
				showTime();
			else
				hideTime();
		}
		public function setUpCoinType():void
		{
			if (GS_MNGR.gameState == GameStates.BLACK_SCREEN)
			{
				stopAnim = true;
				hideTime();
				updCoinDispTxt(STAT_MNGR.numCoinsStr);
				updScoreDisp(STAT_MNGR.score.toString());
			}
			else if (GS_MNGR.gameState == GameStates.CHARACTER_SELECT)
			{
				stopAnim = false;
				hideTime();
				if (contains(TIME_NAME_TFC))
					removeChild(TIME_NAME_TFC);
				updCoinDispTxt(STAT_MNGR.numCoinsStr);
				updScoreDisp(STAT_MNGR.score.toString());
			}
			else
			{
				stopAnim = false;
			}
			if (Cheats.infiniteTime)
				hideTime();
			coinSymbol.gotoAndStop("coin"+coinType+"Start");
		}
		public function animateCoin():void
		{
//			trace("stopAnim: "+stopAnim);
//			if (!stopAnim)
//			{
				coinSymbol.animate(COIN_ANIM_TMR);
				coinSymbol.checkFrame();
//			}
		}
		public function hideTime():void
		{
			if (contains(TIME_DISP_TFC))
				removeChild(TIME_DISP_TFC);
		}
		public function showTime():void
		{
			if (Cheats.infiniteTime || Level.levelInstance is TitleLevel)
				return;
			if (!contains(TIME_DISP_TFC))
				addChild(TIME_DISP_TFC);
		}
		public function hideName():void
		{
			if (contains(NAME_DISP_TFC)) removeChild(NAME_DISP_TFC);
		}
		public function scroll():void
		{
			x = -level.x;
//			trace("tsTxt: "+x+" level: "+level.x);
				//				bg.y = level.y*ss;
		}
		public function get timeRemaining():String
		{
			return TIME_DISP_TFC.text;
		}

		public static function get instance():TopScreenText
		{
			if (!_instance)
				_instance = new TopScreenText();
			return _instance;
		}


	}
}

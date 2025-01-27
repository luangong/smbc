package com.smbc.managers
{
	import com.customClasses.TDCalculator;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.BrowserUtils;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Link;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.data.CampaignModes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.LevelID;
	import com.smbc.data.MusicType;
	import com.smbc.data.OnlineData;
	import com.smbc.data.SoundNames;
	import com.smbc.errors.*;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.graphics.ExplodingRabbitLogo;
	import com.smbc.graphics.StageMask;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.*;
	import com.smbc.main.GlobVars;
	import com.smbc.messageBoxes.DisclaimerMessageBox;
	import com.smbc.messageBoxes.MessageBox;
	import com.smbc.messageBoxes.NotConnectedMessageBox;
	import com.smbc.messageBoxes.PlainMessageBox;
	import com.smbc.screens.InformativeBlackScreen;
	import com.smbc.sound.MusicInfo;
	import com.smbc.text.GameTextMessages;
	import com.smbc.text.TextFieldContainer;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.FullScreenEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.getTimer;

	public final class ScreenManager extends MainManager
	{
		public static const SCRN_MNGR:ScreenManager = new ScreenManager();
		private static var instantiated:Boolean;
		private var newAreaStatsArr:Array = [];
		private var addTxtTmr:CustomTimer;
		private const ADD_TXT_TMR_DUR:int = 1500;
		private var thankTxt:TextFieldContainer;
		private const THANK_TXT_Y:int = 150;
		private var creditsTxt:TextFieldContainer;
		private var creditsTailTxt:TextFieldContainer;
		private var castleTxt:TextFieldContainer;
		private const CASTLE_TXT_Y:int = 220;
		private const CASTLE_TXT_QUEST_IS_OVER_Y:int = 200;
		private const CASTLE_TXT_WIDTH:int = 360;
		private const CASTLE_TXT_QUEST_IS_OVER_WIDTH:int = 300;
		private const CASTLE_TXT_LEADING:int = 12;
		private const CREDITS_TXT_WIDTH:int = 450;
		private var restartGameTmr:CustomTimer;
		private const RESTART_GAME_TMR_DUR:int = 6500;
		private var startMoveCreditsTmr:CustomTimer;
		private const START_MOVE_CREDITS_TMR_DUR:int = 2500;
		private const STAGE_HEIGHT:int = GlobVars.STAGE_HEIGHT;
		private var moveCreditsLoopTmr:CustomTimer;
		private const MOVE_CREDITS_LOOP_TMR_INT:Number = Level.LOOP_TMR_INT;
		private const CREDITS_SPEED:int = 40;
		private const CREDITS_SPEED_FAST:int = CREDITS_SPEED*10;
		private var speedUpCredits:Boolean;
		private const CREDITS_VISIBLE_END_Y:int = GlobVars.TILE_SIZE*2;
		private const CREDITS_VISIBLE_START_Y:int = STAGE_HEIGHT - GlobVars.TILE_SIZE*2;
		private const DT_MAX:Number = .045;
		private var dt:Number = DT_MAX;
		private const TD_CALC:TDCalculator = GlobVars.TD_CALC;
		private const GLOB_STG_TOP:int = GlobVars.STAGE_TOP;
		private var erLogo:ExplodingRabbitLogo;
//		private const LOGO_TMR_INT:int = 15; //4500
//		private const LOGO_DUR:int = 4500/LOGO_TMR_INT;
		private static const LOGO_TIME_BETWEEN_TRANSITIONS:int = 2500;
		private const LOGO_NUM_FADE_INTS:int = 1000/15;
		private const LOGO_SCALE_INC:Number = MessageBox.SCALE_INC;
		private var logoTmr:CustomTimer = new CustomTimer(15,4500/15);
		public var forceShowCharacterSelectScreen:Boolean;
		private var logoCanChangeSize:Boolean;
		private var logoFullStartTime:int;
		public var creditsAreRolling:Boolean;

		private var blackRect:Sprite;

		private var blackRectBg:Sprite;


		public function ScreenManager()
		{
			if (instantiated)
				throw new SingletonError();
			instantiated = true;
		}

		override public function initiate():void
		{
			super.initiate();
			GameSettings.changeLockFrameRate( int(GameSettings.lockFrameRate) );
			var debug:Boolean = GameSettings.DEBUG_MODE;
			if (!debug || !GameSettings.SKIP_FAKE_LEVEL)
				game.addChild( new FakeLevel() );

			if (debug && GameSettings.skipTitleScreen)
				eventMngr.startNewGame();
			else if (!debug || !GameSettings.skipLogos)
				showOpeningLogos();
			else // normally called from DisclaimerMessageBox
				restartGame();
//			var infoStr:String = CustomMovieClip.skinInfoStr;
//			infoStr = infoStr.substr(0,infoStr.length - 1);
//			var cmcStr:String = CustomMovieClip.cmcInfoStr;
//			cmcStr = cmcStr.substr(0,cmcStr.length - 1);
//			trace(infoStr  + cmcStr + "\n]\n}");
			var poop:String;
//			GlobVars.STAGE.addEventListener(FullScreenEvent.FULL_SCREEN,fullScreenEventHandler,false,0,true);
			GlobVars.STAGE.fullScreenSourceRect = new Rectangle(0,0,512,480);
//			toggleFullScreen();
		}

		public function enterFullScreen():Boolean
		{
//			var userAgent:String = BrowserUtils.userAgent;
//			var os:String = Capabilities.os;
//			trace("userAgent: "+userAgent);
//			if (userAgent != null && userAgent.indexOf("Chrome") != -1 && (os.indexOf("Windows") != -1 || os.indexOf("Linux") != -1) )
//				return false;

			var stage:Stage = GlobVars.STAGE;
			try
			{
				if (!fullScreenIsEnabled && OnlineData.onOfficialWebsite)
					stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			catch (error:Error)
			{
				trace(error);
			}
			return fullScreenIsEnabled;
		}

		public function get fullScreenIsEnabled():Boolean
		{
			var stage:Stage = GlobVars.STAGE;
			return stage.displayState == StageDisplayState.FULL_SCREEN || stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}

		protected function fullScreenEventHandler(event:FullScreenEvent):void
		{
			var stage:Stage = GlobVars.STAGE;
			if (event.fullScreen)
			{
				trace("enter fullscreen");
			}
			else
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
				trace("exit fullscreen");
			}
		}
		private function showOpeningLogos():void
		{
			if (!OnlineData.loaded && !GameSettings.DEBUG_MODE)
			{
				new NotConnectedMessageBox().initiate();
				return;
			}
			gsMngr.lockGameState = false;
			gsMngr.gameState = GameStates.LOGOS;
			erLogo = new ExplodingRabbitLogo();
			game.addChild(erLogo);
			erLogo.scaleX = 0;
			erLogo.scaleY = 0;
			erLogo.x = GlobVars.STAGE_WIDTH/2 + 20;
			erLogo.y = GlobVars.STAGE_HEIGHT/2;
			logoTmr.addEventListener(TimerEvent.TIMER,logoTmrHandler,false,0,true);
			logoTmr.start();
			logoCanChangeSize = true;
			game.graphics.beginFill(0xff000000);
			game.graphics.drawRect(0,0,GlobVars.STAGE_WIDTH,GlobVars.STAGE_HEIGHT);
			game.graphics.endFill();
		}
		private function logoTmrHandler(event:TimerEvent):void
		{
			if (logoCanChangeSize && logoTmr.currentCount < LOGO_NUM_FADE_INTS) // fading in
			{
				erLogo.scaleX += LOGO_SCALE_INC*dt;
				erLogo.scaleY = erLogo.scaleX;
				if (erLogo.scaleX > 1)
				{
					logoCanChangeSize = false;
					logoTmr.pause();
					erLogo.scaleX = 1;
					erLogo.scaleY = 1;
					game.stage.addEventListener(Event.RENDER, renderHandler, false, 0, true);
					game.stage.invalidate();
				}
			}
//			else if ((!logoCanChangeSize && getTimer() - logoFullStartTime >= LOGO_TIME_BETWEEN_TRANSITIONS) || logoTmr.currentCount > logoTmr.repeatCount - LOGO_NUM_FADE_INTS) // fading out
//			{
//				erLogo.scaleX -= LOGO_SCALE_INC*dt;
//				erLogo.scaleY = erLogo.scaleX;
//				if (erLogo.scaleX <= 0)
//				{
//					logoTmr.stop();
//					logoTmr.removeEventListener(TimerEvent.TIMER,logoTmrHandler);
//					game.removeChild(erLogo);
//					var disclaimer:DisclaimerMessageBox = new DisclaimerMessageBox();
////					titleBox = new MessageBoxTitleContainer();
////					disclaimer.nextMsgBxToCreate = titleBox;
////					titleBox.visible = false;
//					disclaimer.initiate();
//				}
//			}
		}

		public function openingLogosEnd():void
		{
			if (logoTmr != null)
			{
				logoTmr.stop();
				logoTmr.removeEventListener(TimerEvent.TIMER, logoTmrHandler);
			}
			erLogo.parent.removeChild(erLogo);
			erLogo = null;
			GameSettings.setTitleMapSkin();
			ScreenManager.SCRN_MNGR.restartGame();
		}

		protected function renderHandler(event:Event):void
		{
			game.stage.removeEventListener(Event.RENDER, renderHandler);
			game.stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
		}

		protected function enterFrameHandler(event:Event):void
		{
			game.stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			logoFullStartTime = getTimer();
			sndMngr.recordSoundsPhase1();
		}
		public function logoCanExit():void
		{
			logoTmr.resume();
		}
		public function restartGame():void
		{
//			if (!OnlineData.loaded && !GameSettings.DEBUG_MODE)
//			{
//				new NotConnectedMessageBox().initiate();
//				return;
//			}
			TitleLevel.allowRestart = true;
			var titleLevel:TitleLevel = new TitleLevel();
			if (blackRect && blackRect.parent)
				blackRect.parent.removeChild(blackRect);
			if (blackRectBg && blackRectBg.parent)
				blackRectBg.parent.removeChild(blackRectBg);
			game.addChild(titleLevel);
		}
		public function startNewGameHandler():void
		{
//			if (TitleScreen.instance)
//				TitleScreen.instance.cleanUp();
			var titleLevel:TitleLevel = TitleLevel.instance;
			if (titleLevel)
				titleLevel.destroyLevel();
			game.addChild( new FakeLevel(FakeLevel.DEFAULT_CHANGE_TO_SKIN_NUM, true) ); // fixes start with mushroom palette bug
			createLevel(statMngr.currentLevelID);
		}
		public function createLevel(levelID:LevelID):void
		{
			//trace("create level: "+levStr+" statMngr.curLev: "+statMngr.curLev);
			statMngr.currentLevelID = levelID;
			gsMngr.lockGameState = false;
			if (statMngr.newLev)
			{
				var campMode:int = GameSettings.campaignMode;
				if ( (campMode != CampaignModes.SINGLE_CHARACTER && campMode != CampaignModes.SINGLE_CHARACTER_RANDOM) || forceShowCharacterSelectScreen)
				{
					forceShowCharacterSelectScreen = false;
					//var charSelScr:CharacterSelectScreen = new CharacterSelectScreen(statMngr.allowCharacterRevival);
					var charSelScr:CharacterSelect = new CharacterSelect(statMngr.allowCharacterRevival);
					game.addChild(charSelScr);
					//charSelScr.initiate();
				}
				else
				{
					if (campMode == CampaignModes.SINGLE_CHARACTER_RANDOM)
					{
						statMngr.setRandomCharNum();
						game.addChild(new FakeLevel(GraphicsManager.CHAR_SKIN_NUM_RANDOM));
					}
					eventMngr.selectedCharacter(statMngr.curCharNum); // skips character select screen
				}
			}
			else
				initiateLevel();
		}
		public function selectedCharacterHandler():void
		{
			gsMngr.gameState = GameStates.BLACK_SCREEN;
			var infBlkScrn:InformativeBlackScreen = new InformativeBlackScreen(InformativeBlackScreen.SCREEN_TYPE_PRE_LEVEL);
			infBlkScrn.initiate();
		}
		public function preLevelScreenFinished():void
		{
			gsMngr.gameState = "buildLevel";
			initiateLevel();
		}
		public function gameOver():void
		{
			level.destroyLevel();
			if (gsMngr.lockGameState)
				gsMngr.lockGameState = false;
			gsMngr.gameState = GameStates.BLACK_SCREEN;
			var infBlkScrn:InformativeBlackScreen = new InformativeBlackScreen(InformativeBlackScreen.SCREEN_TYPE_GAME_OVER);
			infBlkScrn.initiate();
		}
		public function showTimeUpScreen():void
		{
			level.pauseMainTmrs();
			var infBlkScrn:InformativeBlackScreen = new InformativeBlackScreen(InformativeBlackScreen.SCREEN_TYPE_TIME_UP);
			infBlkScrn.initiate();
		}
		public function timeUpScreenFinished():void
		{
			eventMngr.checkGameOver();
		}
		public function displayThankYouText():void
		{
			var nameTxt:String = player.charNameTxt;
			var skinName:String = statMngr.getSkinName();
			var skinNum:int = statMngr.getCharSkinNum( statMngr.curCharNum );
			if (skinName)
				nameTxt = skinName;
			if (player is Sophia)
			{
				if ( skinNum == Sophia.SKIN_SOPHIA_III_NES || skinNum == Sophia.SKIN_SOPHIA_III_SNES || skinNum == Sophia.SKIN_SOPHIA_III_GB || skinNum == Sophia.SKIN_SOPHIA_III_16B )
					nameTxt = "Jason";
				else if ( skinNum == Sophia.SKIN_SOPHIA_J7_NES || skinNum == Sophia.SKIN_SOPHIA_J7_SNES || skinNum == Sophia.SKIN_SOPHIA_J7_GB )
					nameTxt = "Roddy";
				else if ( skinNum == Sophia.SKIN_TETRIMINO_NES || skinNum == Sophia.SKIN_TETRIMINO_SNES )
					nameTxt = "Mino";
			}
			var txt:String = GameTextMessages.THANK_YOU.replace(GameTextMessages.THANK_YOU_REPLACE_STR,nameTxt);
			thankTxt = new TextFieldContainer(FontCharHud.FONT_NUM);
//			thankTxt.defaultTextFormat = GlobVars.TF_MAIN;
//			thankTxt.autoSize = TextFieldAutoSize.LEFT;
//			thankTxt.embedFonts = true;
			thankTxt.text = txt;
			thankTxt.x = GlobVars.STAGE_WIDTH/2 - thankTxt.width/2;
			thankTxt.y = THANK_TXT_Y;
//			thankTxt.selectable = false;
			game.addChildAt(thankTxt,game.getChildIndex(level));
			addTxtTmr = new CustomTimer(ADD_TXT_TMR_DUR,1);
			addTxtTmr.addEventListener(TimerEvent.TIMER_COMPLETE,addTxtTmrHandler,false,0,true);
			addTxtTmr.start();
		}
		private function addTxtTmrHandler(e:TimerEvent):void
		{
			var tf:TextFormat = GlobVars.TF_MAIN;
			tf.leading = CASTLE_TXT_LEADING;
			addTxtTmr.stop();
			addTxtTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,addTxtTmrHandler);
			addTxtTmr = null;
			castleTxt = new TextFieldContainer(FontCharHud.FONT_NUM);
//			castleTxt.defaultTextFormat = tf;
//			castleTxt.selectable = false;
//			castleTxt.embedFonts = true;
			if (level.worldNum != LevelDataManager.currentLevelData.worldCount)
			{
				castleTxt.multiline = true;
//				castleTxt.wordWrap = true;
				castleTxt.textBlockWidth = CASTLE_TXT_WIDTH;
				var txt:String = GameTextMessages.ANOTHER_CASTLE;
				var namesArr:Array = statMngr.getCurrentBmc().namesArr;
				if (namesArr != null)
				{
					var princessName:String = namesArr[BmdSkinCont.IND_NAME_ARR_PRINCESS];
					if (princessName != null)
						txt = txt.replace(GameTextMessages.PRINCESS_REPLACE_STR,princessName);
				}
				castleTxt.text = txt;
				castleTxt.y = CASTLE_TXT_Y;
				level.startDungeonEndTmr();
			}
			else
			{
				castleTxt.multiline = false;
//				castleTxt.autoSize = TextFieldAutoSize.LEFT;
				castleTxt.text = GameTextMessages.QUEST_IS_OVER;
				castleTxt.y = CASTLE_TXT_QUEST_IS_OVER_Y;
				startMoveCreditsTmr = new CustomTimer(START_MOVE_CREDITS_TMR_DUR,1);
				startMoveCreditsTmr.addEventListener(TimerEvent.TIMER_COMPLETE,startMoveCreditsTmrHandler,false,0,true);
				startMoveCreditsTmr.start();
			}
			castleTxt.x = GlobVars.STAGE_WIDTH/2 - castleTxt.width/2;
			game.addChildAt(castleTxt,game.getChildIndex(level));

		}
		private function startMoveCreditsTmrHandler(event:TimerEvent):void
		{
			startMoveCreditsTmr.stop();
			startMoveCreditsTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,startMoveCreditsTmrHandler);
			startMoveCreditsTmr = null;
			sndMngr.changeMusic( MusicType.CREDITS );
			var tf:TextFormat = GlobVars.TF_MAIN;
			tf.leading = CASTLE_TXT_LEADING;
			tf.align = TextFormatAlign.CENTER;
			var fontType:int = FontCharMenu.TYPE_CREDITS;
//			var mapSkin:int = GameSettings.getMapSkinLimited();
//			if ( mapSkin == BmdInfo.SKIN_NUM_SUPER_MARIO_LAND_2 || mapSkin == BmdInfo.SKIN_SMB_SNES )
//				fontType = FontCharMenu.TYPE_SELECTED;
			creditsTxt = new TextFieldContainer(FontCharMenu.FONT_NUM,fontType);
//			creditsTxt.defaultTextFormat = tf;
			creditsTxt.multiline = true;
//			creditsTxt.selectable = false;
//			creditsTxt.embedFonts = true;
//			creditsTxt.wordWrap = true;
			creditsTxt.textBlockWidth = CREDITS_TXT_WIDTH;
//			creditsTxt.autoSize = TextFieldAutoSize.LEFT;
//			creditsTxt.text = Games.creditsGameList;
			creditsTxt.text = GameTextMessages.CREDITS_BEFORE_GAMES + Games.creditsGameList + GameTextMessages.CREDITS_AFTER_GAMES;
			creditsTxt.x = GlobVars.STAGE_WIDTH/2 - creditsTxt.width/2;
			creditsTxt.y = STAGE_HEIGHT;
			creditsTxt.center();
			creditsTailTxt = new TextFieldContainer(FontCharMenu.FONT_NUM,fontType);
//			creditsTailTxt.defaultTextFormat = tf;
			creditsTailTxt.multiline = true;
//			creditsTailTxt.wordWrap = true;
			creditsTailTxt.textBlockWidth = CREDITS_TXT_WIDTH;
//			creditsTailTxt.selectable = false;
//			creditsTailTxt.embedFonts = true;
//			creditsTailTxt.autoSize = TextFieldAutoSize.LEFT;
			creditsTailTxt.text = GameTextMessages.CREDITS_TAIL;
			creditsTailTxt.x = GlobVars.STAGE_WIDTH/2 - creditsTailTxt.width/2;
			creditsTailTxt.y = creditsTxt.y + creditsTxt.height;
			blackRect = new Sprite();
			blackRect.graphics.beginFill(0x000000);
			blackRect.graphics.drawRect(0,0,GlobVars.STAGE_WIDTH,GlobVars.TILE_SIZE*2);
			blackRect.graphics.endFill();
			var tileSize:int = GlobVars.TILE_SIZE;
			blackRectBg = new Sprite();
			blackRectBg.graphics.beginFill(0x000000);
			blackRectBg.graphics.drawRect(0,tileSize*3,GlobVars.STAGE_WIDTH,tileSize*12);
			blackRectBg.graphics.endFill();
			//var tsTxtInd:int = level.level.background.BG_VEC[0].getChildIndex(level.tsTxt);
			//level.level.background.BG_VEC[0].setChildIndex(thankTxt,tsTxtInd);
			//level.level.background.BG_VEC[0].setChildIndex(castleTxt,tsTxtInd);
			game.addChildAt(blackRectBg,game.getChildIndex(level));
			game.addChildAt(creditsTxt,game.getChildIndex(level));
			game.addChildAt(creditsTailTxt,game.getChildIndex(level));
			//tsTxtInd = level.level.background.BG_VEC[0].getChildIndex(level.tsTxt);
			game.addChildAt(blackRect,game.getChildIndex(level));
			moveCreditsLoopTmr = new CustomTimer(MOVE_CREDITS_LOOP_TMR_INT);
			moveCreditsLoopTmr.addEventListener(TimerEvent.TIMER,moveCreditsLoopTmrHandler,false,0,true);
			moveCreditsLoopTmr.start();
			creditsAreRolling = true;
			speedUpCredits = false;
		}

		private function moveCreditsLoopTmrHandler(event:TimerEvent):void
		{
			dt = TD_CALC.getTD();
			if (dt > DT_MAX)
				dt = DT_MAX;
			var moveAmt:Number = CREDITS_SPEED*dt;
			if (speedUpCredits)
				moveAmt = CREDITS_SPEED_FAST*dt;
			if (thankTxt)
				thankTxt.y -= moveAmt;
			if (castleTxt)
				castleTxt.y -= moveAmt;
			if (creditsTxt)
				creditsTxt.y -= moveAmt;
			if (creditsTailTxt.y + creditsTailTxt.height/2 > STAGE_HEIGHT/2)
				creditsTailTxt.y = creditsTxt.y + creditsTxt.height;
			else if (!restartGameTmr)
			{
				var restartDur:int = RESTART_GAME_TMR_DUR;
				if (speedUpCredits)
					restartDur /= 4;
				restartGameTmr = new CustomTimer(restartDur,1);
				restartGameTmr.addEventListener(TimerEvent.TIMER_COMPLETE,restartGameTmrHandler,false,0,true);
				restartGameTmr.start();
			}

			if (thankTxt && thankTxt.y + thankTxt.height < CREDITS_VISIBLE_END_Y)
			{
				game.removeChild(thankTxt);
				thankTxt = null;
			}
			else if (castleTxt && castleTxt.y + castleTxt.height < CREDITS_VISIBLE_END_Y)
			{
				game.removeChild(castleTxt);
				castleTxt = null;
			}
			else if (creditsTxt && creditsTxt.y + creditsTxt.height < CREDITS_VISIBLE_END_Y)
			{
				game.removeChild(creditsTxt);
				creditsTxt = null;
				moveCreditsLoopTmr.stop();
				moveCreditsLoopTmr.removeEventListener(TimerEvent.TIMER,moveCreditsLoopTmrHandler);
				moveCreditsLoopTmr = null;
			}
		}
		public function fastForwardCredits():void
		{
			speedUpCredits = true;
		}
		private function restartGameTmrHandler(event:TimerEvent):void
		{
			restartGameTmr.stop();
			restartGameTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,restartGameTmrHandler);
			restartGameTmr = null;
			creditsAreRolling = false;
			eventMngr.beatGame();
		}
		private function initiateLevel():void
		{
			level = new Level(statMngr.currentLevelID, LevelDataManager.currentLevelData, newAreaStatsArr, statMngr.newLev);
			game.addChild(level);

			if (thankTxt != null)
			{
				if (thankTxt.parent)
					thankTxt.parent.removeChild(thankTxt);
				thankTxt = null;
			}
			if (castleTxt != null)
			{
				if (castleTxt.parent)
					castleTxt.parent.removeChild(castleTxt);
				castleTxt = null;
			}
			if (creditsTxt != null)
			{
				if (creditsTxt.parent)
					creditsTxt.parent.removeChild(creditsTxt);
				creditsTxt = null;
			}
			if (creditsTailTxt != null)
			{
				if (creditsTailTxt.parent)
					creditsTailTxt.parent.removeChild(creditsTailTxt);
				creditsTailTxt = null;
			}
		}
		public function loadNewArea(oldLevNum:String,oldLevArea:String,newArea:String,oldAreaStatsArr:Array):void
		{
			//trace("oldLevStr: "+oldLevNum+oldLevArea+" newArea: "+newArea);
			if (newArea.length != 1)
				throw new StringError("trying to load invalid area");
			newAreaStatsArr = statMngr.saveAreaStats(oldLevNum,oldLevArea,newArea,oldAreaStatsArr);
			//trace("newAreaStatsArr: "+newAreaStatsArr);
			statMngr.newLev = false;
			createLevel( LevelID.Create(oldLevNum + newArea) );
		}
		public function resetAreaStats():void
		{
			newAreaStatsArr = [];
		}
		public function loadNewLevel(levelID:LevelID):void
		{
			statMngr.resetLevelStats();
			newAreaStatsArr = [];
			statMngr.newLev = true;
			createLevel(levelID);
		}

	}
}

package com.smbc.sound
{
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.games.GameContra;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.cross.sound.MusicFormat;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Bill;
	import com.smbc.characters.Link;
	import com.smbc.characters.Mario;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.Ryu;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.characters.Sophia;
	import com.smbc.data.LevelTypes;

	import mx.utils.StringUtil;

	public class MusicInfo
	{
		//[Embed(source="../assets/audio/bgm/bgm_mario_overworld_16.ogg", mimeType="application/octet-stream")]
		//public static const SuperMarioBrosOgg:Class;
		//*
		private static const SPC:String = MusicFormat.SPC;
		private static const NSF:String = MusicFormat.NSF;
		private static const KSS:String = MusicFormat.KSS;
		private static const NSFE:String = MusicFormat.NSFE;
		private static const VGM:String = MusicFormat.VGM;
		private static const GBS:String = MusicFormat.GBS;

		private static const NES:String = Consoles.nintendo;
		private static const SNES:String = Consoles.superNintendo;
		private static const GB:String = Consoles.gameBoy;
		private static const MSX:String = Consoles.msx;
		private static const SONG_DCT:CustomDictionary = new CustomDictionary();
		public static var SFX_DCT:CustomDictionary = new CustomDictionary();

		/*
		// nintendo
		[Embed(source="../assets/audio/seq/nsf/BlasterMaster.nsf", mimeType="application/octet-stream")]
		public static const BlasterMasterNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/BlasterMasterSfx.nsf", mimeType="application/octet-stream")]
		public static const BlasterMasterSfxNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/Castlevania.nsf", mimeType="application/octet-stream")]
		private static const CastlevaniaNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/Castlevania2.nsf", mimeType="application/octet-stream")]
		private static const Castlevania2Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/Castlevania3.nsf", mimeType="application/octet-stream")]
		private static const Castlevania3Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/ContraSfx.nsf", mimeType="application/octet-stream")]
		private static const ContraNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/ContraForce.nsf", mimeType="application/octet-stream")]
		private static const ContraForceNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/FinalFantasy.nsf", mimeType="application/octet-stream")]
		private static const FinalFantasyNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/LifeForce.nsf", mimeType="application/octet-stream")]
		private static const LifeForceNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan.nsf", mimeType="application/octet-stream")]
		private static const MegaManNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan2.nsf", mimeType="application/octet-stream")]
		private static const MegaMan2Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan3.nsf", mimeType="application/octet-stream")]
		private static const MegaMan3Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan4.nsf", mimeType="application/octet-stream")]
		private static const MegaMan4Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan5.nsf", mimeType="application/octet-stream")]
		private static const MegaMan5Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan6.nsf", mimeType="application/octet-stream")]
		private static const MegaMan6Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/Metroid.nsf", mimeType="application/octet-stream")]
		private static const MetroidNsf:Class;
//		[Embed(source="../assets/audio/seq/nsf/MetroidFds.nsf", mimeType="application/octet-stream")]
//		private static const MetroidFdsNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/NinjaGaiden.nsf", mimeType="application/octet-stream")]
		private static const NinjaGaidenNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/NinjaGaiden2.nsf", mimeType="application/octet-stream")]
		private static const NinjaGaiden2Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/NinjaGaiden3.nsf", mimeType="application/octet-stream")]
		private static const NinjaGaiden3Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/SuperC.nsf", mimeType="application/octet-stream")]
		private static const SuperCNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/SuperMarioBrosVs.nsf", mimeType="application/octet-stream")]
		private static const SuperMarioBrosVsNsf:Class;
		[Embed(source="../assets/audio/seq/nsf/SuperMarioBros3.nsf", mimeType="application/octet-stream")]
		private static const SuperMarioBros3Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/SuperMarioBros3.nsfe", mimeType="application/octet-stream")]
		public static const SuperMarioBros3Nsfe:Class;

		[Embed(source="../assets/audio/seq/nsf/Zelda1.nsf", mimeType="application/octet-stream")]
		private static const Zelda1Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/Zelda2.nsf", mimeType="application/octet-stream")]
		public static const Zelda2Nsf:Class;

		// gameboy
		[Embed(source="../assets/audio/seq/gbs/BlasterMasterEnemyBelow.gbs", mimeType="application/octet-stream")]
		public static const BlasterMasterEnemyBelowGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/CastlevaniaAdventure.gbs", mimeType="application/octet-stream")]
		public static const CastlevaniaAdventureGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/CastlevaniaLegends.gbs", mimeType="application/octet-stream")]
		public static const CastlevaniaLegendsGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/ContraTheAlienWars.gbs", mimeType="application/octet-stream")]
		public static const ContraTheAlienWarsGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/MegaMan.gbs", mimeType="application/octet-stream")]
		public static const MegaManGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/MegaMan3.gbs", mimeType="application/octet-stream")]
		public static const MegaMan3Gbs:Class;
		[Embed(source="../assets/audio/seq/gbs/MegaMan4.gbs", mimeType="application/octet-stream")]
		public static const MegaMan4Gbs:Class;
		[Embed(source="../assets/audio/seq/gbs/MegaMan5.gbs", mimeType="application/octet-stream")]
		public static const MegaMan5Gbs:Class;
		[Embed(source="../assets/audio/seq/gbs/NinjaGaidenShadow.gbs", mimeType="application/octet-stream")]
		public static const NinjaGaidenShadowGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/OperationC.gbs", mimeType="application/octet-stream")]
		public static const OperationCGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/ZeldaLinksAwakening.gbs", mimeType="application/octet-stream")]
		public static const ZeldaLinksAwakeningGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/Metroid2.gbs", mimeType="application/octet-stream")]
		public static const Metroid2ReturnOfSamusGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/SuperMarioBrosDeluxe.gbs", mimeType="application/octet-stream")]
		public static const SuperMarioBrosDeluxeGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/SuperMarioLand.gbs", mimeType="application/octet-stream")]
		public static const SuperMarioLandGbs:Class;
		[Embed(source="../assets/audio/seq/gbs/SuperMarioLand2.gbs", mimeType="application/octet-stream")]
		public static const SuperMarioLand2Gbs:Class;

		// super nintendo
		[Embed(source="../assets/audio/seq/spc/BlasterMasterSnes/Overworld.spc", mimeType="application/octet-stream")]
		public static const BlasterMasterSnes_Overworld:Class;
		{ SONG_DCT["BlasterMasterSnes_Overworld"] = [ BlasterMasterSnes_Overworld, SPC, -1, 80, 0 ] }



		[Embed(source="../assets/audio/seq/spc/Contra3/Casualty of War.spc", mimeType="application/octet-stream")]
		public static const Contra3_CasualtyOfWar:Class;
		{ SONG_DCT["Contra3_CasualtyOfWar"] = [ Contra3_CasualtyOfWar, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Ground Zero.spc", mimeType="application/octet-stream")]
		public static const Contra3_GroundZero:Class;
		{ SONG_DCT["Contra3_GroundZero"] = [ Contra3_GroundZero, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Mission Accomplished.spc", mimeType="application/octet-stream")]
		public static const Contra3_MissionAccomplished:Class;
		{ SONG_DCT["Contra3_MissionAccomplished"] = [ Contra3_MissionAccomplished, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Invasion.spc", mimeType="application/octet-stream")]
		public static const Contra3_Invasion:Class;
		{ SONG_DCT["Contra3_Invasion"] = [ Contra3_Invasion, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/No Man's Land.spc", mimeType="application/octet-stream")]
		public static const Contra3_NoMansLand:Class;
		{ SONG_DCT["Contra3_NoMansLand"] = [ Contra3_NoMansLand, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Tearing Up the Turnpike.spc", mimeType="application/octet-stream")]
		public static const Contra3_TearingUpTheTurnpike:Class;
		{ SONG_DCT["Contra3_TearingUpTheTurnpike"] = [ Contra3_TearingUpTheTurnpike, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Road Warriors.spc", mimeType="application/octet-stream")]
		public static const Contra3_RoadWarriors:Class;
		{ SONG_DCT["Contra3_RoadWarriors"] = [ Contra3_RoadWarriors, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Nesting in the Sands.spc", mimeType="application/octet-stream")]
		public static const Contra3_NestingInTheSands:Class;
		{ SONG_DCT["Contra3_NestingInTheSands"] = [ Contra3_NestingInTheSands, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Neo Kobe Steel Factory.spc", mimeType="application/octet-stream")]
		public static const Contra3_NeoKobeSteelFactory:Class;
		{ SONG_DCT["Contra3_NeoKobeSteelFactory"] = [ Contra3_NeoKobeSteelFactory, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/The Final Gauntlet (Part 2).spc", mimeType="application/octet-stream")]
		public static const Contra3_TheFinalGauntlet2:Class;
		{ SONG_DCT["Contra3_TheFinalGauntlet2"] = [ Contra3_TheFinalGauntlet2, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/Contra3/Point of Entry.spc", mimeType="application/octet-stream")]
		public static const Contra3_PointOfEntry:Class;
		{ SONG_DCT["Contra3_PointOfEntry"] = [ Contra3_PointOfEntry, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Stage Clear.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_EnterTheGraveyard:Class;
		{ SONG_DCT["MegaMan7_EnterTheGraveyard"] = [ MegaMan7_EnterTheGraveyard, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Stage Clear.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_StageClear:Class;
		{ SONG_DCT["MegaMan7_StageClear"] = [ MegaMan7_StageClear, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/New Weapon.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_NewWeapon:Class;
		{ SONG_DCT["MegaMan7_NewWeapon"] = [ MegaMan7_NewWeapon, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaManAndBass/Burnerman.spc", mimeType="application/octet-stream")]
		public static const MegaManAndBass_Burnerman:Class;
		{ SONG_DCT["MegaManAndBass_Burnerman"] = [ MegaManAndBass_Burnerman, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Robot Museum.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_RobotMuseum:Class;
		{ SONG_DCT["MegaMan7_RobotMuseum"] = [ MegaMan7_RobotMuseum, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/The Eight Robot Masters.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_TheEightRobotMasters:Class;
		{ SONG_DCT["MegaMan7_TheEightRobotMasters"] = [ MegaMan7_TheEightRobotMasters, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Stage Clear.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_TheHauntedGraveyard:Class;
		{ SONG_DCT["MegaMan7_TheHauntedGraveyard"] = [ MegaMan7_TheHauntedGraveyard, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Shademan.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_Shademan:Class;
		{ SONG_DCT["MegaMan7_Shademan"] = [ MegaMan7_Shademan, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Stage Start.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_StageStart:Class;
		{ SONG_DCT["MegaMan7_StageStart"] = [ MegaMan7_StageStart, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaMan7/Remains of the Lab.spc", mimeType="application/octet-stream")]
		public static const MegaMan7_RemainsOfTheLab:Class;
		{ SONG_DCT["MegaMan7_RemainsOfTheLab"] = [ MegaMan7_RemainsOfTheLab, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaManAndBass/Game Over.spc", mimeType="application/octet-stream")]
		public static const MegaManAndBass_GameOver:Class;
		{ SONG_DCT["MegaManAndBass_GameOver"] = [ MegaManAndBass_GameOver, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaManAndBass/Major Boss Battle.spc", mimeType="application/octet-stream")]
		public static const MegaManAndBass_MajorBossBattle:Class;
		{ SONG_DCT["MegaManAndBass_MajorBossBattle"] = [ MegaManAndBass_MajorBossBattle, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaManAndBass/Pirateman.spc", mimeType="application/octet-stream")]
		public static const MegaManAndBass_Pirateman:Class;
		{ SONG_DCT["MegaManAndBass_Pirateman"] = [ MegaManAndBass_Pirateman, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/MegaManAndBass/Tenguman.spc", mimeType="application/octet-stream")]
		public static const MegaManAndBass_Tenguman:Class;
		{ SONG_DCT["MegaManAndBass_Tenguman"] = [ MegaManAndBass_Tenguman, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Death.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Death:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Death"] = [ NinjaGaidenTrilogy_Death, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Act... .spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Act:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Act"] = [ NinjaGaidenTrilogy_Act, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Fortress.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Fortress:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Fortress"] = [ NinjaGaidenTrilogy_Fortress, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Long Train.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_LongTrain:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_LongTrain"] = [ NinjaGaidenTrilogy_LongTrain, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Mine.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Mine:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Mine"] = [ NinjaGaidenTrilogy_Mine, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Mountain.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Mountain:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Mountain"] = [ NinjaGaidenTrilogy_Mountain, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Running.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Running:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Running"] = [ NinjaGaidenTrilogy_Running, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Rooftop.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Rooftop:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Rooftop"] = [ NinjaGaidenTrilogy_Rooftop, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Prison.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Prison:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Prison"] = [ NinjaGaidenTrilogy_Prison, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/The Maze of Darkness.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_TheMazeOfDarkness:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_TheMazeOfDarkness"] = [ NinjaGaidenTrilogy_TheMazeOfDarkness, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Boss Fight.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_BossFight:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_BossFight"] = [ NinjaGaidenTrilogy_BossFight, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/Sorrow.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_Sorrow:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_Sorrow"] = [ NinjaGaidenTrilogy_Sorrow, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/NinjaGaidenTrilogy/After Him!.spc", mimeType="application/octet-stream")]
		public static const NinjaGaidenTrilogy_AfterHim:Class;
		{ SONG_DCT["NinjaGaidenTrilogy_AfterHim"] = [ NinjaGaidenTrilogy_AfterHim, SPC, -1, 80, 0 ] }


//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Bonus.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_BonusSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_BonusSmb1"] = [ SuperMarioAllStars_BonusSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Bonus (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_BonusFastSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_BonusFastSmb1"] = [ SuperMarioAllStars_BonusFastSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Castle.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_CastleSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_CastleSmb1"] = [ SuperMarioAllStars_CastleSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Castle (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_CastleFastSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_CastleFastSmb1"] = [ SuperMarioAllStars_CastleFastSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/all/Game Select.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_GameSelect:Class;
		{ SONG_DCT["SuperMarioAllStars_GameSelect"] = [ SuperMarioAllStars_GameSelect, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Course Clear.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_CourseClear:Class;
		{ SONG_DCT["SuperMarioAllStars_CourseClear"] = [ SuperMarioAllStars_CourseClear, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Going Underground.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_IntroLevelSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_IntroLevelSmb1"] = [ SuperMarioAllStars_IntroLevelSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Game Over.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_GameOverSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_GameOverSmb1"] = [ SuperMarioAllStars_GameOverSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Overworld.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_OverworldSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_OverworldSmb1"] = [ SuperMarioAllStars_OverworldSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Overworld (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_OverworldFastSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_OverworldFastSmb1"] = [ SuperMarioAllStars_OverworldFastSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Player Down.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_DieSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_DieSmb1"] = [ SuperMarioAllStars_DieSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Swimming.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_WaterSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_WaterSmb1"] = [ SuperMarioAllStars_WaterSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Swimming (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_WaterFastSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_WaterFastSmb1"] = [ SuperMarioAllStars_WaterFastSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/World Clear.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_WinCastleSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_WinCastleSmb1"] = [ SuperMarioAllStars_WinCastleSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Underworld.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_UnderGroundSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_UnderGroundSmb1"] = [ SuperMarioAllStars_UnderGroundSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb1/Underworld (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_UndergroundFastSmb1:Class;
		{ SONG_DCT["SuperMarioAllStars_UndergroundFastSmb1"] = [ SuperMarioAllStars_UndergroundFastSmb1, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/all/Invincible.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_Invincible:Class;
		{ SONG_DCT["SuperMarioAllStars_Invincible"] = [ SuperMarioAllStars_Invincible, SPC, -1, 80, 0 ] }

//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/all/Invincible (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_InvincibleFast:Class;
		{ SONG_DCT["SuperMarioAllStars_InvincibleFast"] = [ SuperMarioAllStars_InvincibleFast, SPC, -1, 80, 0 ] }

		//smb3
//		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Airship.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_Airship:Class;
		{ SONG_DCT["SuperMarioAllStars_Airship"] = [ SuperMarioAllStars_Airship, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Airship (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_AirshipFast:Class;
		{ SONG_DCT["SuperMarioAllStars_AirshipFast"] = [ SuperMarioAllStars_AirshipFast, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Course Clear (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_CourseClearSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_CourseClearSmb3"] = [ SuperMarioAllStars_CourseClearSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Ending (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_EndingSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_EndingSmb3"] = [ SuperMarioAllStars_EndingSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Fortress.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_Fortress:Class;
		{ SONG_DCT["SuperMarioAllStars_Fortress"] = [ SuperMarioAllStars_Fortress, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Fortress (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_FortressFast:Class;
		{ SONG_DCT["SuperMarioAllStars_FortressFast"] = [ SuperMarioAllStars_FortressFast, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Game Over (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_GameOverSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_GameOverSmb3"] = [ SuperMarioAllStars_GameOverSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Grass Land.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_GrassLand:Class;
		{ SONG_DCT["SuperMarioAllStars_GrassLand"] = [ SuperMarioAllStars_GrassLand, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/In the Clouds.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_InTheClouds:Class;
		{ SONG_DCT["SuperMarioAllStars_InTheClouds"] = [ SuperMarioAllStars_InTheClouds, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/In the Clouds (Hurry Up).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_InTheCloudsFast:Class;
		{ SONG_DCT["SuperMarioAllStars_InTheCloudsFast"] = [ SuperMarioAllStars_InTheCloudsFast, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Player Down (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_PlayerDownSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_PlayerDownSmb3"] = [ SuperMarioAllStars_PlayerDownSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Swimming (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_SwimmingSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_SwimmingSmb3"] = [ SuperMarioAllStars_SwimmingSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Swimming (Hurry Up) (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_SwimmingFastSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_SwimmingFastSmb3"] = [ SuperMarioAllStars_SwimmingFastSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/The Evil King Bowser.spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_TheEvilKingBowser:Class;
		{ SONG_DCT["SuperMarioAllStars_TheEvilKingBowser"] = [ SuperMarioAllStars_TheEvilKingBowser, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/World Clear (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_WorldClearSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_WorldClearSmb3"] = [ SuperMarioAllStars_WorldClearSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Overworld (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_OverworldSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_OverworldSmb3"] = [ SuperMarioAllStars_OverworldSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/SuperMarioAllStars/smb3/Overworld (Hurry Up) (smb3).spc", mimeType="application/octet-stream")]
		public static const SuperMarioAllStars_OverworldFastSmb3:Class;
		{ SONG_DCT["SuperMarioAllStars_OverworldFastSmb3"] = [ SuperMarioAllStars_OverworldFastSmb3, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/CastlevaniaDraculaX/Den.spc", mimeType="application/octet-stream")]
		public static const CastlevaniaDraculaX_Den:Class;
		{ SONG_DCT["CastlevaniaDraculaX_Den"] = [ CastlevaniaDraculaX_Den, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/CastlevaniaDraculaX/Bloodlines.spc", mimeType="application/octet-stream")]
		public static const CastlevaniaDraculaX_Bloodlines:Class;
		{ SONG_DCT["CastlevaniaDraculaX_Bloodlines"] = [ CastlevaniaDraculaX_Bloodlines, SPC, -1, 80, 0 ] }

		//[Embed(source="../assets/audio/seq/spc/CastlevaniaDraculaX/Rescued.spc", mimeType="application/octet-stream")]
		public static const CastlevaniaDraculaX_Rescued:Class;
		{ SONG_DCT["CastlevaniaDraculaX_Rescued"] = [ CastlevaniaDraculaX_Rescued, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Beginning.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_Beginning:Class;
		{ SONG_DCT["SuperCastlevania4_Beginning"] = [ SuperCastlevania4_Beginning, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Beginning.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_BloodyTears:Class;
		{ SONG_DCT["SuperCastlevania4_BloodyTears"] = [ SuperCastlevania4_BloodyTears, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Death of Simon.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_DeathOfSimon:Class;
		{ SONG_DCT["SuperCastlevania4_DeathOfSimon"] = [ SuperCastlevania4_DeathOfSimon, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Beginning.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_DraculasTheme:Class;
		{ SONG_DCT["SuperCastlevania4_DraculasTheme"] = [ SuperCastlevania4_DraculasTheme, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Game Over.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_GameOver:Class;
		{ SONG_DCT["SuperCastlevania4_GameOver"] = [ SuperCastlevania4_GameOver, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/In The Castle.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_InTheCastle:Class;
		{ SONG_DCT["SuperCastlevania4_InTheCastle"] = [ SuperCastlevania4_InTheCastle, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Secret Room.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_SecretRoom:Class;
		{ SONG_DCT["SuperCastlevania4_SecretRoom"] = [ SuperCastlevania4_SecretRoom, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Stage Clear.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_StageClear:Class;
		{ SONG_DCT["SuperCastlevania4_StageClear"] = [ SuperCastlevania4_StageClear, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/The Cave.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_TheCave:Class;
		{ SONG_DCT["SuperCastlevania4_TheCave"] = [ SuperCastlevania4_TheCave, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Theme of Simon.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_ThemeOfSimon:Class;
		{ SONG_DCT["SuperCastlevania4_ThemeOfSimon"] = [ SuperCastlevania4_ThemeOfSimon, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperCastlevania4/Vampire Killer.spc", mimeType="application/octet-stream")]
		public static const SuperCastlevania4_VampireKiller:Class;
		{ SONG_DCT["SuperCastlevania4_VampireKiller"] = [ SuperCastlevania4_VampireKiller, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Item Room.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_ItemRoom:Class;
		{ SONG_DCT["SuperMetroid_ItemRoom"] = [ SuperMetroid_ItemRoom, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Item Acquisition Fanfare.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_ItemFanfare:Class;
		{ SONG_DCT["SuperMetroid_ItemFanfare"] = [ SuperMetroid_ItemFanfare, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Maridia Rocky Underwater Area No Fade.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_MaridiaRockyUnderwater:Class;
		{ SONG_DCT["SuperMetroid_MaridiaRockyUnderwater"] = [ SuperMetroid_MaridiaRockyUnderwater, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Samus Aran's Appearance Fanfare.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_SamusAppearanceFanfare:Class;
		{ SONG_DCT["SuperMetroid_SamusAppearanceFanfare"] = [ SuperMetroid_SamusAppearanceFanfare, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Samus Aran's Final Cry.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_SamusDie:Class;
		{ SONG_DCT["SuperMetroid_SamusDie"] = [ SuperMetroid_SamusDie, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Brinstar Overgrown with Vegetation Area No Fade.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_BrinstarVegetation:Class;
		{ SONG_DCT["SuperMetroid_BrinstarVegetation"] = [ SuperMetroid_BrinstarVegetation, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Crateria ~ The Space Pirates Appear.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_CriteriaSpacePirates:Class;
		{ SONG_DCT["SuperMetroid_CriteriaSpacePirates"] = [ SuperMetroid_CriteriaSpacePirates, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Norfair Ancient Ruins Area.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_NorfairAncientRuins:Class;
		{ SONG_DCT["SuperMetroid_NorfairAncientRuins"] = [ SuperMetroid_NorfairAncientRuins, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Continue.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_Continue:Class;
		{ SONG_DCT["SuperMetroid_Continue"] = [ SuperMetroid_Continue, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Escape.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_Escape:Class;
		{ SONG_DCT["SuperMetroid_Escape"] = [ SuperMetroid_Escape, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Ending.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_Tension:Class;
		{ SONG_DCT["SuperMetroid_Tension"] = [ SuperMetroid_Tension, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Ending.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_SamusTheme:Class;
		{ SONG_DCT["SuperMetroid_SamusTheme"] = [ SuperMetroid_SamusTheme, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Ending.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_SuperMetroidTheme:Class;
		{ SONG_DCT["SuperMetroid_SuperMetroidTheme"] = [ SuperMetroid_SuperMetroidTheme, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/SuperMetroid/Ending.spc", mimeType="application/octet-stream")]
		public static const SuperMetroid_Tourian:Class;
		{ SONG_DCT["SuperMetroid_Tourian"] = [ SuperMetroid_Tourian, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Hyrule Field Main Theme.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_HyruleField:Class;
		{ SONG_DCT["ZeldaLinkToThePast_HyruleField"] = [ ZeldaLinkToThePast_HyruleField, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Dark Golden Land.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_DarkGoldenLand:Class;
		{ SONG_DCT["ZeldaLinkToThePast_DarkGoldenLand"] = [ ZeldaLinkToThePast_DarkGoldenLand, SPC, -1, 80, 0 ] }

//		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Treasure!.spc", mimeType="application/octet-stream")]
//		public static const ZeldaLinkToThePast_Treasure:Class;
//		{ SONG_DCT["ZeldaLinkToThePast_Treasure"] = [ ZeldaLinkToThePast_Treasure, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Guessing-Game House.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_GuessingGameHouse:Class;
		{ SONG_DCT["ZeldaLinkToThePast_GuessingGameHouse"] = [ ZeldaLinkToThePast_GuessingGameHouse, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Lost Ancient Ruins.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_LostAncientRuins:Class;
		{ SONG_DCT["ZeldaLinkToThePast_LostAncientRuins"] = [ ZeldaLinkToThePast_LostAncientRuins, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Beginning of the Journey.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_BeginningOfTheJourney:Class;
		{ SONG_DCT["ZeldaLinkToThePast_BeginningOfTheJourney"] = [ ZeldaLinkToThePast_BeginningOfTheJourney, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Great Victory!.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_GreatVictory:Class;
		{ SONG_DCT["ZeldaLinkToThePast_GreatVictory"] = [ ZeldaLinkToThePast_GreatVictory, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Princess Zelda's Rescue.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_PrincessZeldasRescue:Class;
		{ SONG_DCT["ZeldaLinkToThePast_PrincessZeldasRescue"] = [ ZeldaLinkToThePast_PrincessZeldasRescue, SPC, -1, 80, 0 ] }

//		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Priest of the Dark Order.spc", mimeType="application/octet-stream")]
//		public static const ZeldaLinkToThePast_PriestOfTheDarkOrder:Class;
//		{ SONG_DCT["ZeldaLinkToThePast_PriestOfTheDarkOrder"] = [ ZeldaLinkToThePast_PriestOfTheDarkOrder, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Dank Dungeons.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_DankDungeons:Class;
		{ SONG_DCT["ZeldaLinkToThePast_DankDungeons"] = [ ZeldaLinkToThePast_DankDungeons, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/The Silly Pink Rabbit!.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_TheSillyPinkRabbit:Class;
		{ SONG_DCT["ZeldaLinkToThePast_TheSillyPinkRabbit"] = [ ZeldaLinkToThePast_TheSillyPinkRabbit, SPC, -1, 100, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Soldiers of Kakariko Village.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_SoldiersOfKakarikoVillage:Class;
		{ SONG_DCT["ZeldaLinkToThePast_SoldiersOfKakarikoVillage"] = [ ZeldaLinkToThePast_SoldiersOfKakarikoVillage, SPC, -1, 80, 0 ] }

		[Embed(source="../assets/audio/seq/spc/ZeldaLinkToThePast/Seal of Seven Maidens.spc", mimeType="application/octet-stream")]
		public static const ZeldaLinkToThePast_SealOfSevenMaidens:Class;
		{ SONG_DCT["ZeldaLinkToThePast_SealOfSevenMaidens"] = [ ZeldaLinkToThePast_SealOfSevenMaidens, SPC, -1, 80, 0 ] }
		*/
		public static const SEP:String = "_";
		public static const STR:String = "MFX";
		public static const BGM_STR:String = SEP + "BGM"; // begins with separator
		public static const LOOP_STR:String = SEP + "LOOP"; // begins with separator

		// nsf volumes
		private static const VOL_BLASTER_MASTER:int = SoundLevels.BLASTER_MASTER_NSF;
		private static const VOL_BLASTER_MASTER_SFX:int = 100;
		private static const VOL_CASTLEVANIA:int = SoundLevels.CASTLEVANIA_NSF;
		private static const VOL_CASTLEVANIA_SFX:int = 100;
		private static const VOL_CASTLEVANIA_2:int = SoundLevels.CASTLEVANIA_2_NSF;
		private static const VOL_CONTRA:int = SoundLevels.CONTRA_NSF;
		private static const VOL_CONTRA_SFX:int = 110;
		private static const VOL_SUPER_C_SFX:int = 110;
		private static const VOL_CONTRA_FORCE:int = SoundLevels.CONTRA_FORCE_NSF;
		private static const VOL_FINAL_FANTASY:int = VOL_CONTRA;
		private static const VOL_LIFE_FORCE:int = SoundLevels.LIFE_FORCE_NSF;
		private static const VOL_KID_ICARUS:int = 150;
		private static const VOL_MEGA_MAN:int = SoundLevels.MEGA_MAN_NSF;
		private static const VOL_MEGA_MAN_2:int = SoundLevels.MEGA_MAN_2_NSF;
		private static const VOL_MEGA_MAN_2_SFX:int = 100;
		private static const VOL_MEGA_MAN_3:int = SoundLevels.MEGA_MAN_3_NSF;
		private static const VOL_MEGA_MAN_3_SFX:int = 100;
		private static const VOL_MEGA_MAN_4_SFX:int = 100;
		private static const VOL_MEGA_MAN_5_SFX:int = 100;
		private static const VOL_MEGA_MAN_6_SFX:int = 100;
		private static const VOL_METROID:int = SoundLevels.METROID_NSF;
		private static const VOL_METROID_SFX:int = 160;
		private static const VOL_NINJA_GAIDEN:int = SoundLevels.NINJA_GAIDEN_NSF;
		private static const VOL_NINJA_GAIDEN_SFX:int = 110;
		private static const VOL_NINJA_GAIDEN_2:int = SoundLevels.NINJA_GAIDEN_2_NSF;
		private static const VOL_NINJA_GAIDEN_2_SFX:int = 110;
		private static const VOL_NINJA_GAIDEN_3_SFX:int = 110;
		private static const VOL_SUPER_MARIO_BROS:int = SoundLevels.SUPER_MARIO_BROS_NSF;
		public static const VOL_SUPER_MARIO_BROS_SFX:int = 100;
		private static const VOL_SUPER_MARIO_BROS_3:int = SoundLevels.SUPER_MARIO_BROS_3_NSF;
		private static const VOL_ZELDA_1:int = SoundLevels.ZELDA_1_NSF;
		private static const VOL_ZELDA_1_SFX:int = 115;
		private static const VOL_ZELDA_2:int = SoundLevels.ZELDA_2_NSF;

		// ends with separator
		public static const CHAR_STR_BILL:String = Bill.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_LINK:String = Link.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_MARIO:String = Mario.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_MEGA_MAN:String = MegaMan.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_RYU:String = Ryu.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_SAMUS:String = Samus.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_SIMON:String = Simon.CHAR_NAME_CAPS + SEP;
		public static const CHAR_STR_SOPHIA:String = Sophia.CHAR_NAME_CAPS + SEP;

		private static const MARIO_SECONDS_LEFT_DELAY:int = 2800;
		// does not contain separator
		public static const TYPE_DUNGEON_BGM:String = "DUNGEON" + BGM_STR;
		public static const TYPE_DAY_BGM:String = "DAY" + BGM_STR;
		public static const TYPE_DIE:String = "DIE";
		public static const TYPE_NIGHT_BGM:String = "NIGHT" + BGM_STR;
		public static const TYPE_UNDER_GROUND_BGM:String = "UNDER_GROUND" + BGM_STR;
		public static const TYPE_WATER_BGM:String = "WATER" + BGM_STR;
		public static const TYPE_BONUS_BGM:String = "BONUS" + BGM_STR;
		public static const TYPE_CREDITS:String = "CREDITS";
		public static const TYPE_GAME_OVER:String = "GAME_OVER";
		public static const TYPE_INTRO:String = "INTRO";
		public static const TYPE_INTRO_LEVEL:String = "INTRO_LEVEL";
		public static const TYPE_SECONDS_LEFT:String = "SECONDS_LEFT";
		public static const TYPE_STAR:String = "STAR";
		public static const TYPE_WIN:String = "WIN";
		public static const TYPE_WIN_CASTLE:String = "WIN_CASTLE";

		private static const BT_BGM:String = SoundContainer.BT_BGM;
		private static const BT_LOOPING_SFX:String = SoundContainer.BT_LOOPING_SFX;
		private static const BT_MUSIC_EFFECT:String = SoundContainer.BT_MUSIC_EFFECT;
		private static const BT_OVERRIDE:String = SoundContainer.BT_OVERRIDE;
		private static const BT_SFX:String = SoundContainer.BT_SFX;


		public static const TRACK_OFFSET:int = -1; // number added to track before played
		private static var indCtr:int = -1;
		public static const IND_SOURCE_CLASS:int = indCtr+=1;
		public static const IND_FILE_TYPE:int = indCtr+=1;
		public static const IND_TRACK_NUM:int = indCtr+=1;
		public static const IND_VOLUME:int = indCtr+=1;
		public static const IND_START_TIME:int = indCtr+=1;
		public static const IND_SOUND_TYPE:int = indCtr+=1;
		public static const IND_DURATION:int = indCtr+=1;
		public static const IND_LOOP_PNT:int = indCtr+=1;
		public static const IND_BUFFER:int = indCtr+=1;

		public static const IND_8BIT:int = 0;
		public static const IND_16BIT:int = 1;
		public static const IND_GB:int = 2;

		private static const ContraNsf:Class = Games.contra.Nsf;
		private static const SuperCNsf:Class = Games.superC.Nsf;
		private static const SuperMarioBrosVsNsf:Class = Games.superMarioBros.NSF;
		private static const Zelda1Nsf:Class = Games.zelda.Nsf;
		private static const NinjaGaidenNsf:Class = Games.ninjaGaiden.Nsf;
		private static const MetroidNsf:Class = Games.metroid.Nsf;
		private static const CastlevaniaNsf:Class = Games.castlevania.Nsf;
		private static const Castlevania2Nsf:Class = Games.castlevania2.Nsf;
		private static const Castlevania3Nsf:Class = Games.castlevania3.Nsf;
		private static const BlasterMasterSfxNsf:Class = Games.blasterMaster.NsfSfx;
		private static const LifeForceNsf:Class = Games.lifeForce.Nsfe;
		private static const MegaManNsf:Class = Games.megaMan.Nsf;
		private static const MegaMan2Nsf:Class = Games.megaMan2.Nsf;
		private static const MegaMan3Nsf:Class = Games.megaMan3.Nsf;
		private static const MegaMan6Nsf:Class = Games.megaMan6.Nsf;
		private static const KidIcarusNsf:Class = Games.kidIcarus.Nsf;

		[Embed(source="../assets/audio/seq/nsf/NinjaGaiden2.nsf", mimeType="application/octet-stream")]
		private static const NinjaGaiden2Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/NinjaGaiden3.nsf", mimeType="application/octet-stream")]
		private static const NinjaGaiden3Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan4.nsf", mimeType="application/octet-stream")]
		private static const MegaMan4Nsf:Class;
		[Embed(source="../assets/audio/seq/nsf/MegaMan5.nsf", mimeType="application/octet-stream")]
		private static const MegaMan5Nsf:Class;

		//public static const IND_SPEED:int = 2;
		//private static const SN:int = 1; // speed normal
		//public static const GAME_CHARACTER_SELECT:Array = [ [ SuperMarioBros3Nsf, NSF,14,VOL_SUPER_MARIO_BROS_3,0 ] ];
//		public static const GAME_CHARACTER_SELECT:Array = [ [ SuperMarioBrosVsNsf, NSF,21,VOL_SUPER_MARIO_BROS,0 ] ];
//		{ GAME_CHARACTER_SELECT.push( getArr(SuperMarioAllStars_GameSelect), [ SuperMarioBrosDeluxeGbs, GBS, 12, 85, 0 ] ); }
//		public static const GAME_TITLE_SCREEN:Array = [ [ SuperMarioBrosVsNsf, NSF,1,VOL_SUPER_MARIO_BROS,0 ] ];
		//public static const GAME_ENDING:String = GAME_PREFIX + "Ending" + SOUND_SUFFIX;
		//public static const GAME_SECONDS_LEFT_INTRO:Array = [ [ SuperMarioBrosNsf, NSF,
		//public static const GAME_STAR_POWER_FAST:String = GAME_PREFIX + "StarPower" + FAST_STR + SOUND_SUFFIX;

		public static const SFX_BillDieSnd:Array = addSfx( [ [ ContraNsf, NSF, 83, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillEnemyExplodeSnd:Array = addSfx( [ [ ContraNsf, NSF, 26, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillElectrecuteSnd:Array = addSfx( [ [ ContraNsf, NSF, 29, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillFlareSnd:Array = addSfx( [ [ ContraNsf, NSF, 17, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillGetItemSnd:Array = addSfx( [ [ ContraNsf, NSF, 32, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillLandSnd:Array = addSfx( [ [ ContraNsf, NSF, 5, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillLaserSnd:Array = addSfx( [ [ SuperCNsf, NSF, 14, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_BillMachineGunSnd:Array = addSfx( [ [ SuperCNsf, NSF, 13, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_BillNormalShotSnd:Array = addSfx( [ [ SuperCNsf, NSF, 12, VOL_SUPER_C_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillShotHitSnd:Array = addSfx( [ [ ContraNsf, NSF, 23, VOL_CONTRA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_BillSpreadSnd:Array = addSfx( [ [ SuperCNsf, NSF, 15, VOL_SUPER_C_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_GameBowserFallSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 33, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameBowserFireSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 24, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameBrickBreakSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 23, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_GameBridgeBreakSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 40, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameCanonSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 29, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_GameCharacterSelectCursorSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 40, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameCoinSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 26, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameFlagPoleSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 41, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameHitCeilingSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 36, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameItemAppearSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 27, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameKickShellSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 38, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameNewLifeSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 32, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GamePauseSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 22, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GamePipeSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 39, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_GamePointsSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 30, VOL_SUPER_MARIO_BROS_SFX, 0, BT_LOOPING_SFX, 120, 30, null ] ] );
		public static const SFX_GamePowerUpSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 31, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameSecondsLeftIntroSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 40, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameStompSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 37, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_GameVineSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 28, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_LinkBombExplodeSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 30, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_LinkBoomerangSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 27, VOL_ZELDA_1_SFX, 0, BT_LOOPING_SFX, 0, 0, null ] ] );
		public static const SFX_LinkDieSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 10, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkGetHeartSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 34, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkGetItemSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 24, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkHitEnemySnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 32, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkHitEnemyArmorSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 31, VOL_ZELDA_1_SFX - 35, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkIntroLevelSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 5, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_LinkJumpSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 25, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkKillEnemySnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 25, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkSetBombSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 36, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkSelectItemSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 21, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkShootArrowSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 35, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkTakeDamageSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 17, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkShootSwordSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 14, VOL_ZELDA_1_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_LinkStabSnd:Array = addSfx( [ [ Zelda1Nsf, NSF, 26, VOL_ZELDA_1_SFX + 8, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_MarioFireballSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 40, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MarioJumpBigSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 35, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MarioJumpSmallSnd:Array = addSfx( [ [ SuperMarioBrosVsNsf, NSF, 34, VOL_SUPER_MARIO_BROS_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_MegaManChargeKickSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 36, VOL_MEGA_MAN_5_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_MegaManChargeLoopSnd:Array = addSfx( [ [ MegaMan4Nsf, NSF, 40, VOL_MEGA_MAN_2_SFX, 0, BT_LOOPING_SFX, 150, 0, null ] ] );
		public static const SFX_MegaManChargeShotWeakSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 33, VOL_MEGA_MAN_5_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManChargeShotSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 34, VOL_MEGA_MAN_5_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_MegaManChargeStartSnd:Array = addSfx( [ [ MegaMan4Nsf, NSF, 35, VOL_MEGA_MAN_2_SFX, 0, BT_OVERRIDE, 0, 0, null ] ] );
		public static const SFX_MegaManChargeHeatStartSnd:Array = addSfx( [ [ MegaMan2Nsf, NSF, 54, VOL_MEGA_MAN_2_SFX, 0, BT_LOOPING_SFX, 1340, 1200, null ] ] );
		public static const SFX_MegaManChargeHeatLoopSnd:Array = addSfx( [ [ MegaMan2Nsf, NSF, 56, VOL_MEGA_MAN_2_SFX, 0, BT_LOOPING_SFX, 1340, 1200, null ] ] );
		public static const SFX_MegaManChargeStartSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 35, VOL_MEGA_MAN_5_SFX, 0, BT_LOOPING_SFX, 1340, 1200, null ] ] );
		public static const SFX_MegaManDeflectSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 40, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManDieSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 39, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManDieAltSnd:Array = addSfx( [ [ MegaMan2Nsf, NSF, 66, VOL_MEGA_MAN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManGetEnergySnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 50, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManGetEnergyLoopingSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 50, VOL_MEGA_MAN_6_SFX, 0, BT_LOOPING_SFX, 120, 30, null ] ] );
		public static const SFX_MegaManGetNewLifeSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 37, VOL_MEGA_MAN_5_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManHitEnemySnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 54, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManIceSlasherSnd:Array = addSfx( [ [ MegaManNsf, NSF, 43, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManIceSlasherHitSnd:Array = addSfx( [ [ MegaManNsf, NSF, 28, VOL_MEGA_MAN_6_SFX -20, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManLandSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 37, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManMagmaBazookaSnd:Array = addSfx( [ [ MegaMan5Nsf, NSF, 44, VOL_MEGA_MAN_5_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManMetalBladeSnd:Array = addSfx( [ [ MegaMan2Nsf, NSF, 36, VOL_MEGA_MAN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManPharaohShotSmallSnd:Array = addSfx( [ [ MegaMan4Nsf, NSF, 28, VOL_MEGA_MAN_4_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManPharaohShotBigSnd:Array = addSfx( [ [ MegaMan4Nsf, NSF, 63, VOL_MEGA_MAN_4_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManShootSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 36, VOL_MEGA_MAN_6_SFX - 10, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManTakeDamageSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 38, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManTeleportSnd:Array = addSfx( [ [ MegaMan6Nsf, NSF, 59, VOL_MEGA_MAN_6_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_MegaManWaterShieldExpandSnd:Array = addSfx( [ [ MegaMan3Nsf, NSF, 41, VOL_MEGA_MAN_3_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_PitShootSnd:Array = addSfx( [ [ KidIcarusNsf, NSF, 16, VOL_KID_ICARUS, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_PitJumpSnd:Array = addSfx( [ [ KidIcarusNsf, NSF, 19, VOL_KID_ICARUS + 100, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_RyuArtOfFireWheelSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 41, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuAttackArmorSnd:Array = addSfx( [ [ NinjaGaiden3Nsf, NSF, 61, VOL_NINJA_GAIDEN_3_SFX - 35, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuAttackSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 32, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuDamageEnemySnd:Array = addSfx( [ [ NinjaGaiden3Nsf, NSF, 67, VOL_NINJA_GAIDEN_3_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuFireDrgonBallSnd:Array = addSfx( [ [ NinjaGaiden2Nsf, NSF, 69, VOL_NINJA_GAIDEN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuGetPickupSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 36, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuGetScrollSnd:Array = addSfx( [ [ NinjaGaiden2Nsf, NSF, 49, VOL_NINJA_GAIDEN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuKillEnemySnd:Array = addSfx( [ [ NinjaGaiden2Nsf, NSF, 37, VOL_NINJA_GAIDEN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuJumpSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 33, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuJumpSlashSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 42, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuTakeDamageSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 35, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuThrowBigStarSnd:Array = addSfx( [ [ NinjaGaiden2Nsf, NSF, 43, VOL_NINJA_GAIDEN_2_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_RyuThrowSmallStarSnd:Array = addSfx( [ [ NinjaGaidenNsf, NSF, 39, VOL_NINJA_GAIDEN_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_SamusBombExplodeSnd:Array = addSfx( [ [ MetroidNsf, NSF, 15, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusBombSetSnd:Array = addSfx( [ [ MetroidNsf, NSF, 27, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusBulletProofSnd:Array = addSfx( [ [ MetroidNsf, NSF, 24, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusDieSnd:Array = addSfx( [ [ MetroidNsf, NSF, 34, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusGetEnergySnd:Array = addSfx( [ [ MetroidNsf, NSF, 25, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusGetMissileSnd:Array = addSfx( [ [ MetroidNsf, NSF, 26, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusHitEnemySnd:Array = addSfx( [ [ MetroidNsf, NSF, 21, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_SamusIceBeamSnd:Array = addSfx( [ [ MetroidNsf, NSF, 20, VOL_METROID_FDS, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusJumpSnd:Array = addSfx( [ [ MetroidNsf, NSF, 20, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusLandSnd:Array = addSfx( [ [ MetroidNsf, NSF, 14, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_SamusLongBeamSnd:Array = addSfx( [ [ MetroidNsf, NSF, 25, VOL_METROID_FDS, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusMorphBallSnd:Array = addSfx( [ [ MetroidNsf, NSF, 28, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusScrewAttackSnd:Array = addSfx( [ [ MetroidNsf, NSF, 17, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusShootMissileSnd:Array = addSfx( [ [ MetroidNsf, NSF, 16, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusShortBeamSnd:Array = addSfx( [ [ MetroidNsf, NSF, 23, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_SamusStepSnd:Array = addSfx( [ [ MetroidNsf, NSF, 0, VOL_METROID_FDS, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusTakeDamageSnd:Array = addSfx( [ [ MetroidNsf, NSF, 37, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SamusWaveBeamSnd:Array = addSfx( [ [ MetroidNsf, NSF, 19, VOL_METROID_SFX, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_SimonAxeSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 25, VOL_CASTLEVANIA_SFX, 0, BT_LOOPING_SFX, 0, 0, null ] ] );
		public static const SFX_SimonCrossSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 23, VOL_CASTLEVANIA_SFX, 0, BT_LOOPING_SFX, 0, 0, null ] ] );
		public static const SFX_SimonGetHeartSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 38, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonGetWeaponSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 40, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonHitEnemySnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 36, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonHitEnemyC2Snd:Array = addSfx( [ [ Castlevania2Nsf, NSF, 36, VOL_CASTLEVANIA_SFX + 15, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_SimonHitEnemyArmorSnd:Array = addSfx( [ [ Castlevania3Nsf, NSF, 245, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonHolyWaterExplodeSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 46, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonKillEnemySnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 36, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonKillEnemyC2Snd:Array = addSfx( [ [ Castlevania2Nsf, NSF, 38, VOL_CASTLEVANIA_SFX + 15, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonRosarySnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 52, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonStopWatchSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 42, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonTakeDamageSnd:Array = addSfx( [ [ Castlevania3Nsf, NSF, 70, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonThrowDaggerSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 24, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonWhipSnd:Array = addSfx( [ [ CastlevaniaNsf, NSF, 25, VOL_CASTLEVANIA_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SimonFlameWhipSnd:Array = addSfx( [ [ Castlevania2Nsf, NSF, 28, VOL_CASTLEVANIA_SFX + 30, 0, BT_SFX, 0, 0, null ] ] );

		public static const SFX_SophiaBulletExplodeSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 41, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaDieSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 75, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaGetPickupSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 45, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaHitEnemySnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 55, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaHoverSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 49, VOL_BLASTER_MASTER_SFX, 0, BT_LOOPING_SFX, 180, 0, null ] ] );
		public static const SFX_SophiaJumpSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 47, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaKillEnemySnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 30, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaLandSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 46, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaMissileSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 48, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaOpenSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 63, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaSelectWeaponSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 26, VOL_BLASTER_MASTER_SFX - 5, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaShootNormalSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 32, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaShootHyperSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 34, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaShootCrusherSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 35, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );
		public static const SFX_SophiaTakeDamageSnd:Array = addSfx( [ [ BlasterMasterSfxNsf, NSF, 61, VOL_BLASTER_MASTER_SFX, 0, BT_SFX, 0, 0, null ] ] );

//		public static const SFX_VicViperShootSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 17, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperLaserSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 19, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperArmoredSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 22, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperDamageBossSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 23, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperDamageEnemySnd:Array = addSfx( [ [ LifeForceNsf, NSF, 28, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperGetPowerUpSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 34, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperKillEnemySnd:Array = addSfx( [ [ LifeForceNsf, NSF, 35, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperUsePowerUpSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 36, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperDieSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 37, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );
//		public static const SFX_VicViperNewLifeSnd:Array = addSfx( [ [ LifeForceNsf, NSF, 42, VOL_LIFE_FORCE, 0, BT_SFX, 0, 0, null ] ] );

		/*
		// [ [ new nsfName, trackNum, volume, startTime, 100, 0 ] ];
		public static const BILL_BOSS_BGM:Array = [ [ ContraNsf, NSF, 67, VOL_CONTRA, 0 ] ];
		{ BILL_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ OperationCGbs, GBS, 11, 85, 0 ] ); }
		public static const BILL_BONUS_BGM:Array = [ [ ContraNsf, NSF, 55, VOL_CONTRA, 0 ] ];
		{ BILL_BONUS_BGM.push( getArr(Contra3_NestingInTheSands), [ ContraTheAlienWarsGbs, GBS, 3, 85, 0 ] ); }
		public static const BILL_CREDITS:Array = [ [ ContraNsf, NSF, 75, VOL_CONTRA, 0 ] ];
		//{ BILL_CREDITS.push( getArr(Contra3_), [ OperationCGbs, GBS, 13, 85, 0 ] ); }
		public static const BILL_DAY_BGM:Array = [ [ ContraNsf, NSF, 43, VOL_CONTRA, 0 ] ];
		{ BILL_DAY_BGM.push( getArr(Contra3_GroundZero), [ OperationCGbs, GBS, 2, 85, 0 ] ); }
		//public static const BILL_DIE:Array;
		public static const BILL_DUNGEON_BGM:Array = [ [ ContraNsf, NSF, 67, VOL_CONTRA, 0 ] ];
		{ BILL_DUNGEON_BGM.push( getArr(Contra3_Invasion), [ OperationCGbs, GBS, 14, 85, 0 ] ); }
		public static const BILL_GAME_OVER:Array = [ [ ContraNsf, NSF, 79, VOL_CONTRA, 0 ] ];
		{ BILL_GAME_OVER.push( getArr(Contra3_CasualtyOfWar), [ OperationCGbs, GBS, 8, 85, 0 ] ); }
		public static const BILL_INTRO:Array = [ [ ContraNsf, NSF, 39, VOL_CONTRA, 0 ] ];
		//{ BILL_INTRO.push( getArr(Contra3_), [ OperationCGbs, GBS, 10, 85, 0 ] ); }
		public static const BILL_INTRO_LEVEL:Array = [ [ ContraForceNsf, NSF, 2, VOL_CONTRA_FORCE, 0 ] ];
		{ BILL_INTRO_LEVEL.push( getArr(Contra3_PointOfEntry), [ OperationCGbs, GBS, 12, 85, 0 ] ); }
		public static const BILL_NIGHT_BGM:Array = [ [ ContraNsf, NSF, 51, VOL_CONTRA, 0 ] ];
		{ BILL_NIGHT_BGM.push( getArr(Contra3_NoMansLand), [ OperationCGbs, GBS, 6, 85, 0 ] ); }
		public static const BILL_STAR:Array = [ [ ContraForceNsf, NSF, 6, VOL_CONTRA_FORCE, 0 ] ];
		{ BILL_STAR.push( getArr(Contra3_RoadWarriors), [ OperationCGbs, GBS, 1, 85, 0 ] ); }
		public static const BILL_SECONDS_LEFT:Array = [ [ ContraForceNsf, NSF, 12, VOL_CONTRA_FORCE, 0 ] ];
		{ BILL_SECONDS_LEFT.push( getArr(Contra3_TheFinalGauntlet2), [ OperationCGbs, GBS, 3, 85, 0 ] ); }
		public static const BILL_UNDER_GROUND_BGM:Array = [ [ ContraNsf, NSF, 63, VOL_CONTRA, 0 ] ];
		{ BILL_UNDER_GROUND_BGM.push( getArr(Contra3_TearingUpTheTurnpike), [ OperationCGbs, GBS, 7, 85, 0 ] ); }
		public static const BILL_WATER_BGM:Array = [ [ ContraNsf, NSF, 47, VOL_CONTRA, 0 ] ];
		{ BILL_WATER_BGM.push( getArr(Contra3_NeoKobeSteelFactory), [ OperationCGbs, GBS, 4, 85, 0 ] ); }
		public static const BILL_WIN:Array = [ [ ContraNsf, NSF, 71, VOL_CONTRA, 0 ] ];
		{ BILL_WIN.push( getArr(Contra3_MissionAccomplished), [ OperationCGbs, GBS, 9, 85, 0 ] ); }
		public static const BILL_WIN_CASTLE:Array = [ [ ContraForceNsf, NSF, 16, VOL_CONTRA_FORCE, 0 ] ];
		{ BILL_WIN_CASTLE.push( getArr(Contra3_MissionAccomplished), [ ContraTheAlienWarsGbs, GBS, 4, 85, 0 ] ); }


		public static const LINK_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ LINK_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ ZeldaLinksAwakeningGbs, GBS, 25, 85, 0 ] ); }
		public static const LINK_BONUS_BGM:Array = [ [ Zelda2Nsf, NSF, 10, VOL_ZELDA_2, 0 ] ];
		{ LINK_BONUS_BGM.push( getArr(ZeldaLinkToThePast_GuessingGameHouse), [ ZeldaLinksAwakeningGbs, GBS, 48, 85, 0 ] ); }
		public static const LINK_CREDITS:Array = [ [ Zelda2Nsf, NSF, 21, VOL_ZELDA_2, 0 ] ];
		//{ LINK_CREDITS.push( getArr(ZeldaLinkToThePast_), [ ZeldaLinksAwakeningGbs, GBS, 96, 85, 0 ] ); }
		public static const LINK_DAY_BGM:Array = [ [ Zelda1Nsf, NSF, 3, VOL_ZELDA_1, 0 ] ];
		{ LINK_DAY_BGM.push( getArr(ZeldaLinkToThePast_HyruleField), [ ZeldaLinksAwakeningGbs, GBS, 5, 85, 0 ] ); }
		//public static const LINK_DIE:Array;
		//{ LINK_DAY_BGM.push( getArr(ZeldaLinkToThePast_HyruleField), [ ZeldaLinksAwakeningGbs, GBS, 5, 85, 0 ] ); }
		public static const LINK_DUNGEON_BGM:Array = [ [ Zelda1Nsf, NSF, 8, VOL_ZELDA_1, 0 ] ];
		{ LINK_DUNGEON_BGM.push( getArr(ZeldaLinkToThePast_LostAncientRuins), [ ZeldaLinksAwakeningGbs, GBS, 97, 85, 0 ] ); }
		public static const LINK_GAME_OVER:Array = [ [ Zelda1Nsf, NSF, 2, VOL_ZELDA_1, 0 ] ];
		//{ LINK_GAME_OVER.push( getArr(ZeldaLinkToThePast_ga), [ ZeldaLinksAwakeningGbs, GBS, 11, 85, 0 ] ); }
		public static const LINK_INTRO:Array = [ [ Zelda1Nsf, NSF, 5, VOL_ZELDA_1, 0 ] ];
		{ LINK_INTRO.push( getArr(ZeldaLinkToThePast_BeginningOfTheJourney), [ ZeldaLinksAwakeningGbs, GBS, 16, 85, 0 ] ); }
		//public static const LINK_INTRO_LEVEL:Array = [ [ ContraNsf, NSF, 1, 100, 0 ] ];
		//{ LINK_NIGHT_BGM.push( getArr(ZeldaLinkToThePast_DarkGoldenLand), [ ZeldaLinksAwakeningGbs, GBS, 3, 85, 0 ] ); }
		public static const LINK_NIGHT_BGM:Array = [ [ Zelda2Nsf, NSF, 2, VOL_ZELDA_2, 0 ] ];
		{ LINK_NIGHT_BGM.push( getArr(ZeldaLinkToThePast_DarkGoldenLand), [ ZeldaLinksAwakeningGbs, GBS, 6, 85, 0 ] ); }
		public static const LINK_SECONDS_LEFT:Array = [ [ Zelda2Nsf, NSF, 5, VOL_ZELDA_2, 0 ] ];
		{ LINK_SECONDS_LEFT.push( getArr(ZeldaLinkToThePast_SoldiersOfKakarikoVillage), [ ZeldaLinksAwakeningGbs, GBS, 80, 85, 0 ] ); }
		public static const LINK_STAR:Array = [ [ Zelda2Nsf, NSF, 15, VOL_ZELDA_2, 0 ] ];
		{ LINK_STAR.push( getArr(ZeldaLinkToThePast_TheSillyPinkRabbit), [ ZeldaLinksAwakeningGbs, GBS, 73, 85, 0 ] ); }
		public static const LINK_UNDER_GROUND_BGM:Array = [ [ Zelda2Nsf, NSF, 12, VOL_ZELDA_2, 0 ] ]; // Labrynth
		{ LINK_UNDER_GROUND_BGM.push( getArr(ZeldaLinkToThePast_DankDungeons), [ ZeldaLinksAwakeningGbs, GBS, 9, 85, 0 ] ); }
		public static const LINK_WATER_BGM:Array = [ [ Zelda1Nsf, NSF, 1, VOL_ZELDA_1, 0 ] ];
		{ LINK_WATER_BGM.push( getArr(ZeldaLinkToThePast_SealOfSevenMaidens), [ ZeldaLinksAwakeningGbs, GBS, 29, 85, 0 ] ); }
		public static const LINK_WIN:Array = [ [ Zelda2Nsf, NSF, 22, VOL_ZELDA_2, 0 ] ];
		{ LINK_WIN.push( getArr(ZeldaLinkToThePast_GreatVictory), [ ZeldaLinksAwakeningGbs, GBS, 37, 85, 0 ] ); }
		public static const LINK_WIN_CASTLE:Array = [ [ Zelda1Nsf, NSF, 6, VOL_ZELDA_1, 0 ] ];
		{ LINK_WIN_CASTLE.push( getArr(ZeldaLinkToThePast_PrincessZeldasRescue), [ ZeldaLinksAwakeningGbs, GBS, 49, 85, 0 ] ); }

		public static const LUIGI_BOSS_BGM:Array = [ [ SuperMarioBros3Nsf, NSF,24,VOL_SUPER_MARIO_BROS_3,0 ] ];
		{ LUIGI_BOSS_BGM.push( getArr(SuperMarioAllStars_TheEvilKingBowser), [ SuperMarioLandGbs, GBS, 9, 85, 0 ] ); }
		public static const LUIGI_BONUS_BGM:Array = [ [ SuperMarioBros3Nsf, NSF, 13, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_BONUS_BGM.push( getArr(SuperMarioAllStars_InTheClouds), [ SuperMarioLandGbs, GBS, 7, 85, 0 ] ); }
		public static const LUIGI_BONUS_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 28, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_BONUS_FAST.push( getArr(SuperMarioAllStars_InTheCloudsFast), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_CREDITS:Array = [ [ SuperMarioBros3Nsf, NSF, 25, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_CREDITS.push( getArr(SuperMarioAllStars_EndingSmb3), [ SuperMarioLandGbs, GBS, 18, 85, 0 ] ); }
		public static const LUIGI_DAY_BGM:Array = [ [ SuperMarioBros3Nsfe, NSFE, 9, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_DAY_BGM.push( getArr(SuperMarioAllStars_OverworldSmb3), [ SuperMarioLandGbs, GBS, 1, 85, 0 ] ); }
		public static const LUIGI_DAY_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 27, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_DAY_FAST.push( getArr(SuperMarioAllStars_OverworldFastSmb3), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_DIE:Array = [ [ SuperMarioBros3Nsf, NSF, 32, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_DIE.push( getArr(SuperMarioAllStars_PlayerDownSmb3), [ SuperMarioLandGbs, GBS, 11, 85, 0 ] ); }
		public static const LUIGI_DUNGEON_BGM:Array = [ [ SuperMarioBros3Nsf, NSF, 23, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_DUNGEON_BGM.push( getArr(SuperMarioAllStars_Fortress), [ SuperMarioLand2Gbs, GBS, 11, 85, 0 ] ); }
		public static const LUIGI_DUNGEON_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 36, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_DUNGEON_FAST.push( getArr(SuperMarioAllStars_FortressFast), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_GAME_OVER:Array = [ [ SuperMarioBrosVsNsf, NSF, 16, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_GAME_OVER.push( getArr(SuperMarioAllStars_GameOverSmb3), [ SuperMarioLandGbs, GBS, 8, 85, 0 ] ); }
		public static const LUIGI_INTRO:Array = [ [ SuperMarioBros3Nsf, NSF, 19, VOL_SUPER_MARIO_BROS_3, 0 ] ];
		//{ LUIGI_INTRO.push( getArr(SuperMarioAllStars_in), [ SuperMarioLandGbs, GBS, 8, 85, 0 ] ); }
		public static const LUIGI_INTRO_LEVEL:Array = [ [ SuperMarioBros3Nsf, NSF, 1, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_INTRO_LEVEL.push( getArr(SuperMarioAllStars_GrassLand), [ SuperMarioLand2Gbs, GBS, 6, 85, 0 ] ); }
		public static const LUIGI_NIGHT_BGM:Array = [ [ SuperMarioBros3Nsfe, NSFE, 34, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_NIGHT_BGM.push( getArr(SuperMarioAllStars_Airship), [ SuperMarioLand2Gbs, GBS, 1, 85, 0 ] ); }
		public static const LUIGI_STAR:Array = [ [ SuperMarioBros3Nsf, NSF, 14, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_STAR.push( getArr(SuperMarioAllStars_Invincible), [ SuperMarioLand2Gbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_STAR_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 31, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_STAR_FAST.push( getArr(SuperMarioAllStars_InvincibleFast), [ SuperMarioLand2Gbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_UNDER_GROUND_BGM:Array = [ [ SuperMarioBros3Nsf, NSF, 12, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_UNDER_GROUND_BGM.push( getArr(SuperMarioAllStars_UnderGroundSmb1), [ SuperMarioLandGbs, GBS, 2, 85, 0 ] ); }
		public static const LUIGI_UNDER_GROUND_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 30, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_UNDER_GROUND_FAST.push( getArr(SuperMarioAllStars_UndergroundFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_WATER_BGM:Array = [ [ SuperMarioBros3Nsf, NSF, 11, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_WATER_BGM.push( getArr(SuperMarioAllStars_SwimmingSmb3), [ SuperMarioLandGbs, GBS, 3, 85, 0 ] ); }
		public static const LUIGI_WATER_FAST:Array = [ [ SuperMarioBros3Nsfe, NSFE, 29, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ LUIGI_WATER_FAST.push( getArr(SuperMarioAllStars_SwimmingFastSmb3), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const LUIGI_WIN:Array = [ [ SuperMarioBros3Nsf, NSF, 27, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_WIN.push( getArr(SuperMarioAllStars_CourseClearSmb3), [ SuperMarioLandGbs, GBS, 12, 85, 0 ] ); }
		public static const LUIGI_WIN_CASTLE:Array = [ [ SuperMarioBros3Nsf, NSF, 29, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ LUIGI_WIN_CASTLE.push( getArr(SuperMarioAllStars_WorldClearSmb3), [ SuperMarioLandGbs, GBS, 16, 85, 0 ] ); }

		// Mario
		public static const MARIO_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ MARIO_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ SuperMarioLandGbs, GBS, 9, 85, 0 ] ); }
		public static const MARIO_BONUS_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 7, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_BONUS_BGM.push( getArr(SuperMarioAllStars_BonusSmb1), [ SuperMarioLandGbs, GBS, 7, 85, 0 ] ); }
		public static const MARIO_BONUS_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 14, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_BONUS_FAST.push( getArr(SuperMarioAllStars_BonusFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_CREDITS:Array = [ [ SuperMarioBrosVsNsf, NSF, 19, VOL_SUPER_MARIO_BROS, 0 ] ];
		//{ MARIO_CREDITS.push( getArr(SuperMarioAllStars_), [ SuperMarioLandGbs, GBS, 18, 85, 0 ] ); }
		public static const MARIO_DAY_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 1, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_DAY_BGM.push( getArr(SuperMarioAllStars_OverworldSmb1), [ SuperMarioLandGbs, GBS, 1, 85, 0 ] ); }
		public static const MARIO_DAY_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 10, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_DAY_FAST.push( getArr(SuperMarioAllStars_OverworldFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_DIE:Array = [ [ SuperMarioBrosVsNsf, NSF, 15, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_DIE.push( getArr(SuperMarioAllStars_DieSmb1), [ SuperMarioLandGbs, GBS, 11, 85, 0 ] ); }
		public static const MARIO_DUNGEON_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 5, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_DUNGEON_BGM.push( getArr(SuperMarioAllStars_CastleSmb1), [ SuperMarioLand2Gbs, GBS, 11, 85, 0 ] ); }
		public static const MARIO_DUNGEON_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 13, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_DUNGEON_FAST.push( getArr(SuperMarioAllStars_CastleFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_GAME_OVER:Array = [ [ SuperMarioBrosVsNsf, NSF, 16, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_GAME_OVER.push( getArr(SuperMarioAllStars_GameOverSmb1), [ SuperMarioLandGbs, GBS, 8, 85, 0 ] ); }
		public static const MARIO_INTRO:Array = [ [ SuperMarioBros3Nsf, NSF, 19, VOL_SUPER_MARIO_BROS_3, 0 ] ];
		//{ MARIO_INTRO.push( getArr(SuperMarioAllStars_in), [ SuperMarioLandGbs, GBS, 8, 85, 0 ] ); }
		public static const MARIO_INTRO_LEVEL:Array = [ [ SuperMarioBrosVsNsf, NSF, 8, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_INTRO_LEVEL.push( getArr(SuperMarioAllStars_IntroLevelSmb1), [ SuperMarioLand2Gbs, GBS, 6, 85, 0 ] ); }
		public static const MARIO_NIGHT_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 1, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_NIGHT_BGM.push( getArr(SuperMarioAllStars_OverworldSmb1), [ SuperMarioLand2Gbs, GBS, 1, 85, 0 ] ); }
		public static const MARIO_STAR:Array = [ [ SuperMarioBrosVsNsf, NSF, 7, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_STAR.push( getArr(SuperMarioAllStars_Invincible), [ SuperMarioLand2Gbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_STAR_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 14, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_STAR_FAST.push( getArr(SuperMarioAllStars_InvincibleFast), [ SuperMarioLand2Gbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_UNDER_GROUND_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 3, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_UNDER_GROUND_BGM.push( getArr(SuperMarioAllStars_UnderGroundSmb1), [ SuperMarioLandGbs, GBS, 2, 85, 0 ] ); }
		public static const MARIO_UNDER_GROUND_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 12, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_UNDER_GROUND_FAST.push( getArr(SuperMarioAllStars_UndergroundFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_WATER_BGM:Array = [ [ SuperMarioBrosVsNsf, NSF, 2, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_WATER_BGM.push( getArr(SuperMarioAllStars_WaterSmb1), [ SuperMarioLandGbs, GBS, 3, 85, 0 ] ); }
		public static const MARIO_WATER_FAST:Array = [ [ SuperMarioBrosVsNsf, NSF, 11, VOL_SUPER_MARIO_BROS, MARIO_SECONDS_LEFT_DELAY ] ];
		{ MARIO_WATER_FAST.push( getArr(SuperMarioAllStars_WaterFastSmb1), [ SuperMarioLandGbs, GBS, 4, 85, 0 ] ); }
		public static const MARIO_WIN:Array = [ [ SuperMarioBrosVsNsf, NSF, 4, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_WIN.push( getArr(SuperMarioAllStars_CourseClear), [ SuperMarioLandGbs, GBS, 12, 85, 0 ] ); }
		public static const MARIO_WIN_CASTLE:Array = [ [ SuperMarioBrosVsNsf, NSF, 6, VOL_SUPER_MARIO_BROS, 0 ] ];
		{ MARIO_WIN_CASTLE.push( getArr(SuperMarioAllStars_WinCastleSmb1), [ SuperMarioLandGbs, GBS, 16, 85, 0 ] ); }

		// Proto Man
		public static const PROTO_MAN_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ PROTO_MAN_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ MegaMan3Gbs, GBS, 4, 85, 0 ] ); }
		public static const PROTO_MAN_BONUS_BGM:Array = [ [ MegaMan2Nsf, NSF, 7, VOL_MEGA_MAN_2, 0 ] ]; // Air Man
		{ PROTO_MAN_BONUS_BGM.push( getArr(MegaManAndBass_Burnerman), [ MegaMan3Gbs, GBS, 12, 85, 0 ] ); }
		public static const PROTO_MAN_CREDITS:Array = [ [ MegaMan2Nsf, NSF, 24, VOL_MEGA_MAN_2, 0 ] ];
		//{ PROTO_MAN_CREDITS.push( getArr(MegaMan7_), [ MegaMan3Gbs, GBS, 20, 85, 0 ] ); }
		public static const PROTO_MAN_DAY_BGM:Array = [ [ MegaMan3Nsf, NSF, 2, VOL_MEGA_MAN_3, 0 ] ]; // [ [ MegaMan3Nsf, NSF, 1, 100, 0 ] ];
		{ PROTO_MAN_DAY_BGM.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const PROTO_MAN_DAY_BGM_LOOP:Array = [ [ MegaMan3Nsf, NSF, 1, VOL_MEGA_MAN_3, 0 ] ];
		{ PROTO_MAN_DAY_BGM_LOOP.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const PROTO_MAN_DIE:Array = [ [ MegaMan3Nsf, NSF, 25, VOL_MEGA_MAN_3, 0 ] ];
		//{ PROTO_MAN_DIE.push( getArr(MegaMan7_), [ MegaManGbs, GBS, 16, 85, 0 ] ); }
		public static const PROTO_MAN_DUNGEON_BGM:Array = [ [ MegaMan2Nsf, NSF, 14, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_DUNGEON_BGM.push( getArr(MegaMan7_TheHauntedGraveyard), [ MegaMan5Gbs, GBS, 8, 85, 0 ] ); }
		public static const PROTO_MAN_GAME_OVER:Array = [ [ MegaMan3Nsf, NSF, 16, VOL_MEGA_MAN_3, 0 ] ];
		{ PROTO_MAN_GAME_OVER.push( getArr(MegaManAndBass_GameOver), [ MegaManGbs, GBS, 14, 85, 0 ] ); }
		public static const PROTO_MAN_INTRO:Array = [ [ MegaMan2Nsf, NSF, 5, VOL_MEGA_MAN_2, 3100 ] ];
		{ PROTO_MAN_INTRO.push( getArr(MegaMan7_StageStart), [ MegaMan3Gbs, GBS, 2, 85, 0 ] ); }
		public static const PROTO_MAN_INTRO_LEVEL:Array = [ [ MegaManNsf, NSF, 1, VOL_MEGA_MAN, 0 ] ];
		{ PROTO_MAN_INTRO_LEVEL.push( getArr(MegaMan7_EnterTheGraveyard), [ MegaManGbs, GBS, 3, 85, 0 ] ); }
		public static const PROTO_MAN_NIGHT_BGM:Array = [ [ MegaMan2Nsf, NSF, 19, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_NIGHT_BGM.push( getArr(MegaMan7_RobotMuseum), [ MegaMan3Gbs, GBS, 15, 85, 0 ] ); }
		public static const PROTO_MAN_SECONDS_LEFT:Array = [ [ MegaMan3Nsf, NSF, 15, VOL_MEGA_MAN_3, 0 ] ];
		{ PROTO_MAN_SECONDS_LEFT.push( getArr(MegaManAndBass_MajorBossBattle), [ MegaMan4Gbs, GBS, 22, 85, 0 ] ); }
		public static const PROTO_MAN_STAR:Array = [ [ MegaMan2Nsf, NSF, 2, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_STAR.push( getArr(MegaMan7_NewWeapon), [ MegaMan4Gbs, GBS, 25, 85, 0 ] ); }
		public static const PROTO_MAN_UNDER_GROUND_BGM:Array = [ [ MegaMan2Nsf, NSF, 11, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_UNDER_GROUND_BGM.push( getArr(MegaMan7_Shademan), [ MegaMan5Gbs, GBS, 3, 85, 0 ] ); }
		public static const PROTO_MAN_WATER_BGM:Array = [ [ MegaMan2Nsf, NSF, 8, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_WATER_BGM.push( getArr(MegaManAndBass_Pirateman), [ MegaMan4Gbs, GBS, 7, 85, 0 ] ); }
		public static const PROTO_MAN_WIN:Array = [ [ MegaMan2Nsf, NSF, 15, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_WIN.push( getArr(MegaMan7_StageClear), [ MegaMan3Gbs, GBS, 11, 85, 0 ] ); }
		public static const PROTO_MAN_WIN_CASTLE:Array = [ [ MegaMan2Nsf, NSF, 21, VOL_MEGA_MAN_2, 0 ] ];
		{ PROTO_MAN_WIN_CASTLE.push( getArr(MegaMan7_RemainsOfTheLab), [ MegaMan3Gbs, GBS, 9, 85, 0 ] ); }


		public static const BASS_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ BASS_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ MegaMan3Gbs, GBS, 4, 85, 0 ] ); }
		public static const BASS_BONUS_BGM:Array = [ [ MegaMan2Nsf, NSF, 7, VOL_MEGA_MAN_2, 0 ] ]; // Air Man
		{ BASS_BONUS_BGM.push( getArr(MegaManAndBass_Burnerman), [ MegaMan3Gbs, GBS, 12, 85, 0 ] ); }
		public static const BASS_CREDITS:Array = [ [ MegaMan2Nsf, NSF, 24, VOL_MEGA_MAN_2, 0 ] ];
		//{ BASS_CREDITS.push( getArr(MegaMan7_), [ MegaMan3Gbs, GBS, 20, 85, 0 ] ); }
		public static const BASS_DAY_BGM:Array = [ [ MegaMan3Nsf, NSF, 2, VOL_MEGA_MAN_3, 0 ] ]; // [ [ MegaMan3Nsf, NSF, 1, 100, 0 ] ];
		{ BASS_DAY_BGM.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const BASS_DAY_BGM_LOOP:Array = [ [ MegaMan3Nsf, NSF, 1, VOL_MEGA_MAN_3, 0 ] ];
		{ BASS_DAY_BGM_LOOP.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const BASS_DIE:Array = [ [ MegaMan3Nsf, NSF, 25, VOL_MEGA_MAN_3, 0 ] ];
		//{ BASS_DIE.push( getArr(MegaMan7_), [ MegaManGbs, GBS, 16, 85, 0 ] ); }
		public static const BASS_DUNGEON_BGM:Array = [ [ MegaMan2Nsf, NSF, 14, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_DUNGEON_BGM.push( getArr(MegaMan7_TheHauntedGraveyard), [ MegaMan5Gbs, GBS, 8, 85, 0 ] ); }
		public static const BASS_GAME_OVER:Array = [ [ MegaMan3Nsf, NSF, 16, VOL_MEGA_MAN_3, 0 ] ];
		{ BASS_GAME_OVER.push( getArr(MegaManAndBass_GameOver), [ MegaManGbs, GBS, 14, 85, 0 ] ); }
		public static const BASS_INTRO:Array = [ [ MegaMan2Nsf, NSF, 5, VOL_MEGA_MAN_2, 3100 ] ];
		{ BASS_INTRO.push( getArr(MegaMan7_StageStart), [ MegaMan3Gbs, GBS, 2, 85, 0 ] ); }
		public static const BASS_INTRO_LEVEL:Array = [ [ MegaManNsf, NSF, 1, VOL_MEGA_MAN, 0 ] ];
		{ BASS_INTRO_LEVEL.push( getArr(MegaMan7_EnterTheGraveyard), [ MegaManGbs, GBS, 3, 85, 0 ] ); }
		public static const BASS_NIGHT_BGM:Array = [ [ MegaMan2Nsf, NSF, 19, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_NIGHT_BGM.push( getArr(MegaMan7_RobotMuseum), [ MegaMan3Gbs, GBS, 15, 85, 0 ] ); }
		public static const BASS_SECONDS_LEFT:Array = [ [ MegaMan3Nsf, NSF, 15, VOL_MEGA_MAN_3, 0 ] ];
		{ BASS_SECONDS_LEFT.push( getArr(MegaManAndBass_MajorBossBattle), [ MegaMan4Gbs, GBS, 22, 85, 0 ] ); }
		public static const BASS_STAR:Array = [ [ MegaMan2Nsf, NSF, 2, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_STAR.push( getArr(MegaMan7_NewWeapon), [ MegaMan4Gbs, GBS, 25, 85, 0 ] ); }
		public static const BASS_UNDER_GROUND_BGM:Array = [ [ MegaMan2Nsf, NSF, 11, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_UNDER_GROUND_BGM.push( getArr(MegaMan7_Shademan), [ MegaMan5Gbs, GBS, 3, 85, 0 ] ); }
		public static const BASS_WATER_BGM:Array = [ [ MegaMan2Nsf, NSF, 8, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_WATER_BGM.push( getArr(MegaManAndBass_Pirateman), [ MegaMan4Gbs, GBS, 7, 85, 0 ] ); }
		public static const BASS_WIN:Array = [ [ MegaMan2Nsf, NSF, 15, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_WIN.push( getArr(MegaMan7_StageClear), [ MegaMan3Gbs, GBS, 11, 85, 0 ] ); }
		public static const BASS_WIN_CASTLE:Array = [ [ MegaMan2Nsf, NSF, 21, VOL_MEGA_MAN_2, 0 ] ];
		{ BASS_WIN_CASTLE.push( getArr(MegaMan7_RemainsOfTheLab), [ MegaMan3Gbs, GBS, 9, 85, 0 ] ); }


		public static const MEGA_MAN_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ MEGA_MAN_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ MegaMan3Gbs, GBS, 4, 85, 0 ] ); }
		public static const MEGA_MAN_BONUS_BGM:Array = [ [ MegaMan2Nsf, NSF, 7, VOL_MEGA_MAN_2, 0 ] ]; // Air Man
		{ MEGA_MAN_BONUS_BGM.push( getArr(MegaManAndBass_Burnerman), [ MegaMan3Gbs, GBS, 12, 85, 0 ] ); }
		public static const MEGA_MAN_CREDITS:Array = [ [ MegaMan2Nsf, NSF, 20, VOL_MEGA_MAN_2, 0 ] ];
		//{ MEGA_MAN_CREDITS.push( getArr(MegaMan7_), [ MegaMan3Gbs, GBS, 20, 85, 0 ] ); }
		public static const MEGA_MAN_DAY_BGM:Array = [ [ MegaMan3Nsf, NSF, 2, VOL_MEGA_MAN_3, 0 ] ]; // [ [ MegaMan3Nsf, NSF, 1, 100, 0 ] ];
		{ MEGA_MAN_DAY_BGM.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const MEGA_MAN_DAY_BGM_LOOP:Array = [ [ MegaMan3Nsf, NSF, 1, VOL_MEGA_MAN_3, 0 ] ];
		{ MEGA_MAN_DAY_BGM_LOOP.push( getArr(MegaManAndBass_Tenguman), [ MegaMan5Gbs, GBS, 4, 85, 0 ] ); }
		public static const MEGA_MAN_DIE:Array = [ [ MegaMan3Nsf, NSF, 25, VOL_MEGA_MAN_3, 0 ] ];
		//{ MEGA_MAN_DIE.push( getArr(MegaMan7_), [ MegaManGbs, GBS, 16, 85, 0 ] ); }
		public static const MEGA_MAN_DUNGEON_BGM:Array = [ [ MegaMan2Nsf, NSF, 12, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_DUNGEON_BGM.push( getArr(MegaMan7_TheHauntedGraveyard), [ MegaMan5Gbs, GBS, 8, 85, 0 ] ); }
		public static const MEGA_MAN_GAME_OVER:Array = [ [ MegaMan3Nsf, NSF, 16, VOL_MEGA_MAN_3, 0 ] ];
		{ MEGA_MAN_GAME_OVER.push( getArr(MegaManAndBass_GameOver), [ MegaManGbs, GBS, 14, 85, 0 ] ); }
		public static const MEGA_MAN_INTRO:Array = [ [ MegaMan2Nsf, NSF, 5, VOL_MEGA_MAN_2, 3100 ] ];
		{ MEGA_MAN_INTRO.push( getArr(MegaMan7_StageStart), [ MegaMan3Gbs, GBS, 2, 85, 0 ] ); }
		public static const MEGA_MAN_INTRO_LEVEL:Array = [ [ MegaManNsf, NSF, 2, VOL_MEGA_MAN, 0 ] ];
		{ MEGA_MAN_INTRO_LEVEL.push( getArr(MegaMan7_EnterTheGraveyard), [ MegaManGbs, GBS, 3, 85, 0 ] ); }
		public static const MEGA_MAN_NIGHT_BGM:Array = [ [ MegaMan2Nsf, NSF, 9, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_NIGHT_BGM.push( getArr(MegaMan7_RobotMuseum), [ MegaMan3Gbs, GBS, 15, 85, 0 ] ); }
		public static const MEGA_MAN_SECONDS_LEFT:Array = [ [ MegaMan3Nsf, NSF, 15, VOL_MEGA_MAN_3, 0 ] ];
		{ MEGA_MAN_SECONDS_LEFT.push( getArr(MegaManAndBass_MajorBossBattle), [ MegaMan4Gbs, GBS, 22, 85, 0 ] ); }
		public static const MEGA_MAN_STAR:Array = [ [ MegaMan2Nsf, NSF, 14, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_STAR.push( getArr(MegaMan7_NewWeapon), [ MegaMan4Gbs, GBS, 25, 85, 0 ] ); }
		public static const MEGA_MAN_UNDER_GROUND_BGM:Array = [ [ MegaMan2Nsf, NSF, 1, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_UNDER_GROUND_BGM.push( getArr(MegaMan7_Shademan), [ MegaMan5Gbs, GBS, 3, 85, 0 ] ); }
		public static const MEGA_MAN_WATER_BGM:Array = [ [ MegaMan2Nsf, NSF, 8, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_WATER_BGM.push( getArr(MegaManAndBass_Pirateman), [ MegaMan4Gbs, GBS, 7, 85, 0 ] ); }
		public static const MEGA_MAN_WIN:Array = [ [ MegaMan2Nsf, NSF, 22, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_WIN.push( getArr(MegaMan7_StageClear), [ MegaMan3Gbs, GBS, 11, 85, 0 ] ); }
		public static const MEGA_MAN_WIN_CASTLE:Array = [ [ MegaMan2Nsf, NSF, 23, VOL_MEGA_MAN_2, 0 ] ];
		{ MEGA_MAN_WIN_CASTLE.push( getArr(MegaMan7_RemainsOfTheLab), [ MegaMan3Gbs, GBS, 9, 85, 0 ] ); }


		public static const RYU_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ RYU_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ NinjaGaidenShadowGbs, GBS, 8, 85, 0 ] ); }
		public static const RYU_BONUS_BGM:Array = [ [ NinjaGaiden2Nsf, NSF, 6, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_BONUS_BGM.push( getArr(NinjaGaidenTrilogy_TheMazeOfDarkness), [ NinjaGaidenShadowGbs, GBS, 7, 85, 0 ] ); }
		public static const RYU_CREDITS:Array = [ [ NinjaGaidenNsf, NSF, 25, VOL_NINJA_GAIDEN, 0 ] ];
		//{ RYU_CREDITS.push( getArr(NinjaGaidenTrilogy_), [ NinjaGaidenShadowGbs, GBS, 11, 85, 0 ] ); }
		public static const RYU_DUNGEON_BGM:Array = [ [ NinjaGaidenNsf, NSF, 5, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_DUNGEON_BGM.push( getArr(NinjaGaidenTrilogy_BossFight), [ NinjaGaidenShadowGbs, GBS, 6, 85, 0 ] ); }
		public static const RYU_DAY_BGM:Array = [ [ NinjaGaidenNsf, NSF, 15, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_DAY_BGM.push( getArr(NinjaGaidenTrilogy_Mine), [ NinjaGaidenShadowGbs, GBS, 5, 85, 0 ] ); }
		public static const RYU_DIE:Array = [ [ NinjaGaidenNsf, NSF, 26, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_DIE.push( getArr(NinjaGaidenTrilogy_Death), [ NinjaGaidenShadowGbs, GBS, 11, 85, 0 ] ); }
		public static const RYU_GAME_OVER:Array = [ [ NinjaGaiden2Nsf, NSF, 31, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_GAME_OVER.push( getArr(NinjaGaidenTrilogy_Death), [ NinjaGaidenShadowGbs, GBS, 11, 85, 0 ] ); }
		public static const RYU_INTRO:Array = [ [ NinjaGaidenNsf, NSF, 3, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_INTRO.push( getArr(NinjaGaidenTrilogy_Act), [ NinjaGaidenShadowGbs, GBS, 2, 85, 0 ] ); }
		public static const RYU_INTRO_LEVEL:Array = [ [ NinjaGaidenNsf, NSF, 7, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_INTRO_LEVEL.push( getArr(NinjaGaidenTrilogy_Prison), [ NinjaGaidenShadowGbs, GBS, 1, 85, 0 ] ); }
		public static const RYU_NIGHT_BGM:Array = [ [ NinjaGaiden2Nsf, NSF, 22, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_NIGHT_BGM.push( getArr(NinjaGaidenTrilogy_Rooftop), [ NinjaGaidenShadowGbs, GBS, 4, 85, 0 ] ); }
		public static const RYU_SECONDS_LEFT:Array = [ [ NinjaGaiden2Nsf, NSF, 2, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_SECONDS_LEFT.push( getArr(NinjaGaidenTrilogy_LongTrain), [ NinjaGaidenShadowGbs, GBS, 9, 85, 0 ] ); }
		public static const RYU_STAR:Array = [ [ NinjaGaidenNsf, NSF, 10, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_STAR.push( getArr(NinjaGaidenTrilogy_Running), [ NinjaGaidenShadowGbs, GBS, 13, 85, 0 ] ); }
		public static const RYU_UNDER_GROUND_BGM:Array = [ [ NinjaGaiden2Nsf, NSF, 1, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_UNDER_GROUND_BGM.push( getArr(NinjaGaidenTrilogy_Fortress), [ NinjaGaidenShadowGbs, GBS, 3, 85, 0 ] ); }
		public static const RYU_WATER_BGM:Array = [ [ NinjaGaiden2Nsf, NSF, 3, VOL_NINJA_GAIDEN_2, 0 ] ];
		{ RYU_WATER_BGM.push( getArr(NinjaGaidenTrilogy_Mountain), [ NinjaGaidenShadowGbs, GBS, 7, 85, 0 ] ); }
		public static const RYU_WIN:Array = [ [ NinjaGaidenNsf, NSF, 28, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_WIN.push( getArr(NinjaGaidenTrilogy_AfterHim), [ NinjaGaidenShadowGbs, GBS, 10, 85, 0 ] ); }
		public static const RYU_WIN_CASTLE:Array = [ [ NinjaGaidenNsf, NSF, 11, VOL_NINJA_GAIDEN, 0 ] ];
		{ RYU_WIN_CASTLE.push( getArr(NinjaGaidenTrilogy_Sorrow), [ NinjaGaidenShadowGbs, GBS, 12, 85, 0 ] ); }


		public static const SAMUS_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ SAMUS_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ Metroid2ReturnOfSamusGbs, GBS, 11, 85, 0 ] ); }
		public static const SAMUS_BONUS_BGM:Array = [ [ MetroidNsf, NSF, 10, VOL_METROID, 0 ] ];
		{ SAMUS_BONUS_BGM.push( getArr(SuperMetroid_ItemRoom), [ Metroid2ReturnOfSamusGbs, GBS, 13, 85, 0 ] ); }
		public static const SAMUS_CREDITS:Array = [ [ MetroidNsf, NSF, 2, VOL_METROID, 0 ] ];
		//{ SAMUS_BONUS_BGM.push( getArr(SuperMetroid_), [ Metroid2ReturnOfSamusGbs, GBS, 19, 85, 0 ] ); }
		//public static const SAMUS_DIE:Array;
		public static const SAMUS_DAY_BGM:Array = [ [ MetroidNsf, NSF, 5, VOL_METROID, 0 ] ];
		{ SAMUS_DAY_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ Metroid2ReturnOfSamusGbs, GBS, 3, 85, 0 ] ); }
		public static const SAMUS_DUNGEON_BGM:Array = [ [ MetroidNsf, NSF, 11, VOL_METROID, 0 ] ];
		{ SAMUS_DUNGEON_BGM.push( getArr(SuperMetroid_Tourian), [ Metroid2ReturnOfSamusGbs, GBS, 4, 85, 0 ] ); }
		public static const SAMUS_GAME_OVER:Array = [ [ MetroidNsf, NSF, 1, VOL_METROID, 0 ] ];
		{ SAMUS_GAME_OVER.push( getArr(SuperMetroid_Continue), [ Metroid2ReturnOfSamusGbs, GBS, 3, 85, 0 ] ); }
		public static const SAMUS_INTRO:Array = [ [ MetroidNsf, NSF, 4, VOL_METROID, 0 ] ];
		{ SAMUS_INTRO.push( getArr(SuperMetroid_SamusAppearanceFanfare), [ Metroid2ReturnOfSamusGbs, GBS, 2, 85, 0 ] ); }
		public static const SAMUS_INTRO_LEVEL:Array = [ [ MetroidNsf, NSF, 6, VOL_METROID, 0 ] ];
		{ SAMUS_INTRO_LEVEL.push( getArr(SuperMetroid_Tension), [ Metroid2ReturnOfSamusGbs, GBS, 14, 85, 0 ] ); }
		public static const SAMUS_NIGHT_BGM:Array = [ [ MetroidNsf, NSF, 5, VOL_METROID, 0 ] ];
		{ SAMUS_NIGHT_BGM.push( getArr(SuperMetroid_NorfairAncientRuins), [ Metroid2ReturnOfSamusGbs, GBS, 3, 85, 0 ] ); }
		public static const SAMUS_SECONDS_LEFT:Array = [ [ MetroidNsf, NSF, 7, VOL_METROID, 0 ] ];
		{ SAMUS_SECONDS_LEFT.push( getArr(SuperMetroid_Escape), [ Metroid2ReturnOfSamusGbs, GBS, 16, 85, 0 ] ); }
		public static const SAMUS_STAR:Array = [ [ MetroidNsf, NSF, 1, VOL_METROID, 0 ] ];
		{ SAMUS_STAR.push( getArr(SuperMetroid_SuperMetroidTheme), [ Metroid2ReturnOfSamusGbs, GBS, 19, 85, 0 ] ); }
		public static const SAMUS_UNDER_GROUND_BGM:Array = [ [ MetroidNsf, NSF, 9, VOL_METROID, 0 ] ];
		{ SAMUS_UNDER_GROUND_BGM.push( getArr(SuperMetroid_CriteriaSpacePirates), [ Metroid2ReturnOfSamusGbs, GBS, 4, 85, 0 ] ); }
		public static const SAMUS_WATER_BGM:Array = [ [ MetroidNsf, NSF, 8, VOL_METROID, 0 ] ];
		{ SAMUS_WATER_BGM.push( getArr(SuperMetroid_MaridiaRockyUnderwater), [ Metroid2ReturnOfSamusGbs, GBS, 13, 85, 0 ] ); }
		public static const SAMUS_WIN:Array = [ [ MetroidNsf, NSF, 3, VOL_METROID, 0 ] ];
		{ SAMUS_WIN.push( getArr(SuperMetroid_ItemFanfare), [ Metroid2ReturnOfSamusGbs, GBS, 9, 85, 0 ] ); }
		public static const SAMUS_WIN_CASTLE:Array = [ [ MetroidNsf, NSF, 10, VOL_METROID, 0 ] ];
		{ SAMUS_WIN_CASTLE.push( getArr(SuperMetroid_SamusTheme), [ Metroid2ReturnOfSamusGbs, GBS, 18, 85, 0 ] ); }


		public static const SIMON_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		{ SIMON_BOSS_BGM.push( getArr(Contra3_NestingInTheSands), [ CastlevaniaAdventureGbs, GBS, 4, 85, 0 ] ); }
		public static const SIMON_BONUS_BGM:Array = [ [ Castlevania2Nsf, NSF, 4, VOL_CASTLEVANIA_2, 0 ] ];
		{ SIMON_BONUS_BGM.push( getArr(SuperCastlevania4_SecretRoom), [ CastlevaniaAdventureGbs, GBS, 5, 85, 0 ] ); }
		public static const SIMON_CREDITS:Array = [ [ CastlevaniaNsf, NSF, 11, VOL_CASTLEVANIA, 0 ] ];
		//{ SIMON_BONUS_BGM.push( getArr(SuperCastlevania4_SecretRoom), [ CastlevaniaLegendsGbs, GBS, 21, 85, 0 ] ); }
		public static const SIMON_DUNGEON_BGM:Array = [ [ CastlevaniaNsf, NSF, 8, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_DUNGEON_BGM.push( getArr(SuperCastlevania4_InTheCastle), [ CastlevaniaAdventureGbs, GBS, 6, 85, 0 ] ); }
		public static const SIMON_DAY_BGM:Array = [ [ CastlevaniaNsf, NSF, 2, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_DAY_BGM.push( getArr(SuperCastlevania4_VampireKiller), [ CastlevaniaAdventureGbs, GBS, 1, 85, 0 ] ); }
		public static const SIMON_DIE:Array = [ [ CastlevaniaNsf, NSF, 14, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_DIE.push( getArr(SuperCastlevania4_DeathOfSimon), [ CastlevaniaAdventureGbs, GBS, 2, 85, 0 ] ); }
		public static const SIMON_GAME_OVER:Array = [ [ CastlevaniaNsf, NSF, 15, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_GAME_OVER.push( getArr(SuperCastlevania4_GameOver), [ CastlevaniaAdventureGbs, GBS, 3, 85, 0 ] ); }
		public static const SIMON_INTRO:Array = [ [ CastlevaniaNsf, NSF, 1, VOL_CASTLEVANIA, 2250 ] ];
		{ SIMON_INTRO.push( getArr(SuperCastlevania4_Beginning), [ CastlevaniaAdventureGbs, GBS, 13, 85, 0 ] ); }
		public static const SIMON_INTRO_LEVEL:Array = [ [ Castlevania2Nsf, NSF, 8, VOL_CASTLEVANIA_2, 0 ] ];
		{ SIMON_INTRO_LEVEL.push( getArr(SuperCastlevania4_DraculasTheme), [ CastlevaniaAdventureGbs, GBS, 9, 85, 0 ] ); }
		public static const SIMON_NIGHT_BGM:Array = [ [ Castlevania2Nsf, NSF, 3, VOL_CASTLEVANIA_2, 0 ] ];
		{ SIMON_NIGHT_BGM.push( getArr(SuperCastlevania4_ThemeOfSimon), [ CastlevaniaLegendsGbs, GBS, 4, 85, 0 ] ); }
		public static const SIMON_SECONDS_LEFT:Array = [ [ Castlevania2Nsf, NSF, 6, VOL_CASTLEVANIA_2, 0 ] ];
		{ SIMON_SECONDS_LEFT.push( getArr(CastlevaniaDraculaX_Den), [ CastlevaniaAdventureGbs, GBS, 12, 85, 0 ] ); }
		public static const SIMON_UNDER_GROUND_BGM:Array = [ [ Castlevania2Nsf, NSF, 2, VOL_CASTLEVANIA_2, 0 ] ]; //Bloody Tears
		{ SIMON_UNDER_GROUND_BGM.push( getArr(SuperCastlevania4_BloodyTears), [ CastlevaniaAdventureGbs, GBS, 7, 85, 0 ] ); }
		public static const SIMON_WATER_BGM:Array = [ [ Castlevania2Nsf, NSF, 1, VOL_CASTLEVANIA_2, 0 ] ];
		{ SIMON_WATER_BGM.push( getArr(SuperCastlevania4_TheCave), [ CastlevaniaLegendsGbs, GBS, 16, 85, 0 ] ); }
		public static const SIMON_STAR:Array = [ [ CastlevaniaNsf, NSF, 9, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_STAR.push( getArr(CastlevaniaDraculaX_Bloodlines), [ CastlevaniaLegendsGbs, GBS, 15, 85, 0 ] ); }
		public static const SIMON_WIN:Array = [ [ CastlevaniaNsf, NSF, 12, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_WIN.push( getArr(SuperCastlevania4_StageClear), [ CastlevaniaAdventureGbs, GBS, 10, 85, 0 ] ); }
		public static const SIMON_WIN_CASTLE:Array = [ [ CastlevaniaNsf, NSF, 13, VOL_CASTLEVANIA, 0 ] ];
		{ SIMON_WIN_CASTLE.push( getArr(CastlevaniaDraculaX_Rescued), [ CastlevaniaLegendsGbs, GBS, 3, 85, 0 ] ); }


		public static const SOPHIA_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		//{ SOPHIA_BOSS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ Metroid2ReturnOfSamusGbs, GBS, 10, 85, 0 ] ); }
		public static const SOPHIA_BONUS_BGM:Array = [ [ BlasterMasterNsf, NSF, 5, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_BONUS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 3, 85, 0 ] ); }
		public static const SOPHIA_CREDITS:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_CREDITS.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }
		public static const SOPHIA_DUNGEON_BGM:Array = [ [ BlasterMasterNsf, NSF, 6, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_DUNGEON_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 4, 85, 0 ] ); }
		public static const SOPHIA_DAY_BGM:Array = [ [ BlasterMasterNsf, NSF, 3, VOL_BLASTER_MASTER, 0 ] ]; //7330
		{ SOPHIA_DAY_BGM.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const SOPHIA_DAY_BGM_LOOP:Array = [ [ BlasterMasterNsf, NSF, 1, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_DAY_BGM_LOOP.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		//public static const SOPHIA_DIE:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		public static const SOPHIA_GAME_OVER:Array = [ [ BlasterMasterNsf, NSF, 17, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_GAME_OVER.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 14, 85, 0 ] ); }
		public static const SOPHIA_INTRO:Array = [ [ BlasterMasterNsf, NSF, 3, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_INTRO.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const SOPHIA_INTRO_LEVEL:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_INTRO_LEVEL.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 8, 85, 0 ] ); }
		public static const SOPHIA_NIGHT_BGM:Array = [ [ BlasterMasterNsf, NSF, 8, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_NIGHT_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 6, 85, 0 ] ); }
		public static const SOPHIA_SECONDS_LEFT:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_SECONDS_LEFT.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 11, 85, 0 ] ); }
		public static const SOPHIA_UNDER_GROUND_BGM:Array = [ [ BlasterMasterNsf, NSF, 4, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_UNDER_GROUND_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 2, 85, 0 ] ); }
		public static const SOPHIA_WATER_BGM:Array = [ [ BlasterMasterNsf, NSF, 7, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_WATER_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 5, 85, 0 ] ); }
		public static const SOPHIA_STAR:Array = [ [ BlasterMasterNsf, NSF, 13, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_STAR.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 9, 85, 0 ] ); }
		public static const SOPHIA_WIN:Array = [ [ BlasterMasterNsf, NSF, 15, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_WIN.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 13, 85, 0 ] ); }
		public static const SOPHIA_WIN_CASTLE:Array = [ [ BlasterMasterNsf, NSF, 16, VOL_BLASTER_MASTER, 0 ] ];
		{ SOPHIA_WIN_CASTLE.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }


		public static const VIC_VIPER_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		//{ VIC_VIPER_BOSS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ Metroid2ReturnOfSamusGbs, GBS, 10, 85, 0 ] ); }
		public static const VIC_VIPER_BONUS_BGM:Array = [ [ BlasterMasterNsf, NSF, 5, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_BONUS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 3, 85, 0 ] ); }
		public static const VIC_VIPER_CREDITS:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_CREDITS.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }
		public static const VIC_VIPER_DUNGEON_BGM:Array = [ [ LifeForceNsf, NSF, 8, VOL_LIFE_FORCE, 0 ] ];
		{ VIC_VIPER_DUNGEON_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 4, 85, 0 ] ); }
		public static const VIC_VIPER_DAY_BGM:Array = [ [ LifeForceNsf, NSF, 1, VOL_LIFE_FORCE, 0 ] ]; //7330
		{ VIC_VIPER_DAY_BGM.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const VIC_VIPER_DAY_BGM_LOOP:Array = [ [ BlasterMasterNsf, NSF, 1, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_DAY_BGM_LOOP.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		//public static const VIC_VIPER_DIE:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		public static const VIC_VIPER_GAME_OVER:Array = [ [ BlasterMasterNsf, NSF, 17, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_GAME_OVER.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 14, 85, 0 ] ); }
		public static const VIC_VIPER_INTRO:Array = [ [ BlasterMasterNsf, NSF, 3, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_INTRO.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const VIC_VIPER_INTRO_LEVEL:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_INTRO_LEVEL.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 8, 85, 0 ] ); }
		public static const VIC_VIPER_NIGHT_BGM:Array = [ [ BlasterMasterNsf, NSF, 8, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_NIGHT_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 6, 85, 0 ] ); }
		public static const VIC_VIPER_SECONDS_LEFT:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_SECONDS_LEFT.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 11, 85, 0 ] ); }
		public static const VIC_VIPER_UNDER_GROUND_BGM:Array = [ [ BlasterMasterNsf, NSF, 4, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_UNDER_GROUND_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 2, 85, 0 ] ); }
		public static const VIC_VIPER_WATER_BGM:Array = [ [ BlasterMasterNsf, NSF, 7, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_WATER_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 5, 85, 0 ] ); }
		public static const VIC_VIPER_STAR:Array = [ [ LifeForceNsf, NSF, 12, VOL_LIFE_FORCE, 0 ] ];
		{ VIC_VIPER_STAR.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 9, 85, 0 ] ); }
		public static const VIC_VIPER_WIN:Array = [ [ BlasterMasterNsf, NSF, 15, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_WIN.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 13, 85, 0 ] ); }
		public static const VIC_VIPER_WIN_CASTLE:Array = [ [ BlasterMasterNsf, NSF, 16, VOL_BLASTER_MASTER, 0 ] ];
		{ VIC_VIPER_WIN_CASTLE.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }


		public static const WAR_OF_LIGHT_BOSS_BGM:Array = [ [ ContraNsf, NSF,5,VOL_CONTRA,0 ] ];
		//{ WAR_OF_LIGHT_BOSS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ Metroid2ReturnOfSamusGbs, GBS, 10, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_BONUS_BGM:Array = [ [ BlasterMasterNsf, NSF, 5, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_BONUS_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 3, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_CREDITS:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_CREDITS.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_DUNGEON_BGM:Array = [ [ LifeForceNsf, NSF, 8, VOL_LIFE_FORCE, 0 ] ];
		{ WAR_OF_LIGHT_DUNGEON_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 4, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_DAY_BGM:Array = [ [ FinalFantasyNsf, NSF, 4, VOL_FINAL_FANTASY, 0 ] ]; //7330
		{ WAR_OF_LIGHT_DAY_BGM.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_DAY_BGM_LOOP:Array = [ [ BlasterMasterNsf, NSF, 1, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_DAY_BGM_LOOP.push( getArr(BlasterMasterSnes_Overworld), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		//public static const WAR_OF_LIGHT_DIE:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		public static const WAR_OF_LIGHT_GAME_OVER:Array = [ [ BlasterMasterNsf, NSF, 17, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_GAME_OVER.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 14, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_INTRO:Array = [ [ BlasterMasterNsf, NSF, 3, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_INTRO.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 1, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_INTRO_LEVEL:Array = [ [ BlasterMasterNsf, NSF, 2, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_INTRO_LEVEL.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 8, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_NIGHT_BGM:Array = [ [ FinalFantasyNsf, NSF, 16, VOL_FINAL_FANTASY, 0 ] ];
		{ WAR_OF_LIGHT_NIGHT_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 6, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_SECONDS_LEFT:Array = [ [ BlasterMasterNsf, NSF, 14, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_SECONDS_LEFT.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 11, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_UNDER_GROUND_BGM:Array = [ [ FinalFantasyNsf, NSF, 9, VOL_FINAL_FANTASY, 0 ] ];
		{ WAR_OF_LIGHT_UNDER_GROUND_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 2, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_WATER_BGM:Array = [ [ BlasterMasterNsf, NSF, 7, VOL_BLASTER_MASTER, 0 ] ];
		{ WAR_OF_LIGHT_WATER_BGM.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 5, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_STAR:Array = [ [ FinalFantasyNsf, NSF, 6, VOL_FINAL_FANTASY, 0 ] ];
		{ WAR_OF_LIGHT_STAR.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 9, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_WIN:Array = [ [ FinalFantasyNsf, NSF, 19, VOL_FINAL_FANTASY, 0 ] ];
		{ WAR_OF_LIGHT_WIN.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 13, 85, 0 ] ); }
		public static const WAR_OF_LIGHT_WIN_CASTLE:Array = [ [ FinalFantasyNsf, NSF, 18, VOL_FINAL_FANTASY, 0 ] ];
		{ WAR_OF_LIGHT_WIN_CASTLE.push( getArr(SuperMetroid_BrinstarVegetation), [ BlasterMasterEnemyBelowGbs, GBS, 12, 85, 0 ] ); }
		*/
		private static function addSfx(arr:Array):Array
		{
			SFX_DCT.addItem(arr);
			return arr;
		}

		private static function getArr(musicClass:Class):Array
		{
			if (!musicClass)
				return null;
			var str:String = Class(musicClass).toString();
			var num:int = 17;
			str = str.substr(num,str.length - num - 1);
			return SONG_DCT[str] as Array;
		}
	}
}

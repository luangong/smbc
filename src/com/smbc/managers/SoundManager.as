package com.smbc.managers
{


	import com.adobe.WAVWriter;
	import com.chewtinfoil.utils.StringUtils;
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.explodingRabbit.cross.data.Consoles;
	import com.explodingRabbit.cross.games.Game;
	import com.explodingRabbit.cross.games.GameSuperMarioBros;
	import com.explodingRabbit.cross.games.GameSuperMarioBros3;
	import com.explodingRabbit.cross.games.Games;
	import com.explodingRabbit.cross.sound.Song;
	import com.explodingRabbit.utils.Base64;
	import com.explodingRabbit.utils.Base64Fast;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.gme.EmulatorType;
	import com.gme.GameMusicEmu;
	import com.gme.SampleRate;
	import com.gskinner.performance.AbstractTest;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.*;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.data.BackgroundNames;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.data.LevelTypes;
	import com.smbc.data.MapPack;
	import com.smbc.data.MusicQuality;
	import com.smbc.data.MusicSets;
	import com.smbc.data.MusicType;
	import com.smbc.data.SecondaryHRect;
	import com.smbc.data.SoundNames;
	import com.smbc.data.Themes;
	import com.smbc.errors.SingletonError;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.Background;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.graphics.ThemeGroup;
	import com.smbc.graphics.TopScreenText;
	import com.smbc.graphics.fontChars.FontCharHud;
	import com.smbc.graphics.fontChars.FontCharMenu;
	import com.smbc.level.CharacterSelect;
	import com.smbc.level.FakeLevel;
	import com.smbc.level.LevelData;
	import com.smbc.level.TitleLevel;
	import com.smbc.main.GlobVars;
	import com.smbc.main.GlobalFunctions;
	import com.smbc.messageBoxes.DisclaimerMessageBox;
	import com.smbc.messageBoxes.MenuBox;
	import com.smbc.projectiles.MarioFireBall;
	import com.smbc.sound.*;
	import com.smbc.text.TextFieldContainer;

	import flash.events.Event;
	import flash.events.SampleDataEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundCodec;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.sampler.getInvocationCount;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	import flxmp.Module;
	import flxmp.Player;

	import mx.utils.StringUtil;

	import neoart.flod.xm.XM;
	import neoart.flod.xm.XMPlayer;

	public final class SoundManager extends MainManager
	{
		public static const SND_MNGR:SoundManager = new SoundManager();
		public const TURN_OFF_SOUND:Boolean = GameSettings.TURN_OFF_SOUND;
		private static var instantiated:Boolean;
		private var _readyToPlay:Boolean;
		private var base64Decoder:Base64Fast;
		private var _bgm:BackgroundMusic;
		private static const AUDIO_SAMPLE_RATE:int = 44100;
		private static const AUDIO_BIT_RATE:int = 32;
		private static const AUDIO_NUM_CHANNELS:int = 2;
		private static const SPC_RESAMPLE_RATE:Number = 32000/44100;
		private const SN_STAR_POWER:String = SoundNames.BGM_GAME_STAR_POWER;
		public static const SND_NAME_SUFFIX:String = "Snd";
		public static const SND_LOC_STR:String = "com.smbc.sound.soundFiles.";
		public const CUR_SNDS_DCT:CustomDictionary = new CustomDictionary(); // uses class as key and sound as value, holds the sounds that are currently playing
		public const P_SND_DCT:CustomDictionary = new CustomDictionary(); // uses class as key and sound as value, sounds that are paused?
		public const SOUNDS_TO_PLAY_DCT:CustomDictionary = new CustomDictionary(); // uses sound name as key and value
		private const SFX_GAME_PAUSE:String = SoundNames.SFX_GAME_PAUSE;
		public var sfxVolMinusNum:Number = SoundLevels.MAX_VOLUME - GameSettings.SFX_VOLUME;
		public var musicVolMinusNum:Number = SoundLevels.MAX_VOLUME - GameSettings.MUSIC_VOLUME;
		private var bgmPausePos:Number;
		private var bgmClassName:String;
		public var songCurrentlyPlaying:Song;
		public var curMusicType:String;
		public const SND_LEV_DCT:CustomDictionary = new CustomDictionary();
		public const BGM_SCT_DCT:CustomDictionary = new CustomDictionary();
		public const SND_LEV_DIVISOR:int = SoundLevels.LEVEL_DIVISOR;
		private const SN_SECONDS_LEFT_INTRO:String = SoundNames.BGM_GAME_SECONDS_LEFT_INTRO;
		public var muteSfx:Boolean;
		public var muteMusic:Boolean;
//		private var ovPlayer:OggVorbisPlayer;
		//*
		private var loadingTfc:TextFieldContainer;
		private var loadingCtr:int;
		private var loadingNumToRecordThisPhase:int;
		private var loadingTotalNum:int;
		public var curMusicPlayer:GameMusicEmu;
		public var musicPlayerMain:GameMusicEmu;
		public var musicPlayerMinor:GameMusicEmu;
		public var sfxPlayer:GameMusicEmu;
		public var otherPlayer:GameMusicEmu;
		private const IND_MUSIC_CLASS:int = MusicInfo.IND_SOURCE_CLASS;
		private const IND_SONG_TYPE:int = MusicInfo.IND_FILE_TYPE;
		private const IND_MUSIC_TRACK:int = MusicInfo.IND_TRACK_NUM;
		private const IND_MUSIC_VOLUME:int = MusicInfo.IND_VOLUME;
		private const IND_MUSIC_START_TIME:int = MusicInfo.IND_START_TIME;
		private const IND_MUSIC_DURATION:int = MusicInfo.IND_DURATION;
		private static const IND_MUSIC_TYPE:int = MusicInfo.IND_SOUND_TYPE;
		private const IND_MUSIC_ARR_8BIT:int = MusicInfo.IND_8BIT;
		private const IND_MUSIC_ARR_16BIT:int = MusicInfo.IND_16BIT
		private const IND_MUSIC_ARR_GB:int = MusicInfo.IND_GB;
		private static const IND_MUSIC_BUFFER:int = MusicInfo.IND_BUFFER;
		private static const SOUND_TYPE_OVERRIDE:String = SoundContainer.BT_OVERRIDE;
//		private const USE_NSF:Boolean = GameSettings.useNsf;
		private const NSF_INFO_DCT:CustomDictionary = new CustomDictionary();
		private const NSF_TRACK_OFFSET:int = MusicInfo.TRACK_OFFSET;
		private var lastMusicSetSetting:int;
		private var lastMusicTypeSetting:int;
		public var changeMusicOnResumeGame:Boolean;
		public var soundBuffer:ByteArray = new ByteArray();
		public var port1:int = -1;
		public var port2:int = -1;
		public var port3:int = -1;
		public var port4:int = -1;
//		[Embed(source="/Users/jay/Desktop/base64Song.txt",mimeType="application/octet-stream")]
//		private const Base64StrClass:Class;
//		public const BASE_64_STR:String = String( new Base64StrClass() );
		private var audioPlayerDct:CustomDictionary = new CustomDictionary();
//		[Embed(source="../assets/audio/seq/song.xm", mimeType="application/octet-stream")]
//		private const XM_SONG:Class;
		//*/

		private var wavData:ByteArray;
		private var _out:ByteArray

		private var playingSpc:Boolean;
//		private var audioPlayer:AudioPlayer = new AudioPlayer(8192);

		private var xmPlayer:Player;
		private var flodPlayer:XMPlayer;
		public function SoundManager()
		{
			if (instantiated)
				throw new SingletonError();
			instantiated = true;
			//trace("turn off sound: "+TURN_OFF_SOUND);
		}
		public function updateVars():void
		{
			level = GlobVars.level;
			player = level.player;
		}
		override public function initiate():void
		{
			super.initiate();
			changeMuteSettings();

//			set up gme instances
			musicPlayerMain = new GameMusicEmu(0);
			curMusicPlayer = musicPlayerMain;
			musicPlayerMain.init(EmulatorType.NSF);
			musicPlayerMain.setStereoDepth(0);

			musicPlayerMinor = new GameMusicEmu(1);
			musicPlayerMinor.init(EmulatorType.NSF);
			musicPlayerMinor.setStereoDepth(0);

			sfxPlayer = new GameMusicEmu(2);
			sfxPlayer.init(EmulatorType.NSF);
			sfxPlayer.setStereoDepth(0);

			otherPlayer = new GameMusicEmu(3);
			otherPlayer.init(EmulatorType.NSF);
			otherPlayer.setStereoDepth(0);

			SoundMixer.soundTransform = new SoundTransform(GameSettings.MASTER_VOLUME/SND_LEV_DIVISOR);
			SoundContainer.initiateClass();

			MusicSets.setUpSwapOrder();
			if (TURN_OFF_SOUND)
				return;
			changeSfxVolume();
			changeMusicVolume();
			var sndNameLst:XMLList = describeType(SoundNames)..constant;
			var sndLevLst:XMLList = describeType(SoundLevels)..constant;
			var sndNameLstLen:int = sndNameLst.length();
			var sndLevLstLen:int = sndLevLst.length();
			outLoop: for (var i:int = 0; i < sndNameLstLen; i++)
			{
				var nameConst:Object = sndNameLst[i].@name;
				var nameVal:String = SoundNames[sndNameLst[i].@name] as String;
			//	trace("nameConst: "+nameConst+' nameVal: '+ nameVal);
				innerLoop: for (var j:int = 0; j < sndLevLstLen; j++)
				{
					var levConst:Object = sndLevLst[j].@name;
					var levVal:int = SoundLevels[sndLevLst[j].@name] as int;
				//	trace("levConst: "+levConst+" levVal: "+ levVal);
					if (nameConst == levConst)
					{
						SND_LEV_DCT.addItem(nameVal,levVal);
						break innerLoop;
					}
				}
			}
		}
		public function startLevel():void
		{
			if (level is CharacterSelect)
				return;
			var startAtLoop:Boolean = !statMngr.newLev;
			changeMusic(null,startAtLoop);
			/*if (TURN_OFF_SOUND)
				return;
			if (level && level.previouslyVisitedArea)
				_bgm.playAtLoopNum();*/
		}
		public function removeBgm():void
		{
			if (_bgm)
			{
				_bgm.cleanUp();
				_bgm = null;
			}
			if (curMusicPlayer.isPlaying)
				curMusicPlayer.pause();
		}
		// called by TitleScreen && CharacterSelectScreen
		public function startBgm(bgmStr:String):void
		{
			//*
			if (TURN_OFF_SOUND)
				return;
			removeBgm();
			var bgmClass:Class = getDefinitionByName(SND_LOC_STR+bgmStr) as Class;
			_bgm = new bgmClass();
			// */
		}
		public function pauseGame():void
		{
			changeMusicOnResumeGame = false;
			lastMusicSetSetting = GameSettings.musicSet;
			lastMusicTypeSetting = GameSettings.musicType;
			pauseBgm();
			if (TURN_OFF_SOUND)
				return;
			pauseLoopingsSfx();
			SND_MNGR.playSoundNow(SFX_GAME_PAUSE);
		}
		public function resumeGame():void // called when game is unpaused
		{
			if (lastMusicSetSetting != GameSettings.musicSet || lastMusicTypeSetting != GameSettings.musicType || changeMusicOnResumeGame)
				changeMusic();
			changeMusicOnResumeGame = false;
			resumeBgm();
			if (TURN_OFF_SOUND)
				return;
			resumeLoopingSfx();
			SND_MNGR.playSound(SFX_GAME_PAUSE);
		}
		public function pauseResumeBgm():void // turns  music on and off for character select screen
		{
			if (curMusicPlayer.isPlaying)
				curMusicPlayer.pause();
			else if (curMusicPlayer.isPaused)
				curMusicPlayer.play();
		}
		public function pauseBgm():void
		{
			if (curMusicPlayer.isPlaying)
				curMusicPlayer.pause();
			if (TURN_OFF_SOUND)
				return;
			if (_bgm)
				_bgm.pauseSound();
		}
		public function resumeBgm():void
		{
			if (curMusicPlayer.isPaused)
				curMusicPlayer.play();
			if (TURN_OFF_SOUND)
				return;
			if (_bgm)
			{
				if (_bgm.paused)
				{
					_bgm.resumeSound();
					return;
				}
				else
				{
					removeBgm();
				}
			}
			if (bgmPausePos >= 0 && bgmClassName)
			{
				var bgmClass:Class = getDefinitionByName(SND_LOC_STR + bgmClassName) as Class;
				_bgm = new bgmClass();
				_bgm.pauseSound();
				_bgm.fakePause(bgmPausePos);
				_bgm.resumeSound();
				bgmPausePos = 0;
				bgmClassName = null;
			}

		}
		public function pauseLoopingsSfx():void
		{
			for each (var snd:SoundContainer in CUR_SNDS_DCT)
			{
				if (snd.soundName == SoundNames.SFX_LINK_BOOMERANG || snd.soundName == SoundNames.SFX_SIMON_CROSS || snd.soundName == SoundNames.SFX_SIMON_AXE || snd.soundName == SoundNames.SFX_MEGA_MAN_CHARGE_START)
					snd.pauseSound();
			}
		}
		public function resumeLoopingSfx():void
		{
			if (TURN_OFF_SOUND)
				return;
			for each (var snd:SoundContainer in CUR_SNDS_DCT)
			{
				if (snd.soundName == SoundNames.SFX_LINK_BOOMERANG || snd.soundName == SoundNames.SFX_SIMON_CROSS || snd.soundName == SoundNames.SFX_SIMON_AXE || snd.soundName == SoundNames.SFX_MEGA_MAN_CHARGE_START)
				{
					if (snd.paused)
						snd.resumeSound();
				}
			}
		}

		public function removeSfx():void
		{
			if (TURN_OFF_SOUND)
				return;
			for (var sndCl:Object in CUR_SNDS_DCT)
			{
				var snd:SoundContainer = CUR_SNDS_DCT[sndCl];
				removeSnd(snd);
			}
			P_SND_DCT.clear();
		}
		public function playSound(sndStr:String):void
		{
			//*
			//trace("play sound: "+sndStr);
			if (TURN_OFF_SOUND)
				return;
//			SOUNDS_TO_PLAY_DCT.addItem(getDefinitionByName(SND_LOC_STR+sndStr) as Class);
//			SOUNDS_TO_PLAY_DCT.addItem(SoundInfo[sndStr] as Class,sndStr);
			SOUNDS_TO_PLAY_DCT.addItem(sndStr);
			_readyToPlay = true;
			// */
		}
		//*
		/*public function playByteArraySound():void
		{
//			var wavWriter:WAVWriter = new WAVWriter();
//			wavWriter.numOfChannels = 2;
//			wavWriter.sampleBitRate = 16;
//			wavWriter.samplingRate = 44100;

//			var input:ByteArray = new ByteArray();
//			input.writeBytes(storedDynamicSoundData);
//			storedDynamicSoundData.position = 0;
//			wavData = storedDynamicSoundData;
//			wavData = convertByteArrayToFloat(soundBuffer);
			if (!wavData)
				wavData = new ByteArray();
//			wavData.endian = Endian.LITTLE_ENDIAN;
//			wavWriter.processSamples(wavData,convertByteArrayToFloat(soundBuffer),44100,2);
			wavData.endian = Endian.LITTLE_ENDIAN;
			wavData.writeBytes(soundBuffer);
			wavData.position = 0;
			var sound:Sound = new Sound();
			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onSampleData);
			var channel:SoundChannel = sound.play();

//			channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete, false, 0, true);
		}*/
		private function writeToSampleChannelData(data:ByteArray,arr:Array):void
		{
			var vec1:Vector.<Number> = arr[0];
			var vec2:Vector.<Number> = arr[1];
			var floatVal:int = 32768;
			var n:int = data.length/4;
			for (var i:int = 0; i < n; i++)
			{
				var num1:Number = data.readShort();
				var num2:Number = data.readShort();
				num1 /= floatVal;
				num2 /= floatVal;
				vec1[i] = num1;
				vec2[i] = num2;
			}
		}
		public function swapEndianness16Bit(dataIn:ByteArray):ByteArray
		{
			var start:int = getTimer();
			var dataOut:ByteArray = new ByteArray();
			var position:int = dataIn.position;
			dataOut.endian = dataIn.endian;
			dataIn.position = 0;
			var n:int = dataIn.length/2;
			for (var i:int = 0; i < n; i++)
			{
				var num1:Number = dataIn.readByte();
				var num2:Number = dataIn.readByte();
				dataOut.writeByte(num2);
				dataOut.writeByte(num1);
			}
			dataOut.position = 0;
			trace("time to swap: "+(getTimer() - start));
			return dataOut;
		}
//		public function cacheByteArray(data:ByteArray,arr:Array):void
//		{
////			if (!cacheFilter)
////			{
//			var start:int = getTimer();
//			data.position = 0;
//			var source:Sample = convByteArrToSample(data);
//			data.clear();
//			CacheFilter.MAX_CACHE = NaN;
//
//			var cacheFilter:CacheFilter = arr[ConsoleType.BIT_8][IND_MUSIC_BUFFER];
//			cacheFilter.source = source;
//			cacheFilter.fill();
//			source.destroy();
//			arr[ConsoleType.BIT_8][IND_MUSIC_BUFFER] = cacheFilter;
////			var tempAp:AudioPlayer = new AudioPlayer(GameMusicEmu.BYTE_LENGTH/2);
////			tempAp.play( cacheFilter.clone() );   // actually make some noise
////			trace("arr: "+arr+" ind: "+IND_MUSIC_BUFFER);
////			trace("set up sample time: "+ ( getTimer() - start) );
////			}
////			}
//		}
//		private function convByteArrToSample(data:ByteArray):Sample
//		{
//			var numSamples:uint = data.length / (AUDIO_BIT_RATE >> 3);
//			var numFrames:uint = numSamples / AUDIO_NUM_CHANNELS;
//			var audDes:AudioDescriptor = new AudioDescriptor();
//			var sample:Sample = new Sample( audDes, numFrames);
////			sample.readWavBytes(data, AUDIO_BIT_RATE, AUDIO_NUM_CHANNELS, numFrames);
////			var start:int = getTimer();
//			sample.readBytes(data);
////			trace("set up sample time: "+ ( getTimer() - start) );
//			return sample;
//		}
		/*private function swapBytes(dataIn:ByteArray):ByteArray
		{
			var dataOut:ByteArray = new ByteArray();
			dataIn.position = 0;
			var n:int = dataIn.length;
			for (var i:int = n; i >= 0; i--)
			{
				var byte1:Number = dataIn.
				dataOut.writeShort(byte2);
				dataOut.writeShort(byte1);
			}
			dataOut.position = 0;
			return dataOut;
		}*/
		protected function convertByteArrayToFloat(bytesIn:ByteArray):ByteArray
		{
			var bytesOut:ByteArray = new ByteArray();
			var n:int = bytesIn.length/2;  // 32768 is how long _out needs to be;
			for (var i:int = 0; i < n; i++)
			{
				var num:Number = bytesIn.readShort();
				num /= 32768;
				bytesOut.writeFloat(num);
			}
			bytesOut.position = 0;
			return bytesOut;
		}

	/*	protected function onSampleData(event:SampleDataEvent):void
		{
			if (wavData.bytesAvailable <= 0)
				return;

			for (var i:int = 0; i < 8192; i++)
			{
				var sample:Number = 0;
				if (wavData.bytesAvailable > 0)
					sample = wavData.readFloat();
				event.data.writeFloat(sample);
//				event.data.writeFloat(sample);
			}
			var data:ByteArray = event.data;
			var length:int = 8192;  // 32768 is how long _out needs to be;
			var loop:uint = 1;

			// execute SPC emulator for getting wave audio
//			_out.position = 0;
			//			_libgme.play(_out, length);
//			var hexStr:String = ExternalInterface.call("window.playSamples", byteArrayToHex(_out), length);
//			_out.writeBytes( toArray(hexStr) );
			//			_out.length = 32768;
//			_out.position = 0;
//			_out.endian = Endian.LITTLE_ENDIAN;

			// executing while for wave length
			for (var i:uint = 0; i < length; i++)
			{
				var s1:Number = 0;
				var s2:Number = 0;

				// play() method returned for 16 bit wave sound data
				// but it is not playable for Flash Player.
				// converting float type wave sound data.
				s1 = wavData.readShort();
				s1 /= 32768;
				s2 = wavData.readShort();
				s2 /= 32768;

				// write wave sound buffer
				for (var n:uint = 0; n < loop; n++) {
					data.writeFloat(s1); // left channel
					data.writeFloat(s2); // right channel
				}
			}
		}*/
		protected function onSampleData(event:SampleDataEvent):void
		{
			if (!wavData.bytesAvailable)
				return;
			var data:ByteArray = event.data;
			var n:int = 8192*2;
			for (var i:int = 0; i < n; i++)
			{
				var sample:Number = wavData.readFloat();
				data.writeFloat(sample);
//				trace("read: "+sample);
				/*if (stereo && wavData.bytesAvailable)
				{
					sample = wavData.readFloat();
					data.writeFloat(sample);
				}*/
			}
		}

		private function playGmeJava(arr:Array):void
		{
//			SoundMixer.stopAll();
//			var songType:String = arr[IND_SONG_TYPE];
//			var currentTrack:int = arr[IND_MUSIC_TRACK] + NSF_TRACK_OFFSET;
//			playingSpc = false;
//			if (songType == EmulatorType.SPC)
//			{
//				playingSpc = true;
//				currentTrack = 1;
//			}
//			var byteArray:ByteArray = new arr[IND_MUSIC_CLASS]() as ByteArray;
//			ExternalInterface.call("window.loadTrack", byteArrayToHex(byteArray), currentTrack, "."+songType.toUpperCase());
//			var start:int = getTimer();
//			var encodedStr:String = Base64.encode(byteArray);
//			trace("time to encode: "+ (getTimer() - start) );
//			ExternalInterface.call("window.loadTrack", encodedStr, currentTrack, "."+songType.toUpperCase());
//			var sound:Sound = new Sound();
//			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onGmeSampleData, false, 0, true);
//			var channel:SoundChannel = sound.play();
//			trace("str: "+str);
//			trace("encoded str: "+str);
//			trace("base64: "+str);
//			soundBuffer = toArray(str);
//			soundBuffer = Base64.decode(str);
//			trace("soundBuffer: "+soundBuffer);
//			soundBuffer.endian = Endian.LITTLE_ENDIAN;
//			var sound:Sound = new Sound();
//			sound.addEventListener(SampleDataEvent.SAMPLE_DATA, onGmeSampleData);
//			var channel:SoundChannel = sound.play();

			// recording
//			start = getTimer();
//			var str:String = ExternalInterface.call("window.recordTrack");
//			trace("time to receive data: "+ ( getTimer() - start) );
//			playByteArraySound( base64Decoder.decode(str) );
		}

//		protected function onGmeSampleData(e:SampleDataEvent):void
//		{
//			var buffer:ByteArray = e.data;
//			var length:int = 8192;  // 32768 is how long _out needs to be;
//			var loop:uint = 1;
//			// execute SPC emulator for getting wave audio
//			_out.position = 0;
////			_libgme.play(_out, length);
//			var str:String = ExternalInterface.call("window.playSamples", byteArrayToHex(_out), length);
//			var newData:ByteArray = base64Decoder.decode(str);
//			var sample:Sample;
////			var filter:ResamplingFilter = new ResamplingFilter(sample as IAudioSource);
////			filter.wr
//			if (playingSpc)
//			{
//				var numSamples:uint = newData.length / (AUDIO_BIT_RATE >> 3);
//				var numFrames:Number = numSamples / AUDIO_NUM_CHANNELS;
//				numFrames *= 44100/32000;
//				sample = new Sample( new AudioDescriptor(AUDIO_SAMPLE_RATE, AUDIO_NUM_CHANNELS), numFrames );
//				var sample2:Sample = convByteArrToSample(newData);
//				sample.resampleIn(sample2, SPC_RESAMPLE_RATE );
//			}
//			else
//				sample = convByteArrToSample(newData);
//			sample.writeBytes(buffer);
//			buffer.endian = Endian.LITTLE_ENDIAN;
////			e.data.writeBytes(newData);
////			_out.writeBytes( toArray(hexStr) );
////			_out.writeBytes( Base64.decode(str) );
////			_out.length = 32768;
////			_out.position = 0;
////			_out.endian = Endian.LITTLE_ENDIAN;
//
//			// executing while for wave length
//	/*		for (var i:uint = 0; i < length; i++)
//			{
//				var s1:Number = 0;
//				var s2:Number = 0;
//
//				// play() method returned for 16 bit wave sound data
//				// but it is not playable for Flash Player.
//				// converting float type wave sound data.
//				s1 = _out.readShort();
//				s1 /= 32768;
//				s2 = _out.readShort();
//				s2 /= 32768;
//
//				// write wave sound buffer
//				for (var n:uint = 0; n < loop; n++) {
//					data.writeFloat(s1); // left channel
//					data.writeFloat(s2); // right channel
//				}
//			}*/
//		}
		public function restartCurrentSong():void
		{
			playMusic(songCurrentlyPlaying);
		}
//		public function playEmulatedSfx(arr:Array):CacheFilter
		public function playEmulatedSfx(arr:Array):ByteArray
		{
			var n:int = 10;
			var musicType:int = ConsoleType.BIT_8;
//			var buffer:CacheFilter = arr[musicType][IND_MUSIC_BUFFER];
			var buffer:ByteArray = arr[musicType][IND_MUSIC_BUFFER];
//			if (buffer && buffer.source)
			if (buffer)
			{
				return buffer;
			}
			else
			{
				buffer = new ByteArray();
				buffer.endian = Endian.LITTLE_ENDIAN;
				playMusic(arr, sfxPlayer, false, buffer, musicType );
				if (!buffer.length)
					throw new Error("what the hell");
				else
					arr[musicType][IND_MUSIC_BUFFER] = buffer;
			}
			return buffer;
		}

		private function getMusicTypeConsole(regenerate:Boolean = false):int
		{
			var num:int = GameSettings.musicType;
			if (num <= ConsoleType.MAX_CONSOLE_VALUE)
				return num;
			else if (num == ConsoleType.CHARACTER)
				return statMngr.getCurrentBmc( statMngr.curCharNum ).consoleType;
			else if (num == ConsoleType.MAP)
				return grMngr.CLEAN_BMD_VEC_MAP[grMngr.cMapNum].consoleType;
			else //if (num == ConsoleType.RANDOM)
				return int( Math.random() * (ConsoleType.MAX_CONSOLE_VALUE + 1) );
		}
		public function playMusic(songInfo:*, sndEmu:GameMusicEmu = null, startAtLoopPoint:Boolean = false, recordBuffer:ByteArray = null, console:int = -1, playEvenIfMuted:Boolean = false):void
		{
			if (!sndEmu)
				sndEmu = curMusicPlayer;
			pauseOppositeMusicPlayer();
			if (sndEmu == musicPlayerMain || sndEmu == musicPlayerMinor)
//				pauseOppositeMusicPlayer();
			if (sndEmu.isPlaying || sndEmu.isPaused)
				sndEmu.stop();
			if (!songInfo)
				return;
			var song:Song;
			var arr:Array;
			if (songInfo is Array)
				arr = songInfo as Array;
			else
				song = songInfo as Song;
			if (arr)
			{
				sndEmu.currentArr = arr;
				if (console >= 0)
					arr = arr[console];
				else
					arr = arr[getMusicTypeConsole(true)];
			}
			if (!arr && !song)
				return;
			var songType:String;
			if (arr)
				songType= arr[IND_SONG_TYPE];
			else
				songType = song.format;
			sndEmu.init(songType);
			var ms:int = GameSettings.musicSet;
			var mq:int = GameSettings.musicQuality;
			if (arr)
				sndEmu.currentSndClass = arr[IND_MUSIC_CLASS];
			else
				sndEmu.currentSndClass = song.dataClass;
			var byteArray:ByteArray = new sndEmu.currentSndClass() as ByteArray;
			if (arr)
				sndEmu.currentTrack = arr[IND_MUSIC_TRACK] + NSF_TRACK_OFFSET;
			else
				sndEmu.currentTrack = song.track + NSF_TRACK_OFFSET;
//			if (GameSettings.callJavaScript)
//			{
//				var start:int = getTimer();
//				playGmeJava(arr);
//				trace("time to play song: "+ (getTimer() - start) );
//				return;
//			}
//			if (mq == MusicQuality.MID && sndEmu.currentNsf == MusicInfo.BlasterMasterNsf)
//				sndEmu.setPlayerQuality(MusicQuality.LOW);
//			else if (arr == MusicInfo.GAME_CHARACTER_SELECT)
//				sndEmu.setPlayerQuality(MusicQuality.HIGH); // makes character select music high quality
//			else
//				sndEmu.setPlayerQuality();
			sndEmu.loadEmbeddedMusic( sndEmu.currentSndClass );
//			if (songType != EmulatorType.SPC)
				sndEmu.startTrack(sndEmu.currentTrack);
			var startTime:int;
			if (arr)
				startTime = arr[IND_MUSIC_START_TIME];
			else
				startTime = song.start;
			if (startTime != 0)
				sndEmu.seek(startTime);
//			sndEmu.seek(120000);
			var volInt:int;
			if (arr)
				volInt = arr[IND_MUSIC_VOLUME] - musicVolMinusNum;
			else
				volInt = song.volume;
			if (volInt < 0)
				volInt = 0;
			var volDec:Number = 0;
			if (volInt > 0)
				volDec = volInt / SND_LEV_DIVISOR;
			sndEmu.volume = volDec;
			if (recordBuffer)
				sndEmu.recordTrack(recordBuffer,arr[IND_MUSIC_DURATION]);
			else
			{
				if (!muteMusic || playEvenIfMuted)
					sndEmu.play(null, playEvenIfMuted);
				else
					sndEmu.pause();
			}
		}
		public static function toArray(hex:String):ByteArray {
//			hex = hex.replace(/\s|:/gm,'');
			trace("hex.length: "+hex.length);
			var a:ByteArray = new ByteArray();
			if (hex.length&1==1)
				hex="0"+hex;
			for (var i:uint=0;i<hex.length;i+=2) {
				a[i/2] = parseInt(hex.substr(i,2),16);
			}
			return a;
		}

		public static function byteArrayToHex(array:ByteArray, colons:Boolean=false):String {
			var s:String = "";
			for (var i:uint=0;i<array.length;i++) {
				s+=("0"+array[i].toString(16)).substr(-2,2);
				if (colons) {
					if (i<array.length-1) s+=":";
				}
			}
			return s;
		}
		public function removeAllSounds():void
		{
			if (curMusicPlayer.isPlaying)
				curMusicPlayer.pause();
			if (TURN_OFF_SOUND)
				return;
			SoundMixer.stopAll();
			SOUNDS_TO_PLAY_DCT.clear();
			for each (var cs:SoundContainer in CUR_SNDS_DCT)
			{
				cs.cleanUp();
			}
			P_SND_DCT.clear();
			CUR_SNDS_DCT.clear();
			removeBgm();
		}
		public function playSoundNow(sndStr:String):void
		{
			var dct:CustomDictionary = new CustomDictionary();
			dct.addItem(sndStr);
			playStoredSounds(dct);
		}
		public function removeSnd(snd:SoundContainer):void
		{
			snd.cleanUp();
		}
		public function findSound(sndStr:String):SoundContainer
		{
			if (TURN_OFF_SOUND)
				return null;
//			var sndClass:Class = SoundInfo[sndStr] as Class;
			var snd:SoundContainer = CUR_SNDS_DCT[sndStr]
			if (snd)
				return snd;
			else
			{
				SOUNDS_TO_PLAY_DCT.removeItem(sndStr);
				return null;
			}
		}
		// removes a sound that is going to play but has not started yet
		public function removeStoredSound(sndStr:String):void
		{
			if (TURN_OFF_SOUND)
				return;
//			var soundClass:Class = SOUNDS_TO_PLAY_DCT[ SoundInfo[sndStr] as Class];
//			if (soundClass)
				SOUNDS_TO_PLAY_DCT.removeItem(sndStr);
		}
		public function playStoredSounds(dct:CustomDictionary):void
		{
			if (muteSfx)
			{
				dct.clear();
				return;
			}
			for each (var sndName:String in dct)
			{
//				if (sndName == SoundNames.SFX_SAMUS_ICE_BEAM)
//					trace("break");
				var sndCl:Class = SoundInfo[sndName] as Class;
				var oldSnd:SoundContainer = CUR_SNDS_DCT[sndName];
				if (oldSnd)
					removeSnd(oldSnd);
//				var newSound:CustomSoundContainer = new CustomSoundContainer(sndCl);
//				var newSound:SoundEffect = new SoundEffect(sndCl);
				var classToCreate:Class = SoundContainer;
				var newSound:SoundContainer;
//				var buffer:CacheFilter;
				var buffer:ByteArray;
				var musicArr:Array = getMusicArr(sndName);
//				trace("sndName: "+sndName+" musicArr: "+musicArr);
				if (musicArr)
				{
					if (musicArr[ConsoleType.BIT_8][IND_MUSIC_TYPE] == SOUND_TYPE_OVERRIDE)
						classToCreate = getDefinitionByName("com.smbc.sound."+sndName) as Class;
					buffer = playEmulatedSfx(musicArr);
					if (buffer)
						newSound = new classToCreate(sndName,buffer);
				}
				else
				{
					if (sndCl)
						classToCreate = SoundInfo.INFO_DCT[sndCl][SoundInfo.IND_CLASS];
					newSound = new classToCreate(sndName);
				}
//				if ( ( (classType == SoundEffect || classType == LoopingSoundEffect) && !muteSfx) || ( (classType == BackgroundMusic || classType == MusicEffect) && !muteMusic) )
//				{
//				}
				if (newSound)
					CUR_SNDS_DCT.addItem(sndName,newSound);
				dct.removeItem(sndName);
			}
			_readyToPlay = false;
		}
		public function getMusicArr(soundName:String,consoleType:int = -1):Array
		{
			var arr:Array = MusicInfo["SFX_"+soundName];
			if (consoleType == -1)
				return arr;
			if (arr)
				return arr[consoleType];
			return null;
		}
//		protected function audioPlayerCompleteHandler(event:Event):void
//		{
//			var ap:AudioPlayer = event.target as AudioPlayer;
//			ap.removeEventListener(Event.SOUND_COMPLETE,audioPlayerCompleteHandler);
//			ap.stop();
////			(audioPlayerDct[ap] as CacheFilter).
//			audioPlayerDct.removeItem(ap);
//		}

		public function fromJava(str:String):void
		{
//			player.visible = false;
			if (str)
			{
				TopScreenText.instance.updScoreDisp(str.length.toString());
				soundBuffer = toArray(str);
//				soundBuffer.endian = Endian.LITTLE_ENDIAN;
			}
		}
		// CHANGEBGM
		public function changeMusic(musicType:String = null, startAtLoopPoint:Boolean = false):void
		{
			/*var module:Module = new Module( XM_SONG );
			if (!xmPlayer)
				xmPlayer = new Player( module );
			xmPlayer.stop();
			xmPlayer.play();*/
		/*	if (!flodPlayer)
			{
				flodPlayer = new XMPlayer();
				flodPlayer.load( new XM_SONG() as ByteArray );
			}
			flodPlayer.stop();
			flodPlayer.play();
			flodPlayer.loopSong = 1;
			return;*/
			//*
			//if (TURN_OFF_SOUND)
			//	return;
			musicPlayerMain.removeEventListener(CustomEvents.TRACK_END, timeUpWarningEndHandler);
			musicPlayerMinor.removeEventListener(CustomEvents.TRACK_END, timeUpWarningEndHandler);
			var musicPlayer:GameMusicEmu = musicPlayerMain;
//			trace("musicType: "+musicType);
			var musicTypeCameFromLevel:Boolean;
			//*
			var str:String;
			var games:Vector.<Game>;
			var musicSet:int = GameSettings.getMusicSet();
			if (level is TitleLevel)
				musicType = MusicType.TITLE_SCREEN;
			if ( (musicSet == MusicSets.MAP || musicType == MusicType.CHAR_SEL || musicType == MusicType.TITLE_SCREEN) && musicType != MusicType.CHOOSE_CHARACTER && musicType != MusicType.DIE)
				games = grMngr.drawingBoardMapSkinCont.games;
			else
				games = Character.getGamesFromSkin(statMngr.curCharNum);
			var themeGroup:ThemeGroup;
			if (!games || !games.length)
				return;
			var song:Song;
			var console:int;
			if ( (musicType == MusicType.CHAR_SEL || musicType == MusicType.TITLE_SCREEN) && GameSettings.musicType == ConsoleType.CHARACTER )
				console = grMngr.drawingBoardMapSkinCont.consoleType;
			else
				console = GameSettings.getMusicConsole();
			var game:Game = games[console];
			if (!musicType) // use level type
			{
				if (level is CharacterSelect || level is FakeLevel)
					return;
				musicTypeCameFromLevel = true;
				if (player && player.starPwrBgmShouldBePlaying)
				{
					song = game.getSongFromTypePlayList(MusicType.STAR);
					if (!song)
					{
						game = grMngr.drawingBoardMapSkinCont.games[console];
						song = game.getSongFromTypePlayList(MusicType.STAR);
					}
					musicPlayer = musicPlayerMinor;
				}
				if (!song)
				{
					musicType = level.type;
//					if (level.fullLevStr == "8-4b" && GameSettings.getMapSkinLimited() == BmdInfo.SKIN_NUM_SMB_SNES && GameSettings.mapPack == MapPack.Smb)
//						musicType = LevelTypes.CASTLE;
					var mainArea:String = LevelDataManager.currentLevelData.getMainArea(level.id);
					if (level.areaStr != mainArea)
						musicPlayer = musicPlayerMinor;
						themeGroup = Themes.getMapTheme();
						musicType = game.getOverridedMusicType(themeGroup, musicType); // checks if theme group overrides music type
					if (game == grMngr.drawingBoardMapSkinCont.games[console]) // will only override if games match
						song = game.getSongFromThemePlayList( themeGroup.theme, themeGroup.setNum, musicType );
				}
			}
			else if (musicType == SoundNames.BGM_GAME_SECONDS_LEFT_INTRO)
				song = getSecondsLeftSng(console);
			else if (musicType == MusicType.CHOOSE_CHARACTER && statMngr.curCharNum == MegaMan.CHAR_NUM)
			{
				var tmpSong:Song = MegaManBase.getProtoManWhistleSong();
				if (tmpSong)
					song = tmpSong;
			}
			if (!song)
				song = game.getSongFromTypePlayList(musicType);
			// check for hurry version
			if (musicTypeCameFromLevel && statMngr.secondsLeft)
			{
				var hurrySong:Song = game.getHurryVersionOfSong(song);
				if ( !(player && player.starPwrBgmShouldBePlaying) )
				{
					if (!hurrySong)
						hurrySong = game.getSongFromTypePlayList(MusicType.HURRY);
					if (hurrySong)
						song = hurrySong;
				}
			}
			if (song)
			{
				if (!musicPlayer.isPlaying || songCurrentlyPlaying != song || musicPlayer.fadeTmr )
				{
					curMusicPlayer = musicPlayer;
					if (musicPlayer == musicPlayerMain && musicPlayer.isPaused && musicPlayer.currentSong == song && startAtLoopPoint)
					{
						curMusicPlayer.currentSong = song;
						musicPlayer.play();
						pauseOppositeMusicPlayer();
					}
					else
					{
						curMusicPlayer.currentSong = song;
						playMusic( song, musicPlayer );
					}
					if (musicType == SoundNames.BGM_GAME_SECONDS_LEFT_INTRO)
						musicPlayer.addEventListener(CustomEvents.TRACK_END, timeUpWarningEndHandler, false, 0, true);
					songCurrentlyPlaying = song;
					curMusicType = musicType;
				}
			}

			/*if (newBgmName == SoundNames.BGM_GAME_SECONDS_LEFT_INTRO)
			{
				removeBgm();
				var soundClass:Class = SoundInfo[newBgmName] as Class;
				var classType:Class = SoundInfo.INFO_DCT[soundClass][SoundInfo.IND_CLASS];
				var newSnd:CustomSoundContainer = new classType(soundClass);
				_bgm = new soundClass();
				return;
			}*/
			/*if (USE_NSF)
			{
				var bgtSub:String;
				var musicCharName:String = getMusicCharName();
				if (player && player.starPwrBgmShouldBePlaying)
				{
					starPwrStart();
					return;
				}
				if (statMngr.secondsLeft)
				{
					if (musicCharName != Mario.CHAR_NAME_CAPS)
					{
						str = musicCharName + MusicInfo.SEP + MusicInfo.TYPE_SECONDS_LEFT;
						playMusic(MusicInfo[str]);
					}
					else
					{
						if (bgt == MusicType.BONUS)
							playMusic(MusicInfo.MARIO_BONUS_FAST);
						else if (bgt == MusicType.DUNGEON)
							playMusic(MusicInfo.MARIO_DUNGEON_FAST);
						else if (bgt == MusicType.OVER_WORLD)
							playMusic(MusicInfo.MARIO_DAY_FAST);
						else if (bgt == MusicType.UNDER_GROUND)
							playMusic(MusicInfo.MARIO_UNDER_GROUND_FAST);
						else if (bgt == MusicType.WATER)
							playMusic(MusicInfo.MARIO_WATER_FAST);
					}
					return;
				}
				else if (bgt == MusicType.BONUS)
					bgtSub = MusicInfo.TYPE_BONUS_BGM;
				else if (bgt == MusicType.DUNGEON)
					bgtSub = MusicInfo.TYPE_DUNGEON_BGM;
				else if (bgt == MusicType.INTRO)
				{
					if (musicCharName == Link.CHAR_NAME_CAPS)
					{
						playSound(SoundNames.MFX_LINK_INTRO_LEVEL);
						return;
					}
					else
						bgtSub = MusicInfo.TYPE_INTRO_LEVEL;
				}
				else if (bgt == MusicType.OVER_WORLD)
				{
//					if (LevelData.instance.bgStrVec[0] == BackgroundNames.NIGHT_SKY)
//						bgtSub = MusicInfo.TYPE_NIGHT_BGM;
//					else
						bgtSub = MusicInfo.TYPE_DAY_BGM;
				}
				else if (bgt == MusicType.UNDER_GROUND)
					bgtSub = MusicInfo.TYPE_UNDER_GROUND_BGM;
				else if (bgt == MusicType.WATER)
					bgtSub = MusicInfo.TYPE_WATER_BGM;
				else if (bgt == MusicType.NIGHT)
					bgtSub = MusicInfo.TYPE_NIGHT_BGM;
				str = musicCharName + MusicInfo.SEP + bgtSub;
//				if (musicCharName == Sophia.CHAR_NAME_CAPS)
//					return;
				if (musicCharName == Sophia.CHAR_NAME_CAPS && bgtSub == MusicInfo.TYPE_DAY_BGM)
				{
					if (startAtLoopPoint)
						str += MusicInfo.LOOP_STR;
					else if (musicPlayer.isPlaying && GameSettings.musicSet != MusicSets.RANDOM && musicPlayer.currentNsf == MusicInfo.BlasterMasterNsf && musicPlayer.currentTrack == MusicInfo.SOPHIA_DAY_BGM[IND_MUSIC_TRACK] + NSF_TRACK_OFFSET)
						return;
				}
				var musicArr:Array = MusicInfo[str][getMusicTypeConsole()];
				if (musicPlayer.isPlaying && musicPlayer.currentNsf == musicArr[IND_MUSIC_CLASS] && musicPlayer.currentTrack == musicArr[IND_MUSIC_TRACK] + NSF_TRACK_OFFSET)
					return;
				removeBgm();
				playMusic(MusicInfo[str],musicPlayer,startAtLoopPoint);
				return;
			}*///*/
			/*removeBgm();
			if (newBgmName != null)
			{
				soundClass = getDefinitionByName(SND_LOC_STR + newBgmName) as Class;
				_bgm = new soundClass();
				return;
			}
			if (bgt == "intro")
			{
				playSound(SoundNames.MFX_MARIO_INTRO);
				return;
			}
			else if (bgt == "bonus")
			{
				if (player is Mario)
				{
					var starSndClass:Class = getDefinitionByName(SND_LOC_STR + SN_STAR_POWER) as Class;
					_bgm = new starSndClass();
					return;
				}
				else
					bgt = "water";
			}
			var pn:String = player.charName;
			var name:String = pn.charAt(0).toUpperCase() + pn.substring(1,pn.length);
			var typeStr:String = bgt.charAt(0).toUpperCase() + bgt.substring(1,bgt.length);
			var sndStr:String = name+typeStr+SND_NAME_SUFFIX;
			soundClass = getDefinitionByName(SND_LOC_STR+sndStr) as Class;
			_bgm = new soundClass();*/
		}

		protected function timeUpWarningEndHandler(event:Event):void
		{
//			changeMusic();
			if (level)
				level.addEventListener(CustomEvents.GAME_LOOP_END, gameLoopEndHandler, false, 0, true);
//			musicPlayer.removeEventListener(CustomEvents.TRACK_END, timeUpWarningEndHandler, false, 0, true);
		}

		protected function gameLoopEndHandler(event:Event):void
		{
			if (level)
				level.removeEventListener(CustomEvents.GAME_LOOP_END, gameLoopEndHandler);
			changeMusic();
		}

		private function getSecondsLeftSng(consoleType:int):Song
		{
			switch(consoleType)
			{
				case ConsoleType.BIT_8:
					return Games.superMarioBros.SngSecondsLeft;
				case ConsoleType.BIT_16:
					return Games.superMarioBrosSnes.SngTimeUpWarning;
				case ConsoleType.GB:
					return Games.superMarioBros.SngSecondsLeft;
			}
			return Games.superMarioBros.SngSecondsLeft;
		}

		private function pauseOppositeMusicPlayer():void
		{
				if (curMusicPlayer == musicPlayerMain && musicPlayerMinor.isPlaying)
					musicPlayerMinor.pause();
				else if (curMusicPlayer == musicPlayerMinor && musicPlayerMain.isPlaying)
					musicPlayerMain.pause();
		}
		public function getMusicCharName():String
		{
			// returns capitalized char name needed for nsfinfo
			var musicSet:int = GameSettings.musicSet;
			var num:int;
			if (musicSet == MusicSets.CHARACTER)
				num = statMngr.curCharNum;
			else if (musicSet == MusicSets.MAP)
				num = grMngr.CLEAN_BMD_VEC_MAP[grMngr.cMapNum].charArr[0];
			else if (musicSet == MusicSets.RANDOM)
				num = statMngr.getRandomCharNum();
			else
			{
				var name:String = MusicSets.convNumToStr(musicSet);
				num = CharacterInfo.convNameToNum(name);
			}
			return CharacterInfo.CHAR_ARR[num][CharacterInfo.IND_CHAR_NAME_CAPS];
		}
		public function starPwrStart():void
		{
			if (level && level is TitleLevel)
				return;
			//*
			//if (TURN_OFF_SOUND || (_bgm && _bgm.className == SN_SECONDS_LEFT_INTRO) )
			if (_bgm && _bgm.soundName == SN_SECONDS_LEFT_INTRO)
				return;
//			changeMusic( MusicType.STAR, false, statMngr.secondsLeft );
			changeMusic( );
			// */
		}
		public function starPwrEnd():void
		{
			if (level && level is TitleLevel)
				return;
			changeMusic(null,true);
		}
		public function changeMuteSettings():void
		{
			muteSfx = GameSettings.muteSfx;
			var firstMuteMusic:Boolean = muteMusic;
			muteMusic = GameSettings.muteMusic;
			if (firstMuteMusic != muteMusic && level is TitleLevel)
			{
				if (!muteMusic)
					changeMusic();
				else
					curMusicPlayer.stop();
			}
		}
		public function changeSfxVolume():void
		{
			sfxVolMinusNum = SoundLevels.MAX_VOLUME - GameSettings.SFX_VOLUME;
		}
		public function changeMusicVolume():void
		{
			musicVolMinusNum = SoundLevels.MAX_VOLUME - GameSettings.MUSIC_VOLUME;
		}
		public function get bgm():BackgroundMusic
		{
			return _bgm;
		}
		public function get readyToPlay():Boolean
		{
			return _readyToPlay;
		}

		public function recordSoundsPhase1():void
		{
			loadingTotalNum = MusicInfo.SFX_DCT.length;
			loadingNumToRecordThisPhase = int(loadingTotalNum/2);
			loadingTfc = new TextFieldContainer(FontCharMenu.FONT_NUM,FontCharMenu.TYPE_CREDITS);
			loadingTfc.x = GlobVars.STAGE_WIDTH - 255;
			loadingTfc.y = GlobVars.STAGE_HEIGHT - 35;
			loadingTfc.text = "loading "+loadingCtr+" / "+loadingTotalNum;
			game.addChild(loadingTfc);
			recordNextSnd();
		}

		protected function enterFrameHandler(event:Event):void
		{
			game.stage.removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			recordNextSnd();
		}
		private function recordNextSnd():void
		{
			var dct:CustomDictionary = MusicInfo.SFX_DCT
			for each (var arr:Array in dct)
			{
				playEmulatedSfx(arr);
				dct.removeItem(arr);
				loadingCtr++;
				break;
			}
			loadingTfc.text = "loading "+loadingCtr+" / "+loadingTotalNum;
			if (dct.length)
				game.stage.addEventListener(Event.ENTER_FRAME,enterFrameHandler,false,0,true);
//			else if (dct.length) // end of phase 1
//				scrnMngr.logoCanExit();
			else // end of phase 2
			{
				game.removeChild(loadingTfc);
				loadingTfc = null;
				scrnMngr.openingLogosEnd();
//				DisclaimerMessageBox.instance.allowCancel();
			}
		}

		public function recordSoundsPhase2():void
		{
			loadingNumToRecordThisPhase = int.MAX_VALUE;
			recordNextSnd();
		}
	}
}

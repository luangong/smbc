package com.smbc.main
{

	import com.adobe.protocols.dict.Dict;
	import com.caurina.transitions.PropertyInfoObj;
	import com.customClasses.MCAnimator;
	import com.explodingRabbit.cross.data.EffectReasons;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxFlash;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxStop;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusEffect;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.Character;
	import com.smbc.characters.MegaMan;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.GameStates;
	import com.smbc.data.HitTestTypes;
	import com.smbc.data.PaletteTypes;
	import com.smbc.enemies.KoopaGreen;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.MasterObjects;
	import com.smbc.graphics.Palette;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.ground.SpringRed;
	import com.smbc.interfaces.IAnimated;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.interfaces.IHitTestable;
	import com.smbc.interfaces.IInitiater;
	import com.smbc.interfaces.ITimeline;
	import com.smbc.level.Level;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.SoundManager;
	import com.smbc.managers.StatManager;
	import com.smbc.projectiles.Projectile;
	import com.smbc.utils.GameLoopTimer;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;

	public class LevObj extends SkinObj implements IInitiater, IHitTestable, IAnimated
	{
		public var level:Level = GlobVars.level;
		protected static var player:Character;
		protected var game:SuperMarioBrosCrossover = level.GAME;
		protected const GLOB_STG_TOP:int = Level.GLOB_STG_TOP;
		protected const GLOB_STG_BOT:int = Level.GLOB_STG_BOT;
		protected const GLOB_STG_RHT:int = Level.GLOB_STG_RHT;
		protected const GLOB_STG_LFT:int = Level.GLOB_STG_LFT;
		protected const ZERO_PT:Point = level.ZERO_PT;
		protected const TILE_SIZE:int = level.TILE_SIZE;
		protected static const PR_PASSTHROUGH_ALWAYS:String = StatusProperty.TYPE_PASS_THROUGH_ALWAYS_AGG;
		protected static const PR_PASSTHROUGH_DEFEAT:String = StatusProperty.TYPE_PASS_THROUGH_DEFEAT_AGG;
		protected static const PR_PIERCE_AGG:String = StatusProperty.TYPE_PIERCE_AGG;
		protected static const PR_PIERCE_PAS:String = StatusProperty.TYPE_PIERCE_PAS;
		protected static const PR_FLASH_AGG:String = StatusProperty.TYPE_FLASH_AGG;
		protected static const PR_DAMAGES_PLAYER_AGG:String = StatusProperty.TYPE_DAMAGES_PLAYER_AGG;
		protected static const PR_INVULNERABLE_AGG:String = StatusProperty.TYPE_INVULNERABLE_AGG;
		protected static const PR_STOP_AGG:String = StatusProperty.TYPE_STOP_AGG;
		protected static const PR_STOP_PAS:String = StatusProperty.TYPE_STOP_PAS;
		protected static const PR_FREEZE_PAS:String = StatusProperty.TYPE_FREEZE_PAS;
		protected static const PR_UNFREEZE_AGG:String = StatusProperty.TYPE_UNFREEZE_AGG;
		protected static const PR_FREEZE_AGG:String = StatusProperty.TYPE_FREEZE_AGG;
		protected static const PR_TYPE_SUPER_ARM_GRABBABLE_PAS:String = StatusProperty.TYPE_SUPER_ARM_GRABBABLE_PAS;
		protected static const PR_STOP_ALL_ENEMIES_ACTIVE_AGG:String = StatusProperty.TYPE_STOP_ALL_ENEMIES_ACTIVE_AGG;
		private static const PROP_ORDER_REFERENCE:Vector.<String> = StatusProperty.PROP_ORDER;
		protected static const RSN_NONSPECIFIC:String = EffectReasons.NONSPECIFIC;
		protected static const RSN_OVERRIDE:String = EffectReasons.OVERRIDE;
		protected static const STATFX_FLASH:String = StatusEffect.TYPE_FLASH;
		protected static const STATFX_FREEZE:String = StatusEffect.TYPE_FREEZE;
		protected static const STATFX_KNOCK_BACK:String = StatusEffect.TYPE_KNOCK_BACK;
		protected static const STATFX_STOP:String = StatusEffect.TYPE_STOP;
		protected static const STATFX_INVULNERABLE:String = StatusEffect.TYPE_INVULNERABLE;
//		protected static const STATPR_FLASH_DEFAULT:StatusProperty = new StatusProperty(PR_FLASH_AGG,0, new StatFxFlash(null,34,400) );
//		protected static const STATPR_STOP_DEFAULT:StatusProperty = new StatusProperty(PR_STOP_AGG,0, new statfx );
		public static const PIERCE_STR_ARMORED:int = 5;
		public static const PIERCE_STR_ARMOR_PIERCING:int = 6;
		protected const SCRN_MNGR:ScreenManager = ScreenManager.SCRN_MNGR;
		protected const GS_MNGR:GameStateManager = GameStateManager.GS_MNGR;
		protected static const GS_PLAY:String = GameStates.PLAY;
		protected static const GS_WATCH:String = GameStates.WATCH;
		protected const SND_MNGR:SoundManager = SoundManager.SND_MNGR;
		protected const STAT_MNGR:StatManager = StatManager.STAT_MNGR;
		protected const EVENT_MNGR:EventManager = EventManager.EVENT_MNGR;
		public static const ST_DIE:String = "die";
		public var areaRect:Sprite;
		public var bmp:Bitmap;
		public var hTop:Number;
		public var hBot:Number;
		public var hLft:Number;
		public var hRht:Number;
		public var hMidX:Number;
		public var hMidY:Number;
		public var hHeight:Number;
		public var hWidth:Number;
		public var lhTop:Number;
		public var lhBot:Number;
		public var lhLft:Number;
		public var lhRht:Number;
		public var lhMidX:Number;
		public var lhMidY:Number;
		public var lhHeight:Number;
		public var lhWidth:Number;
		public var stuckInWall:Boolean;
		public var xPenAmt:Number;
		public var yPenAmt:Number;
		public var vx:Number = 0;
		public var vy:Number = 0;
		protected var locStgTop:Number = level.locStgTop;
		protected var locStgRht:Number = level.locStgRht;
		protected var locStgLft:Number = level.locStgLft;
		protected var locStgBot:Number = level.locStgBot;
		protected const TMR_DCT:CustomDictionary = new CustomDictionary(true);
		protected const P_TMR_DCT:CustomDictionary = new CustomDictionary(true);
		protected var fLabVec:Vector.<FrameLabel> = new Vector.<FrameLabel>();
		protected var dt:Number = .05;
		public var globX:Number;
		public var globY:Number;
		public var lState:String;
		public var cState:String;
		public var lockState:Boolean;
		public var cHeight:Number;
		public var cWidth:Number;
		public var nx:Number;
		public var ny:Number;
		public var lx:Number;
		public var ly:Number;
		public static const NAME_STOP_UPDATE:String = "updStopUpdate";
		public static const NAME_STOP_ANIM:String = "updStopAnim";
		public static const NAME_STOP_TIMERS:String = "updStopTimers";
		/**
		 *This contains objects that hold info for overriding stats for objects
		 */
		private var reasonOvRdObj:Object = new Object();
		public var stopUpdate:Boolean;
		public var stopHit:Boolean;
		public var onScreen:Boolean;
		public var destroyed:Boolean;
		public var destroyOffScreen:Boolean;
		public var dosLft:Boolean;
		public var dosRht:Boolean;
		public var dosTop:Boolean;
		public var dosBot:Boolean;
		public var hitDistOver:int;
		public var updateOffScreen:Boolean;
		public var hitTestAgainstNonGroundDct:CustomDictionary = new CustomDictionary();
		public var hitTestAgainstGroundDct:CustomDictionary = new CustomDictionary();
		public var hitTestTypesDct:CustomDictionary = new CustomDictionary();
		protected static const HT_CHARACTER:String = HitTestTypes.CHARACTER;
		protected static const HT_ENEMY:String = HitTestTypes.ENEMY;
		protected static const HT_PROJECTILE_ENEMY:String = HitTestTypes.PROJECTILE_ENEMY;
		protected static const HT_PROJECTILE_CHARACTER:String = HitTestTypes.PROJECTILE_CHARACTER;
		protected static const HT_PICKUP:String = HitTestTypes.PICKUP;
		protected static const HT_GROUND_NON_BRICK:String = HitTestTypes.GROUND_NON_BRICK;
		protected static const HT_BRICK:String = HitTestTypes.BRICK;
		protected static const HT_PLATFORM:String = HitTestTypes.PLATFORM;
		public var propsDct:Dictionary = new Dictionary();
		private const propAggOrderVec:Vector.<StatusProperty> = new Vector.<StatusProperty>();
		private const statusEffectsDct:Dictionary = new Dictionary();
		private var unappliedStatFxs:Vector.<StatusEffect>;
		protected var clearHitsAfterTime:int;
		/**
		 *contains items currently hitting
		 */
		public var hitDct:CustomDictionary = new CustomDictionary(true);

		public function LevObj()
		{
			super();
			if (!player)
				player = GlobVars.level.player;
			removeAllStatusEffects();
			if (areaRect)
				areaRect.visible = false;
			stop();
//			addEventListener(Event.ADDED_TO_STAGE, addedLsr);
			addEventListener(Event.REMOVED_FROM_STAGE, removedLsr);
			EVENT_MNGR.addEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_ACTIVATE, stopAllEnemiesPropActivateHandler, false, 0, true);
			EVENT_MNGR.addEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_DEACTIVATE, stopAllEnemiesPropDeactivateHandler, false, 0, true);
		}

		protected function stopAllEnemiesPropActivateHandler(event:Event):void
		{
			if ( hitTestTypesDct[HT_ENEMY] || hitTestTypesDct[HT_PROJECTILE_ENEMY] )
			{
				var stopAllProp:StatusProperty = player.getProperty(PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				if ( isSusceptibleToProperty( stopAllProp ) )
					addStatusEffect( new StatFxStop(this) );
			}
		}
		protected function stopAllEnemiesPropDeactivateHandler(event:Event):void
		{
			if ( hitTestTypesDct[HT_ENEMY] || hitTestTypesDct[HT_PROJECTILE_ENEMY] )
			{
				var stopAllProp:StatusProperty = player.getProperty(PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				if ( isSusceptibleToProperty( stopAllProp ) )
					removeStatusEffect(StatusEffect.TYPE_STOP);
			}
		}
		// called by level after x and y values set
		override public function initiate():void
		{
			super.initiate();
			fLabVec = Vector.<FrameLabel>(currentLabels);
			lx = this.x;
			ly = this.y;
			nx = lx;
			ny = ly;
			if (accurateAnimTmr)
			{
				if (accurateAnimTmr is CustomTimer)
				{
					mainAnimTmr = accurateAnimTmr as CustomTimer;
					addTmr(accurateAnimTmr);
				}
				accurateAnimTmr.addEventListener(TimerEvent.TIMER, accurateAnimTmrHandler, false, 0, true);
				accurateAnimTmr.start();
			}
			else if (mainAnimTmr)
				ACTIVE_ANIM_TMRS_DCT.addItem(mainAnimTmr);
			if (flashTmr && flashTmr is CustomTimer)
				addTmr(flashTmr);
			if (parent != level)
				level.addChild(this);
			setUpCommonPalettes();
			if ( player)
			{
				var timeStopProp:StatusProperty = player.getProperty(PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				if ( timeStopProp && isSusceptibleToProperty(timeStopProp) )
					stopAllEnemiesPropActivateHandler( null );
			}
		}
		private function updStopAnim():void
		{
			var trueDct:CustomDictionary = getReasonOvRds(NAME_STOP_ANIM,true);
			if (trueDct && trueDct.length)
				stopAnim = true;
			else
				stopAnim = false;
		}
		protected function updStopUpdate():void
		{
			var trueDct:CustomDictionary = getReasonOvRds(NAME_STOP_UPDATE,true);
			if (trueDct && trueDct.length)
				stopUpdate = true;
			else
				stopUpdate = false;
		}
		private function updStopTimers():void
		{
			var trueDct:CustomDictionary = getReasonOvRds(NAME_STOP_TIMERS,true);
			if (trueDct && trueDct.length)
				stopTimers();
			else
				resumeTimers();
		}
		protected function updStopStatusEffect(add:Boolean):void
		{
			if (add)
			{
				addReasonOvRd(NAME_STOP_ANIM,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				addReasonOvRd(NAME_STOP_UPDATE,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				addReasonOvRd(NAME_STOP_TIMERS,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
			}
			else
			{
				removeReasonOvRd(NAME_STOP_ANIM,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				removeReasonOvRd(NAME_STOP_UPDATE,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
				removeReasonOvRd(NAME_STOP_TIMERS,true,PR_STOP_ALL_ENEMIES_ACTIVE_AGG);
			}
		}
		protected function accurateAnimTmrHandler(event:TimerEvent):void
		{
			if ( animate(accurateAnimTmr) )
				checkFrame();
		}
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			if ( getStatusEffect(STATFX_FLASH) )
			{
				resetColor();
				super.gotoAndStop(frame, scene);
				flash(false);
			}
			else
				super.gotoAndStop(frame, scene);
//			if (flashWhiteTmr)
//				flashWhiteChangeColor();
		}
		/*override public function get height():Number
		{
			if (areaRect)
				return areaRect.height;
			else
				return super.height;
		}*/
		override protected function addedToStageHandler(e:Event):void
		{
			super.addedToStageHandler(e);
			var i:int;
			onScreen = true;
			if (P_TMR_DCT)
				resumeTimers();
		}
		protected function removedLsr(e:Event):void
		{
			onScreen = false;
			if (destroyOffScreen)
				destroy();
			if (!destroyed && (dosTop || dosBot || dosLft || dosRht))
				checkDosSides();
			if (TMR_DCT)
				stopTimers();
		}
		protected function checkDosSides():void
		{
			// for other classes
		}
		public static function updPlayerRef(value:Character):void
		{
			player = value;
		}
		public function updateObj():void
		{
			dt = level.dt;
			lx = this.x;
			ly = this.y;
			nx = lx;
			ny = ly;
			locStgTop = level.locStgTop;
			locStgLft = level.locStgLft;
			locStgBot = level.locStgBot;
			locStgRht = level.locStgRht;
		}
		// DRAWOBJ
		public function drawObj():void
		{
			this.x = nx;
			this.y = ny;
			// get global coordinates
			globX = localToGlobal(ZERO_PT).x;
			globY = localToGlobal(ZERO_PT).y;
			if (!(this is Character))
				checkLoc();
		}
		// for override

		public function setState(_nState:String):void
		{
			if (!lockState)
			{
				lState = cState;
				cState = _nState;
			}
		}
		public function getLabNum(_fLab:String):uint
		{
			var n:int = fLabVec.length;
			for (var i:uint = 0; i<n; i++)
			{
				if (fLabVec[i].name == _fLab)
					return(fLabVec[i].frame);
			}
			return 0;
		}
		public function addHitTestableItem(item:String):void
		{
			if (item == HT_BRICK || item == HT_GROUND_NON_BRICK || item == HT_PLATFORM)
				hitTestAgainstGroundDct.addItem(item);
			else
				hitTestAgainstNonGroundDct.addItem(item);
		}
		public function hasHitTestableItem(item:String):Boolean
		{
			if (item == HT_BRICK || item == HT_GROUND_NON_BRICK || item == HT_PLATFORM)
				return Boolean( hitTestAgainstGroundDct[item] );
			return Boolean( hitTestAgainstNonGroundDct[item] );
		}
		protected function addAllGroundToHitTestables():void
		{
			addHitTestableItem(HT_GROUND_NON_BRICK);
			addHitTestableItem(HT_BRICK);
			addHitTestableItem(HT_PLATFORM);
		}
		public function removeHitTestableItem(item:String):void
		{
			if (item == HT_BRICK || item == HT_GROUND_NON_BRICK || item == HT_PLATFORM)
				hitTestAgainstGroundDct.removeItem(item);
			else
				hitTestAgainstNonGroundDct.removeItem(item);
		}
		public function removeAllHitTestableItems():void
		{
			hitTestAgainstGroundDct.clear();
			hitTestAgainstNonGroundDct.clear();
		}
		public function addTmr(t:ICustomTimer):void
		{
			TMR_DCT.addItem(t);
			level.addTmr(t);
		}
		public function removeTmr(t:ICustomTimer):void
		{
			if (t.running)
				t.stop();
			if (t is GameLoopTimer)
				GameLoopTimer(t).destroy();
			TMR_DCT.removeItem(t);
			P_TMR_DCT.removeItem(t);
			level.removeTmr(t);
		}
		protected function resumeTimers():void
		{
			for each (var t:ICustomTimer in P_TMR_DCT)
			{
				t.resume();
				P_TMR_DCT.removeItem(t);
			}
		}
		protected function stopTimers():void
		{
			for each (var t:ICustomTimer in TMR_DCT)
			{
				if (t.running && !destroyed)
				{
					t.pause();
					P_TMR_DCT.addItem(t);
				}
				else if (destroyed)
				{
					t.stop();
					removeTmr(t);
				}
			}
		}
		protected function correctFloatingPointError(number:Number, precision:int = 5):Number
		{
			//default returns (10000 * number) / 10000
			//should correct very small floating point errors
			var correction:Number = Math.pow(10, precision);
			return Math.round(correction * number) / correction;
		}
		protected function removeListeners():void
		{
//			if (hasEventListener(Event.ADDED_TO_STAGE)) removeEventListener(Event.ADDED_TO_STAGE, addedLsr);
			if (hasEventListener(Event.REMOVED_FROM_STAGE)) removeEventListener(Event.REMOVED_FROM_STAGE, removedLsr);
			if (accurateAnimTmr)
				accurateAnimTmr.removeEventListener(TimerEvent.TIMER, accurateAnimTmrHandler);
			if (flashTmr)
				flashTmr.removeEventListener(TimerEvent.TIMER,flashTmrHandler);
			EVENT_MNGR.removeEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_ACTIVATE, stopAllEnemiesPropActivateHandler);
			EVENT_MNGR.removeEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_DEACTIVATE, stopAllEnemiesPropDeactivateHandler);
		}
		protected function reattachLsrs():void
		{
//			if (!hasEventListener(Event.ADDED_TO_STAGE))
//				addEventListener(Event.ADDED_TO_STAGE, addedLsr);
			if (!hasEventListener(Event.REMOVED_FROM_STAGE))
				addEventListener(Event.REMOVED_FROM_STAGE, removedLsr);
			if (accurateAnimTmr)
				accurateAnimTmr.addEventListener(TimerEvent.TIMER, accurateAnimTmrHandler, false, 0, true);
			if (flashTmr)
				flashTmr.addEventListener(TimerEvent.TIMER,flashTmrHandler,false,0,true);
			EVENT_MNGR.addEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_ACTIVATE, stopAllEnemiesPropActivateHandler, false, 0, true);
			EVENT_MNGR.addEventListener(CustomEvents.STOP_ALL_ENEMIES_PROP_DEACTIVATE, stopAllEnemiesPropDeactivateHandler, false, 0, true);
		}
		public function checkLoc():void
		{
			//;alskdf
		}
		public function destroy():void
		{
			removeAllHitTestableItems();
			level.destroy(this);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (parent)
				parent.removeChild(this);
			removeAllStatusEffects();
			removeListeners();
			stopTimers();
			dispatchEvent(new Event(CustomEvents.CLEAN_UP));
		}
		public function finalCheck():void
		{
			// last thing called by anything in LEV_OBJ_FINAL_CHECK_DCT
		}
		public function disarm():void
		{
			if (parent == level)
				level.removeChild(this);
			stopTimers();
			removeListeners();
			level = null;
			player = null;
		}
		public function rearm():void
		{
			level = Level.levelInstance;
			player = level.player;
			for each (var t:ICustomTimer in TMR_DCT)
			{
				if (level)
					level.addTmr(t);
			}
			reattachLsrs();
			resumeTimers();
			if (parent != level)
				level.addChild(this);
			drawObj();
		}
		public function addReasonOvRd(varName:String,value:*,reason:String):void
		{
			if (reason == RSN_OVERRIDE)
				throw new Error("not set up for override reason");
			if (reasonOvRdObj[varName] == undefined)
				reasonOvRdObj[varName] = new Dictionary();
			var lev1:Dictionary = reasonOvRdObj[varName];
			if (lev1[value] == undefined)
				lev1[value] = new CustomDictionary();
			var lev2:CustomDictionary = lev1[value];
			lev2.addItem(reason);
			var fct:Function = this[varName];
			if (fct is Function)
				fct();
		}
		public function removeReasonOvRd(varName:String,value:*,reason:String):void
		{
			if (reasonOvRdObj[varName] != undefined && reasonOvRdObj[varName][value] != undefined)
			{
				if (reason != RSN_OVERRIDE)
					CustomDictionary( reasonOvRdObj[varName][value] ).removeItem(reason);
				else
					delete reasonOvRdObj[varName][value];
			}
			var fct:Function = this[varName];
			if (fct is Function)
				fct();
		}
		public function getReasonOvRds(varName:String,value:*):CustomDictionary
		{
			if (reasonOvRdObj[varName] == undefined)
				return null;
			return reasonOvRdObj[varName][value];
		}
		public function initiateRecolor():void
		{

		}
		public function recolorChildren(obj:DisplayObjectContainer,inColor:uint,outColor:uint):void
		{
			var n:int = obj.numChildren;
			for (var i:int = 0; i < n; i++)
			{
				var mc:DisplayObject = obj.getChildAt(i);
				if (mc is Bitmap)
				{
					var bmd:BitmapData = Bitmap(mc).bitmapData;
					if (obj is MovieClip)
						bmd.threshold(bmd,bmd.rect,ZERO_PT,"==",inColor,outColor);
				}
			}
		}
		public function hit(mc:LevObj,hType:String):void
		{
			hitDct.addItem(mc,hType);
		}
		public function traceHitItems():void
		{
			var str:String = " is hitting: ";
			for (var key:Object in hitDct)
			{
				var value:String = hitDct[key];
				str+=key + ": "+ value + ", ";
			}
//			trace(this.toString() + str);
		}
		public function shiftHit(mc:LevObj,side:String,pen:Number):void
		{
			// for enemy
		}
		public function confirmedHitProj(proj:Projectile):void
		{
			// blah
		}
		public function checkStgPos():void
		{
			// stage position
		}
		protected function addProperty(prop:StatusProperty):void
		{
			propsDct[prop.type] = prop;
			updPropOrderVec();
		}
		protected function removeProperty(type:String):void
		{
			delete propsDct[type];
			updPropOrderVec();
		}
		protected function removeAllProperties():void
		{
			for (var key:Object in propsDct)
			{
				delete propsDct[key];
			}
			propAggOrderVec.fixed = false;
			propAggOrderVec.length = 0;
			propAggOrderVec.fixed = true;
		}
		private function updPropOrderVec():void
		{
			propAggOrderVec.fixed = false;
			propAggOrderVec.length = 0;
			var n:int = PROP_ORDER_REFERENCE.length;
			for (var i:int = 0; i < n; i++)
			{
				var type:String = PROP_ORDER_REFERENCE[i];
				if (propsDct[ type ])
					propAggOrderVec.push( getProperty(type ) );
			}
			propAggOrderVec.fixed = true;
		}
		public function getPropOrderVec():Vector.<StatusProperty>
		{
			if (!propsDct[PR_PIERCE_AGG])
				throw new Error(this+"does not having aggressive piercing");
			return propAggOrderVec;
		}
		public function getProperty(type:String):StatusProperty
		{
			return propsDct[type];
		}
		public function isSusceptibleToProperty(aggProp:StatusProperty):Boolean
		{
			if (!aggProp)
				throw new Error("property does not exist");
			if ( StatusProperty.getPassiveFromType(aggProp.type) )
				throw new Error("aggProp must be aggressive");
			var oppType:String =  StatusProperty.getOpposingType(aggProp.type);
			if (!oppType)
				return true;
			var srcProp:StatusProperty = getProperty(oppType);
			if (!srcProp || aggProp.strength >= srcProp.strength)
				return true;
			return false;
		}
		public function addStatusEffect(effect:StatusEffect,apply:Boolean = true):void
		{
			var oldEffect:StatusEffect = statusEffectsDct[effect.type];
			if (oldEffect)
			{
				if ( oldEffect.checkIfReplaceWithSameType(effect) )
					oldEffect.destroy();
				else
					return;
			}
			statusEffectsDct[effect.type] = effect;
			if (apply)
				effect.apply();
//			addReasonOvRd(effect.type,true,reason);
		}
		public function removeStatusEffect(effectType:String):void
		{
//			removeReasonOvRd(effectType,true,reason);
//			var dct:CustomDictionary = getReasonOvRds(effectType,true);
//			if ( !dct || !dct.length )
			var effect:StatusEffect = statusEffectsDct[effectType];
			if (effect)
			{
				delete statusEffectsDct[effectType];
				if (!effect.destroyed)
					effect.destroy();
			}
		}
		public function updateStatusEffects():void
		{
			for each (var statFx:StatusEffect in statusEffectsDct)
			{
				statFx.targetUpdate();
			}
		}
		protected function removeAllStatusEffects():void
		{
			for each (var effect:StatusEffect in statusEffectsDct)
			{
				removeStatusEffect(effect.type);
			}
		}
		public function getStatusEffect(type:String):StatusEffect
		{
			var blah:Dictionary = statusEffectsDct;
			return statusEffectsDct[type];
		}
	/*	protected function applyNewStatusEffects():void
		{
			var firstFx:StatusEffect = statusEffectsDct[STATFX_STOP];
			if (firstFx)
				firstFx.apply();
			firstFx = statusEffectsDct[STATFX_KNOCK_BACK];
			if (firstFx)
				firstFx.apply();
			for each (var effect:StatusEffect in statusEffectsDct)
			{
				if (!effect.applied)
					effect.apply();
			}
		}*/
//		protected function removeAllProperties():void
//		{
//			propsDct.clear();
//		}
		/*private function callStatusEffectFct(effect:StatusEffect, add:Boolean):void
		{
			switch(effect)
			{
				case StatusEffects.FLASH:
				{
					updFlashStatusEffect(add);
					break;
				}
				case StatusEffects.FREEZE:
				{
					updFreezeStatusEffect(add);
					break;
				}
				case StatusEffects.STOP:
				{
					updStopStatusEffect(add);
					break;
				}
			}
		}*/
	}
}

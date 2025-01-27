package com.smbc.pickups
{

	import com.customClasses.*;
	import com.smbc.characters.*;
	import com.smbc.data.CharacterInfo;
	import com.smbc.data.GameSettings;
	import com.smbc.data.PickupInfo;
	import com.smbc.enemies.Enemy;
	import com.smbc.enemies.PiranhaGreen;
	import com.smbc.ground.*;
	import com.smbc.level.Level;
	import com.smbc.main.AnimatedObject;
	import com.smbc.main.LevObj;
	import com.smbc.managers.StatManager;
	import com.smbc.utils.GameLoopTimer;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.getDefinitionByName;

	public class Pickup extends AnimatedObject
	{
		protected static const MAIN_TYPE_UPGRADE:String = PickupInfo.MAIN_TYPE_UPGRADE;
		protected static const MAIN_TYPE_FAKE:String = PickupInfo.MAIN_TYPE_FAKE;
		protected static const MAIN_TYPE_REGULAR:String = PickupInfo.MAIN_TYPE_REGULAR;

		protected static const UPGRADE_STR:String = PickupInfo.UPGRADE_STR;
		protected static const REGULAR_STR:String = PickupInfo.REGULAR_STR;
		protected static const FAKE_STR:String = PickupInfo.FAKE_STR;

		public static const DEFAULT_X_SPEED:int = 120;
		public var playsRegularSound:Boolean;
		public var grabbedByBoomerang:Boolean;
		protected var _boomerangGrabbable:Boolean;
		public var type:String;
		protected var source:LevObj;
		public var mainType:String;
		protected var mainFrameLabel:String;
		protected var targetHeight:Number;
		protected var riseSpeed:uint;
		protected var inBox:Boolean;
		protected var touchedWall:Boolean;
		public var brickParent:Brick;
		private static const DEL_ALPHA_CHANGE:int = 4000;
		private static const DEL_DESTROY:int = 3000;
		private static const ALPHA_DISAPPEARING:Number = .65;
		private var disappearTmr:GameLoopTimer;

		public function Pickup(type:String = null):void
		{
			super();
			this.type = type;
			if (type)
			{
				mainFrameLabel = type.substr(UPGRADE_STR.length);
				if (type.indexOf(REGULAR_STR) != -1)
				{
					mainType = MAIN_TYPE_REGULAR;
					gotoAndStop(mainFrameLabel);
					stopAnim = true;
					_boomerangGrabbable = true;
				}
				else if (type.indexOf(UPGRADE_STR) != -1)
				{
					mainType = MAIN_TYPE_UPGRADE;
					gotoAndStop(mainFrameLabel);
					stopAnim = true;
					STAT_MNGR.prepareNextUpgrade(player.charNum,type);
					_boomerangGrabbable = true;
				}
				else if (type.indexOf(FAKE_STR) != -1)
					mainType = MAIN_TYPE_FAKE;
			}
			riseSpeed = 40;
			hitTestTypesDct.addItem(HT_PICKUP);
			addHitTestableItem(HT_CHARACTER);
		}
		override public function setStats():void
		{
			super.setStats();
			defyGrav = true;
			gravity = 1400;
		}
		override protected function updateStats():void
		{
			super.updateStats();
//			touchedWall = false;
			if (inBox && hBot <= targetHeight && !grabbedByBoomerang)
				exitBrickEnd();
		}
		public function exitBrickStart(b:Brick):void
		{
			addHitTestableItem(HT_BRICK);
			bottomAo = true;
			if (mainType != MAIN_TYPE_FAKE)
				_boomerangGrabbable = true;
			brickParent = b;
			x = b.x + TILE_SIZE/2;
			y = b.y + TILE_SIZE;
			targetHeight = b.y;
			defyGrav = true;
			behindGround = true;
			stopHit = false;
			inBox = true;
			vy = -riseSpeed;
		}
		protected function exitBrickEnd():void
		{
			inBox = false;
			defyGrav = true;
			behindGround = false;
			ny = brickParent.y;
			vy = 0;
		}
		public function appearFromObject(source:LevObj):void
		{
			this.source = source;
			x = source.hMidX;
			y = source.hMidY + height/2;
			if (source is PiranhaGreen)
			{
				var piranha:PiranhaGreen = source as PiranhaGreen;
				if (!piranha.upsideDown)
					y = piranha.outY - height/2;
				else
					y = piranha.outY + TILE_SIZE + height/2;
			}
			defyGrav = true;
			disappearTmr = new GameLoopTimer(DEL_ALPHA_CHANGE,1);
			addTmr(disappearTmr);
			disappearTmr.addEventListener(TimerEvent.TIMER_COMPLETE,disappearTmrHandler,false,0,true);
			disappearTmr.start();
		}

		override public function initiate():void
		{
			super.initiate();
			if (disappearTmr && source)
			{
				if (source is AnimatedObject && !(source is PiranhaGreen) )
				{
					copyLastStatsFromObject(source as AnimatedObject);
				}
			}
		}


		protected function disappearTmrHandler(event:Event):void
		{
			disappearTmr.stop();
			if (disappearTmr.delay == DEL_ALPHA_CHANGE)
			{
				alpha = ALPHA_DISAPPEARING;
				disappearTmr.delay = DEL_DESTROY;
				disappearTmr.start();
			}
			else
			{
				disappearTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,disappearTmrHandler);
				disappearTmr = null;
				destroy();
			}
		}

		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (disappearTmr)
				disappearTmr.addEventListener(TimerEvent.TIMER_COMPLETE,disappearTmrHandler,false,0,true);
		}

		override protected function removeListeners():void
		{
			super.removeListeners();
			if (disappearTmr)
				disappearTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,disappearTmrHandler);
		}


		public static function generateNextUpgrade():Pickup
		{
			var charNum:int = StatManager.STAT_MNGR.curCharNum;
			var puType:String = StatManager.STAT_MNGR.getRandomUpgrade(charNum);
			if (GameSettings.DEBUG_MODE && GameSettings.FORCE_NEXT_PICKUP)
				puType = GameSettings.FORCE_NEXT_PICKUP;
			if (puType == PickupInfo.MUSHROOM)
				return new Mushroom(Mushroom.ST_RED);
			else if (puType == PickupInfo.MARIO_FIRE_FLOWER || puType == PickupInfo.FIRE_FLOWER)
				return new FireFlower();
			var pickupClass:Class = PickupInfo.getPickupClass(charNum);
			return Pickup( new pickupClass(puType) );
		}
		public function touchPlayer(char:Character):void
		{
			destroy();
//			if (isAmmo)
//				STAT_MNGR.numAmmoPickupsCollected++;
		}
		override public function shiftHit(mc:LevObj,side:String,pen:Number):void
		{
			/*if (side == "left")
				nx += pen/2 + .2;
			else if (side == "right")
				nx -= pen/2 - .2;
			if (mc is Ground)
				groundOnSide(mc as Ground,side);*/
		}
		public function get boomerangGrabbable():Boolean
		{
			return _boomerangGrabbable;
		}
	}
}

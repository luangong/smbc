package com.smbc.pickups
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.Character;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PickupInfo;
	import com.smbc.graphics.VineSegment;
	import com.smbc.ground.Brick;
	import com.smbc.level.Level;

	public class Vine extends Pickup
	{
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		private static var hRectDefHeight:Number;
		private static var hRectDefY:Number;
		private var fromBox:Boolean;
		private var globDest:String = "";
		private var globPipeExInt:int;
		private var color:String;
//		private var numVineSeg:int;
		public var yStart:Number;
		private var startHeight:Number;
		private var segDct:CustomDictionary = new CustomDictionary(true);
		public function Vine(fLab:String)
		{
			super(PickupInfo.VINE);
			mainAnimTmr = MAIN_ANIM_TMR;
			riseSpeed = 60;
			stopAnim = false;
			defyGrav = true;
			vx = 0;
			vy = 0;
//			set color
			if (fLab.indexOf("Green") != -1)
				color = "green";
			else if (fLab.indexOf("Blue") != -1)
				color = "blue";
//			get destination level/area
			trace(fLab);
			var sInd:int = fLab.indexOf("&&pTransDest=")+13;
			var eInd:int = fLab.indexOf("&&",sInd);
			if (eInd == -1)
				eInd = fLab.length;
			if (sInd != -1)
				globDest = fLab.substring(sInd,eInd);
			var globPipeExIntStr:String = Level.ExtractLevelDataProperty(fLab, Level.PROP_NUMBER, true);
			if (globPipeExIntStr != null)
				globPipeExInt = int(globPipeExIntStr);
			gotoAndStop(color);
			startHeight = height;
			/*if (isNaN(hRectDefHeight))
			{
				hRectDefHeight = hRect.height;
				hRectDefY = hRect.y;
			}*/
			behindGround = true;
		}
	 	override public function initiate():void
		{
		 	super.initiate();
		 	if (inBox)
				fromBox = true;
		 	else
		 	{
		 		player.visible = false;
		 		level.watchModeOverrideVine = true;
		 		growFromStgBot();
		 	}
		}
		override public function exitBrickStart(b:Brick):void
		{
			super.exitBrickStart(b);
			targetHeight = GLOB_STG_TOP - TILE_SIZE*2;
			yStart = y - TILE_SIZE;
		}
		private function growFromStgBot():void
		{
			globDest = "";
			y = GLOB_STG_BOT;
			yStart = y;
			targetHeight = y - TILE_SIZE*5;
			defyGrav = true;
			inBox = true;
			vy = -riseSpeed;
		}
		override protected function updateStats():void
		{
			super.updateStats();
			touchedWall = false;
			if (inBox)
			{
				if (yStart - hTop >= getFakeHeight())
					extendVine();
				if (hTop <= targetHeight)
					exitBrickEnd();
			}
		}
		override protected function exitBrickEnd():void
		{
			inBox = false;
			vy = 0;
			ny = targetHeight + TILE_SIZE;
			setHitPoints();
			if (!fromBox)
				player.climbVineStarter(this);
		}
		private function extendVine():void
		{
			var vs:VineSegment = new VineSegment(color);
			vs.y = Math.round(getFakeHeight() - vs.height);
			addChild(vs);
			segDct.addItem(vs);
//			setChildPoperty(hRect,"height", hRect.height + TILE_SIZE);
			hRect.height += TILE_SIZE;
			setHitPoints();
		}

		private function getFakeHeight():int
		{
			return (segDct.length + 1)*TILE_SIZE;
		}
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			super.gotoAndStop(frame, scene);
			for each (var vs:VineSegment in segDct)
			{
				addChild(vs);
				vs.gotoAndStop(currentFrame);
			}
			if (hRect)
			{
				hRect.height = getFakeHeight();
				hRect.y = -TILE_SIZE;
			}
			setHitPoints();
		}


		override public function hitCharacter(char:Character,side:String):void
		{
		//	destroy();
		}
		override public function rearm():void
		{
			super.rearm();
			if (!fromBox)
			{
				player.visible = false;
				level.watchModeOverrideVine = true;
				player.vineToClimb = this;
			}

		}
		public function get vineDest():String
		{
			return globDest;
		}
		public function get vineExInt():int
		{
			return globPipeExInt
		}
		override public function touchPlayer(char:Character):void
		{

		}
	}
}

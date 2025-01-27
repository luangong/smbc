package com.smbc.pickups
{

	import com.customClasses.*;
	import com.smbc.characters.*;
	import com.smbc.data.PickupInfo;
	import com.smbc.ground.*;
	import com.smbc.level.Level;
	import com.smbc.main.*;

	import nl.demonsters.debugger.MonsterDebugger;

	public class PipeTransporter extends Pickup
	{
		public static const P_TRANS_DEST_STR:String = "pTransDest";
		public static const WARP_STR:String = "pipeTransporterWarp";
		protected var teleNum:int;
		public var globDest:String;
		public var globPipeExInt:int;
		public var pipeInt:int;
		protected var teleDest:Teleporter;
		protected var teleStart:Teleporter
		protected var teleEndDist:Number;
		public var axis:String;
		protected var checkPtVec:Vector.<Array>;
		public var ptType:String;
		protected var numCheckPts:int;
		protected var active:Boolean;
		protected var oneCP:Boolean;

		public function PipeTransporter(fStr:String):void
		{
			super(PickupInfo.PIPE_TRANSPORTER);
			_boomerangGrabbable = false;
			if (fStr.indexOf("Global") != -1 || fStr.indexOf(WARP_STR) != -1)
			{
				if (fStr.indexOf("End") != -1)
					ptType = "globalEnd";
				else
					ptType = "global";
				var numInd:int = fStr.indexOf("number=")+7;
				if (numInd != -1)
				{
					if (ptType == "global")
						globPipeExInt = int(fStr.charAt(numInd));
					else if (ptType == "globalEnd")
						pipeInt = int(fStr.charAt(numInd));
				}
				var sInd:int = fStr.indexOf("&&" + P_TRANS_DEST_STR + "=");
				if (sInd != -1)
					sInd += 13;
				var eInd:int = fStr.indexOf("&&",sInd);
				if (eInd == -1)
					eInd = fStr.length;
				if (sInd != -1)
				{
					globDest = fStr.substring(sInd,eInd);
					if (globDest == "0")
						globDest = Level.levelInstance.areaStr;
				}
				if (fStr.indexOf("Vert") != -1)
					axis = "vertical";
				else if (fStr.indexOf("Horz") != -1)
					axis = "horizontal";
				gotoAndStop(axis);
			}
			else if (fStr.indexOf("Local") != -1)
			{
				ptType = "local";
				teleNum = int(fStr.charAt(fStr.indexOf("&&number=") + 9));
				gotoAndStop("vertical");
			}
			else if (fStr.indexOf("pitTransferEnd") != -1)
			{
				ptType = "globalEnd";
				axis = "vertical";
				pipeInt = -1;
				gotoAndStop(axis);
			}
			defyGrav = true;
			stopAnim = true;
		}
		override public function hitCharacter(char:Character,side:String):void
		{

		}
		override public function touchPlayer(char:Character):void
		{

		}
	}
}

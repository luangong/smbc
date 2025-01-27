package com.smbc.graphics
{
	import com.customClasses.MCAnimator;
	import com.smbc.characters.Character;
	import com.smbc.data.GameSettings;
	import com.smbc.data.GameStates;
	import com.smbc.graphics.BmdSkinCont;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;
	import com.smbc.main.SkinObj;
	import com.smbc.managers.GameStateManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.StatManager;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class SubMc extends SkinObj
	{
		protected var suffixVec:Vector.<String> = Vector.<String>(["","",""]);
		protected var hasPState2:Boolean;
		public var parChar:Character;
		public var hitStopAnim:Boolean;
		public var hitFrameLabel:String;
		public var recolor:Boolean;
		public var charNum:int;
		public function SubMc(parChar:Character = null)
		{
			this.parChar = parChar;
			charNum = parChar.charNum;
			parChar.addSubMc(this);
			super();
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (!stopAnim)
			{
				ANIMATOR.animate(this);
				checkFrame();
				return true;
			}
			return false;
		}
		override public function resetColor(useCleanBmd:Boolean = false):void
		{
			if (useCleanBmd)
				redraw(currentFrame,getCleanMasterBmdSkinForReading().bmd);
			else
				redraw(currentFrame);
		}


		// CONVLAB
		public function convLab(_fLab:String):String
		{
//			var num:int;
//			if (parChar)
//				num = parChar.pState - 1;
//			else
//				num = Character.PS_MUSHROOM;
//			return _fLab + suffixVec[num];
			return _fLab;
		}
		override public function gotoAndStop(frame:Object, scene:String=null):void
		{
			if (parChar.replaceColor)
				resetColor();
			super.gotoAndStop(frame,scene);
			if (parChar.getFlashArr())
			{
				var flashArr:Array = parChar.getFlashArr();
				recolorBmps(flashArr[IND_FLASH_ARR_PAL_IN], flashArr[IND_FLASH_ARR_PAL_OUT], flashArr[IND_FLASH_ARR_IN_COLOR], flashArr[IND_FLASH_ARR_OUT_COLOR], parChar.defColors);
			}
		}

		protected function cmcGotoAndStop(frame:Object, scene:String=null):void
		{
			super.gotoAndStop(frame, scene);
		}

		public function setStopFrame(stopFrame:String):void
		{
			gotoAndStop(convLab(stopFrame));
			stopAnim = true;
		}
		public function setPlayFrame(stopFrame:String):void
		{
			gotoAndStop(convLab(stopFrame));
			stopAnim = false;
		}

	}
}

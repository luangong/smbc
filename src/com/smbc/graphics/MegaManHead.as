package com.smbc.graphics
{
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.characters.MegaMan;
	import com.smbc.characters.base.MegaManBase;
	import com.smbc.level.Level;
	import com.smbc.main.GlobVars;

	import flash.display.MovieClip;

	//[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="MegaManHead")]
	public class MegaManHead extends SubMc
	{
		private var level:Level = GlobVars.level;
		private const GAME:SuperMarioBrosCrossover = SuperMarioBrosCrossover.game;
		private var showOutline:Boolean;
		private const HAIR_OUTLINE_X:int = 1;
		private const HAIR_OUTLINE_Y:int = -4;

		public function MegaManHead(megaMan:MegaManBase,mc:MovieClip = null)
		{
			super(megaMan);
//			if (mc)
//				createMasterFromMc(mc);
			hasPState2 = true;
		}
		override public function checkFrame():void
		{
			var pcfl:String = parChar.currentLabel;
			var cs:String = parChar.cState;
			var ps:int = parChar.pState;
			var wind:String = "Wind";
			var cfl:String = currentLabel;
			var nf:String;
			if (cs == "stand")
				setStopFrame("openClosed");
			// walk
			else if (cs == "walk")
			{
				if (cfl.indexOf(wind) != -1)
					setStopFrame("openClosed");
				else
					setStopFrame("openClosed"+wind);
			}
			// jump
			else if (cs == "jump")
			{
				if (cfl.indexOf(wind) != -1)
					setStopFrame("openClosed");
				else
					setStopFrame("openClosed"+wind);
			}
			else if (cs == "flagSlide" || cs == "vine")
			{
				setStopFrame("climb");
			}
			// slide
			else if (cs == "slide")
			{
				if (cfl.indexOf(wind) != -1)
					setStopFrame("openClosed");
				else
					setStopFrame("openClosed"+wind);
			}
			// helmet getting put on
			else if (cs == "poweringUp" && ps == 2)
			{
				if (cfl == convLab("getHelmetEnd"))
					stopAnim = true;
			}
		}

	}
}

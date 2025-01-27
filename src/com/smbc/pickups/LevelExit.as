package com.smbc.pickups
{
	import com.smbc.data.PickupInfo;
	import com.smbc.level.Level;

	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="LevelExit")]
	public class LevelExit extends Pickup
	{
		import com.smbc.characters.Character;
		public function LevelExit()
		{
			super(PickupInfo.LEVEL_EXIT);
			defyGrav = true;
			stopAnim = true;
			hitDistOver = Level.GLOB_STG_BOT/2;
		}
		override public function initiate():void
		{
			super.initiate();
			var gsb:int = Level.GLOB_STG_BOT;
			//setChildHeight(hRect,gsb);
			setChildPoperty(hRect,"height",gsb);
			setChildPoperty(hRect,"y",-gsb);
//			hRect.height = gsb;
//			hRect.y = -gsb;
			ny = gsb;
			y = ny;
			setHitPoints();
		}
		override public function hitCharacter(char:Character,side:String):void
		{
			// don't do anything
		}

		override public function touchPlayer(char:Character):void
		{
			// don't do anything
		}

	}
}

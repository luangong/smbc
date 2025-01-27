package com.smbc.pickups
{
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.PickupInfo;
	import com.smbc.enemies.*;
	import com.smbc.ground.*;
	import com.smbc.main.*;

	import flash.display.MovieClip;

	public class Star extends Pickup
	{
		// Constants:
		// Public Properties:
		// Private Properties:
		private const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_FAST_TMR;
		public var color:String;


		// Initialization:
		public function Star():void
		{
			super(PickupInfo.STAR);
			playsRegularSound = true;
			xSpeed = DEFAULT_X_SPEED;
			ySpeed = 500;
			mainAnimTmr = MAIN_ANIM_TMR;
			stopAnim = false;
			addAllGroundToHitTestables();
		}
		override protected function updateStats():void
		{
			super.updateStats();
			touchedWall = false;
			hitCeiling = false;
			if (onGround && !inBox)
				vy = -ySpeed;
		}
		override protected function exitBrickEnd():void
		{
			super.exitBrickEnd();
			vx = xSpeed;
			defyGrav = false;
		}

		override public function groundOnSide(g:Ground,side:String):void
		{
			if (!touchedWall)
			{
				if (side == "left")
			{
				if (vx < 0)
				{
					vx = -vx;
				}
				nx = g.hRht + hWidth/2;
				wallOnLeft = true;
			}
			else if (side == "right")
			{
				if (vx > 0)
				{
					vx = -vx;
				}
				wallOnRight = true;
				nx = g.hLft - hWidth/2;
			}
			super.groundOnSide(g,side);
			}
			touchedWall = true;
		}
		override public function groundAbove(g:Ground):void {
			hitCeiling = true;
			ny = g.hBot + hHeight;
			if (!onGround)
			{
				vy = 0;
				//ny += 5;
			}
			super.groundAbove(g);
		}
		override public function checkFrame():void
		{
			if (currentFrame >= totalFrames) gotoAndStop(1);
		}
		// Public Methods:
		// Protected Methods:
	}

}

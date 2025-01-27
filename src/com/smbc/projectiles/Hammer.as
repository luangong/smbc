package com.smbc.projectiles
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.characters.*;
	import com.smbc.data.AnimationTimers;
	import com.smbc.enemies.Bowser;
	import com.smbc.enemies.Enemy;
	import com.smbc.enemies.HammerBro;

	import flash.display.MovieClip;
	import flash.geom.Point;

	public class Hammer extends Projectile
	{
		public static const TYPE_NORMAL:String = "normal";
		public static const TYPE_BOWSER:String = "bowser";
		public static const TYPE_BOWSER_FAKE:String = "bowserFake";
		protected var thrower:Enemy;
		protected var type:String;
		// Constants:
		// Public Properties:
		// Private Properties:

		// Initialization:
		public function Hammer(type:String,thrower:Enemy):void
		{
			this.type = type;
			this.thrower = thrower;
			super(thrower,SOURCE_TYPE_ENEMY);
			stopAnim = false;
			mainAnimTmr = AnimationTimers.ANIM_MODERATE_TMR;
			destroyOffScreen = false;
			dosLft = true;
			dosRht = true;
			dosBot = true;
			xSpeed = 120;
			jumpPwr = 200;
			gravity = 500;
			vyMaxPsv = 500;
			addProperty( new StatusProperty( PR_PASSTHROUGH_DEFEAT) );
			gotoAndStop(type + "Start");
			setDir();
		}
		override protected function setDir():void
		{
			if (thrower.scaleX > 0)
			{
				vx = xSpeed;
				x = thrower.nx + thrower.hWidth*.75;
				y = thrower.ny - thrower.height*1.2;
			}
			else
			{
				vx = -xSpeed;
				scaleX = -1;
				x = thrower.nx - thrower.hWidth*.75;
				y = thrower.ny - thrower.height*1.2;
			}
			vy = -jumpPwr;
		}
		override public function checkFrame():void
		{
			if (currentFrameLabel == type + "End")
				gotoAndStop(type + "Start");
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (thrower is Bowser)
				Bowser(thrower).HAMMER_DCT.removeItem(this);
		}
	}

}

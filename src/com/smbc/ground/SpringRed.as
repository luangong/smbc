package com.smbc.ground
{
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.characters.*;
	import com.smbc.data.AnimationTimers;
	import com.smbc.enemies.*;
	import com.smbc.main.*;
	import com.smbc.pickups.*;
	import com.smbc.projectiles.*;
	import com.smbc.sound.*;

	import flash.media.*;

//	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="SpringObj")]
	public class SpringRed extends Ground
	{
		private var color:String;
		public var defSpringPwr:int = 500;
		public var boostSpringPwr:int = 1000;
		public const SPRING_OBJS_DCT:CustomDictionary = new CustomDictionary(true);

		public function SpringRed()
		{
			super("");
			color = "brown";
			gotoAndStop(color + "Start");
			stopAnim = true;
			_animated = true;
			mainAnimTmr = AnimationTimers.ANIM_MIN_FAST_TMR;
		}
		// called by AnimatedObject when it is on spring
		public function sprBounce():void
		{
			if (stopAnim)
			{
				stopAnim = false;
				level.ALWAYS_ANIM_DCT.addItem(this);
				//gotoAndStop(currentFrame+1);
				//noAnimThisCycle = true;
			}
			setColPoints();
			//springing = true;
		}
		override public function setColPoints():void
		{
			lhTop = hTop;
			lhBot = hBot;
			lhLft = hLft;
			lhRht = hRht;
			lhMidX = hMidX;
			lhMidY = hMidY;
			var realBottomPos:Number = this.y + TILE_SIZE;
			hTop = realBottomPos - height; // hits top
			hBot = realBottomPos; // hits bottom
			hLft = x; // hits left side
			hRht = x + width; // hits right side
			hMidX = this.x + width*.5;
			hMidY = realBottomPos - height*.5;
		}
		private function springLaunch(obj:AnimatedObject):void
		{
			obj.vx = obj.sprVX;
			if (obj is Character)
			{
				if (Character(obj).springBoost)
				{
					obj.vy = -boostSpringPwr;
//					obj.vy = -Character(obj).boostSpringPwr;
					Character(obj).springBoost = false;
				}
				else
					obj.vy = -defSpringPwr;
//					obj.vy = -Character(obj).defSpringPwr;
				Character(obj).jumped = true;
				Character(obj).springLaunch(this);
			}
			else
				obj.vy = -defSpringPwr;
			gotoAndStop(color + "Start");
		}
		override public function checkFrame():void
		{
			if (currentFrameLabel == color + "End")
			{
				stopAnim = true;
				level.ALWAYS_ANIM_DCT.removeItem(this);
				gotoAndStop(color + "Start");
				for each (var ao:AnimatedObject in SPRING_OBJS_DCT)
				{
					springLaunch(ao);
				}
				SPRING_OBJS_DCT.clear();
			}
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (level)
				level.ALWAYS_ANIM_DCT.removeItem(this);
		}
	}
}

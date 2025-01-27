package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;
	import com.smbc.data.SoundNames;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.ground.Canon;
	import com.smbc.level.BulletBillSpawner;
	import com.smbc.main.GlobVars;
	import com.smbc.main.LevObj;

	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	[Embed(source="../assets/swfs/SmbcGraphics.swf", symbol="BulletBill")]
	public class BulletBill extends Enemy
	{
		private static const MAIN_ANIM_TMR:CustomTimer = AnimationTimers.ANIM_SLOWEST_TMR;
		public static const ENEMY_NUM:int = EnemyInfo.BulletBill;
		private static const CP_PNT:Point = new Point(169,127);
		public static const WIDTH:int = 32;
		public static const COLOR_BLACK:String = "black";
		public static const COLOR_GRAY:String = "gray";
		private static const FL_FLASH:String = "flash";
		private var destroyableTmr:CustomTimer;
		private const DESTROYABLE_TMR_DUR:int = 200;
		private var color:String;
		private var goRht:Boolean;
		public static const SPEED:int = 170;
		private const BG_MOVE_DIST:int = GlobVars.TILE_SIZE;
		private var startBgPos:Number;
		private var endBgPos:Number;
		private var spwnSrc:LevObj;

		public function BulletBill(xPos:Number,yPos:Number,goRhtTmp:Boolean,spwnSrcTmp:LevObj,colorTmp:String = "black")
		{
			super();
			x = xPos;
			y = yPos;
			goRht = goRhtTmp;
			color = colorTmp;
			gravity = 1250;
			spwnSrc = spwnSrcTmp;
			defyGrav = true;
			stopAnim = false;
			mainAnimTmr = MAIN_ANIM_TMR;
			stompable = true;
			addProperty( new StatusProperty( PR_PIERCE_PAS, PIERCE_STR_ARMORED ) );
			removeAllHitTestableItems();
			addHitTestableItem(HT_CHARACTER);
			addHitTestableItem(HT_PROJECTILE_CHARACTER);
			SND_MNGR.playSound(SoundNames.SFX_GAME_CANON);
			if (spwnSrc is Canon)
			{
				behindGround = true;
				startBgPos = x;
				destroyOffScreen = true;
			}
			if (goRht)
			{
				vx = SPEED;
				scaleX = 1;
				if (behindGround)
					endBgPos = startBgPos + BG_MOVE_DIST;
			}
			else
			{
				vx = -SPEED;
				scaleX = -1;
				if (behindGround)
					endBgPos = startBgPos - BG_MOVE_DIST;
			}
		}
		override protected function overwriteInitialStats():void
		{
			_health = HealthValue.BULLET_BILL;
			scoreAttack = ScoreValue.BULLET_BILL_ATTACK;
			scoreBelow = ScoreValue.BULLET_BILL_BELOW;
			scoreStar = ScoreValue.BULLET_BILL_STAR;
			scoreStomp = ScoreValue.BULLET_BILL_STOMP;
			super.overwriteInitialStats();
		}
		override public function initiate():void
		{
			super.initiate();
			if (spwnSrc is BulletBillSpawner)
			{
				destroyableTmr = new CustomTimer(DESTROYABLE_TMR_DUR,1);
				destroyableTmr.addEventListener(TimerEvent.TIMER_COMPLETE,destroyableTmrHandler,false,0,true);
				addTmr(destroyableTmr);
				destroyableTmr.start();
				updateOffScreen = true;
			}
		}
		override protected function updateStats():void
		{
			super.updateStats();
			if (behindGround)
			{
				if (goRht && nx > endBgPos)
					behindGround = false;
				else if (!goRht && nx < endBgPos)
					behindGround = false;
			}
		}
		override public function stomp():void
		{
			if (!player.canStomp)
				return;
			super.stomp();
			die();
			SND_MNGR.removeStoredSound(SoundNames.SFX_GAME_KICK_SHELL);
			vx = 0;
			vy = 0;
		}

		override public function hitEnemy(enemy:Enemy,side:String):void
		{
			// don't turn around when hitting an enemy
		}
		private function destroyableTmrHandler(event:TimerEvent):void
		{
			destroyableTmr.stop();
			removeTmr(destroyableTmr);
			destroyableTmr = null;
			destroyOffScreen = true;
			updateOffScreen = false;
			if (!onScreen)
				destroy();
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (destroyableTmr)
				destroyableTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,destroyableTmrHandler);
		}
		override protected function reattachLsrs():void
		{
			super.reattachLsrs();
			if (destroyableTmr)
				destroyableTmr.addEventListener(TimerEvent.TIMER_COMPLETE,destroyableTmrHandler,false,0,true);
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (spwnSrc is Canon)
				Canon.BILL_DCT.removeItem(this);
			else if (spwnSrc is BulletBillSpawner)
				BulletBillSpawner(spwnSrc).bulletBillDestroyed(this);
		}

	}
}

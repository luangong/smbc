package com.smbc.projectiles
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxKnockBack;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatFxStop;
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.smbc.characters.Link;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.DamageValue;
	import com.smbc.data.SoundNames;
	import com.smbc.enemies.Enemy;
	import com.smbc.ground.Ground;
	import com.smbc.interfaces.IAttackable;
	import com.smbc.utils.GameLoopTimer;

	import flash.events.Event;
	import flash.events.TimerEvent;

	import flxmp.Player;

	public class LinkProjectile extends Projectile
	{
		public static const TYPE_ARROW:String = "arrow";
		public static const TYPE_BOMB:String = "bomb";
		public static const TYPE_SHOOTING_SWORD:String = "shootingSword";
		private static const FL_ARROW:String = "arrow";
		private static const FL_BOMB:String = "bomb";
		private static const FL_BOMB_EXPLOSION_END:String = "bombExplosionEnd";
		private static const FL_BOMB_EXPLOSION_START:String = "bombExplosionStart";
		private static const FL_SHOOTING_SWORD_END:String = "shootingSwordEnd";
		private static const FL_SHOOTING_SWORD_START:String = "shootingSwordStart";
		private var bombTmr:GameLoopTimer;
		private static const BOMB_TMR_DEL:int = 1000;
		private const SPEED:int = 500;
		private const X_OFFSET:int = 21;
		private const Y_OFFSET:int = 13;
		private const X_OFS_UP:Number = 3;
		private const X_OFS_DOWN:Number = 1;
		private const Y_OFS_UP:int = 40;
		private const Y_OFS_DOWN:int = 6;
		private var hitSomething:Boolean;
		private static const BOMB_X_OFS:int = 26;
		private var knockBackFx:StatFxKnockBack;
		public var type:String;
		private var link:Link;
		public var bombExploded:Boolean;
		// Public Properties:

		// Private Properties:
		// Initialization:
		public function LinkProjectile(link:Link,type:String)
		{
			this.type = type;
			this.link = link;
			super(link,SOURCE_TYPE_PLAYER);
			for each (var prop:StatusProperty in Link.DEFAULT_PROPS_DCT)
			{
				addProperty(prop);
			}
//			removeProperty(StatusProperty.TYPE_KNOCK_BACK_AGG);
			knockBackFx = new StatFxKnockBack(null,null);
//			addProperty( new StatusProperty(StatusProperty.TYPE_KNOCK_BACK_AGG, 0, knockBackFx ) );
			switch(type)
			{
				case TYPE_ARROW:
				{
					stopAnim = true;
					defyGrav = true;
					if ( link.skinNum == Link.SKIN_ZELDA_NES || link.skinNum == Link.SKIN_ZELDA_SNES || link.skinNum == Link.SKIN_ZELDA_GB )
					{
						_damageAmt = 400;
						addProperty( new StatusProperty( PR_PASSTHROUGH_DEFEAT ) );
					}
					else
						_damageAmt = DamageValue.LINK_ARROW;
					gotoAndStop(FL_ARROW);
					setDir();
					knockBackFx.setDirFromSpeed(vx,vy);
					SND_MNGR.playSound(SoundNames.SFX_LINK_SHOOT_ARROW);
					break;
				}
				case TYPE_BOMB:
				{
					_damageAmt = DamageValue.LINK_BOMB;
					gotoAndStop(FL_BOMB);
					needsAccurateGroundHits = true;
					stopAnim = true;
					mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
					doesntHitBricks = true;
					alwaysAllowHits = true;
					x = link.nx + BOMB_X_OFS*link.scaleX;
					y = link.ny;
					gravity = 1000;
					removeAllHitTestableItems();
					addAllGroundToHitTestables();
					addProperty( new StatusProperty(PR_PIERCE_AGG,10) );
					break;
				}
				case TYPE_SHOOTING_SWORD:
				{
					_damageAmt = DamageValue.LINK_SHOOTING_SWORD;
					defyGrav = true;
					setDir();
					knockBackFx.setDirFromSpeed(vx,vy);
					mainAnimTmr = AnimationTimers.ANIM_FAST_TMR;
					link.canShootSword = false;
					SND_MNGR.playSound(SoundNames.SFX_LINK_SHOOT_SWORD);
					break;
				}
			}
			destroyOffScreen = true;
		}

		override public function initiate():void
		{
			super.initiate();
			if (type == TYPE_BOMB)
			{
				if (stuckInWall)
				{
					nx = link.nx;
					x = nx;
				}
//				else
//				{
					bombTmr = new GameLoopTimer(BOMB_TMR_DEL,1);
					bombTmr.addEventListener(TimerEvent.TIMER_COMPLETE,bombTmrHandler,false,0,true);
					bombTmr.start();
					SND_MNGR.playSound(SoundNames.SFX_LINK_SET_BOMB);
//				}
			}
		}

		protected function bombTmrHandler(event:Event):void
		{
			gotoAndStop(FL_BOMB_EXPLOSION_START);
			bombExploded = true;
			stopAnim = false;
			needsAccurateGroundHits = false;
			doesntHitBricks = false;
			alwaysAllowHits = false;
			defyGrav = true;
			vy = 0;
			addProperty( new StatusProperty( PR_PASSTHROUGH_ALWAYS) );
			L_HIT_DCT.clear();
			C_HIT_DCT.clear();
			hitTestTypesDct.addItem(HT_PROJECTILE_ENEMY);
			addHitTestableItem(HT_ENEMY);
			addHitTestableItem(HT_CHARACTER);
			SND_MNGR.playSound(SoundNames.SFX_LINK_BOMB_EXPLODE);
		}

		override protected function setDir():void
		{
			if (player.onGround && type == TYPE_SHOOTING_SWORD)
			{
				var cfl:String = player.currentFrameLabel;
				if (cfl == Link.FL_ATTACK_UP_START)
				{
					vy = -SPEED;
					rotation = -90;
					y = player.ny - Y_OFS_UP;
					if (player.scaleX > 0)
						x = player.nx - X_OFS_UP;
					else
						x = player.nx + X_OFS_UP;
				}
				else if (cfl == Link.FL_ATTACK_DOWN_START)
				{
					vy = SPEED;
					rotation = 90;
					y = player.ny + Y_OFS_DOWN;
					if (player.scaleX > 0)
						x = player.nx + X_OFS_DOWN;
					else
						x = player.nx - X_OFS_DOWN;
				}
				else
				{
					y = player.ny - Y_OFFSET;
					if (player.scaleX > 0)
					{
						vx = SPEED;
						x = player.nx + X_OFFSET;
					}
					else
					{
						vx = -SPEED;
						scaleX = -1;
						x = player.nx - X_OFFSET;
					}
				}
			}
			else if (!player.upBtn && !player.dwnBtn)
			{
				y = player.ny - Y_OFFSET;
				if (player.scaleX > 0)
				{
					vx = SPEED;
					x = player.nx + X_OFFSET;
				}
				else
				{
					vx = -SPEED;
					scaleX = -1;
					x = player.nx - X_OFFSET;
				}
			}
			else if (player.upBtn)
			{
				vy = -SPEED;
				rotation = -90;
				y = player.ny - Y_OFS_UP;
				if (player.scaleX > 0)
					x = player.nx - X_OFS_UP;
				else
					x = player.nx + X_OFS_UP;
			}
			else // if (player.dwnBtn);
			{
				vy = SPEED;
				rotation = 90;
				y = player.ny + Y_OFS_DOWN;
				if (player.scaleX > 0)
					x = player.nx + X_OFS_DOWN;
				else
					x = player.nx - X_OFS_DOWN;
			}
		}
		override public function confirmedHit(mc:IAttackable,damaged:Boolean = true):void
		{
			if (type == TYPE_SHOOTING_SWORD)
				shootingSwordexplode();
			super.confirmedHit(mc,damaged);
		}

		override protected function attackObjPiercing(obj:IAttackable):void
		{
			super.attackObjPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_LINK_HIT_ENEMY);
		}
		override protected function attackObjNonPiercing(obj:IAttackable):void
		{
			super.attackObjNonPiercing(obj);
			if (obj is Enemy)
				SND_MNGR.playSound(SoundNames.SFX_LINK_HIT_ENEMY_ARMOR);
		}
		private function shootingSwordexplode():void
		{
			level.addToLevel(new LinkSimpleGraphics(this,LinkSimpleGraphics.TYPE_SWORD_EXPLOSION,"up-rht"));
			level.addToLevel(new LinkSimpleGraphics(this,LinkSimpleGraphics.TYPE_SWORD_EXPLOSION,"dwn-rht"));
			level.addToLevel(new LinkSimpleGraphics(this,LinkSimpleGraphics.TYPE_SWORD_EXPLOSION,"dwn-lft"));
			level.addToLevel(new LinkSimpleGraphics(this,LinkSimpleGraphics.TYPE_SWORD_EXPLOSION,"up-lft"));
			hitSomething = true;
		}
		override protected function removeListeners():void
		{
			super.removeListeners();
			if (bombTmr)
				bombTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,bombTmrHandler);
		}


		override public function checkFrame():void
		{
			if (type == TYPE_SHOOTING_SWORD && currentFrame == convFrameToInt(FL_SHOOTING_SWORD_END) + 1)
				gotoAndStop(FL_SHOOTING_SWORD_START);
			else if (type == TYPE_BOMB && currentFrame == convFrameToInt(FL_BOMB_EXPLOSION_END) + 1)
				destroy();
		}

		override public function cleanUp():void
		{
			super.cleanUp();
			if (type == TYPE_SHOOTING_SWORD && !hitSomething)
				(source as Link).canShootSword = true;
		}


	}
}

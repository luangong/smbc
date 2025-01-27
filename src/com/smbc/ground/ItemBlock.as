package com.smbc.ground
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.explodingRabbit.display.CustomMovieClip;
	import com.explodingRabbit.utils.CustomDictionary;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.data.AnimationTimers;
	import com.smbc.data.MapInfo;
	import com.smbc.events.CustomEvents;
	import com.smbc.interfaces.ICustomTimer;
	import com.smbc.level.Level;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GraphicsManager;

	import flash.events.Event;
	import flash.sampler.getInvocationCount;

	public class ItemBlock extends Brick
	{
		public var stopAnimLock:Boolean;
		public static var masterItemBlock:ItemBlock;
		private static const ITEM_BLOCK_DCT:CustomDictionary = new CustomDictionary(true);
		public static const DEFAULT_NAME:String = "itemBlock"
		private static const FL_END:String = "end";
		private static const FL_START:String = "start";
		protected static const FL_HIT_MOVING:String = Brick.FL_HIT_MOVING;
		protected static const FL_HIT_RESTING:String = Brick.FL_HIT_RESTING;
		protected static const FL_HIT_RESTING_INVISIBLE:String = "hitRestingInvisible";
		public static var animEndFrameNum:int;
		private static const NUM_ANIM_FRAMES:int = 4;
		public static var animStartFrameDelay:int;
//		private static const CHANGE_MAP_FCT_DCT:CustomDictionary = new CustomDictionary(true);
		{
			EventManager.EVENT_MNGR.addEventListener(CustomEvents.CHANGE_MAP_SKIN, changeMapSkinHandler, false, 0, true);
		}

		public function ItemBlock(_stopFrame:String = null)
		{
			super(_stopFrame);
//			mainAnimTmr = AnimationTimers.ANIM_SLOWEST_TMR;
//			_animated = true;
			if (_stopFrame && _stopFrame.indexOf( Level.PROP_INVISIBLE ) != -1)
			{
				visible = false;
				invisible = true;
				stopAnim = true;
			}
//			CHANGE_MAP_FCT_DCT.addItem(changeMapSkinLocalHandler);
			removeProperty( PR_TYPE_SUPER_ARM_GRABBABLE_PAS );
		}
		override public function initiate():void
		{
			super.initiate();
			if (this != masterItemBlock)
				ITEM_BLOCK_DCT.addItem(this);
		}
		public static function initiateLevelHandler():void
		{
			masterItemBlock = new ItemBlock(DEFAULT_NAME);
			masterItemBlock.initiate();
			Level.levelInstance.ALWAYS_ANIM_DCT.addItem(masterItemBlock);
		}
		protected static function changeMapSkinHandler(event:Event):void
		{
			var groundDct:CustomDictionary = Level.levelInstance.GROUND_DCT;
			var gm:GraphicsManager = GraphicsManager.INSTANCE;
//			var palette:Array = gm.readPalette(gm.drawingBoardMapSkinCont.bmd, GraphicsManager.MAP_INFO_ARR[MapInfo.ItemBlock][GraphicsManager.INFO_ARR_IND_CP]);
			var itemBlock:CustomMovieClip = new CustomMovieClip(null,null,"ItemBlock");
			animStartFrameDelay = gm.getFrameDelay( itemBlock.getPaletteByRow(0) );
			animEndFrameNum = NUM_ANIM_FRAMES + itemBlock.convFrameToInt(FL_START) - 1;
			while ( animEndFrameNum > 0 && itemBlock.frameIsEmpty( animEndFrameNum ) )
			{
				animEndFrameNum--;
			}
			masterItemBlock.changeMapSkinLocalHandler();
//			for each (var fct:Function in CHANGE_MAP_FCT_DCT)
//			{
//				fct();
//			}
		}
		private function changeMapSkinLocalHandler():void
		{
			if (!stopAnim)
				gotoAndStop(FL_START);
			animDelCtr = 0;
		}
		override public function getPickup(_item:String):void
		{
			item = _item;
			if (!item || item == IT_MULTI_COIN)
				item = IT_SINGLE_COIN;
		}

		override public function breakBrick(piecesDamage:Boolean = false):void
		{
			bounce();
		}
		override public function bounce():void
		{
			if (!visible)
				visible = true;
			if (this != masterItemBlock)
				ITEM_BLOCK_DCT.removeItem(this);
			super.bounce();
		}
		override internal function doneBouncing():void
		{
			super.doneBouncing();
			if (!invisible)
				gotoAndStop(FL_HIT_RESTING);
			else
				gotoAndStop(FL_HIT_RESTING_INVISIBLE);
		}
		override public function rearm():void
		{
			super.rearm();
			if (this == masterItemBlock)
				level.ALWAYS_ANIM_DCT.addItem(this);
			else if (!stopAnim)
				ITEM_BLOCK_DCT.addItem(this);
		}
		override public function disarm():void
		{
			if (this == masterItemBlock)
				level.ALWAYS_ANIM_DCT.removeItem(this);
			else
				ITEM_BLOCK_DCT.removeItem(this);
			super.disarm();
		}
		override public function checkFrame():void
		{
			if (this == masterItemBlock)
			{
				if (currentFrame == animEndFrameNum + 1 && !disabled)
					gotoAndStop(FL_START);
				for each (var itemBlock:ItemBlock in ITEM_BLOCK_DCT)
				{
					if (itemBlock.onScreen && !itemBlock.stopAnim)
						itemBlock.gotoAndStop(currentFrame);
				}
			}
		}
		override public function animate(ct:ICustomTimer):Boolean
		{
			if (disabled)
				return false;
			if (mainAnimTmr == ct && currentFrameLabel == FL_START && animDelCtr < animStartFrameDelay)
				animDelCtr ++;
			else
			{
				animDelCtr = 0;
				return $animate(ct);
			}
			return false;
		}
		override public function cleanUp():void
		{
			super.cleanUp();
			if (level && this == masterItemBlock)
				level.ALWAYS_ANIM_DCT.removeItem(this);
			ITEM_BLOCK_DCT.removeItem(this);
//			CHANGE_MAP_FCT_DCT.removeItem(changeMapSkinLocalHandler);
		}
	}
}

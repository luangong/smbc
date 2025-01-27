package com.smbc.messageBoxes
{
	import com.customClasses.TDCalculator;
	import com.explodingRabbit.utils.CustomTimer;
	import com.smbc.SuperMarioBrosCrossover;
	import com.smbc.data.GameSettings;
	import com.smbc.data.ScreenSize;
	import com.smbc.errors.SingletonError;
	import com.smbc.graphics.MessageBoxBackground;
	import com.smbc.graphics.MessageBoxCornerSquare;
	import com.smbc.graphics.MessageBoxFrameBlack;
	import com.smbc.graphics.MessageBoxFramePink;
	import com.smbc.graphics.BmdInfo;
	import com.smbc.interfaces.IInitiater;
	import com.smbc.interfaces.IKeyPressable;
	import com.smbc.main.GlobVars;
	import com.smbc.managers.ButtonManager;
	import com.smbc.managers.EventManager;
	import com.smbc.managers.GraphicsManager;
	import com.smbc.managers.MessageBoxManager;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class MessageBox extends Sprite implements IKeyPressable, IInitiater
	{
		public static var activeInstance:MessageBox;
		public var nonActive:Boolean;
		public static const SCALE_INC:Number = 7;
		private static const FRAME_CROP:int = 0;
		protected const CONTAINER_PADDING:int = 0; //13
		protected const TXT_LEADING:int = 7; //7
		protected var endBoxHeight:int = 200;
		protected var endXPos:Number = ScreenSize.SCREEN_WIDTH/2;
		protected var endYPos:Number = ScreenSize.SCREEN_HEIGHT/2;
		protected const BOX_HEIGHT_MIN:int = 1;
		protected const CORNER_SQUARE_OFFSET:int = 2;
		private static const END_WIDTH:int = 400;
		protected var endBoxWidth:int = END_WIDTH;
		protected const BOX_WIDTH_MIN:int = 1;
		protected const ASPECT_RATIO:Number = endBoxWidth/endBoxHeight;
		protected var _readyToShrink:Boolean;
		protected var _readyToGrow:Boolean = true;
		protected var _interactive:Boolean;
		protected var cancelTmr:CustomTimer;
		public var nextMsgBxToCreate:MessageBox;
		public var nextMsgBxToFocus:MessageBox;
		public var nextMsgBxToReappear:MessageBox;
		protected const CANCEL_TMR_DUR:int = 1000;
		protected const UPD_TMR_INT:Number = 1000/60;
		protected const UPD_TMR:CustomTimer = new CustomTimer(UPD_TMR_INT);
		protected const EVENT_MNGR:EventManager = EventManager.EVENT_MNGR;
		protected const MSG_BX_MNGR:MessageBoxManager = MessageBoxManager.INSTANCE;
		protected const GAME:SuperMarioBrosCrossover = SuperMarioBrosCrossover.game;
		protected const TXT_CONT:Sprite = new Sprite();
		protected const BTN_MNGR:ButtonManager = ButtonManager.BTN_MNGR;
		protected var maxHeight:int;
		public var nonInteractive:Boolean;
		public var mbName:String;
		protected var endHeight:Number;
		protected var endWidth:Number;
		private var hiding:Boolean;
		protected const MAX_FINAL_POSITION_OFFSET_BEFORE_FIX:int = 8;
		private var dt:Number = .03;
		private var ldt:Number;
		private const DT_MAX:Number = .045;
		private const TD_CALC:TDCalculator = new TDCalculator();
		protected var contentMaskRect:Shape;
		protected var contentOverflowHeight:Number;
		protected var bg:Sprite
		protected var instantGrow:Boolean;
		protected var forceWidth:Number;
		protected var forceHeight:Number;
		protected var createdGraphicsFirstTime:Boolean;
		protected var txtContDefY:Number;

		public function MessageBox(width:Number = NaN, height:Number = NaN)
		{
			super();
			this.forceWidth = width;
			this.forceHeight = height;
		}
		public function initiate():void
		{
			/*
			if (activeInstance != null)
				throw new SingletonError();
			*/
			if (!nonActive)
			{
				activeInstance = this;
				BTN_MNGR.activeMsgBx = this;
			}
			GAME.addChild(this);
			x = endXPos;
			y = endYPos;
			cancelTmr = new CustomTimer(CANCEL_TMR_DUR,1);
			cancelTmr.addEventListener(TimerEvent.TIMER_COMPLETE,cancelTmrHandeler,false,0,true);
			UPD_TMR.addEventListener(TimerEvent.TIMER,updTmrHandeler,false,0,true);
			cancelTmr.start();
			UPD_TMR.start();
			setUpText();
			createGraphics();
			endWidth = width;
			endHeight = height;
			if (!instantGrow)
			{
				scaleX = .01;
				scaleY = .01;
			}
			else
				reachedMaxSize();
		}
		protected function createGraphics(newWidth:Number = NaN, newHeight:Number = NaN, widthOfs:int = 0, heightOfs:int = 0):void
		{
			TXT_CONT.mask = null;
			var cornerTopLft:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_TOP_LEFT);
			cornerTopLft.x = FRAME_CROP;
			cornerTopLft.y = FRAME_CROP;
			addChild(cornerTopLft);
			var cornerTopLftRect:Rectangle = getVisibleBounds(cornerTopLft);
			var rectWidth:Number = cornerTopLftRect.width;
			var rectHeight:Number = cornerTopLftRect.height;
			bg = new Sprite();
			bg.x = rectWidth;
			bg.y = rectHeight;
			cornerTopLft.x = rectWidth;
			cornerTopLft.y = rectHeight;
//			if (!createdGraphicsFirstTime)
//			{
				TXT_CONT.x = rectWidth;
				TXT_CONT.y = rectHeight;
				txtContDefY = TXT_CONT.y;
//			}
			// code above makes sure box upper left corner is at 0
			//bg.x = FRAME_THICKNESS;
			//bg.y = FRAME_THICKNESS;
			changeBackgroundColor();
			if ( isNaN(newWidth) )
			{
				bg.width = TXT_CONT.width + widthOfs;
				if (this is MenuBox && !(this is LinksMenu) )
					bg.width += MenuBox.LEFT_MARGIN;
				else if (GameSettings.getInterfaceSkinLimited() == BmdInfo.SKIN_NUM_SMB2_SNES)
					bg.width += 8;
				else
					bg.width += 2;
			}
			else
				bg.width = newWidth;
			if ( isNaN(newHeight) )
				bg.height = TXT_CONT.height + heightOfs;
			else
				bg.height = newHeight;
			if (maxHeight && bg.height > maxHeight)
				bg.height = maxHeight;
			addChild(bg);
			contentMaskRect = new Shape; // initializing the variable named rectangle
			contentMaskRect.graphics.beginFill(0xFF0000); // choosing the colour for the fill, here it is red
			contentMaskRect.graphics.drawRect(0,0,bg.width,bg.height) // (x spacing, y spacing, width, height)
			contentMaskRect.graphics.endFill(); // not always needed but I like to put it in to end the fill
			contentMaskRect.x = bg.x;
			contentMaskRect.y = bg.y;
			addChild(contentMaskRect);
			TXT_CONT.mask = contentMaskRect;
			var frameTop:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_TOP_MID);
			frameTop.width = bg.width;
			frameTop.x = bg.x + FRAME_CROP;
			frameTop.y = bg.y + FRAME_CROP;
			addChild(frameTop);
			var frameRht:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_MID_RIGHT);
			frameRht.height = bg.height;
			frameRht.x = bg.x + bg.width - FRAME_CROP;
			frameRht.y = bg.y + FRAME_CROP;
			addChild(frameRht);
			var frameBot:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_BOT_MID);
			frameBot.width = bg.width;
			frameBot.x = bg.x + FRAME_CROP;
			frameBot.y = bg.y + bg.height - FRAME_CROP;
			addChild(frameBot);
			var frameLft:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_MID_LEFT);
			frameLft.height = bg.height;
			frameLft.x = bg.x + FRAME_CROP;
			frameLft.y = bg.y + FRAME_CROP;
			addChild(frameLft);
			var cornerTopRht:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_TOP_RIGHT);
			cornerTopRht.x = bg.x + bg.width - FRAME_CROP;
			cornerTopRht.y = bg.y + FRAME_CROP;
			addChild(cornerTopRht);
			var cornerBotLft:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_BOT_LEFT);
			cornerBotLft.x = bg.x + FRAME_CROP;
			cornerBotLft.y = bg.y + bg.height - FRAME_CROP;
			addChild(cornerBotLft);
			var cornerBotRht:MessageBoxBackground = new MessageBoxBackground(MessageBoxBackground.FL_BOT_RIGHT);
			cornerBotRht.x = bg.x + bg.width - FRAME_CROP;
			cornerBotRht.y = bg.y + bg.height - FRAME_CROP;
			addChild(cornerBotRht);
			addChild(TXT_CONT);
//			contentOverflowHeight = TXT_CONT.height - ( bg.height );
			contentOverflowHeight = 0;
			if (contentOverflowHeight < 0)
				contentOverflowHeight = 0;
			createdGraphicsFirstTime = true;
		}
		public function resizeBox(changeWidth:Boolean = true, changeHeight:Boolean = true, widthOfs:int = 0,heightOfs:int = 0):void
		{
			var newWidth:Number;
			var newHeight:Number;
			if (!changeWidth)
				newWidth = bg.width;
//				newWidth = getVisibleBounds(this).width;
			if (!changeHeight)
				newHeight = bg.height;
//				newHeight = getVisibleBounds(this).height;

			for (var i:int = 0; i < numChildren; i++)
			{
				var child:DisplayObject = getChildAt(i);
				if ( !(child == TXT_CONT) )
				{
					removeChild(child);
					i--;
				}
				else
					child.mask = null;
			}
			bg = null;
			contentMaskRect = null;
			createGraphics(newWidth, newHeight,widthOfs,heightOfs);
			x = GlobVars.STAGE_WIDTH/2 - width/2;
		}
		public function changeBackgroundColor():void
		{
			var pnt:Point = GraphicsManager.MESSAGE_BOX_BG_COLOR_PNT;
			var color:uint = GraphicsManager.INSTANCE.drawingBoardInterfaceSkinCont.bmd.getPixel(pnt.x,pnt.y); // doesn't use 32 bit number
			var alphaNum:Number = 1;
			if (GameSettings.getInterfaceSkinLimited() == BmdInfo.SKIN_NUM_INVISIBLE)
				alphaNum = 0;
//			trace( color.toString(16) );
			bg.graphics.beginFill(color,alphaNum);
			bg.graphics.drawRect(0,0,1,1);
			bg.graphics.endFill();
		}

		protected function makeBackgroundTransparent():void
		{
			bg.graphics.clear();
			bg.graphics.beginFill(0,0);
			bg.graphics.drawRect(0,0,1,1);
			bg.graphics.endFill();
		}

		protected function getBackgroundColor():uint
		{
			var pnt:Point = GraphicsManager.MESSAGE_BOX_BG_COLOR_PNT;
			return GraphicsManager.INSTANCE.drawingBoardInterfaceSkinCont.bmd.getPixel(pnt.x,pnt.y);
		}

//		public function makeAreaTransparent(rectangle:Rectangle):void
//		{
//			trace("make transparent: "+rectangle);
//			bg.graphics.beginFill(0, 1);
//			bg.graphics.drawRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
//			bg.graphics.endFill();
//		}

		public static function getVisibleBounds(source:DisplayObject):Rectangle
		{
			var matrix:Matrix = new Matrix();
			var sourceRect:Rectangle = source.getBounds(null);
			matrix.tx = -sourceRect.x;
			matrix.ty = -sourceRect.y;
			var data:BitmapData = new BitmapData(sourceRect.width, sourceRect.height, true, 0);
			data.draw(source, matrix);
			var bounds:Rectangle = data.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
			data.dispose();
			return bounds;
		}
		override public function get height():Number
		{
			var num:Number = getVisibleBounds(this).height * scaleY;
			if (num < 0)
				num = -num;
			return num;
		}
		override public function get width():Number
		{
			var num:Number = getVisibleBounds(this).width * scaleX;
			if (num < 0)
				num = -num;
			return num;
		}
		public function cancel():void
		{
			UPD_TMR.start();
			_readyToShrink = true;
			_readyToGrow = false;
			_interactive = false;
		}
		protected function updTmrHandeler(e:TimerEvent):void
		{
			dt = TD_CALC.getTD();
			if (dt > DT_MAX)
				dt = DT_MAX;
			if (readyToGrow)
				grow();
			else if (readyToShrink)
				shrink();
		}
		public function grow():void
		{
			if (_readyToGrow)
			{
			 	var oldWidth:Number = width;
			 	var oldHeight:Number = height - contentOverflowHeight*scaleX;
			 	scaleX += SCALE_INC*dt;
				if (scaleX > 1)
					scaleX = 1;
			 	scaleY = scaleX;
			 	var dWidth:Number = (width - oldWidth)*.5;
			 	var dHeight:Number = ( (height - contentOverflowHeight*scaleX) - oldHeight)*.5;
//			 	x -= dWidth;
//			 	y -= dHeight;
				x = endXPos - width/2;
				y = endYPos - height/2;
				if (scaleX == 1)
					reachedMaxSize();
			}
		}
		protected function reachedMaxSize():void
		{
			UPD_TMR.stop();
			_readyToGrow = false;
		 	scaleX = 1;
			scaleY = 1;
			// chcecks to see if position is off too much
			var perfectEndXPos:Number = endXPos - width/2;
			var perfectEndYPos:Number = endYPos - height/2;
			var xDif:Number = perfectEndXPos - x;
			var yDif:Number = perfectEndYPos - y;
			if (xDif < 0)
				xDif = -xDif;
			if (yDif < 0)
				yDif = -yDif;
			if (xDif > MAX_FINAL_POSITION_OFFSET_BEFORE_FIX)
				x = endXPos - width/2;
			if (yDif > MAX_FINAL_POSITION_OFFSET_BEFORE_FIX)
//				y = endYPos - (height - contentOverflowHeight)/2;
				y = endYPos - height/2;
			if (!nonInteractive)
				_interactive = true;
			GlobVars.STAGE.focus = null;
			//BTN_MNGR.relBtns();
		}
		protected function setUpText():void
		{
			// blah
		}
		public function shrink():void
		{
			var oldWidth:Number = width;
		 	var oldHeight:Number = height;
		 	scaleX -= SCALE_INC*dt;
		 	scaleY = scaleX;
		 	var dWidth:Number = (oldWidth - width)*.5;
		 	var dHeight:Number = (oldHeight - height)*.5;
//		 	x += dWidth;
//		 	y += dHeight;
			x = endXPos - width/2;
			y = endYPos - height/2;
		 	if (scaleX <= 0)
			{
				if (hiding)
					disappear();
				else
					destroy();
			}
		}
		protected function cancelTmrHandeler(e:TimerEvent):void
		{
			cancelTmr.stop();
			cancelTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelTmrHandeler);
			cancelTmr = null;
			if (!nonInteractive)
				_interactive = true;
		}
		public function hide():void
		{
			hiding = true;
			UPD_TMR.start();
			_readyToShrink = true;
			_readyToGrow = false;
		}
		public function get interactive():Boolean
		{
			return _interactive;
		}
		public function pressUpBtn():void
		{

		}
		public function pressDwnBtn():void
		{

		}
		public function pressLftBtn():void
		{

		}
		public function pressRhtBtn():void
		{

		}
		public function pressJmpBtn():void
		{

		}
		public function pressAtkBtn():void
		{

		}
		public function pressSpcBtn():void
		{

		}
		public function pressPseBtn():void
		{

		}
		protected function destroy():void
		{
			if (activeInstance == this)
				activeInstance = null;
			if (cancelTmr && cancelTmr.hasEventListener(TimerEvent.TIMER_COMPLETE))
				cancelTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelTmrHandeler);
			UPD_TMR.stop();
			UPD_TMR.removeEventListener(TimerEvent.TIMER,updTmrHandeler);
			if (parent)
				parent.removeChild(this);
			if (BTN_MNGR.activeMsgBx == this)
				BTN_MNGR.activeMsgBx = null;
			if (nextMsgBxToCreate)
				nextMsgBxToCreate.initiate();
			else if (nextMsgBxToFocus)
				BTN_MNGR.activeMsgBx = nextMsgBxToFocus;
			else if (nextMsgBxToReappear)
				nextMsgBxToReappear.reappear();
			GlobVars.STAGE.focus = null;
		}
		protected function disappear():void
		{
			if (cancelTmr && cancelTmr.hasEventListener(TimerEvent.TIMER_COMPLETE))
				cancelTmr.removeEventListener(TimerEvent.TIMER_COMPLETE,cancelTmrHandeler);
			UPD_TMR.stop();
			_readyToGrow = false;
			_readyToShrink = false;
			if (BTN_MNGR.activeMsgBx == this)
				BTN_MNGR.activeMsgBx = null;
			if (nextMsgBxToCreate)
				nextMsgBxToCreate.initiate();
			else if (nextMsgBxToFocus)
				BTN_MNGR.activeMsgBx = nextMsgBxToFocus;
			else if (nextMsgBxToReappear)
				nextMsgBxToReappear.reappear();
			visible = false;
		}
		public function reappear():void
		{
			UPD_TMR.start();
			_readyToGrow = true;
			_readyToShrink = false;
			BTN_MNGR.activeMsgBx = this;
			visible = true;
		}
		public function get readyToShrink():Boolean
		{
			return _readyToShrink;
		}
		public function get readyToGrow():Boolean
		{
			return _readyToGrow;
		}
	}
}

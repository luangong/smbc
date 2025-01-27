package com.explodingRabbit.components
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

   public class LinkBox extends MovieClip
   {
	   public var title:String;
	   private var _index:int;
	   public var textField:TextField;
	   private var bgImage:Sprite;

      public function LinkBox(_title:String,index:int)
      {
		  title = _title;
		  _index = index;
		  buildLinkBox();
      }

	  private function buildLinkBox():void
	  {
	  	  bgImage = new Sprite();
		  bgImage.graphics.beginFill(0xFFFFFF);
		  bgImage.graphics.drawRect(0,0,100,20);
		  addChild(bgImage);

		  var tFieldFormat:TextFormat = new TextFormat("Arial",12,0x000000,true);
		  textField = new TextField();
		  textField.text = title;
		  textField.autoSize = TextFieldAutoSize.LEFT;
		  textField.wordWrap = false;
		  textField.setTextFormat(tFieldFormat);
		  textField.defaultTextFormat = tFieldFormat;
		  centerText();
		  addChild(textField);

		  var button:Sprite = new Sprite();
		  button.graphics.beginFill(0xFFFF01,0);
		  button.graphics.drawRect(0,0,bgImage.width,bgImage.height);
		  button.graphics.endFill();
		  addChild(button);

		  button.buttonMode = true;
	  }
	  public function centerText():void
	  {
		  textField.x = bgImage.width/2 - textField.width/2;
		  textField.y = bgImage.height/2 - textField.height/2;
	  }

	   public function get index():int
	   {
		   return _index;
	   }

   }
}

package com.smbc.messageBoxes
{
	import com.explodingRabbit.cross.data.ConsoleType;
	import com.smbc.characters.Samus;
	import com.smbc.characters.Simon;
	import com.smbc.data.GameBoyPalettes;
	import com.smbc.data.GameSettings;
	import com.smbc.data.MusicQuality;
	import com.smbc.data.MusicSets;
	import com.smbc.events.CustomEvents;
	import com.smbc.graphics.SkinNames;
	import com.smbc.level.Level;
	import com.smbc.managers.ScreenManager;
	import com.smbc.managers.TutorialManager;
	import com.smbc.sound.SoundLevels;
	import com.smbc.text.TextFieldContainer;

	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;

	public class OptionsMenu extends MenuBox
	{
		public static var lastIndex:int;
		public function OptionsMenu(selectorStartIndex:int = 0)
		{
			super(loadItems(),selectorStartIndex);
		}
		private function loadItems():Array
		{
			return [
			[MenuBoxItems.SET_BUTTONS],
			[MenuBoxItems.GENERAL_OPTIONS],
			[MenuBoxItems.SOUND_OPTIONS],
			[MenuBoxItems.GRAPHICS_OPTIONS],
			[MenuBoxItems.CHEATS],
			[MenuBoxItems.BACK]
			];
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			//var vol:int;
			//var volInc:int = SoundLevels.VOLUME_INCREMENT;
			//var maxVol:int = SoundLevels.MAX_VOLUME;
			//var minVol:int = SoundLevels.MIN_VOLUME;
			var spcOn:String = MenuBoxItems.ON;
			var spcOff:String = MenuBoxItems.OFF;
			var strVec:Vector.<String>;
			var level:Level = Level.levelInstance;
			var str:String;
			var newValueStr:String;
			lastIndex = cSelNum;
			switch(itemName)
			{
				case MenuBoxItems.SET_BUTTONS:
				{
					strVec = new Vector.<String>();
					strVec.push(MenuBoxItems.NO);
					strVec.push(MenuBoxItems.YES);
					var msg1:PlainMessageMenuBox = new PlainMessageMenuBox(MessageBoxMessages.SET_BUTTONS_START,strVec);
					var msg2:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_LFT);
					var msg3:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_RHT);
					var msg4:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_UP);
					var msg5:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_DWN);
					var msg6:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_JMP);
					var msg7:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_ATK);
					var msg8:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_SPC);
					var msg9:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_PSE);
					var msg10:PlainMessageBox = new PlainMessageBox(MessageBoxMessages.SET_BUTTONS_SEL);
					var msg11:PlainMessageMenuBox = new PlainMessageMenuBox(MessageBoxMessages.SET_BUTTONS_END,strVec);
					msg2.nextMsgBxToCreate = msg3;
					msg3.nextMsgBxToCreate = msg4;
					msg4.nextMsgBxToCreate = msg5;
					msg5.nextMsgBxToCreate = msg6;
					msg6.nextMsgBxToCreate = msg7;
					msg7.nextMsgBxToCreate = msg8;
					msg8.nextMsgBxToCreate = msg9;
					msg9.nextMsgBxToCreate = msg10;
					msg10.nextMsgBxToCreate = msg11;
					msg1.mbName = PlainMessageMenuBox.SET_BUTTONS_START_NAME;
					msg11.mbName = PlainMessageMenuBox.SET_BUTTONS_END_NAME;
					MSG_BX_MNGR.setBtnsDct = new Dictionary();
					MSG_BX_MNGR.setBtnsDct[msg2.msgStr] = msg2;
					MSG_BX_MNGR.setBtnsDct[msg3.msgStr] = msg3;
					MSG_BX_MNGR.setBtnsDct[msg4.msgStr] = msg4;
					MSG_BX_MNGR.setBtnsDct[msg5.msgStr] = msg5;
					MSG_BX_MNGR.setBtnsDct[msg6.msgStr] = msg6;
					MSG_BX_MNGR.setBtnsDct[msg7.msgStr] = msg7;
					MSG_BX_MNGR.setBtnsDct[msg8.msgStr] = msg8;
					MSG_BX_MNGR.setBtnsDct[msg9.msgStr] = msg9;
					MSG_BX_MNGR.setBtnsDct[msg10.msgStr] = msg10;
//					MSG_BX_MNGR.writeNextMainMenu(msg11);
//					msg11.nextMsgBxToCreate = new OptionsMenu();
					msg1.nextMsgBxToCreate = new OptionsMenu();
//					MSG_BX_MNGR.writeNextMainMenu(msg1);
//					MSG_BX_MNGR.writeNextMainMenu(msg11.nextMsgBxToCreate);
					nextMsgBxToCreate = msg1;
					cancel();
					break;
				}
				case MenuBoxItems.GENERAL_OPTIONS:
				{
					nextMsgBxToCreate = new GeneralOptions();
					cancel();
					break;
				}
				case MenuBoxItems.SOUND_OPTIONS:
				{
					nextMsgBxToCreate = new SoundOptions();
					cancel();
					break;
				}
				case MenuBoxItems.GRAPHICS_OPTIONS:
				{
					nextMsgBxToCreate = new GraphicsOptions();
					cancel();
					break;
				}
				case MenuBoxItems.BACK:
				{
					if (!nextMsgBxToCreate)
						MSG_BX_MNGR.writeNextMainMenu(this);
					cancel();
					break;
				}
				case MenuBoxItems.CHEATS:
				{
					nextMsgBxToCreate = new CheatMenu();
					cancel();
				}
			}
			SND_MNGR.playSoundNow(SN_CHOOSE_ITEM);
		}
		override public function pressAtkBtn():void
		{
			MSG_BX_MNGR.writeNextMainMenu(this);
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}

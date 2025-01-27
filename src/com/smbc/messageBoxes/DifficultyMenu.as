package com.smbc.messageBoxes
{
	import com.smbc.data.Difficulties;
	import com.smbc.data.GameSettings;
	import com.smbc.events.CustomEvents;
	import com.smbc.text.TextFieldContainer;

	import flash.text.TextField;

	public class DifficultyMenu extends MenuBox
	{
		private var strVec:Vector.<String> = new Vector.<String>();
		private const NORMAL_IND:int = 2;
		public function DifficultyMenu()
		{
			super(loadItems(),0,NaN,true,MessageBoxMessages.DIFFICULTY_MENU_DESCRIPTION);
			strVec = null;
		}
		private function loadItems():Array
		{
			return [
			[MenuBoxItems.VERY_EASY],
			[MenuBoxItems.EASY],
			[MenuBoxItems.NORMAL],
			[MenuBoxItems.HARD],
			[MenuBoxItems.VERY_HARD]
			];
		}
		override protected function setUpSelector():void
		{
			super.setUpSelector();
			madeFirstSelection = false;
			_cSelNum = NORMAL_IND;
			setNewSelection(_cSelNum);
			madeFirstSelection = true;
//			var lTxt:TextField = ARR_VEC[0][IND_ARR_VEC_TEXT_FIELD] as TextField;
//			lTxt.textColor = COLOR_WHITE;
		}
		override protected function chooseItem(itemName:String, itemValue:String, itemTfc:TextFieldContainer, gsOvRdNum:int):void
		{
			GameSettings.changeDifficulty( Difficulties.swapNumAndName(itemName) );
			nextMsgBxToCreate = new CampaignModeMenu();
			cancel();
			SND_MNGR.playSoundNow(MessageBoxSounds.CHOOSE_DIFFICULTY);
		}
		override public function pressAtkBtn():void
		{
			MSG_BX_MNGR.writeNextMainMenu(this);
			cancel();
			SND_MNGR.playSoundNow(SN_CANCEL_ITEM);
		}
	}
}

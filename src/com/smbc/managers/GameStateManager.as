package com.smbc.managers
{
		import com.smbc.data.GameStates;
		import com.smbc.errors.SingletonError;
		import com.smbc.level.Level;

		import flash.utils.getQualifiedClassName;

	public final class GameStateManager extends MainManager
	{
		public static const GS_MNGR:GameStateManager = new GameStateManager();
		private static var instantiated:Boolean;
		private const GS_PLAY:String = GameStates.PLAY;
		private var _gameState:String;
		public var lockGameState:Boolean;

		public function GameStateManager()
		{
			if (instantiated)
				throw new SingletonError();
			instantiated = true;
		}
		override public function initiate():void
		{
			super.initiate();
			gameState = GameStates.LOADING;
		}
		public function get gameState():String
		{
			return _gameState;
		}
		public function set gameState(gs:String):void
		{
			if (lockGameState)
			{
				//trace("gameState locked: "+_gameState);
				return;
			}
			var lastGameState:String = _gameState;
			_gameState = gs;
			//trace("ngs: "+_gameState+"   lgs: "+lastGameState);
			if (_gameState != GS_PLAY)
				statMngr.stopTmrs();
			else
				statMngr.startTmrs();
		}

	}
}

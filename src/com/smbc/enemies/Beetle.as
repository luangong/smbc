package com.smbc.enemies
{
	import com.explodingRabbit.cross.gameplay.statusEffects.StatusProperty;
	import com.smbc.data.EnemyInfo;
	import com.smbc.data.HealthValue;
	import com.smbc.data.ScoreValue;

	import flash.events.TimerEvent;
	import flash.geom.Point;

	public class Beetle extends KoopaGreen
	{
		public static const ENEMY_NUM:int = EnemyInfo.Beetle;

		public function Beetle(fLab:String)
		{
			super(fLab);
			if (fLab.indexOf("Black") != -1 || fLab.indexOf("Brown") != -1)
				colorNum = 1;
			else if (fLab.indexOf("Blue") != -1)
				colorNum = 2;
			else if (fLab.indexOf("Gray") != -1)
				colorNum = 3;
			addProperty( new StatusProperty( PR_PIERCE_PAS, PIERCE_STR_ARMORED ) );
			stompKills = false;
		}
		override protected function overwriteInitialStats():void
		{
			_health = HealthValue.BEETLE;
			scoreAttack = ScoreValue.BEETLE_ATTACK;
			scoreBelow = ScoreValue.BEETLE_BELOW;
			scoreStar = ScoreValue.BEETLE_STAR;
			scoreStomp = ScoreValue.BEETLE_STOMP;
			super.overwriteInitialStats();
		}
		override protected function shellTmr1Handler(e:TimerEvent):void
		{
			SHELL_TMR_1.reset();
			SHELL_TMR_2.start();
		}
	}
}

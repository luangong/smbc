package com.smbc.data
{
	import com.smbc.messageBoxes.MenuBoxItems;

	public class Difficulties
	{
		private static const _VERY_EASY:Array = [ 0, MenuBoxItems.VERY_EASY ];
		private static const _EASY:Array = [ 1, MenuBoxItems.EASY ];
		private static const _NORMAL:Array = [ 2, MenuBoxItems.NORMAL ];
		private static const _HARD:Array = [ 3, MenuBoxItems.HARD ];
		private static const _VERY_HARD:Array = [ 4, MenuBoxItems.VERY_HARD ];
		private static const IND_VALUE:int = 0;
		private static const IND_NAME:int = 1;
		private static const VEC:Vector.<Array> = Vector.<Array>([
		_VERY_EASY,_EASY,_NORMAL,_HARD,_VERY_HARD]);
		public static const MAX_VALUE:int = _VERY_HARD[IND_VALUE];
		
		public static function swapNumAndName(value:*):*
		{
			if (value is int)
				return VEC[value][IND_NAME];
			else if (value is String)
			{
				for each (var arr:Array in VEC)
				{
					if (value == arr[IND_NAME])
						return arr[IND_VALUE];
				}
			}
			throw new Error("improper conversion input");
			return null;
		}

		public static function get VERY_EASY():int
		{
			return _VERY_EASY[IND_VALUE];
		}

		public static function get EASY():int
		{
			return _EASY[IND_VALUE];
		}

		public static function get NORMAL():int
		{
			return _NORMAL[IND_VALUE];
		}

		public static function get HARD():int
		{
			return _HARD[IND_VALUE];
		}

		public static function get VERY_HARD():int
		{
			return _VERY_HARD[IND_VALUE];
		}


	}
}

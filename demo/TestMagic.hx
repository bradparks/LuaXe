package ;

class TestMagic
{
	public static function test()
	{
		untyped __lua__("_G.print('__lua__')");
		untyped __call__(print, 1, 2, 3);
		untyped __tail__(os, clock, 1, 2, "hi");
		untyped __global__(print,'__lua__', 2);
		var z:Int = cast "0";
		trace(untyped __hash__(z));
	}
}
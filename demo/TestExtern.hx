package ;

extern class Extern {
	function new(x:Int);
	static function test():String;
	static var hi:String;
	function selfcall():String;
	var X:Int;
}

class TestExtern
{
	public static function test()
	{
		trace("TestExtern begin");
		// static:
		trace(Extern.test());
		trace(Extern.hi);
		// fields:
		var inst = new Extern(5);
		trace(inst.selfcall());
		trace(inst.X);
		trace("TestExtern end");
	}
}
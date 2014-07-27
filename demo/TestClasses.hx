package ;

// https://github.com/frabbit/hx2python/blob/development/demo/bits/

class LClass
{
    public function new()
    {
    }
}

private class BaseClass
{
    public static inline var SOME_CONSTANT = "someConstant";  //final or inlined at compile time
    public static var UninitialisedStaticVar:Float;
    public var id:String;
    public var count(get, set):Int;
    var _count:Int;
    function get_count() return _count++;
    function set_count(v) return _count = v;
    public function new()
    {
        trace("BaseClass::new");
        #if !as3
        if(_instances == null)
        {
            _instances  = 0;
        }
        #end
        _instances ++;
        _count = 0;
        UninitialisedStaticVar = 1.234;
    }
    public function getString()
    {
        return "string from BaseClass::getString()";
    }
    public function getStringS()
    {
        return "string from BaseClass::getString()";
    }
    public function acceptArgument(value:Bool)
    {
        trace("BaseClass::acceptArguments value = " + Std.string(value));
    }
    public static var instances(get, null):Int = 0;     //TODO(av) make sure this gets initialized
    static var _instances:Int;
    static function get_instances() return _instances;
}

private interface InterfaceDemo
{
    var apiVar:Bool;
    function doSomething():Void;
}

private class AClass extends BaseClass
{
    public function methodInAClass()
    {
        trace("AClass::methodInAClass");
    }
    override function getString()
    {
        return super.getString() + " Overridden in AClass";
       // return "AClsss::getString - override with no super call";
    }
    override function getStringS()
    {
        return "Overridden in AClass";
    }
}

@:keep private class BClass extends AClass implements InterfaceDemo
{
    public static var WHOOT = "whoot";
    public var apiVar:Bool;
    public function new(arg)
    {
        super();
        trace("BClass::new " + arg);
        apiVar = true;
    }
    public function methodInBClass()
    {
        trace("BClass::methodInBClass");
    }
    public function doSomething()
    {
        trace("BClass::doSomething()");
    }
}

class CClass extends BClass
{
    public function new(arg)
    {
        super(arg);
        trace("CClass::new " + arg);
    }
}

class TestClasses
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestClasses begin");
		// new
		var L = new LClass();
		var bc = new BaseClass();
		var a = new AClass();
		var b = new BClass("arg");
		var c = new CClass("arg");
		// methods

		// fields

		if(!perf) trace("TestClasses end");
	}
}
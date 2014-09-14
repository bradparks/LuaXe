package demo.genctests.ctest;
import demo.genctests.*;
class OptionalFunctionArgumentsunit
{
	public static function run() {
		trace(Main.optArg("foo") == "foobaz12");
		trace(Main.optArg("foo", "bar") == "foobar12");
		trace(Main.optArg("foo", 1) == "foobaz1");
		trace(Main.optArg("foo", "bar", 1) == "foobar1");
		trace(Main.optArg("foo", null, null) == "foobaz12");
	}
}
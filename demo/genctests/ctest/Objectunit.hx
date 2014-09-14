package demo.genctests.ctest;
import demo.genctests.*;
class Objectunit
{
	public static function run() {
		var a = { a: "foo", b: 1 };
		trace(a.a == "foo");
		trace(a.b == 1);
	}
}
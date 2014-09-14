package demo.genctests.ctest;
import demo.genctests.*;
class Forunit
{
	public static function run() {
		var i = 0;
		var r1 = null;
		var r2 = null;
		for (e in ["foo", "bar"]) {
			if (i == 0) r1 = e;
			else r2 = e;
			++i;
		}
		trace(r1 == "foo");
		trace(r2 == "bar");
	}
}
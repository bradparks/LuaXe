package demo.genctests.ctest;
import demo.genctests.*;
class FlatEnumunit
{
	public static function run() {
		var a = MyFlatEnum.A;
		trace(a == MyFlatEnum.A);
		var r = "";
		switch(a) {
			case A: r = "foo";
			case _: r = "bar";
		}
		trace(r == "foo");
	}
}
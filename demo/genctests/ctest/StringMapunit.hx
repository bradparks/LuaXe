package demo.genctests.ctest;
import demo.genctests.*;
class StringMapunit
{
	public static function run() {
		var b = new haxe.ds.StringMap<String>();
		b.set("foo", "bar");
		b.set("foo2", "bar2");
		b.set("foo3", "bar3");
		trace(b.exists("foo") == true);
		trace(b.exists("foo2") == true);
		trace(b.exists("foo3") == true);
		trace(b.exists("foo4") == false);
		trace(b.get("foo") == "bar");
		trace(b.get("foo2") == "bar2");
		trace(b.get("foo3") == "bar3");
		b.set("foo2", "bar4");
		trace(b.exists("foo2") == true);
		trace(b.get("foo2") == "bar4");
	}
}
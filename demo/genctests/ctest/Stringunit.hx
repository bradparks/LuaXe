package demo.genctests.ctest;
import demo.genctests.*;
class Stringunit
{
	public static function run() {
		var s = new String("my string");
		trace(s.toString() == s);
		
		var s = "foo";
		s = s + "bar";
		trace(s == "foobar");
		// TODO s += "baz";
		trace(s == "foobarbaz");
	}
}
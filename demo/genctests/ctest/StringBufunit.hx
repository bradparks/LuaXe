package demo.genctests.ctest;
import demo.genctests.*;
class StringBufunit
{
	public static function run() {
		var b = new StringBuf();
		trace(b.toString() == "");
		b.add("foo");
		trace(b.toString() == "foo");
		b.add("bar");
		trace(b.toString() == "foobar");
		b.addChar('z'.code);
		trace(b.toString() == "foobarz");
		b.addSub("babaz", 2);
		trace(b.toString() == "foobarzbaz");
		
		// add, toString
		var x = new StringBuf();
		trace(x.toString() == "");
		x.add(null);
		trace(x.toString() == "null");
		
		// addChar
		var x = new StringBuf();
		x.addChar(32);
		trace(x.toString() == " ");
		
		// addSub
		var x = new StringBuf();
		x.addSub("abcdefg", 1);
		trace(x.toString() == "bcdefg");
		var x = new StringBuf();
		x.addSub("abcdefg", 1, null);
		trace(x.toString() == "bcdefg");
		var x = new StringBuf();
		x.addSub("abcdefg", 1, 3);
		trace(x.toString() == "bcd");
		
		// identity
		function identityTest(s:StringBuf) {
			return s;
		}
		trace(identityTest(x) == x);
	}
}
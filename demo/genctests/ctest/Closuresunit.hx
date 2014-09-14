package demo.genctests.ctest;
import demo.genctests.*;
class Closuresunit
{
	public static function run() {
		var x = 12;
		var y = 99;
		var z = 9;
		function makeBig(i:Int) {
			var z = 20;
			return {f1:i * 2, f2:y, f3:z};
		}
		var k = makeBig(x);
		trace(x == 12);
		trace(y == 99);
		trace(z == 9);
		trace(k.f1 == 24);
		trace(k.f2 == 99);
		trace(k.f3 == 20);
		
		var f1 = makeBig;
		trace(f1(5).f1 == 10);
			
		function filter(a:Array<Int>, f:Int->Bool) {
			var l = [];
			for( x in a )
				if( f(x) )
					l.push(x);
			return l;
		}
		
		var a = [4, 88, 9, 12, 3];
		var a2 = filter(a, function(i) return i > 5);
		trace(a2[0] == 88);
		trace(a2[1] == 9);
		trace(a2[2] == 12);
		
		var c = new SomeClass("foo");
		var func = c.getClosure("456");
		trace(func("789") == "123456789");
		var gc = c.getClosure;
		var gc1 = gc("456");
		var gc2 = gc1("789");
		trace(gc2 == "123456789");
		trace(gc("456")("789") == "123456789");
		
		var old = haxe.Log.trace;
		//var buf = new StringBuf(); TODO
		function newTrace(s,?p) {
		/*	buf.add(s); TODO*/
		}
		newTrace("foo");
		newTrace("bar");
		// TODO trace(buf.toString() == "foobar");
		
		var s0 = "begin";
		function f1(s1:String) {
			var s2 = "1";
			function f2(s3:String) {
				var s4 = "2";
				function f3(s5:String) {
					return s0 + s1 + s2 + s3 + s4 + s5;
				}
				return f3;
			}
			return f2;
		}
		var s = f1("foo")("bar")("end");
		trace(s == "beginfoo1bar2end");
		
		var s0 = "foo";
		function fAssign(s1:String) {
			s0 = s1;
		}
		trace(s0 == "foo");
		fAssign("bar");
		trace(s0 == "bar");
		
		var s1 = "foo";
		var anon = {
			test:function(s2) {
				return s1 + s2;
			}
		}
		trace(anon.test("bar") == "foobar");
	}
}
package demo.genctests.ctest;
import demo.genctests.*;
class OptionalStructureFieldunit
{
	public static function run() {
		function takeTypedef(t:MyTypedef) {
			return t.maybeGiven;
		}
		
		function giveTypedef():MyTypedef {
			return { given: "foo" };
		}
		
		var s:Int = cast takeTypedef({given: "foo" });
		trace(s == 0);
		
		trace(takeTypedef({given: "foo", maybeGiven:"bar"}) == "bar");
		
		var td:MyTypedef = { given: "foo" };
		trace(td.given == "foo");
		trace(td.maybeGiven == null);
		
		td = { given: "foo" };
		trace(td.given == "foo");
		trace(td.maybeGiven == null);
		
		var a:Array<MyTypedef> = [ {given: "foo" }];
		trace(a[0].given == "foo");
		trace(a[0].maybeGiven == null);
		
		var o:{f:MyTypedef} = { f: { given: "foo" }};
		trace(o.f.given == "foo");
		trace(o.f.maybeGiven == null);
		
		var td = giveTypedef();
		trace(td.given == "foo");
		trace(td.maybeGiven == null);
	}
}
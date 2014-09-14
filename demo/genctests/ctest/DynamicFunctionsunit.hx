package demo.genctests.ctest;
import demo.genctests.*;
class DynamicFunctionsunit
{
	public static function run() {
		trace(SomeClassWithDynamicFunctions.staticDyn("foo") == "staticDyn(Static State, foo)");
		SomeClassWithDynamicFunctions.staticDyn = function(v) {
			return 'Custom Func($v)';
		}
		trace(SomeClassWithDynamicFunctions.staticDyn("foo") == "Custom Func(foo)");
		
		var inst = new SomeClassWithDynamicFunctions();
		trace(inst.memberDyn("bar") == "memberDyn(Member State, bar)");
		inst.memberDyn = SomeClassWithDynamicFunctions.staticDyn;
		trace(inst.memberDyn("bar") == "Custom Func(bar)");
	}
}
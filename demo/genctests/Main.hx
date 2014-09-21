package demo.genctests;

import demo.genctests.ctest.*;

class Main {
	static var count = 0;
	static var failures = 0;

	static public function main() {
		trace("Beginning unit tests");
		new Main();
		TestVTable.run();
		Arrayunit.run();
		//Bytesunit.run();
		Closuresunit.run();
		DynamicFunctionsunit.run();
		//FlatEnumunit.run();
		Forunit.run();
		//GenericStackunit.run();
		Ifunit.run();
		//IntIteratorunit.run();
		Mathunit.run();
		Objectunit.run();
		Operatorsunit.run();
		OptionalFunctionArgumentsunit.run();
		OptionalStructureFieldunit.run();
		StringBufunit.run();
		//StringMapunit.run();
		Stringunit.run();
		//Switchunit.run();
		//Tryunit.run();
		//Typeunit.run();
	//	Vectorunit.run();
		Whileunit.run();
	}

	public function new(){
		optArg("test");
		equals(1,2);
		equalsNot(1,2);
		equalsFloat(0.34, 0.457777);
		isTrue(false);
		isFalse(true);
		trace(count);
		trace(failures);
	}

	static public function optArg(s1:String, ?s2:String = "baz", ?i:Int = 12) {
		return s1 + s2 + i;
	}

	@:generic static public function equals<T>(t1:T, t2:T, ?p:haxe.PosInfos) {
		count++;
		if (t1 != t2) {
			failures++;
			haxe.Log.trace("Failure", p);
		} else haxe.Log.trace("ok");
	}

	@:generic static public function equalsNot<T>(t1:T, t2:T, ?p:haxe.PosInfos) {
		count++;
		if (t1 == t2) {
			failures++;
			haxe.Log.trace("Failure", p);
		} else haxe.Log.trace("ok");
	}

	static public function equalsFloat(f1:Float,f2:Float, ?p:haxe.PosInfos) {
		var f1 = f1 < 0 ? -f1 : f1;
		var f2 = f2 < 0 ? -f2 : f2;
		if (f1 > f2 && f1 - f2 > 0.00001 || f2 > f1 && f2 - f1 > 0.00001) {
			failures++;
			haxe.Log.trace("Failure", p);
		} else haxe.Log.trace("ok");
	}

	static public function isTrue(t:Bool, ?p:haxe.PosInfos) {
		count++;
		if (!t) {
			failures++;
			haxe.Log.trace("Failure", p);
		} else haxe.Log.trace("ok");
	}

	static public function isFalse(t:Bool, ?p:haxe.PosInfos) {
		count++;
		if (t) {
			failures++;
			haxe.Log.trace("Failure", p);
		} else haxe.Log.trace("ok");
	}
}
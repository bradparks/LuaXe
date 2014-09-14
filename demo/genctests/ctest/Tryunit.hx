package demo.genctests.ctest;
import demo.genctests.*;
class Tryunit
{
	public static function run() {
		var s = "";
		try {
		// TODO	try {
		// TODO		
		// TODO	} catch(err:Dynamic) {
		// TODO		trace("fail");
		// TODO	}
			throw "I was thrown today";
		} catch(err:String) {
			s = err;
		}
		trace(s == "I was thrown today");
		
		try {
			throw 1;
		} catch(e:String) {
			trace("Should not be entered...");
			throw false;
		} catch(e:Dynamic) {
			s = "Caught dynamic";
		}
		trace(s == "Caught dynamic");
		
		var s2 = "";
		try {
			try {
				throw "exc1";
			} catch(e:Dynamic) {
				throw "exc2";
			}
		} catch(s:String) {
			s2 = s;
		}
		trace(s2 == "exc2");
	}
}
package demo.genctests.ctest;
import demo.genctests.*;
class Vectorunit
{
	public static function run() {
		var v = new haxe.ds.Vector(5);
		trace(v.length == 5);
		v.set(1, 12);
		trace(v.get(1) == 12);
		trace(v.get(0) == 0);
	}
}
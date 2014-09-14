package demo.genctests.ctest;
import demo.genctests.*;
class GenericStackunit
{
	public static function run() {
	// TODO
		var gs = new haxe.ds.GenericStack<String>();
		trace(gs.isEmpty() == true);
	//TODO	trace(gs.first() == null);
		trace(gs.pop() == null);
		trace(gs.remove(null) == false);
		gs.add("foo");
		trace(gs.isEmpty() == false);
	//TODO	trace(gs.first() == "foo");
		trace(gs.pop() == "foo");
	//TODO	trace(gs.isEmpty() == true);
	//TODO	trace(gs.first() == null);
		trace(gs.pop() == null);
		gs.add("foo");
	//TODO	trace(gs.first() == "foo");
		trace(gs.remove("foo") == true);
		trace(gs.isEmpty() == true);
		gs.add("foo");
		gs.add("bar");
		trace(gs.pop() == "bar");
	//TODO	trace(gs.first() == "foo");
		trace(gs.pop() == "foo");
		gs.add(null);
		gs.add(null);
		trace(gs.isEmpty() == false);
	//TODO	trace(gs.first() == null);
		trace(gs.pop() == null);
		trace(gs.remove(null) == true);
		trace(gs.isEmpty() == true);
	//TODO	trace(gs.first() == null);
		trace(gs.pop() == null);
	}
}
package demo.genctests.ctest;
import demo.genctests.*;
class Arrayunit
{
	public static function run() {
		var a = [1, 2, 3];
		trace(a[0] == 1);
		trace(a[1] == 2);
		trace(a[2] == 3);
		
		a[0] = 4;
		trace(a[0] == 4);
		
		a.push(12);
		trace(a[3] == 12);
		trace(a.pop() == 12);
		trace(a.pop() == 3);
		trace(a.pop() == 2);
		trace(a.pop() == 4);
		
		var a = ["foo", "bar"];
		a.push("baz");
		trace(a.pop() == "baz");
		trace(a.pop() == "bar");
		trace(a.pop() == "foo");
		
		var a = ArrayStruct.createWithSize(10);
		trace(a._count == 10);
		for(i in -10...0)
		{
			a.constArray[-i-1] = i;
			trace(a.constArray[-i-1] == i);
		}
		trace(a._count == 10);
		
		var a1 = ["foo", "bar", "baz"];
		var a2 = [];
		for (e in a1) {
			a2.push(e);
		}
		trace(a1 == ["foo", "bar", "baz"]);
		trace(a2 == ["foo", "bar", "baz"]);
	}
}
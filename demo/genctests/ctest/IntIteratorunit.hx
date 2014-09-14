package demo.genctests.ctest;
import demo.genctests.*;
class IntIteratorunit
{
	public static function run() {
		var ii = new IntIterator(0, 2);
		trace(ii.hasNext() == true);
		trace(ii.next() == 0);
		trace(ii.hasNext() == true);
		trace(ii.next() == 1);
		trace(ii.hasNext() == false);
		var ii = new IntIterator(0, 2);
		var r = [];
		for (i in ii)
			r.push(i);
		trace(r == [1, 2]);
		for (i in ii)
			r.push(i);
		trace(r == [1, 2]);
	}
}
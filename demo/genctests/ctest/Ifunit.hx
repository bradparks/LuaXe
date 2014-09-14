package demo.genctests.ctest;
import demo.genctests.*;
class Ifunit
{
	public static function run() {
		var x;
		var two = 2;
		var one = 1;
		if (two > one) {
			x = 1;
		} else {
			x = 2;
		}
		trace(x == 1);
		
		if (one > two) {
			x = 1;
		} else {
			x = 2;
		}
		trace(x == 2);
		
		if (one > two) {
			x = 1;
		} else if (two > one) {
			x = 2;
		} else {
			x = 3;
		}
		trace(x == 2);
	}
}
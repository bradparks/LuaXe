package demo.genctests.ctest;
import demo.genctests.*;
class Operatorsunit
{
	public static function run() {
		trace(1 < 2 == true);
		trace(2 > 1 == true);
		trace(2 == 2 == true);
		trace(2 != 1 == true);
		
		function test(i1:Int, i2:Int) {
			return i1 + i2;
		}
		var a = [99, 3, 7];
		var i = 0;
		trace(test(a[i++], a[i++]) == 102);
		trace(i == 2);
		i = 1;
		trace(test(a[i], a[i++]) == 10);
		trace(i == 2);
		
		var z = 0;
		trace(z++ == 0);
		trace(z == 1);
		trace(++z == 2);
		z++;
		trace(z == 3);
		++z;
		trace(z == 4);
		
		// TODO trace((z += 3) == 7);
		
		var x = 0;
		var arr = [3];
		trace(arr[x++]++ == 3);
		trace(x == 1);
		trace(arr[0] == 4);
		x = 0;
		// TODO trace((arr[x++] += 3) == 7);
		trace(arr[0] == 7);
		
		var a = [0];
		// TODO a[0] += 1;
		trace(a[0] == 1);
		// TODO a[0] += a[0] + 1;
		trace(a[0] == 3);
	}
}
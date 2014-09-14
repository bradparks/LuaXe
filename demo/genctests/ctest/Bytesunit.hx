package demo.genctests.ctest;
import demo.genctests.*;
class Bytesunit
{
	public static function run() {
		var b = haxe.io.Bytes.alloc(5);
		b.set(0, 12);
		trace(b.get(0) == 12);
		trace(b.get(1) == 0);
		trace(b.get(2) == 0);
		trace(b.get(3) == 0);
		trace(b.get(4) == 0);
		var b2 = b.sub(0, 3);
		trace(b2.length == 3);
		trace(b2.get(0) == 12);
		trace(b2.get(1) == 0);
		trace(b2.get(2) == 0);
		var b3 = haxe.io.Bytes.alloc(3);
		b3.blit(1, b2, 0, 2);
		trace(b3.get(0) == 0);
		trace(b3.get(1) == 12);
		trace(b3.get(2) == 0);
	}
}
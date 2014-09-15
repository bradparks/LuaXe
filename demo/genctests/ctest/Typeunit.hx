package demo.genctests.ctest;
import demo.genctests.*;
class Typeunit
{
	public static function run() {
		var cl = Type.resolveClass("Main");
		trace(cl != null);
		trace(Type.getClassName(cl) == "Main");
		
		trace(Type.resolveClass("Waneck12") == null);
		
		var cl = Type.resolveClass("demo.genctests.SomeClass");
		trace(cl != null);
		var inst:SomeClass = Type.createEmptyInstance(cl);
		trace(inst != null);
		
		var cl = Type.resolveClass("demo.genctests.E");
		var cl2 = Type.getSuperClass(cl);
		trace(cl2 != null);
		trace(Type.getClassName(cl2) == "D");
		trace(Type.getClassName(cl2));
	}
}
class TestSyntax
{
	public static function test()
	{
		trace("TestSyntax begin");
		// http://haxe.ru/ref-constants
		var v = 0; // Int
		var v = -134; // Int
		var v = 0xFF00; // Int
		var v = 123.0; // Float
		var v = .14179; // Float
		var v = 13e50; // Float
		var v = -1e-99; // Float
		var v = "hello"; // String
		var v = "hello \"world\" !"; // String
		var v = 'hello "world" !'; // String
		var v = true; // Bool
		var v = false; // Bool
		var v = null; // Unknown<0>
		var v = ~/[a-z]+/i; // EReg
		// TODO http://haxe.ru/ref-operations
		// TODO http://haxe.ru/ref-unary_operations
		// TODO http://haxe.ru/ref-blocks
		/*{
		    {};
		    {};
		    {trace(1);};
		    {};
		}*/
		//trace({ var x = 124; true; });
		// http://haxe.ru/ref-local-variables
		var x;
		var y = 3;
		var z : String;
		var w : String = "";
		var a, b : Bool, c : Int = 0;
		// TODO http://haxe.ru/ref-identificator
		// TODO http://haxe.ru/ref-fields-calls-new
		// TODO http://haxe.ru/ref-array
		// TODO http://haxe.ru/ref-if
		// TODO http://haxe.ru/ref-while
		// TODO http://haxe.ru/ref-for
		// TODO http://haxe.ru/ref-return
		// TODO http://haxe.ru/ref-break-continue
		// TODO http://haxe.ru/ref-exceptions
		// TODO http://haxe.ru/ref-switch
		// TODO http://haxe.ru/ref-local_function
		// TODO http://haxe.ru/ref-anonymous_objects
		// TODO http://haxe.ru/ref-classes
		// TODO http://haxe.ru/ref-class-inheritance
		// TODO http://haxe.ru/ref-class_parameters
		// TODO http://haxe.ru/ref-enum
		// TODO http://haxe.ru/ref-dynamic
		// TODO http://haxe.ru/ref-other_types
		// TODO http://haxe.ru/ref_iterators
		// TODO http://haxe.ru/ref_properties
		// TODO http://haxe.ru/ref_optional-arguments
		// TODO http://haxe.ru/ref_regular%20expressions

 		trace("TestSyntax end");
	}
}
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
		var r = ~/([0-9]+)/g; // литерал
		var str = "hello 48 cool 87!";
		trace( r.match(str) == true); // true
		trace( r.matched(1) == "48");    // 48
		trace( r.split(str) ); // ["hello "," cool ","!"]
 		// https://github.com/frabbit/hx2python/blob/development/demo/ArrayDemo.hx
 		new Array();
 		var a1 = [1, 2, 3];
        trace(a1);
        a1.push(4);
        trace(a1);
        var a2 = [1, 2, 3];
        var a3 = a2.map(function (x) return 100+x);
        trace(a3);
        trace(a2.map(function (x) return 100+x));
        var a:Array<Int> = [2,1,3,0,9,8,7,3,4,6,10,7,8,9,4,2,7,9,5];
        a.sort(function (x,y) return x < y ? -1 : x > y ? 1 : 0);
        trace("sorted a : " + a.join(","));
        var x = [1,2,3,4];
        trace(x.slice(1, 2));
        trace(x);
        trace(x.splice(1, 2));
        trace(x);
        trace(x.concat(a));
        trace(a.join("Yo!"));
        trace(a.length);
        trace(a.pop());
        trace(a.length);
        trace(a.join(""));
        a.reverse();
        trace(a.join(""));
        trace(a.pop());
        a.reverse();
        trace(a.join(""));

        // https://github.com/frabbit/hx2python/blob/development/demo/SimpleDemo.hx
        var z = 5 + 5;	
		var x = 0;
        if ( z > 2) {
            x = 7;
        } else {
            x = 10;
        }
        trace(x);
        trace(z);

        trace("Std test (false == fail)");
        var dyn:Dynamic = null;
        dyn = true;
        trace(Std.string(dyn) == "true");
        dyn = false;
        trace(Std.string(dyn) == "false");
        dyn = "hello";
        trace(Std.string(dyn) == "hello");
        dyn = -100;
        trace(Std.string(dyn) == "-100");
        dyn = -10.07;
        trace(Std.string(dyn) == "-10.07");
        dyn = null;
        trace(Std.string(dyn) == "null");

        dyn = "-101";
        trace(Std.parseInt(dyn) == -101);
        dyn = " 0";
        trace(Std.parseInt(dyn) == 0);

		dyn = "-10.07";
        trace(Std.parseFloat(dyn) == -10.07);

        dyn = 10.07;
        trace(Std.int(dyn) == 10);
        dyn = -10.07;
        trace(Std.int(dyn) == -10);

        trace("StringTools:");
        dyn = "  TestSyntax- -StringTools  ";
        trace(StringTools.startsWith(dyn, "  T"));
        trace(StringTools.startsWith(dyn, " T"));
        trace(StringTools.endsWith(dyn, "s  "));
        trace(StringTools.endsWith(dyn, "s "));
        trace(StringTools.fastCodeAt(dyn,5));
        trace(StringTools.htmlEscape(dyn, true));
        trace(StringTools.htmlEscape(dyn, false));
        trace(StringTools.htmlUnescape(dyn));
        trace(StringTools.isEof(dyn));
        trace(StringTools.isSpace(dyn, 1));
        trace(StringTools.isSpace(dyn, 4));
        trace(StringTools.lpad(dyn, "s ", 5));
        trace(StringTools.ltrim(dyn));
        trace(StringTools.replace(dyn, "s ", "x!&"));
        trace(StringTools.rpad(dyn, "s  ", 3));
        trace(StringTools.rtrim(dyn));
        trace(StringTools.trim(dyn));
        trace(StringTools.urlDecode(dyn + "%D0%BF%D1%80%D0%B8%D0%B2%D0%B5%D1%82"));
        var r:String = StringTools.urlEncode(dyn + "привет");
		trace(r.toUpperCase());
		dyn = 367;
		trace(StringTools.hex(dyn));


        trace("TestSyntax end");
	}
}
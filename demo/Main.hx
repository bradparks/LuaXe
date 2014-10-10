package ;

import luaxe.Lua;
import luaxe.Sys;

// Use readme
@:require("hello", "world")
class Main
{
    public static function main()
    {
        // Using native Lua arrays
        // indexed from zero [0]
        var larr = new LuaArray<Int>();
        larr[0] = 100500;
        trace(larr[0]);
        trace(larr.length);

        // Haxe arrays also indexed from zero [0]
        var arr = [5,55,555];
        var arr2 = ["a","b","c"];
        trace(arr);
        trace(arr[0]);
        arr.push(77);
        arr2.push("x");
        trace(arr);

        // Multiline strings are supported
        trace(" Dyna
        _test_multiline_strings_
            mic ");

        // luaxe.Sys.hx is a replacement of Sys.hx
        trace(Sys.time());
    }
}

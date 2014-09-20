package ;

import luaxe.Lua;

class Vehicle {
    public var numberOfWheels: Int;
    public var maxPassengers: Int;

    public function description(): String {
        return '$numberOfWheels wheels; up to ${0+maxPassengers+0} passengers';
    }

    public function new() {
        numberOfWheels = 0;
        maxPassengers = 1;
    }
}

class Bicycle extends Vehicle {
    public function new() {
        super();
        numberOfWheels = 2;
    }
}

class Tandem extends Bicycle {
    public function new() {
        super();
        maxPassengers = 2;
    }
}

class Car extends Vehicle {
    var speed: Float = 0.0;
    public function new(maxP) {
        super();
        maxPassengers = 5 + maxP;
        numberOfWheels = 4;
    }

    override function description() {
        return super.description() + 
        '; traveling at $speed mph';
    }

    public static function stat(text, none = "none")
    {
        trace('static called with text "$text"');
    }
}

// testing:
//@:require("hello", "world")
class Main
{
    static var test = "hello";
    public static function main()
    {
        trace("go -->");
        var d = Date.now().getTime();

        TestString.test();
        TestIfs.test();
        TestFuncs.test();
        TestFuncs.test();
        TestClasses.test();
        TestExceptions.test();
        TestSyntax.test(); 
        
        //#if test_lua_magic trace(Lua.eval("100 + 15.5")); #end
        #if test_lua_magic
        TestMagic.test();
        TestExtern.test();
        var larr = new LuaArray<Int>();
            larr[0] = 100500;
            trace(larr[0]);
            trace(larr.length);
        #end


        Car.stat("huh?");
        var someVehicle = new Vehicle();
        trace('Vehicle: ${someVehicle.description()}');
        var bicycle = new Bicycle();
        trace('Bicycle: ${bicycle.description()}');
        var tandem = new Tandem();
        trace(tandem);
        trace('Tandem: ${tandem.description()}');
        trace('Car: ${(new Car(5)).description()}');
        
        var arr = [5,55,555];
        var arr2 = ["a","b","c"];
        trace(arr);
        trace(arr[0]);
        arr.push(77);
        arr2.push("x");
        trace(arr);

        //var OpOr = arr[0] | 0;

        var obj = {a:2,b:3};
        var b = {a:2,b:3};

        var factory = function()//Factory 
        {
            return {a:2,b:3};
        }

        var count:Float = 0;
        var x = 0;

        for(i in 0...10)
        {
            arr.push(i);
            arr2.push("i");
            obj = {a:2,b:3};//Object Create 
            b = factory ();
            count += obj.a + b.b + arr.length;
        }

        for(i in 0...arr.length)
        {
            count += (arr[i]) + arr2.length;
            x++;
            ++x;
            --x;
            x--;
        }

        trace(count);
        trace(arr.length);
        trace(b);
        trace(obj);
        
        /* */
        #if neko
         var platform = ("[neko] > ");
        #elseif lua
         var platform = ("[lua] > ");
        #elseif js
         var platform = ("[js] > "); 
        #else 
         var platform = ("[cpp] > ");
        #end

        trace(platform + "FeatureTest: " + Std.int((Date.now().getTime()-d)) + "ms");
        
        // Lua is SLOW on strings, so test them separately
        d = Date.now().getTime();

        for(i in 0...10000)
        {
            TestString.test(true);
        }

        trace(platform + "StringPerfTest: " + Std.int((Date.now().getTime()-d)) + "ms");

        d = Date.now().getTime();

        //benchmark.LoopTesterApp.main();
        demo.genctests.Main.main();

        trace(platform + "ComplexPerfTest: " + Std.int((Date.now().getTime()-d)) + "ms");

        // combined perf test without strings
        // heat JIT
        for(i in 0...5) {
            TestIfs.test(true);
            TestFuncs.test(true);
            TestLoops.test(true);
        }

        d = Date.now().getTime();
      
        for(i in 0...100000)
        {
            TestIfs.test(true);
            TestFuncs.test(true);
            TestLoops.test(true);
        }

        trace(platform + "LangPerfTest: " + Std.int((Date.now().getTime()-d)) + "ms");
    }
}
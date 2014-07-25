package ;

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
        return //super.description() + 
        '; traveling at $speed mph';
    }

    public static function stat(text, none = "none")
    {
        trace('static called with text "$text"');
    }
}

// testing:
class Main
{
    static var test = "hello";
    public static function main()
    {
        trace("go -->");
        #if lua
            var d = untyped os.clock();
        #else
            var d = Date.now().getTime();
        #end

        TestString.test();
        /*

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

        for(i in 0...100000)
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
         trace("[neko] >");
        #elseif lua
         trace("[lua] >");
        #elseif js
         trace("[js] >"); 
        #else 
         trace("[cpp] >");
        #end

        #if lua
            trace("" + Std.int(1000*((untyped os.clock())-d)) + "ms");
        #else
            trace("" + Std.int((Date.now().getTime()-d)) + "ms");
        #end
        
        #if lua
            d = untyped os.clock();
        #else
            d = Date.now().getTime();
        #end
        
        for(i in 0...100000)
        {
            TestString.test(true);
        }

        #if lua
            trace("LangPerfTest: " + Std.int(1000*((untyped os.clock())-d)) + "ms");
        #else
            trace("LangPerfTest: " + Std.int((Date.now().getTime()-d)) + "ms");
        #end
        /**/
    }
}
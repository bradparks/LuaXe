function exec()
-- class Vehicle
Vehicle = {};
__inherit(Vehicle, Object);
Vehicle.__index = Vehicle;
do --{
	
	function Vehicle.new(  )
		local self = {}
		setmetatable(self, Vehicle) 
		self.numberOfWheels = 0;
		self.maxPassengers = 1;
		return self
	end
	--var numberOfWheels;
	--var maxPassengers;
	function Vehicle:description(  ) 
		return "" .. self.numberOfWheels .. " wheels; up to " + self.maxPassengers .. " passengers";
	end
	
	
end --}

-- class Bicycle extends Vehicle
Bicycle = {};
__inherit(Bicycle, Vehicle);
Bicycle.__index = Bicycle;
do --{
	
	function Bicycle.new(  )
		local self = {}
		setmetatable(self, Bicycle) 
				__inherit(self, Vehicle.new());
		self.numberOfWheels = 2;
		return self
	end
	
end --}

-- class Tandem extends Bicycle
Tandem = {};
__inherit(Tandem, Bicycle);
Tandem.__index = Tandem;
do --{
	
	function Tandem.new(  )
		local self = {}
		setmetatable(self, Tandem) 
				__inherit(self, Bicycle.new());
		self.maxPassengers = 2;
		return self
	end
	
end --}

-- class Car extends Vehicle
Car = {};
__inherit(Car, Vehicle);
Car.__index = Car;
do --{
	
	function Car.new(  )
		local self = {}
		setmetatable(self, Car) 
		self.speed = 0.0;
				__inherit(self, Vehicle.new());
		self.maxPassengers = 5;
		self.numberOfWheels = 4;
		return self
	end
	function Car.stat(  ) 
		print("static called");
	end
	--var speed;
	function Car:description(  ) 
		return "; traveling at " .. self.speed .. " mph";
	end
	
	
end --}

-- class Main
Main = {};
__inherit(Main, Object);
Main.__index = Main;
do --{
	function Main.main(  ) 
		print("go -->");
		local d = os:clock();
		Car.stat();
		local someVehicle = Vehicle.new();
		print("Vehicle: " .. someVehicle:description());
		local bicycle = Bicycle.new();
		print("Bicycle: " .. bicycle:description());
		local tandem = Tandem.new();
		print(tandem);
		print("Tandem: " .. tandem:description());
		print("Car: " .. Car.new():description());
		local arr = setmetatable({[0]=5, 55, 555}, HaxeArrayMeta);
		local arr2 = setmetatable({[0]="a", "b", "c"}, HaxeArrayMeta);
		print(arr);
		print(arr[0]);
		table.insert(arr, 77)
		table.insert(arr2, "x")
		print(arr);
		local obj = setmetatable({ a = 2, b = 3 },Object);
		local b = setmetatable({ a = 2, b = 3 },Object);
		local factory = function (  ) 
			return setmetatable({ a = 2, b = 3 },Object);
		end;
		local count = 0;
		local x = 0;
		
			local _g = 0;
			do while((_g < 100000))do 
				local i = _g; _g = _g + 1
				table.insert(arr, i)
				table.insert(arr2, "i")
				obj = setmetatable({ a = 2, b = 3 },Object);
				b = factory();
				count = count + obj.a + b.b + arr.length;
			end;
		end;
		
			local _g1 = 0;
			local _g2 = arr.length;
			do while((_g1 < _g2))do 
				local i1 = _g1; _g1 = _g1 + 1
				count = count + arr[i1] + arr2.length;
				x = x + 1
				x = x + 1
				x = x - 1
				x = x - 1
			end;
		end;
		print(count);
		print(arr.length);
		print(b);
		print(obj);
		print("[lua] >");
		print("" .. Std:int(1000 * (os:clock() - d)) .. "ms");
		d = os:clock();
		
			local _g3 = 0;
			do while((_g3 < 100000))do 
				local i2 = _g3; _g3 = _g3 + 1
				x = 0;
				x = x + 1
				x = x + 1
				x = x - 1
				x = x - 1
			end;
		end;
		print("LangPerfTest: " .. Std:int(1000 * (os:clock() - d)) .. "ms");
	end
	
end --}

-- class Std
-- ignored --


end
-- boot

null = nil

function __inherit(to, base)
	-- copy all fields from parent
    for k, v in pairs(base) do
        to[k] = v
    end
end

function __concat(a, b)
	return a .. b
end

-- universal & safe
-- TODO: _false not calculated in Haxe, if _true!
-- TODO: make inline function
function __ternar(_cond,_true,_false)
	--local result = _true
	--if(not _cond)then result = _false end
	--return result
	if(_cond)then return _true end
	return _false
end

function __increment(t,k)
   t[k]=(t[k] or 0)+1
   return t[k]-1
end

haxe_Log = {};
function haxe_Log.trace(a)
	print(a)
end
function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end
-- Std class http://api.haxe.org/Std.html
Std = {};
Std_Std = Std;
function Std.int( x, y ) -- Fix for tail-call generator bug, TODO fix
	return y and math.floor(y) or math.floor(x)
end
-- TODO maybe Std.func = func is faster to call
--static function string(s:Dynamic):String
--Converts any value to a String.
--If s is of String, Int, Float or Bool, its value is returned.
--If s is an instance of a class and that class or one of its parent classes has a toString method, that method is called. If no such method is present, the result is unspecified.
--If s is an enum constructor without argument, the constructor's name is returned. If arguments exists, the constructor's name followed by the String representations of the arguments is returned.
--If s is a structure, the field names along with their values are returned. The field order and the operator separating field names and values are unspecified.
--If s is null, "null" is returned.
function Std.string( s )
	return "" .. x -- TODO
end
--function instance<T, S>(value:T, c:Class<S>):S
--Checks if object value is an instance of class c.
--Compiles only if the class specified by c can be assigned to the type of value.
--This method checks if a downcast is possible. That is, if the runtime type of value is assignable to the class specified by c, value is returned. Otherwise null is returned.
--This method is not guaranteed to work with interfaces or core types such as String, Array and Date.
--If value is null, the result is null. If c is null, the result is unspecified.
function Std.instance( value, c )
	return nil -- TODO
end
--static function is(v:Dynamic, t:Dynamic):Bool
--Tells if a value v is of the type t. Returns false if v or t are null.
--static function parseFloat(x:String):Float
--Converts a String to a Float.
--The parsing rules for parseInt apply here as well, with the exception of invalid input resulting in a NaN value instead of null.
--Additionally, decimal notation may contain a single . to denote the start of the fractions.
function Std.is( v, t )
	return nil -- TODO
end
--static function parseInt(x:String):Null<Int>
--Converts a String to an Int.
--Leading whitespaces are ignored.
--If x starts with 0x or 0X, hexadecimal notation is recognized where the following digits may contain 0-9 and A-F.
--Otherwise x is read as decimal number with 0-9 being allowed characters. x may also start with a - to denote a negative value.
--In decimal mode, parsing continues until an invalid character is detected, in which case the result up to that point is returned. For hexadecimal notation, the effect of invalid characters is unspecified.
--Leading 0s that are not part of the 0x/0X hexadecimal notation are ignored, which means octal notation is not supported.
--If the input cannot be recognized, the result is null.
function Std.string( x )
	return nil -- TODO
end
--static function random(x:Int):Int
--Return a random integer between 0 included and x excluded.
--If x <= 1, the result is always 0.
function Std.random( x )
	if x <= 1 then return 0 end
	return 0 -- TODO
end
-- String class

local StringMeta = getmetatable('')
function StringMeta.__add(a,b) return a .. b end

StringMeta.__index = function (str, p)
	if (p == "length") then
		return string.len(str)
	elseif (tonumber(p) == p) then
		return string.sub(str, p+1, p+1)
	else
		return str_proto[p]
	end
end


-- base Object class
Object = {}
Object.__index = Object;
function Object.__tostring(o)
    --return table_print(v) --JSON:encode(v)
    local s = "{ "
    function prv(n,v)
    	s = s + n + ": " + v
    end
    local first = true
    for key, value in pairs (o) do
    	prv(first and key or (", " + key),value)
    	first = false
    end	
    return s + " }"
end
-- Array class http://api.haxe.org/Array.html
HaxeArray = {}
--HaxeArray.__index = HaxeArray;
--__inherit(HaxeArray, Object);

--HaxeArray.__index = function(self, i)
--	return __ternar(type(x) == "number",self[i+1],self[i])
--end;

--[[
var length:Int
function new():Void
function concat(a:Array<T>):Array<T>
function copy():Array<T>
function filter(f:T ->Bool):Array<T>
function indexOf(x:T, ?fromIndex:Int):Int
function insert(pos:Int, x:T):Void
function iterator():Iterator<T>
function join(sep:String):String
function lastIndexOf(x:T, ?fromIndex:Int):Int
function map<S>(f:T ->S):Array<S>
function pop():Null<T>
function push(x:T):Int
function remove(x:T):Bool
function reverse():Void
function shift():Null<T>
function slice(pos:Int, ?end:Int):Array<T>
function sort(f:T ->T ->Int):Void
function splice(pos:Int, len:Int):Array<T>
function toString():String
function unshift(x:T):Void
]]

--local HaxeArrayMeta;

--if(table.getn)then
--if(false)then	
--arr_mt = {
--	__index = function (arr, p)
--		if (p == "length") then
--			if arr[0] then return table.getn(arr) + 1 end
--			return table.getn(arr)
--		else
--			return HaxeArray[p]
--		end
--	end
--}
--else 
HaxeArrayMeta = {
	__index = function (arr, p)
		if (p == "length") then
			if arr[0] then return #arr + 1 end
			return #arr
		else
			return HaxeArray[p]
		end
	end
}
--end

function __Array(r) 
	return setmetatable(r, HaxeArrayMeta)--HaxeArray)
end

function Array()
	return __Array({})
end

function HaxeArray.push(ths, elem)
	--table.insert(ths, #ths+1, elem)
	--return ths.length
	local length = #ths
	table.insert(ths, length+1, elem)
	return length
end

function HaxeArray.__tostring(o)
    --return table_print(v) --JSON:encode(v)
    local s = "[ "
    function prv(v)
    	s = s + v
    end
    local first = true
    for key, value in pairs (o) do
    	prv(first and value or (", " + value))
    	first = false
    end	
    return s + " ]"
end

HaxeArrayMeta.__tostring = HaxeArray.__tostring;
-- abstract (non-abstract in Lua) class Map http://api.haxe.org/Map.html

-- TODO
--[[
function exists(k:K):Bool
function get(k:K):Null<V>
function iterator():Iterator<V>
function keys():Iterator<K>
function remove(k:K):Bool
function set(k:K, v:V):Void
function toString():String
]]
HaxeMap = {}
__inherit(HaxeMap, Object);
HaxeMap.__index = HaxeMap;
function Map()
	local r = {}
	setmetatable(r, HaxeMap) 
	return r
end

function HaxeMap:get(self, key)
	return self[key]
end

function HaxeMap:set(self, key, value)
	self[key] = value
end

function HaxeMap:iterator(self)
	return pairs(self)
end

function HaxeMap:keys(self)
	return pairs(self)
end
exec()
Main.main()
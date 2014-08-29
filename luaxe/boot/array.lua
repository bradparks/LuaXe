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
	return setmetatable(r, HaxeArrayMeta)
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

function HaxeArray.copy(ths)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = v
	end
	return __Array(result)
end

function HaxeArray.slice(ths, a, b)
	local result = {}
	for i = a,b-1 do
		result[i] = ths[i]
	end
	return __Array(result)
end

function HaxeArray.splice(ths, a, b)
	local result = {}
	for i = a,b do
		result[i] = ths[i]
	end
	for i = a,b-a do
		ths[i] = ths[i+a+1]
	end
	for i = b,table.getn(ths) do
		ths[i] = nil
	end
	return __Array(result)
end

function HaxeArray.concat(ths,a)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = v
	end
    for i=0,#a do
        result[#result+1] = a[i]
    end
    return __Array(result)
end

function HaxeArray.join(ths,a)
	return table.concat(ths,a,0)
end

function HaxeArray.sort(ths, fun) -- TODO optimize
	local isSorted = false
	while isSorted == false do
		movedElements = 0
		for x = 0, table.getn(ths) - 1, 1 do
			if fun(ths[x], ths[x + 1]) > 0 then
				movedElements = movedElements + 1
				testedElement = ths[x]
				ths[x] = ths[x + 1]
				ths[x + 1] = testedElement
			end
		end
		if movedElements == 0 then
			isSorted = true
		end
	end
	return ths
end

function HaxeArray.map(ths, fun)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = fun(v)
	end
	return __Array(result)
end

function HaxeArray.pop(ths)
	local length = #ths
	if(length == 0) then return nil end
	local last = ths[length]
	ths[length] = nil
	return last
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

function HaxeArray.toString(o)
	return HaxeArray.__tostring(o)
end

HaxeArrayMeta.__tostring = HaxeArray.__tostring;

Array_Array = {}
function Array_Array.new(arg)
	return setmetatable(arg or {}, HaxeArrayMeta)
end
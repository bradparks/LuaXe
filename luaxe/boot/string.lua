-- String class

String = {}
String_String = String

local __StringMeta = getmetatable('')
function __StringMeta.__add(a,b) return a .. b end

__StringMeta.__index = function (str, p)
	if (p == "length") then
		return string.len(str) -- var length:Int
	--elseif (tonumber(p) == p) then -- no String indexing avalable in Haxe
	--	return string.sub(str, p+1, p+1)
	else
		return String[p]
	end
end

-- optimize lookup
local __string_sub = string.sub
local __string_byte = string.byte
local __string_find = string.find

-- just easy
-- http://lua-users.org/wiki/StringLibraryTutorial
String.fromCharCode = string.char -- static Int -> String
String.substring = string.sub -- Int -> ?Int -> String
String.toLowerCase = string.lower --> String
String.toUpperCase = string.upper --> String

-- some useless
function String.new(string) -- static String -> String (not Void)
	return string
end

function String:toString() --> String
	return self
end

-- complex funcs
function String:charAt(index) -- Int -> String
	return __string_sub(self, index+1, index+1)
end

function String:charCodeAt(index) -- Int -> Null<Int>
	return __string_byte(__string_sub(self, index+1, index+1))
end

function String:indexOf(str, startIndex) -- String -> ?Int -> Int
	local r = string.find(self, str, startIndex)
  return r and (r - 1) or -1
end

-- TODO startIndex
function String:lastIndexOf(str, startIndex) -- String -> ?Int -> Int
	local i, j
    local k = 0
    repeat
        i = j
        j, k = __string_find(self, str, k + 1, true)
    until j == nil

    return (i or 0) - 1
end

-- http://lua-users.org/wiki/SplitJoin
function String:split(d) -- String -> Array<String>
--Splits this String at each occurence of delimiter.
--If this String is the empty String "", the result is not consistent across targets and may either be [] (on Js, Cpp) or [""].
--If delimiter is the empty String "", this String is split into an Array of this.length elements, where the elements correspond to the characters of this String.
--If delimiter is not found within this String, the result is an Array with one element, which equals this String.
--If delimiter is null, the result is unspecified.
--Otherwise, this String is split into parts at each occurence of delimiter. If this String starts (or ends) with [delimiter}, the result Array contains a leading (or trailing) empty String "" element. Two subsequent delimiters also result in an empty String "" element.
local t, ll
local p = self
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return setmetatable(t, HaxeArrayMeta)
end

function String:substr(pos, len) -- Int -> ?Int -> String
	return len and __string_sub(self, pos+1, pos+len)
  or __string_sub(self, pos+1)
end

-- temporal fix
HxOverrides_HxOverrides = HxOverrides_HxOverrides or {}
HxOverrides_HxOverrides.substr = String.substr
HxOverrides_HxOverrides.cca = String.charCodeAt
HxOverrides = HxOverrides_HxOverrides

-- TEST
--S = "Returns a String"
--print(S)
--print(S.length)
--print(S:toLowerCase())
--print(S:toUpperCase())
--print(S:substring(8))
--print(S:substr(8,1))
--print(String.fromCharCode(65))
--print(S:charAt(5))
--print(S:charCodeAt(5))
--print(S:indexOf(" a "))
--print(S:lastIndexOf(" a "))
--print(S:lastIndexOf(" aa "))
--print(S:split(" "))--
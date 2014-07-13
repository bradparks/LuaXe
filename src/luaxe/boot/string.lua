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


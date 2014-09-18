-- boot

null = nil
trace = print
undefined = { } -- unique special value for (mostly) internal use.

function ___inherit(to, base)
	-- copy all fields from parent
    for k, v in pairs(base) do
        to[k] = v
    end
    to.__super__ = base
end

function __new__(obj, ...)
	return obj.new(...)
end

haxe_Log_Log = {};
function haxe_Log_Log.trace(a, i)
	print(a)
	if(i) then print(i) end
end

function haxe_Log_Log.clear()
	-- TODO
end

-- Closure
function ___bind(o,m)
	if(not m)then return nil end;
	return function(...)
    	local result = m(o, ...);
    	return result;
 	end
end

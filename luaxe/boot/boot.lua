-- boot

null = nil
trace = print

function ___inherit(to, base)
	-- copy all fields from parent
    for k, v in pairs(base) do
        to[k] = v
    end
end

function __new__(obj)
	return obj.new()
end

function ___concat(a, b)
	return a .. b
end

-- universal & safe
-- TODO: _false not calculated in Haxe, if _true!
-- TODO: make inline function
function ___ternar(_cond,_true,_false)
	--local result = _true
	--if(not _cond)then result = _false end
	--return result
	if(_cond)then return _true end
	return _false
end

function ___increment(t,k)
   t[k]=(t[k] or 0)+1
   return t[k]-1
end

haxe_Log = {};
haxe_Log_Log = haxe_Log;
function haxe_Log.trace(a, i)
	print(a)
	if(i) then print(i) end
end

function haxe_Log.clear()
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
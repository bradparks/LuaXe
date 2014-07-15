-- boot

null = nil
trace = print

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
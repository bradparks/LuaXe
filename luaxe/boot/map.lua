-- abstract (non-abstract in Lua) class Map http://api.haxe.org/Map.html

-- TODO
--function exists(k:K):Bool
--function get(k:K):Null<V>
--function iterator():Iterator<V>
--function keys():Iterator<K>
--function remove(k:K):Bool
--function set(k:K, v:V):Void
--function toString():String

HaxeMap = {}
___inherit(HaxeMap, Object);
HaxeMap.__index = HaxeMap;
function HaxeMap.Map()
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

haxe_ds_IntMap_IntMap = HaxeMap
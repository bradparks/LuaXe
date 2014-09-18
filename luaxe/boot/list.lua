List = {}
List.__index = List
List_List = List

function List.new()
	local self = {
		_a = {}, length = 0
	}
	setmetatable(self, List)
	return self
end

function List:add(item)
	table.insert(self._a, item)
	self.length = self.length + 1
end

function List:push(item)
	table.insert(self._a, item, 1)
	self.length = self.length + 1
end

function List:first()
	return self._a[1]
end

function List:last()
	return self._a[self.length]
end

function List:clear()
	self._a, self.length = {}, 0
end

function List:isEmpty()
	return self.length == 0
end

function List:join(sep)
	return table.concat(self._a, sep)
end

function List:pop()
	return table.remove(self._a, 1)
end

function List.__tostring(o)
	return "{" .. table.concat(o._a, ",") .. "}"
end
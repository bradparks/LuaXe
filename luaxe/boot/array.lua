-- Array class http://api.haxe.org/Array.html

Array_Array = {}
Array_Array.__index = function (arr, p)
		if (p == "length") then
			if arr[0] then return #arr + 1 end
			return #arr -- table.getn(arr)
		else
			return Array_Array[p]
		end
	end

function __Array(r) 
	return setmetatable(r, Array_Array)
end

function Array()
	return __Array({})
end

function Array_Array.push(ths, elem)
	local length = #ths
	table.insert(ths, length+1, elem)
	return length
end

function Array_Array.copy(ths)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = v
	end
	return __Array(result)
end

function Array_Array.slice(ths, a, b)
	local result = {}
	for i = a,b-1 do
		result[i] = ths[i]
	end
	return __Array(result)
end

function Array_Array.splice(ths, a, b)
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

function Array_Array.concat(ths,a)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = v
	end
    for i=0,#a do
        result[#result+1] = a[i]
    end
    return __Array(result)
end

function Array_Array.join(ths,a)
	local t = {}
	for i=0, #ths do
		t[i] = tostring(ths[i] or "")
	end
	return table.concat(t,a,0)
end

function Array_Array.sort(ths, fun) -- TODO optimize
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

function Array_Array.map(ths, fun)
	local result = {}
	for k,v in pairs(ths) do -- ipairs is bad idea
		result[k] = fun(v)
	end
	return __Array(result)
end

function Array_Array.pop(ths)
	local length = #ths
	if(length == 0) then return nil end
	local last = ths[length]
	ths[length] = nil
	return last
end

function Array_Array.reverse(ths)
	local length = #ths
	if(length < 2) then return end
	for i = 0,length/2,1 do
		local temp = ths[i]
		ths[i] = ths[length-i]
		ths[length-i] = temp
	end
end

function Array_Array.__tostring(o)
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

function Array_Array.toString(o)
	return Array_Array.__tostring(o)
end

function Array_Array.new(arg)
	return setmetatable(arg or {}, Array_Array)
end
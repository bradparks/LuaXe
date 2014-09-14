Math = {}
Math_Math = Math

function Math.round(num)
	if num >= 0 then return math.floor(num+.5) 
	 else return math.ceil(num-.5) end
end

Math.NaN = 1/0;
Math.NEGATIVE_INFINITY = -1.0 / 0.0
Math.POSITIVE_INFINITY = 1.0 / 0.0
Math.PI = math.pi

Math.random = math.random
Math.abs = math.abs
Math.min = math.min
Math.max = math.max
Math.sin = math.sin
Math.cos = math.cos
Math.exp = math.exp
Math.log = math.log
Math.sqrt = math.sqrt
Math.fround = Math.round
Math.ffloor = math.floor
Math.fceil = math.ceil

function Math.floor(num)
	return Math.round(math.floor(num))
end

function Math.ceil(num)
	return Math.round(math.ceil(num))
end

function Math.isNaN(num)
	return num == Math.NaN
end

function Math.isFinite(num)
	return num ~= Math.NEGATIVE_INFINITY and num ~= Math.POSITIVE_INFINITY and num ~= Math.NaN
end
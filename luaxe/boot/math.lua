Math = {}
Math_Math = Math

function Math.round(num)
	if num >= 0 then return math.floor(num+.5) 
	 else return math.ceil(num-.5) end
end

Math.NaN = 0/0;
Math.NEGATIVE_INFINITY = -1.0 / 0.0
Math.POSITIVE_INFINITY = 1.0 / 0.0
Math.PI = math.pi

Math.random, Math.abs, Math.min, Math.max = math.random, math.abs, math.min, math.max
Math.sin, Math.cos, Math.exp, Math.log, Math.tan = math.sin, math.cos, math.exp, math.log
Math.sqrt, Math.fround, Math.ffloor, Math.fceil = math.sqrt, Math.round, math.floor, math.ceil
Math.acos, Math.asin, Math.atan, Math.atan2, Math.pow = math.acos, math.asin, math.atan, math.atan2, math.pow

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

function Math.get_NaN()return Math.NaN end
function Math.get_POSITIVE_INFINITY()return Math.POSITIVE_INFINITY end
function Math.get_NEGATIVE_INFINITY()return Math.NEGATIVE_INFINITY end
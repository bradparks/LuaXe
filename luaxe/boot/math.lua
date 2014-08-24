Math = {}
Math_Math = Math

function Math_Math.round(num)
	if num >= 0 then return math.floor(num+.5) 
	 else return math.ceil(num-.5) end
end

Math_Math.random = math.random;
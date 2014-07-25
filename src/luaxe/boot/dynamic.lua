-- implements variables boxing


function Dynamic(value)
	--[[
		For now, vars are not boxed
		because of heavy usage of metatables.
	]]
	return value
end
local EReg = {}
EReg_EReg = EReg
EReg.__index = EReg

function EReg.new(def)
	local self = {}
	setmetatable(self, EReg)
	return self
end
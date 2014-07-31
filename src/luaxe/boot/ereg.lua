local EReg = {}
EReg_EReg = EReg
EReg.__index = EReg

function EReg.new(def)
	local self = {}
	setmetatable(self, EReg)
	return self
end
-- TODO
function EReg:match() return nil end
function EReg:matched() return nil end
function EReg:split() return nil end

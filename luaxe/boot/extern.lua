local Extern = {}
TestExtern_Extern = Extern -- setting proper namespace (namespace.TestExtern.Extern -> namespace_TestExtern_Extern)
Extern.__index = Extern -- need for metatable
Extern.hi = "Hello!" -- static var

function Extern.new(x) -- constructor
	local self = { X = x } -- "X" is a class field
	setmetatable(self, Extern)
	return self
end

function Extern:selfcall() return self.X end
function Extern.test() return "static test" end
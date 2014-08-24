-- Date class

Date = {}
Date.__index = Date
Date_Date = Date

function Date.now()
	local self = {
		t = 1000*os.clock()
	}
	setmetatable(self, Date)
	return self
end
Date.new = Date.now

function Date:getTime()
	return self.t
end
-- Date class
-- thanks to https://github.com/insweater

Date = {}
Date.__index = Date
Date_Date = Date

function Date.now()
	local self = {
		d = os.date("*t")
	}
	setmetatable(self, Date)
	return self
end

function Date.fromTime(t)
	local self = {
		d = os.date(t)
	}
	setmetatable(self, Date)
	return self
end

function Date.new(year, month, day, hour, min, sec)
	if(year == nil)then
		return Date.now()
	end
	local self = {
		d = {year = year, day = day, month = month, hour = hour, min = min, sec = sec}
	}
	setmetatable(self, Date)
	return self
end

function Date:getDate()
	return self.d.day
end

function Date:getDay()
	return os.date("%w", self:getTime())
end

function Date:getHours()
	return self.d.hour
end

function Date:getMinutes()
	return self.d.min
end

function Date:getMonth()
	return self.d.month - 1
end

function Date:getSeconds()
	return self.d.sec
end

function Date:getTime()
	return os.time(self.d)
end

function Date:getFullYear()
	return self.d.year
end

-- to-do function Date.__tostring(o) end
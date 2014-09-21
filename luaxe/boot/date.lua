-- Date class
-- thanks to https://github.com/insweater

Date = {}
Date.__index = Date
Date_Date = Date

function Date.now()
	local self = {
		d = os.date("*t"),
		ms = 1000*os.clock()
	}
	setmetatable(self, Date)
	return self
end

function Date.fromTime(t)
	local self = {
		d = os.date(t)
	}
	self.ms = os.time(self.d)*1000;
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
	self.ms = os.time(self.d)*1000;
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
	return self.ms--os.time(self.d)
end

function Date:getFullYear()
	return self.d.year
end

function Date.__tostring(o) 
	return os.date("%Y-%m-%d %H:%M:%S", o:getTime());
end

function Date.toString(o)
	return Date.__tostring(o)
end

function Date.fromString(dateString) -- FIXME
	local pattern = "(%d+)%-(%d+)%-(%d+) (%d+):(%d+):(%d+)"
    local xyear, xmonth, xday, xhour, xminute = string.match(dateString, pattern)
    local convertedTimestamp = os.time({year = xyear, month = xmonth, 
        day = xday, hour = xhour, min = xminute, sec = xseconds})
    print(convertedTimestamp)
    print(type(convertedTimestamp))
    return Date.fromTime(convertedTimestamp)
end

HxOverrides_HxOverrides.dateStr = Date.__tostring;
HxOverrides_HxOverrides.strDate = Date.fromString;
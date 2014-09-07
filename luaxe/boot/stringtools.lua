-- StringTools

StringTools = {}
StringTools_StringTools = StringTools

function StringTools.endsWith(s, ends)
	local elen = ends.length
	local slen = s.length
	return (slen >= elen) and (HxOverrides.substr(s,slen - elen,elen) == ends)
end
function StringTools.fastCodeAt(s, index)
	return s:charCodeAt(index)
end
function StringTools.hex(n, digits)
	local s = ""
	local hexChars = "0123456789ABCDEF"
	--repeat TODO
	--	s = hexChars.charAt(n & 15) + s;
	--	n >>>= 4;
	--until n > 0
	if(digits)-- ~= null)
	then
		while(s.length < digits)
		do
			s = "0" + s
		end
	end
	return s
end
function StringTools.htmlEscape(s, quotes)
	s = s:split("&"):join("&amp;"):split("<"):join("&lt;"):split(">"):join("&gt;")
	if(quotes)then
		return s:split("\""):join("&quot;"):split("'"):join("&#039;")
	else return s end
end
function StringTools.htmlUnescape(s)
	return s:split("&gt;"):join(">"):split("&lt;"):join("<"):split("&quot;"):join("\""):split("&#039;"):join("'"):split("&amp;"):join("&")
end
function StringTools.isEof(c)
	return c ~= c
end
function StringTools.isSpace(s, pos)
	local c = HxOverrides.cca(s,pos)
	return c > 8 and c < 14 or c == 32
end
function StringTools.lpad(s, c, l)
	if(c.length <= 0)then return s end
	while(s.length < l)do s = c + s end
	return s
end
function StringTools.ltrim(s)
	local l = s.length
	local r = 0
	while(r < l and StringTools.isSpace(s,r))do r = r + 1 end
	if(r > 0)then return HxOverrides.substr(s,r,l - r) else return s end
end
function StringTools.replace(s, sub, by)
	return s:split(sub):join(by);
end
function StringTools.rpad(s, c, l)
	if(c.length <= 0)then return s end
	while(s.length < l)do s = s + c end
	return s
end
function StringTools.rtrim(s)
	local l = s.length
	local r = 0
	while(r < l and StringTools.isSpace(s,l - r - 1)) do r = r + 1 end
	if(r > 0)then return HxOverrides.substr(s,0,l - r) else return s end
end
function StringTools.startsWith(s, start)
	return (s.length >= start.length) and (HxOverrides.substr(s,0,start.length) == start)
end
function StringTools.trim(s)
	return StringTools.ltrim(StringTools.rtrim(s))
end
local hex={}
for i=0,255 do
    hex[string.format("%0x",i)]=string.char(i)
    hex[string.format("%0X",i)]=string.char(i)
end
function StringTools.urlDecode(s)
	return (string.gsub(s,'%%(%x%x)',hex))
end
function StringTools.urlEncode(s)
	local format = string.format
	local strbyte = string.byte
	local function hex(ch)
		return format("%%%02x", strbyte(ch))
	end
	return (string.gsub(s, "[^-._/a-zA-Z0-9]", hex))
end
Type = {};
Type_Type = Type;

function Type_Type.getSuperClass( c )
	return c.__super__
end

function Type_Type.getClassName( c )
	return c.__name__
end

function Type_Type.resolveClass( name )
	local cl = ___hxClasses[name]
	if(cl == nil)then
		return nil
	end
	return cl
end

function Type_Type.createEmptyInstance( cl )
	return ___hxClasses[cl].new()
end
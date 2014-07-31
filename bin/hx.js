(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var EReg = function(r,opt) {
	opt = opt.split("u").join("");
	this.r = new RegExp(r,opt);
};
EReg.__name__ = true;
EReg.prototype = {
	__class__: EReg
};
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
var Main = function() { };
Main.__name__ = true;
Main.main = function() {
	console.log("go -->");
	var d = new Date().getTime();
	TestString.test();
	TestIfs.test();
	TestFuncs.test();
	TestFuncs.test();
	TestClasses.test();
	TestExceptions.test();
	TestSyntax.test();
	console.log("[js] >");
	console.log("FeatureTest: " + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	var _g = 0;
	while(_g < 10000) {
		var i = _g++;
		TestString.test(true);
	}
	console.log("StringPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	console.log("ComplexPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	var _g1 = 0;
	while(_g1 < 100000) {
		var i1 = _g1++;
		TestIfs.test(true);
		TestFuncs.test(true);
		TestLoops.test(true);
	}
	console.log("LangPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
Std["int"] = function(x) {
	return x | 0;
};
var LClass = function() {
};
LClass.__name__ = true;
LClass.prototype = {
	__class__: LClass
};
var _TestClasses = {};
_TestClasses.BaseClass = function() {
	console.log("BaseClass::new");
	if(_TestClasses.BaseClass._instances == null) _TestClasses.BaseClass._instances = 0;
	_TestClasses.BaseClass._instances++;
	this._count = 0;
	_TestClasses.BaseClass.UninitialisedStaticVar = 1.234;
};
_TestClasses.BaseClass.__name__ = true;
_TestClasses.BaseClass.prototype = {
	__class__: _TestClasses.BaseClass
};
_TestClasses.InterfaceDemo = function() { };
_TestClasses.InterfaceDemo.__name__ = true;
_TestClasses.AClass = function() {
	_TestClasses.BaseClass.call(this);
};
_TestClasses.AClass.__name__ = true;
_TestClasses.AClass.__super__ = _TestClasses.BaseClass;
_TestClasses.AClass.prototype = $extend(_TestClasses.BaseClass.prototype,{
	__class__: _TestClasses.AClass
});
_TestClasses.BClass = function(arg) {
	_TestClasses.AClass.call(this);
	console.log("BClass::new " + arg);
	this.apiVar = true;
};
_TestClasses.BClass.__name__ = true;
_TestClasses.BClass.__interfaces__ = [_TestClasses.InterfaceDemo];
_TestClasses.BClass.__super__ = _TestClasses.AClass;
_TestClasses.BClass.prototype = $extend(_TestClasses.AClass.prototype,{
	methodInBClass: function() {
		console.log("BClass::methodInBClass");
	}
	,doSomething: function() {
		console.log("BClass::doSomething()");
	}
	,__class__: _TestClasses.BClass
});
var CClass = function(arg) {
	_TestClasses.BClass.call(this,arg);
	console.log("CClass::new " + arg);
};
CClass.__name__ = true;
CClass.__super__ = _TestClasses.BClass;
CClass.prototype = $extend(_TestClasses.BClass.prototype,{
	__class__: CClass
});
var TestClasses = function() { };
TestClasses.__name__ = true;
TestClasses.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestClasses begin");
	var L = new LClass();
	var bc = new _TestClasses.BaseClass();
	var a = new _TestClasses.AClass();
	var b = new _TestClasses.BClass("arg");
	var c = new CClass("arg");
	if(!perf) console.log("TestClasses end");
};
var TestExceptions = function() { };
TestExceptions.__name__ = true;
TestExceptions.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestExceptions begin");
	var x = null;
	try {
		x.tryMe();
	} catch( $e0 ) {
		if( js.Boot.__instanceof($e0,TestExceptions) ) {
			var e = $e0;
			if(!perf) console.log("<TestExceptions> Exception here! " + Std.string(e));
		} else {
		var e1 = $e0;
		if(!perf) console.log("Exception here!");
		if(!perf) console.log("Info: " + Std.string(e1));
		}
	}
	if(!perf) console.log("TestExceptions end");
};
TestExceptions.prototype = {
	tryMe: function() {
		return 0;
	}
	,__class__: TestExceptions
};
var TestFuncs = function() { };
TestFuncs.__name__ = true;
TestFuncs.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestFuncs begin");
	var none22 = 0;
	var none = function() {
	};
	var none2 = function() {
		none();
		var none221 = 0;
	};
	var none3 = function() {
		var none1 = function() {
		};
		var none21 = function() {
			none1();
		};
	};
	var none4 = function() {
		var x = 0;
		var none5 = function() {
			x++;
			var none31 = function() {
				var none6 = function() {
				};
				var none23 = function() {
					none6();
				};
			};
			none31();
		};
		var none24 = function() {
			none5();
			x++;
		};
		none5();
		none24();
		if(!perf) console.log(x == 3);
	};
	var fx = function() {
		return 0;
	};
	none();
	none2();
	none3();
	none4();
	if(!perf) console.log("TestFuncs end");
};
var TestIfs = function() { };
TestIfs.__name__ = true;
TestIfs.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestIfs begin");
	var none = function() {
	};
	var bool = true;
	if(bool) {
	}
	if(!bool) {
	} else {
	}
	if(!bool && bool) {
	}
	if(!bool && bool || bool) {
	}
	if(bool) none();
	if(bool) none(); else {
	}
	if(bool) {
	} else none();
	if(bool) none(); else none();
	if(!bool && bool) none();
	if(!bool && bool || bool) none();
	var rr = function() {
		if(!bool) return; else return;
		return;
	};
	rr();
	var rr1 = function() {
		if(bool) return 1; else return 2;
		return 3;
	};
	rr1();
	if(bool) {
		if(!bool) {
			if(!bool && bool) {
			}
		} else if(!bool && bool || bool) {
		}
	}
	if(bool) {
		none();
		if(bool) none(); else if(bool) {
			if(!bool && bool) {
				if(bool) {
					if(!bool && bool || bool) none();
					none();
				} else none();
				none();
			}
		} else none();
	}
	var z = 10;
	var x = 0;
	if(z > 2) x = 7; else x = 10;
	var v = Math.round(Math.random() * 100);
	var foo = function(x1) {
		return x1 + 1;
	};
	switch(v) {
	case 0:
		break;
	case 1:case 2:case 3:
		break;
	case 65:
		break;
	default:
	}
	if(!perf) console.log("TestIfs end");
};
var TestLoops = function() { };
TestLoops.__name__ = true;
TestLoops.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestLoops begin");
	var _g = 0;
	while(_g < 10) {
		var i = _g++;
		var x = 1;
	}
	var x1 = 0;
	while(x1 < 10) {
		x1++;
		var _g1 = 0;
		while(_g1 < 10) {
			var i1 = _g1++;
			var x2 = 1;
			var _g11 = 0;
			while(_g11 < 10) {
				var i2 = _g11++;
				var x3 = 1;
			}
		}
		var _g2 = 0;
		while(_g2 < 10) {
			var i3 = _g2++;
			var x4 = 1;
			var _g12 = 0;
			while(_g12 < 10) {
				var i4 = _g12++;
				var x5 = 1;
			}
		}
	}
	if(!perf) console.log("TestLoops end");
};
var TestString = function() { };
TestString.__name__ = true;
TestString.eq = function(text,bool) {
	if(!bool && !TestString._perf) console.log(text + " failed");
};
TestString.test = function(perf) {
	if(perf == null) perf = false;
	TestString._perf = perf;
	if(!perf) console.log("TestString begin");
	var S = "Returns a String _!@#$%^&*()1234567890-=/*[]{}";
	TestString.eq("eq",S == "Returns a String _!@#$%^&*()1234567890-=/*[]{}");
	TestString.eq("length",S.length == 46);
	TestString.eq("substring",S.substring(8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
	TestString.eq("substr",HxOverrides.substr(S,8,1) == "a");
	TestString.eq("substring a,b",S.substring(8,10) == "a ");
	TestString.eq("substr a,b",HxOverrides.substr(S,8,1) == "a");
	TestString.eq("substr",HxOverrides.substr(S,8,null) == "a String _!@#$%^&*()1234567890-=/*[]{}");
	TestString.eq("fromCharCode",true);
	TestString.eq("charAt",S.charAt(5) == "n");
	TestString.eq("charCodeAt",HxOverrides.cca(S,5) == 110);
	if(!perf) console.log("TestString end");
};
var TestSyntax = function() { };
TestSyntax.__name__ = true;
TestSyntax.test = function() {
	console.log("TestSyntax begin");
	var v = 0;
	var v1 = -134;
	var v2 = 65280;
	var v3 = 123.0;
	var v4 = .14179;
	var v5 = 13e50;
	var v6 = -1e-99;
	var v7 = "hello";
	var v8 = "hello \"world\" !";
	var v9 = "hello \"world\" !";
	var v10 = true;
	var v11 = false;
	var v12 = null;
	var v13 = new EReg("[a-z]+","i");
	var x;
	var y = 3;
	var z;
	var w = "";
	var a;
	var b;
	var c = 0;
	console.log("TestSyntax end");
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else return o.__class__;
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i = _g1++;
					if(i != 2) str += "," + js.Boot.__string_rec(o[i],s); else str += js.Boot.__string_rec(o[i],s);
				}
				return str + ")";
			}
			var l = o.length;
			var i1;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str2 = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str2.length != 2) str2 += ", \n";
		str2 += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str2 += "\n" + s + "}";
		return str2;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
Math.NaN = Number.NaN;
Math.NEGATIVE_INFINITY = Number.NEGATIVE_INFINITY;
Math.POSITIVE_INFINITY = Number.POSITIVE_INFINITY;
Math.isFinite = function(i) {
	return isFinite(i);
};
Math.isNaN = function(i1) {
	return isNaN(i1);
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
Date.prototype.__class__ = Date;
Date.__name__ = ["Date"];
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
_TestClasses.BClass.WHOOT = "whoot";
Main.main();
})();

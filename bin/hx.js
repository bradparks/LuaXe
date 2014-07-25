(function () { "use strict";
var HxOverrides = function() { };
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
Main.main = function() {
	console.log("go -->");
	var d = new Date().getTime();
	TestString.test();
	TestIfs.test();
	console.log("[js] >");
	console.log("FeatureTest: " + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	var _g = 0;
	while(_g < 100000) {
		var i = _g++;
		TestString.test(true);
	}
	console.log("StringPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	var _g1 = 0;
	while(_g1 < 1000000) {
		var i1 = _g1++;
		TestIfs.test(true);
	}
	console.log("LangPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
};
var Std = function() { };
Std["int"] = function(x) {
	return x | 0;
};
var TestIfs = function() { };
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
	if(!perf) console.log("TestIfs end");
};
var TestString = function() { };
TestString.test = function(perf) {
	if(perf == null) perf = false;
	if(!perf) console.log("TestString begin");
	var test = function(text,bool) {
		if(!bool && !perf) console.log(text + " failed");
	};
	var S = "Returns a String _!@#$%^&*()1234567890-=/*[]{}";
	test("eq",S == "Returns a String _!@#$%^&*()1234567890-=/*[]{}");
	test("length",S.length == 46);
	test("toLowerCase",S.toLowerCase() == "returns a string _!@#$%^&*()1234567890-=/*[]{}");
	test("toUpperCase",S.toUpperCase() == "RETURNS A STRING _!@#$%^&*()1234567890-=/*[]{}");
	test("substring",S.substring(8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
	test("substr",HxOverrides.substr(S,8,1) == "a");
	test("fromCharCode",true);
	test("charAt",S.charAt(5) == "n");
	test("charCodeAt",HxOverrides.cca(S,5) == 110);
	test("indexOf",S.indexOf(" a ") == 7);
	test("lastIndexOf",S.lastIndexOf(" a ") == 7);
	test("lastIndexOf",S.lastIndexOf(" aa ") == -1);
	test("split",S.split(" ").length == 4);
	if(!perf) console.log("TestString end");
};
Main.main();
})();

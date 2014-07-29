(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
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
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
var Main = function() { };
Main.main = function() {
	console.log("go -->");
	var d = new Date().getTime();
	TestString.test();
	TestIfs.test();
	TestFuncs.test();
	TestFuncs.test();
	TestClasses.test();
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
	benchmark.LoopTesterApp.main();
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
var IMap = function() { };
var Std = function() { };
Std["int"] = function(x) {
	return x | 0;
};
var LClass = function() {
};
var _TestClasses = {};
_TestClasses.BaseClass = function() {
	console.log("BaseClass::new");
	if(_TestClasses.BaseClass._instances == null) _TestClasses.BaseClass._instances = 0;
	_TestClasses.BaseClass._instances++;
	this._count = 0;
	_TestClasses.BaseClass.UninitialisedStaticVar = 1.234;
};
_TestClasses.InterfaceDemo = function() { };
_TestClasses.AClass = function() {
	_TestClasses.BaseClass.call(this);
};
_TestClasses.AClass.__super__ = _TestClasses.BaseClass;
_TestClasses.AClass.prototype = $extend(_TestClasses.BaseClass.prototype,{
});
_TestClasses.BClass = function(arg) {
	_TestClasses.AClass.call(this);
	console.log("BClass::new " + arg);
	this.apiVar = true;
};
_TestClasses.BClass.__interfaces__ = [_TestClasses.InterfaceDemo];
_TestClasses.BClass.__super__ = _TestClasses.AClass;
_TestClasses.BClass.prototype = $extend(_TestClasses.AClass.prototype,{
	methodInBClass: function() {
		console.log("BClass::methodInBClass");
	}
	,doSomething: function() {
		console.log("BClass::doSomething()");
	}
});
var CClass = function(arg) {
	_TestClasses.BClass.call(this,arg);
	console.log("CClass::new " + arg);
};
CClass.__super__ = _TestClasses.BClass;
CClass.prototype = $extend(_TestClasses.BClass.prototype,{
});
var TestClasses = function() { };
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
var TestFuncs = function() { };
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
var benchmark = {};
benchmark.LoopTesterApp = function() { };
benchmark.LoopTesterApp.buildDiamond = function(cfg,start) {
	var bb0 = start;
	new benchmark.BasicBlockEdge(cfg,bb0,bb0 + 1);
	new benchmark.BasicBlockEdge(cfg,bb0,bb0 + 2);
	new benchmark.BasicBlockEdge(cfg,bb0 + 1,bb0 + 3);
	new benchmark.BasicBlockEdge(cfg,bb0 + 2,bb0 + 3);
	return bb0 + 3;
};
benchmark.LoopTesterApp.buildStraight = function(cfg,start,n) {
	var _g = 0;
	while(_g < n) {
		var i = _g++;
		new benchmark.BasicBlockEdge(cfg,start + i,start + i + 1);
	}
	return start + n;
};
benchmark.LoopTesterApp.buildBaseLoop = function(cfg,from) {
	var header = benchmark.LoopTesterApp.buildStraight(cfg,from,1);
	var diamond1 = benchmark.LoopTesterApp.buildDiamond(cfg,header);
	var d11 = benchmark.LoopTesterApp.buildStraight(cfg,diamond1,1);
	var diamond2 = benchmark.LoopTesterApp.buildDiamond(cfg,d11);
	var footer = benchmark.LoopTesterApp.buildStraight(cfg,diamond2,1);
	new benchmark.BasicBlockEdge(cfg,diamond2,d11);
	new benchmark.BasicBlockEdge(cfg,diamond1,header);
	new benchmark.BasicBlockEdge(cfg,footer,from);
	footer = benchmark.LoopTesterApp.buildStraight(cfg,footer,1);
	return footer;
};
benchmark.LoopTesterApp.main = function() {
	var d = new Date().getTime();
	var cfg = new benchmark.MaoCFG();
	var lsg = new benchmark.LoopStructureGraph();
	cfg.CreateNode(0);
	benchmark.LoopTesterApp.buildBaseLoop(cfg,0);
	cfg.CreateNode(1);
	new benchmark.BasicBlockEdge(cfg,0,2);
	var _g = 0;
	while(_g < 300) {
		var dummyloops = _g++;
		var lsglocal = new benchmark.LoopStructureGraph();
		new benchmark.MaoLoops(cfg,lsglocal).run();
	}
	var n = 2;
	var _g1 = 0;
	while(_g1 < 10) {
		var parlooptrees = _g1++;
		cfg.CreateNode(n + 1);
		new benchmark.BasicBlockEdge(cfg,2,n + 1);
		n = n + 1;
		var _g11 = 0;
		while(_g11 < 100) {
			var i = _g11++;
			var top = n;
			n = benchmark.LoopTesterApp.buildStraight(cfg,n,1);
			var _g2 = 0;
			while(_g2 < 25) {
				var j = _g2++;
				n = benchmark.LoopTesterApp.buildBaseLoop(cfg,n);
			}
			var bottom = benchmark.LoopTesterApp.buildStraight(cfg,n,1);
			new benchmark.BasicBlockEdge(cfg,n,top);
			n = bottom;
		}
		new benchmark.BasicBlockEdge(cfg,n,1);
	}
};
benchmark.BasicBlockEdge = function(cfg,from_name,to_name) {
	this.from_ = cfg.CreateNode(from_name);
	this.to_ = cfg.CreateNode(to_name);
	this.from_.out_edges_.push(this.to_);
	this.to_.in_edges_.push(this.from_);
	cfg.edge_list_.push(this);
};
benchmark.BasicBlock = function(name) {
	this.in_edges_ = new Array();
	this.out_edges_ = new Array();
	this.name_ = name;
};
benchmark.MaoCFG = function() {
	this.node_count = 0;
	this.basic_block_map_ = new haxe.ds.IntMap();
	this.edge_list_ = new Array();
};
benchmark.MaoCFG.prototype = {
	CreateNode: function(name) {
		var first = this.node_count == 0;
		var node = this.basic_block_map_.get(name);
		if(node == null) {
			node = new benchmark.BasicBlock(name);
			this.basic_block_map_.set(name,node);
			this.node_count++;
		}
		if(first) this.start_node_ = node;
		return node;
	}
};
benchmark.SimpleLoop = function() {
	this.is_root_ = false;
	this.nesting_level_ = 0;
	this.depth_level_ = 0;
	this.basic_blocks_ = new Array();
	this.children_ = new Array();
};
benchmark.SimpleLoop.prototype = {
	AddNode: function(basic_block) {
		var _g = 0;
		var _g1 = this.basic_blocks_;
		while(_g < _g1.length) {
			var b = _g1[_g];
			++_g;
			if(b == basic_block) return;
		}
		this.basic_blocks_.push(basic_block);
	}
	,AddChildLoop: function(loop) {
		var _g = 0;
		var _g1 = this.children_;
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			if(c == loop) return;
		}
		this.children_.push(loop);
	}
	,set_parent: function(parent) {
		this.parent_ = parent;
		parent.AddChildLoop(this);
	}
	,set_counter: function(value) {
		this.counter_ = value;
	}
	,set_nesting_level: function(level) {
		this.nesting_level_ = level;
		if(level == 0) this.is_root_ = true;
	}
};
benchmark.LoopStructureGraph = function() {
	this.root_ = new benchmark.SimpleLoop();
	this.loops_ = new Array();
	this.loop_counter_ = 0;
	this.root_.set_nesting_level(0);
	this.root_.set_counter(this.loop_counter_++);
	this.loops_.push(this.root_);
};
benchmark.LoopStructureGraph.prototype = {
	CreateNewLoop: function() {
		var loop = new benchmark.SimpleLoop();
		loop.set_counter(this.loop_counter_++);
		return loop;
	}
};
benchmark.UnionFindNode = function(bb,dfs_number) {
	this.dfs_number_ = 0;
	this.parent_ = this;
	this.bb_ = bb;
	this.dfs_number_ = dfs_number;
};
benchmark.UnionFindNode.prototype = {
	FindSet: function() {
		var nodeList = new Array();
		var node = this;
		while(node != node.parent_) {
			if(node.parent_ != node.parent_.parent_) nodeList.push(node);
			node = node.parent_;
		}
		var p = node.parent_;
		var _g = 0;
		while(_g < nodeList.length) {
			var n = nodeList[_g];
			++_g;
			n.parent_ = p;
		}
		return node;
	}
};
benchmark.MaoLoops = function(cfg,lsg) {
	this.CFG_ = cfg;
	this.lsg_ = lsg;
};
benchmark.MaoLoops.IsAncestor = function(w,v,last) {
	return w <= v && v <= last[w];
};
benchmark.MaoLoops.prototype = {
	DFS: function(current_node,nodes,number,last,current) {
		nodes[current] = new benchmark.UnionFindNode(current_node,current);
		number.set(current_node.name_,current);
		var lastid = current;
		var _g = 0;
		var _g1 = current_node.out_edges_;
		while(_g < _g1.length) {
			var target = _g1[_g];
			++_g;
			if(number.get(target.name_) == -1) lastid = this.DFS(target,nodes,number,last,lastid + 1);
		}
		last[number.get(current_node.name_)] = lastid;
		return lastid;
	}
	,FindLoops: function() {
		if(this.CFG_.start_node_ == null) return;
		var size = this.CFG_.node_count;
		if(size < 1) return;
		var non_back_preds = new Array();
		non_back_preds[size - 1] = null;
		var back_preds = new Array();
		back_preds[size - 1] = null;
		var _g = 0;
		while(_g < size) {
			var i = _g++;
			non_back_preds[i] = new haxe.ds.IntMap();
			back_preds[i] = new Array();
		}
		var header = new Array();
		header[size - 1] = 0;
		var type = new Array();
		type[size - 1] = 0;
		var last = new Array();
		last[size - 1] = 0;
		var nodes = new Array();
		var number = new haxe.ds.IntMap();
		var $it0 = this.CFG_.basic_block_map_.iterator();
		while( $it0.hasNext() ) {
			var block = $it0.next();
			number.set(block.name_,-1);
		}
		this.DFS(this.CFG_.start_node_,nodes,number,last,0);
		var _g1 = 0;
		while(_g1 < size) {
			var w = _g1++;
			header[w] = 0;
			type[w] = 1;
			var node_w = nodes[w].bb_;
			if(node_w == null) {
				type[w] = 5;
				continue;
			}
			if(node_w.in_edges_.length != 0) {
				var _g11 = 0;
				var _g2 = node_w.in_edges_;
				while(_g11 < _g2.length) {
					var node_v = _g2[_g11];
					++_g11;
					var v = number.get(node_v.name_);
					if(v == -1) continue;
					if(w <= v && v <= last[w]) back_preds[w].push(v); else non_back_preds[w].set(v,v);
				}
			}
		}
		header[0] = 0;
		var w1 = size - 1;
		while(w1 >= 0) {
			var node_pool = new Array();
			var node_w1 = nodes[w1].bb_;
			if(node_w1 == null) {
				--w1;
				continue;
			}
			var _g3 = 0;
			var _g12 = back_preds[w1];
			while(_g3 < _g12.length) {
				var v1 = _g12[_g3];
				++_g3;
				if(v1 != w1) node_pool.push(nodes[v1].FindSet()); else type[w1] = 3;
			}
			var worklist = node_pool.slice();
			if(node_pool.length < 1) type[w1] = 2;
			var jobs = worklist.length;
			while(jobs > 0) {
				var x = worklist[--jobs];
				var non_back_size = 0;
				var $it1 = non_back_preds[x.dfs_number_].keys();
				while( $it1.hasNext() ) {
					var i1 = $it1.next();
					non_back_size++;
					if(non_back_size > 32768) return;
					var y = nodes[i1];
					var ydash = y.FindSet();
					if(!benchmark.MaoLoops.IsAncestor(w1,ydash.dfs_number_,last)) {
						type[w1] = 4;
						non_back_preds[w1].set(ydash.dfs_number_,ydash.dfs_number_);
					} else if(ydash.dfs_number_ != w1) {
						var found = false;
						var _g4 = 0;
						while(_g4 < node_pool.length) {
							var n = node_pool[_g4];
							++_g4;
							if(n == ydash) {
								found = true;
								break;
							}
						}
						if(!found) {
							worklist[++jobs] = ydash;
							node_pool.push(ydash);
						}
					}
				}
			}
			if(node_pool.length > 0 || type[w1] == 3) {
				var loop = this.lsg_.CreateNewLoop();
				nodes[w1].loop_ = loop;
				var _g5 = 0;
				while(_g5 < node_pool.length) {
					var node = node_pool[_g5];
					++_g5;
					header[node.dfs_number_] = w1;
					node.parent_ = nodes[w1];
					if(node.loop_ != null) node.loop_.set_parent(loop); else loop.AddNode(node.bb_);
				}
				this.lsg_.loops_.push(loop);
			}
			--w1;
		}
	}
	,run: function() {
		this.FindLoops();
		return this.lsg_.loops_.length;
	}
};
var haxe = {};
haxe.ds = {};
haxe.ds.IntMap = function() {
	this.h = { };
};
haxe.ds.IntMap.__interfaces__ = [IMap];
haxe.ds.IntMap.prototype = {
	set: function(key,value) {
		this.h[key] = value;
	}
	,get: function(key) {
		return this.h[key];
	}
	,keys: function() {
		var a = [];
		for( var key in this.h ) {
		if(this.h.hasOwnProperty(key)) a.push(key | 0);
		}
		return HxOverrides.iter(a);
	}
	,iterator: function() {
		return { ref : this.h, it : this.keys(), hasNext : function() {
			return this.it.hasNext();
		}, next : function() {
			var i = this.it.next();
			return this.ref[i];
		}};
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
_TestClasses.BClass.WHOOT = "whoot";
Main.main();
})();

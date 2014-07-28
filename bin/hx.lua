-- optimize lookup
--local __string_sub = string.sub
--local __string_byte = string.byte
--local __string_find = string.find
--local __string_fromCharCode = string.char -- static Int -> String
--local __string_substring = string.sub -- Int -> ?Int -> String
--local __string_toLowerCase = string.lower --> String
--local __string_toUpperCase = string.upper --> String
--local __string_len = string.len

-- hm, it lowers performance
function exec()
-- class HxOverrides_HxOverrides
-- ignored --

-- class Main_Main
Main_Main = {};
__inherit(Main_Main, Object);
Main_Main.__index = Main_Main;
do --{
	function Main_Main.main(  )
		
			print("go -->");
			local d = __new__(Date_Date):getTime();
			TestString_TestString.test();
			TestIfs_TestIfs.test();
			TestFuncs_TestFuncs.test();
			TestMagic_TestMagic.test();
			TestFuncs_TestFuncs.test();
			TestClasses_TestClasses.test();
			print("[lua] >");
			print("FeatureTest: " .. Std_Std.int(__new__(Date_Date):getTime() - d) .. "ms");
			d = __new__(Date_Date):getTime();
			
				local _g = 0;
				while((_g < 10000))do ::continue:: 
					local i = _g; _g = _g + 1
					TestString_TestString.test(true)
				end
			;
			print("StringPerfTest: " .. Std_Std.int(__new__(Date_Date):getTime() - d) .. "ms");
			d = __new__(Date_Date):getTime();
			benchmark_LoopTesterApp_LoopTesterApp.main();
			print("ComplexPerfTest: " .. Std_Std.int(__new__(Date_Date):getTime() - d) .. "ms");
			d = __new__(Date_Date):getTime();
			
				local _g1 = 0;
				while((_g1 < 100000))do ::continue:: 
					local i1 = _g1; _g1 = _g1 + 1
					TestIfs_TestIfs.test(true);
					TestFuncs_TestFuncs.test(true);
					TestLoops_TestLoops.test(true)
				end
			;
			print("LangPerfTest: " .. Std_Std.int(__new__(Date_Date):getTime() - d) .. "ms")
		
	
	end
	
end --}

-- class Map_IMap abstract class Map_IMap
do --{
	
end --}

-- class Std_Std
-- ignored --

-- class TestClasses_LClass
TestClasses_LClass = {};
__inherit(TestClasses_LClass, Object);
TestClasses_LClass.__index = TestClasses_LClass;
do --{
	
	function TestClasses_LClass.new(  )
		local self = {}
		setmetatable(self, TestClasses_LClass) end
	
end --}

-- class TestClasses_BaseClass
TestClasses_BaseClass = {};
__inherit(TestClasses_BaseClass, Object);
TestClasses_BaseClass.__index = TestClasses_BaseClass;
do --{
	
	function TestClasses_BaseClass.new(  )
		local self = {}
		setmetatable(self, TestClasses_BaseClass)
		
			print("BaseClass::new");
			if(TestClasses_BaseClass._instances == nil)then
				TestClasses_BaseClass._instances = 0
			end;
			(function () local _r = TestClasses_BaseClass._instances or 0; TestClasses_BaseClass._instances = _r + 1; return _r end)();
			self._count = 0;
			TestClasses_BaseClass.UninitialisedStaticVar = 1.234
		
	
	return self
	end
	--static var UninitialisedStaticVar;
	--static var _instances;
	--var _count;
	
end --}

-- class TestClasses_InterfaceDemo abstract class TestClasses_InterfaceDemo
do --{
	
end --}

-- class TestClasses_AClass extends TestClasses_BaseClass
TestClasses_AClass = {};
__inherit(TestClasses_AClass, TestClasses_BaseClass);
TestClasses_AClass.__index = TestClasses_AClass;
do --{
	
	function TestClasses_AClass.new(  )
		local self = {}
		setmetatable(self, TestClasses_AClass)
				__inherit(self, TestClasses_BaseClass.new())
	
	return self
	end
	
end --}

-- class TestClasses_BClass extends TestClasses_AClass
TestClasses_BClass = {};
__inherit(TestClasses_BClass, TestClasses_AClass);
TestClasses_BClass.__index = TestClasses_BClass; -- implements TestClasses_InterfaceDemo
do --{
	
	function TestClasses_BClass.new( arg )
		local self = {}
		setmetatable(self, TestClasses_BClass)
		
					__inherit(self, TestClasses_AClass.new());
			print("BClass::new " .. arg);
			self.apiVar = true
		
	
	return self
	end
	TestClasses_BClass.WHOOT = "whoot";
	--var apiVar;
	function TestClasses_BClass:methodInBClass(  )
		print("BClass::methodInBClass")
	
	end
	
	function TestClasses_BClass:doSomething(  )
		print("BClass::doSomething()")
	
	end
	
	
end --}

-- class TestClasses_CClass extends TestClasses_BClass
TestClasses_CClass = {};
__inherit(TestClasses_CClass, TestClasses_BClass);
TestClasses_CClass.__index = TestClasses_CClass;
do --{
	
	function TestClasses_CClass.new( arg )
		local self = {}
		setmetatable(self, TestClasses_CClass)
		
					__inherit(self, TestClasses_BClass.new(arg));
			print("CClass::new " .. arg)
		
	
	return self
	end
	
end --}

-- class TestClasses_TestClasses
TestClasses_TestClasses = {};
__inherit(TestClasses_TestClasses, Object);
TestClasses_TestClasses.__index = TestClasses_TestClasses;
do --{
	function TestClasses_TestClasses.test( perf )
		
			if(not perf)then
				print("TestClasses begin")
			end;
			local L = TestClasses_LClass.new();
			local bc = TestClasses_BaseClass.new();
			local a = TestClasses_AClass.new();
			local b = TestClasses_BClass.new("arg");
			local c = TestClasses_CClass.new("arg");
			if(not perf)then
				print("TestClasses end")
			end
		
	
	end
	
end --}

-- class TestFuncs_TestFuncs
TestFuncs_TestFuncs = {};
__inherit(TestFuncs_TestFuncs, Object);
TestFuncs_TestFuncs.__index = TestFuncs_TestFuncs;
do --{
	function TestFuncs_TestFuncs.test( perf )
		
			if(not perf)then
				print("TestFuncs begin")
			end;
			local none22 = 0;
			local none = function (  ) end;
			local none2 = function (  )
				
					none();
					local none221 = 0
				
			
			end;
			local none3 = function (  )
				
					local none1 = function (  ) end;
					local none21 = function (  )
						none1()
					
					end
				
			
			end;
			local none4 = function (  )
				
					local x = 0;
					local none5 = function (  )
						
							x = x + 1
							local none31 = function (  )
								
									local none6 = function (  ) end;
									local none23 = function (  )
										none6()
									
									end
								
							
							end;
							none31()
						
					
					end;
					local none24 = function (  )
						
							none5();
							(function () local _r = x or 0; x = _r + 1; return _r end)()
						
					
					end;
					none5();
					none24();
					if(not perf)then
						print(x == 3)
					end
				
			
			end;
			local fx = function (  )
				return 0;
			
			end;
			none();
			none2();
			none3();
			none4();
			if(not perf)then
				print("TestFuncs end")
			end
		
	
	end
	
end --}

-- class TestIfs_TestIfs
TestIfs_TestIfs = {};
__inherit(TestIfs_TestIfs, Object);
TestIfs_TestIfs.__index = TestIfs_TestIfs;
do --{
	function TestIfs_TestIfs.test( perf )
		
			if(not perf)then
				print("TestIfs begin")
			end;
			local none = function (  ) end;
			local bool = true;
			if(bool)then end;
			if(not bool)then end;
			if(not bool  and  bool)then end;
			if(not bool  and  bool  or  bool)then end;
			if(bool)then
				none()
			end;
			if(bool)then
				none()
			end;
			if(not((bool))) then
				none()
			end;
			if(bool)then
				none()
			else
				none()
			end;
			if(not bool  and  bool)then
				none()
			end;
			if(not bool  and  bool  or  bool)then
				none()
			end;
			local rr = function (  )
				
					if(not bool)then
						return
					else
						return
					end;
					return
				
			
			end;
			rr();
			local rr1 = function (  )
				
					if(bool)then
						return 1
					else
						return 2
					end;
					return 3
				
			
			end;
			rr1();
			if(bool)then
				if(not bool)then
				if(not bool  and  bool)then end
			else
				if(not bool  and  bool  or  bool)then end
			end
			end;
			if(bool)then
				
				none();
				if(bool)then
					none()
				else
					if(bool)then
					if(not bool  and  bool)then
					
					if(bool)then
						
						if(not bool  and  bool  or  bool)then
							none()
						end;
						none()
					
					else
						none()
					end;
					none()
				
				end
				else
					none()
				end
				end
			
			end;
			local z = 10;
			local x = 0;
			if(z > 2)then
				x = 7
			else
				x = 10
			end;
			if(not perf)then
				print("TestIfs end")
			end
		
	
	end
	
end --}

-- class TestLoops_TestLoops
TestLoops_TestLoops = {};
__inherit(TestLoops_TestLoops, Object);
TestLoops_TestLoops.__index = TestLoops_TestLoops;
do --{
	function TestLoops_TestLoops.test( perf )
		
			if(not perf)then
				print("TestLoops begin")
			end;
			
				local _g = 0;
				while((_g < 10))do ::continue:: 
					local i = _g; _g = _g + 1
					local x = 1
				end
			;
			local x1 = 0;
			while((x1 < 10))do ::continue:: 
				x1 = x1 + 1
				
					local _g1 = 0;
					while((_g1 < 10))do ::continue:: 
						local i1 = _g1; _g1 = _g1 + 1
						local x2 = 1;
						
							local _g11 = 0;
							while((_g11 < 10))do ::continue:: 
								local i2 = _g11; _g11 = _g11 + 1
								local x3 = 1
							end
						
					end
				;
				
					local _g2 = 0;
					while((_g2 < 10))do ::continue:: 
						local i3 = _g2; _g2 = _g2 + 1
						local x4 = 1;
						
							local _g12 = 0;
							while((_g12 < 10))do ::continue:: 
								local i4 = _g12; _g12 = _g12 + 1
								local x5 = 1
							end
						
					end
				
			end;
			if(not perf)then
				print("TestLoops end")
			end
		
	
	end
	
end --}

-- class TestMagic_TestMagic
TestMagic_TestMagic = {};
__inherit(TestMagic_TestMagic, Object);
TestMagic_TestMagic.__index = TestMagic_TestMagic;
do --{
	function TestMagic_TestMagic.test(  )
		
			_G.print('__lua__');
			print(1, 2, 3);
			os:clock(1, 2, "hi");
			_G.print("__lua__", 2)
		
	
	end
	
end --}

-- class TestString_TestString
TestString_TestString = {};
__inherit(TestString_TestString, Object);
TestString_TestString.__index = TestString_TestString;
do --{
	--static var _perf;
	function TestString_TestString.eq( text, bool )
		if(not bool  and  not TestString_TestString._perf)then
			print(text .. " failed")
		end
	
	end
	function TestString_TestString.test( perf )
		
			TestString_TestString._perf = perf;
			if(not perf)then
				print("TestString begin")
			end;
			local S = "Returns a String _!@#$%^&*()1234567890-=/*[]{}";
			TestString_TestString.eq("eq", S == "Returns a String _!@#$%^&*()1234567890-=/*[]{}");
			TestString_TestString.eq("length", #(S) == 46);
			TestString_TestString.eq("substring", S:substring(1+8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
			TestString_TestString.eq("substr", HxOverrides_HxOverrides.substr(S, 8, 1) == "a");
			TestString_TestString.eq("substring a,b", S:substring(1+8, 0+10) == "a ");
			TestString_TestString.eq("substr a,b", HxOverrides_HxOverrides.substr(S, 8, 1) == "a");
			TestString_TestString.eq("substr", HxOverrides_HxOverrides.substr(S, 8, nil) == "a String _!@#$%^&*()1234567890-=/*[]{}");
			TestString_TestString.eq("fromCharCode", true);
			TestString_TestString.eq("charAt", S:charAt(5) == "n");
			TestString_TestString.eq("charCodeAt", HxOverrides_HxOverrides.cca(S, 5) == 110);
			if(not perf)then
				print("TestString end")
			end
		
	
	end
	
end --}

-- class benchmark_LoopTesterApp_LoopTesterApp
benchmark_LoopTesterApp_LoopTesterApp = {};
__inherit(benchmark_LoopTesterApp_LoopTesterApp, Object);
benchmark_LoopTesterApp_LoopTesterApp.__index = benchmark_LoopTesterApp_LoopTesterApp;
do --{
	function benchmark_LoopTesterApp_LoopTesterApp.buildDiamond( cfg, start )
		
			local bb0 = start;
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, bb0, bb0 + 1);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, bb0, bb0 + 2);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, bb0 + 1, bb0 + 3);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, bb0 + 2, bb0 + 3);
			return bb0 + 3
		
	
	end
	function benchmark_LoopTesterApp_LoopTesterApp.buildStraight( cfg, start, n )
		
			
				local _g = 0;
				while((_g < n))do ::continue:: 
					local i = _g; _g = _g + 1
					benchmark_MaoLoops_BasicBlockEdge.new(cfg, start + i, start + i + 1)
				end
			;
			return start + n
		
	
	end
	function benchmark_LoopTesterApp_LoopTesterApp.buildBaseLoop( cfg, from )
		
			local header = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, from, 1);
			local diamond1 = benchmark_LoopTesterApp_LoopTesterApp.buildDiamond(cfg, header);
			local d11 = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, diamond1, 1);
			local diamond2 = benchmark_LoopTesterApp_LoopTesterApp.buildDiamond(cfg, d11);
			local footer = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, diamond2, 1);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, diamond2, d11);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, diamond1, header);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, footer, from);
			footer = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, footer, 1);
			return footer
		
	
	end
	function benchmark_LoopTesterApp_LoopTesterApp.main(  )
		
			local d = __new__(Date_Date):getTime();
			local cfg = benchmark_MaoLoops_MaoCFG.new();
			local lsg = benchmark_MaoLoops_LoopStructureGraph.new();
			cfg:CreateNode(0);
			benchmark_LoopTesterApp_LoopTesterApp.buildBaseLoop(cfg, 0);
			cfg:CreateNode(1);
			benchmark_MaoLoops_BasicBlockEdge.new(cfg, 0, 2);
			
				local _g = 0;
				while((_g < 300))do ::continue:: 
					local dummyloops = _g; _g = _g + 1
					local lsglocal = benchmark_MaoLoops_LoopStructureGraph.new();
					benchmark_MaoLoops_MaoLoops.new(cfg, lsglocal):run()
				end
			;
			local n = 2;
			
				local _g1 = 0;
				while((_g1 < 10))do ::continue:: 
					local parlooptrees = _g1; _g1 = _g1 + 1
					cfg:CreateNode(n + 1);
					benchmark_MaoLoops_BasicBlockEdge.new(cfg, 2, n + 1);
					n = n + 1;
					
						local _g11 = 0;
						while((_g11 < 100))do ::continue:: 
							local i = _g11; _g11 = _g11 + 1
							local top = n;
							n = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, n, 1);
							
								local _g2 = 0;
								while((_g2 < 25))do ::continue:: 
									local j = _g2; _g2 = _g2 + 1
									n = benchmark_LoopTesterApp_LoopTesterApp.buildBaseLoop(cfg, n)
								end
							;
							local bottom = benchmark_LoopTesterApp_LoopTesterApp.buildStraight(cfg, n, 1);
							benchmark_MaoLoops_BasicBlockEdge.new(cfg, n, top);
							n = bottom
						end
					;
					benchmark_MaoLoops_BasicBlockEdge.new(cfg, n, 1)
				end
			
		
	
	end
	
end --}

-- class benchmark_MaoLoops_BasicBlockEdge
benchmark_MaoLoops_BasicBlockEdge = {};
__inherit(benchmark_MaoLoops_BasicBlockEdge, Object);
benchmark_MaoLoops_BasicBlockEdge.__index = benchmark_MaoLoops_BasicBlockEdge;
do --{
	
	function benchmark_MaoLoops_BasicBlockEdge.new( cfg, from_name, to_name )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_BasicBlockEdge)
		
			self.from_ = cfg:CreateNode(from_name);
			self.to_ = cfg:CreateNode(to_name);
			self.from_.out_edges_.push(self.to_);
			self.to_.in_edges_.push(self.from_);
			cfg.edge_list_.push(self)
		
	
	return self
	end
	--var from_;
	--var to_;
	
end --}

-- class benchmark_MaoLoops_BasicBlock
benchmark_MaoLoops_BasicBlock = {};
__inherit(benchmark_MaoLoops_BasicBlock, Object);
benchmark_MaoLoops_BasicBlock.__index = benchmark_MaoLoops_BasicBlock;
do --{
	
	function benchmark_MaoLoops_BasicBlock.new( name )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_BasicBlock)
		
			self.in_edges_ = Array_Array.new();
			self.out_edges_ = Array_Array.new();
			self.name_ = name
		
	
	return self
	end
	--var in_edges_;
	--var out_edges_;
	--var name_;
	
end --}

-- class benchmark_MaoLoops_MaoCFG
benchmark_MaoLoops_MaoCFG = {};
__inherit(benchmark_MaoLoops_MaoCFG, Object);
benchmark_MaoLoops_MaoCFG.__index = benchmark_MaoLoops_MaoCFG;
do --{
	
	function benchmark_MaoLoops_MaoCFG.new(  )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_MaoCFG)
		
			self.node_count = 0;
			self.basic_block_map_ = haxe_ds_IntMap_IntMap.new();
			self.edge_list_ = Array_Array.new()
		
	
	return self
	end
	--var basic_block_map_;
	--var start_node_;
	--var edge_list_;
	--var node_count;
	function benchmark_MaoLoops_MaoCFG:CreateNode( name )
		
			local first = self.node_count == 0;
			local node = self.basic_block_map_:get(name);
			if(node == nil)then
				
				node = benchmark_MaoLoops_BasicBlock.new(name);
				self.basic_block_map_:set(name, node);
				(function () local _r = self.node_count or 0; self.node_count = _r + 1; return _r end)()
			
			end;
			if(first)then
				self.start_node_ = node
			end;
			return node
		
	
	end
	
	
end --}

-- class benchmark_MaoLoops_SimpleLoop
benchmark_MaoLoops_SimpleLoop = {};
__inherit(benchmark_MaoLoops_SimpleLoop, Object);
benchmark_MaoLoops_SimpleLoop.__index = benchmark_MaoLoops_SimpleLoop;
do --{
	
	function benchmark_MaoLoops_SimpleLoop.new(  )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_SimpleLoop)
		
			self.is_root_ = false;
			self.nesting_level_ = 0;
			self.depth_level_ = 0;
			self.basic_blocks_ = Array_Array.new();
			self.children_ = Array_Array.new()
		
	
	return self
	end
	function benchmark_MaoLoops_SimpleLoop:AddNode( basic_block )
		
			
				local _g = 0;
				local _g1 = self.basic_blocks_;
				while((_g < _g1.length))do ::continue:: 
					local b = _g1[_g];
					_g = _g + 1
					if(b == basic_block)then
						return
					end
				end
			;
			self.basic_blocks_.push(basic_block)
		
	
	end
	
	function benchmark_MaoLoops_SimpleLoop:AddChildLoop( loop )
		
			
				local _g = 0;
				local _g1 = self.children_;
				while((_g < _g1.length))do ::continue:: 
					local c = _g1[_g];
					_g = _g + 1
					if(c == loop)then
						return
					end
				end
			;
			self.children_.push(loop)
		
	
	end
	
	function benchmark_MaoLoops_SimpleLoop:set_parent( parent )
		
			self.parent_ = parent;
			parent:AddChildLoop(self)
		
	
	end
	
	function benchmark_MaoLoops_SimpleLoop:set_counter( value )
		self.counter_ = value
	
	end
	
	function benchmark_MaoLoops_SimpleLoop:set_nesting_level( level )
		
			self.nesting_level_ = level;
			if(level == 0)then
				self.is_root_ = true
			end
		
	
	end
	
	--var basic_blocks_;
	--var children_;
	--var parent_;
	--var is_root_;
	--var counter_;
	--var nesting_level_;
	--var depth_level_;
	
end --}

-- class benchmark_MaoLoops_LoopStructureGraph
benchmark_MaoLoops_LoopStructureGraph = {};
__inherit(benchmark_MaoLoops_LoopStructureGraph, Object);
benchmark_MaoLoops_LoopStructureGraph.__index = benchmark_MaoLoops_LoopStructureGraph;
do --{
	
	function benchmark_MaoLoops_LoopStructureGraph.new(  )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_LoopStructureGraph)
		
			self.root_ = benchmark_MaoLoops_SimpleLoop.new();
			self.loops_ = Array_Array.new();
			self.loop_counter_ = 0;
			self.root_.set_nesting_level(0);
			self.root_.set_counter((function () local _r = self.loop_counter_ or 0; self.loop_counter_ = _r + 1; return _r end)());
			self.loops_.push(self.root_)
		
	
	return self
	end
	function benchmark_MaoLoops_LoopStructureGraph:CreateNewLoop(  )
		
			local loop = benchmark_MaoLoops_SimpleLoop.new();
			loop:set_counter((function () local _r = self.loop_counter_ or 0; self.loop_counter_ = _r + 1; return _r end)());
			return loop
		
	
	end
	
	--var root_;
	--var loops_;
	--var loop_counter_;
	
end --}

-- class benchmark_MaoLoops_UnionFindNode
benchmark_MaoLoops_UnionFindNode = {};
__inherit(benchmark_MaoLoops_UnionFindNode, Object);
benchmark_MaoLoops_UnionFindNode.__index = benchmark_MaoLoops_UnionFindNode;
do --{
	
	function benchmark_MaoLoops_UnionFindNode.new( bb, dfs_number )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_UnionFindNode)
		
			self.dfs_number_ = 0;
			self.parent_ = self;
			self.bb_ = bb;
			self.dfs_number_ = dfs_number
		
	
	return self
	end
	function benchmark_MaoLoops_UnionFindNode:FindSet(  )
		
			local nodeList = Array_Array.new();
			local node = self;
			while((node ~= node.parent_))do ::continue:: 
				if(node.parent_ ~= node.parent_.parent_)then
					nodeList:push(node)
				end;
				node = node.parent_
			end;
			local p = node.parent_;
			
				local _g = 0;
				while((_g < nodeList.length))do ::continue:: 
					local n = nodeList[_g];
					_g = _g + 1
					n.parent_ = p
				end
			;
			return node
		
	
	end
	
	--var parent_;
	--var bb_;
	--var loop_;
	--var dfs_number_;
	
end --}

-- class benchmark_MaoLoops_MaoLoops
benchmark_MaoLoops_MaoLoops = {};
__inherit(benchmark_MaoLoops_MaoLoops, Object);
benchmark_MaoLoops_MaoLoops.__index = benchmark_MaoLoops_MaoLoops;
do --{
	
	function benchmark_MaoLoops_MaoLoops.new( cfg, lsg )
		local self = {}
		setmetatable(self, benchmark_MaoLoops_MaoLoops)
		
			self.CFG_ = cfg;
			self.lsg_ = lsg
		
	
	return self
	end
	function benchmark_MaoLoops_MaoLoops.IsAncestor( w, v, last )
		return w <= v  and  v <= last[w];
	
	end
	function benchmark_MaoLoops_MaoLoops:DFS( current_node, nodes, number, last, current )
		
			nodes[current] = benchmark_MaoLoops_UnionFindNode.new(current_node, current);
			number:set(current_node.name_, current);
			local lastid = current;
			
				local _g = 0;
				local _g1 = current_node.out_edges_;
				while((_g < _g1.length))do ::continue:: 
					local target = _g1[_g];
					_g = _g + 1
					if(number:get(target.name_) == -1)then
						lastid = self:DFS(target, nodes, number, last, lastid + 1)
					end
				end
			;
			last[number:get(current_node.name_)] = lastid;
			return lastid
		
	
	end
	
	function benchmark_MaoLoops_MaoLoops:FindLoops(  )
		
			if(self.CFG_.start_node_ == nil)then
				return
			end;
			local size = self.CFG_.node_count;
			if(size < 1)then
				return
			end;
			local non_back_preds = Array_Array.new();
			non_back_preds[size - 1] = nil;
			local back_preds = Array_Array.new();
			back_preds[size - 1] = nil;
			
				local _g = 0;
				while((_g < size))do ::continue:: 
					local i = _g; _g = _g + 1
					non_back_preds[i] = haxe_ds_IntMap_IntMap.new();
					back_preds[i] = Array_Array.new()
				end
			;
			local header = Array_Array.new();
			header[size - 1] = 0;
			local type = Array_Array.new();
			type[size - 1] = 0;
			local last = Array_Array.new();
			last[size - 1] = 0;
			local nodes = Array_Array.new();
			local number = haxe_ds_IntMap_IntMap.new();
			for ___, block in (self.CFG_.basic_block_map_:iterator()) do ::continue:: 
				number:set(block.name_, -1)
			end;
			self:DFS(self.CFG_.start_node_, nodes, number, last, 0);
			
				local _g1 = 0;
				while((_g1 < size))do ::continue:: 
					local w = _g1; _g1 = _g1 + 1
					header[w] = 0;
					type[w] = 1;
					local node_w = nodes[w].bb_;
					if(node_w == nil)then
						
						type[w] = 5;
						goto continue
					
					end;
					if(node_w.in_edges_.length ~= 0)then
						
						local _g11 = 0;
						local _g2 = node_w.in_edges_;
						while((_g11 < _g2.length))do ::continue:: 
							local node_v = _g2[_g11];
							_g11 = _g11 + 1
							local v = number:get(node_v.name_);
							if(v == -1)then
								goto continue
							end;
							if(w <= v  and  v <= last[w])then
								back_preds[w]:push(v)
							else
								non_back_preds[w]:set(v, v)
							end
						end
					
					end
				end
			;
			header[0] = 0;
			local w1 = size - 1;
			while((w1 >= 0))do ::continue:: 
				local node_pool = Array_Array.new();
				local node_w1 = nodes[w1].bb_;
				if(node_w1 == nil)then
					
					w1 = w1 - 1
					goto continue
				
				end;
				
					local _g3 = 0;
					local _g12 = back_preds[w1];
					while((_g3 < _g12.length))do ::continue:: 
						local v1 = _g12[_g3];
						_g3 = _g3 + 1
						if(v1 ~= w1)then
							node_pool:push(nodes[v1]:FindSet())
						else
							type[w1] = 3
						end
					end
				;
				local worklist = node_pool:slice();
				if(node_pool.length < 1)then
					type[w1] = 2
				end;
				local jobs = worklist.length;
				while((jobs > 0))do ::continue:: 
					local x = worklist[(function () jobs = (jobs or 0) - 1; return jobs; end)()];
					local non_back_size = 0;
					for ___, i1 in (non_back_preds[x:dfs_number_]:keys()) do ::continue:: 
						
						non_back_size = non_back_size + 1
						if(non_back_size > 32768)then
							return
						end;
						local y = nodes[i1];
						local ydash = y:FindSet();
						if(not benchmark_MaoLoops_MaoLoops.IsAncestor(w1, ydash.dfs_number_, last))then
							
							type[w1] = 4;
							non_back_preds[w1]:set(ydash.dfs_number_, ydash.dfs_number_)
						
						else
							if(ydash.dfs_number_ ~= w1)then
							
							local found = false;
							
								local _g4 = 0;
								while((_g4 < node_pool.length))do ::continue:: 
									local n = node_pool[_g4];
									_g4 = _g4 + 1
									if(n == ydash)then
										
										found = true;
										break
									
									end
								end
							;
							if(not found)then
								
								worklist[(function () jobs = (jobs or 0) + 1; return jobs; end)()] = ydash;
								node_pool:push(ydash)
							
							end
						
						end
						end
					
					end
				end;
				if(node_pool.length > 0  or  type[w1] == 3)then
					
					local loop = self.lsg_.CreateNewLoop();
					nodes[w1].loop_ = loop;
					
						local _g5 = 0;
						while((_g5 < node_pool.length))do ::continue:: 
							local node = node_pool[_g5];
							_g5 = _g5 + 1
							header[node.dfs_number_] = w1;
							node.parent_ = nodes[w1];
							if(node.loop_ ~= nil)then
								node.loop_.set_parent(loop)
							else
								loop:AddNode(node.bb_)
							end
						end
					;
					self.lsg_.loops_.push(loop)
				
				end;
				(function () w1 = (w1 or 0) - 1; return w1; end)()
			end
		
	
	end
	
	--var CFG_;
	--var lsg_;
	function benchmark_MaoLoops_MaoLoops:run(  )
		
			self:FindLoops();
			return self.lsg_.loops_.length
		
	
	end
	
	
end --}

-- class haxe_ds_IntMap_IntMap
-- ignored --


end
-- boot

null = nil
trace = print

function __inherit(to, base)
	-- copy all fields from parent
    for k, v in pairs(base) do
        to[k] = v
    end
end

function __new__(obj)
	return obj.new()
end

function __concat(a, b)
	return a .. b
end

-- universal & safe
-- TODO: _false not calculated in Haxe, if _true!
-- TODO: make inline function
function __ternar(_cond,_true,_false)
	--local result = _true
	--if(not _cond)then result = _false end
	--return result
	if(_cond)then return _true end
	return _false
end

function __increment(t,k)
   t[k]=(t[k] or 0)+1
   return t[k]-1
end

haxe_Log = {};
function haxe_Log.trace(a)
	print(a)
end
function table_print (tt, indent, done)
  done = done or {}
  indent = indent or 0
  if type(tt) == "table" then
    local sb = {}
    for key, value in pairs (tt) do
      table.insert(sb, string.rep (" ", indent)) -- indent it
      if type (value) == "table" and not done [value] then
        done [value] = true
        table.insert(sb, "{\n");
        table.insert(sb, table_print (value, indent + 2, done))
        table.insert(sb, string.rep (" ", indent)) -- indent it
        table.insert(sb, "}\n");
      elseif "number" == type(key) then
        table.insert(sb, string.format("\"%s\"\n", tostring(value)))
      else
        table.insert(sb, string.format(
            "%s = \"%s\"\n", tostring (key), tostring(value)))
       end
    end
    return table.concat(sb)
  else
    return tt .. "\n"
  end
end

function to_string( tbl )
    if  "nil"       == type( tbl ) then
        return tostring(nil)
    elseif  "table" == type( tbl ) then
        return table_print(tbl)
    elseif  "string" == type( tbl ) then
        return tbl
    else
        return tostring(tbl)
    end
end
-- Std class http://api.haxe.org/Std.html
Std = {};
Std_Std = Std;
function Std.int( x, y ) -- Fix for tail-call generator bug, TODO fix
	return y and math.floor(y) or math.floor(x)
end
-- TODO maybe Std.func = func is faster to call
--static function string(s:Dynamic):String
--Converts any value to a String.
--If s is of String, Int, Float or Bool, its value is returned.
--If s is an instance of a class and that class or one of its parent classes has a toString method, that method is called. If no such method is present, the result is unspecified.
--If s is an enum constructor without argument, the constructor's name is returned. If arguments exists, the constructor's name followed by the String representations of the arguments is returned.
--If s is a structure, the field names along with their values are returned. The field order and the operator separating field names and values are unspecified.
--If s is null, "null" is returned.
function Std.string( s )
	return "" .. x -- TODO
end
--function instance<T, S>(value:T, c:Class<S>):S
--Checks if object value is an instance of class c.
--Compiles only if the class specified by c can be assigned to the type of value.
--This method checks if a downcast is possible. That is, if the runtime type of value is assignable to the class specified by c, value is returned. Otherwise null is returned.
--This method is not guaranteed to work with interfaces or core types such as String, Array and Date.
--If value is null, the result is null. If c is null, the result is unspecified.
function Std.instance( value, c )
	return nil -- TODO
end
--static function is(v:Dynamic, t:Dynamic):Bool
--Tells if a value v is of the type t. Returns false if v or t are null.
--static function parseFloat(x:String):Float
--Converts a String to a Float.
--The parsing rules for parseInt apply here as well, with the exception of invalid input resulting in a NaN value instead of null.
--Additionally, decimal notation may contain a single . to denote the start of the fractions.
function Std.is( v, t )
	return nil -- TODO
end
--static function parseInt(x:String):Null<Int>
--Converts a String to an Int.
--Leading whitespaces are ignored.
--If x starts with 0x or 0X, hexadecimal notation is recognized where the following digits may contain 0-9 and A-F.
--Otherwise x is read as decimal number with 0-9 being allowed characters. x may also start with a - to denote a negative value.
--In decimal mode, parsing continues until an invalid character is detected, in which case the result up to that point is returned. For hexadecimal notation, the effect of invalid characters is unspecified.
--Leading 0s that are not part of the 0x/0X hexadecimal notation are ignored, which means octal notation is not supported.
--If the input cannot be recognized, the result is null.
function Std.string( x )
	return nil -- TODO
end
--static function random(x:Int):Int
--Return a random integer between 0 included and x excluded.
--If x <= 1, the result is always 0.
function Std.random( x )
	if x <= 1 then return 0 end
	return 0 -- TODO
end
-- String class

String = {}
String_String = String

local __StringMeta = getmetatable('')
function __StringMeta.__add(a,b) return a .. b end

__StringMeta.__index = function (str, p)
	if (p == "length") then
		return string.len(str) -- var length:Int
	--elseif (tonumber(p) == p) then -- no String indexing avalable in Haxe
	--	return string.sub(str, p+1, p+1)
	else
		return String[p]
	end
end

-- optimize lookup
local __string_sub = string.sub
local __string_byte = string.byte
local __string_find = string.find

-- just easy
-- http://lua-users.org/wiki/StringLibraryTutorial
String.fromCharCode = string.char -- static Int -> String
String.substring = string.sub -- Int -> ?Int -> String
String.toLowerCase = string.lower --> String
String.toUpperCase = string.upper --> String

-- some useless
function String.new(string) -- static String -> String (not Void)
	return string
end

function String:toString() --> String
	return self
end

-- complex funcs
function String:charAt(index) -- Int -> String
	return __string_sub(self, index+1, index+1)
end

function String:charCodeAt(index) -- Int -> Null<Int>
	return __string_byte(__string_sub(self, index+1, index+1))
end

function String:indexOf(str, startIndex) -- String -> ?Int -> Int
	local r = string.find(self, str, startIndex)
  return r and (r - 1) or -1
end

-- TODO startIndex
function String:lastIndexOf(str, startIndex) -- String -> ?Int -> Int
	local i, j
    local k = 0
    repeat
        i = j
        j, k = __string_find(self, str, k + 1, true)
    until j == nil

    return (i or 0) - 1
end

-- http://lua-users.org/wiki/SplitJoin
function String:split(delimiter) -- String -> Array<String>
--Splits this String at each occurence of delimiter.
--If this String is the empty String "", the result is not consistent across targets and may either be [] (on Js, Cpp) or [""].
--If delimiter is the empty String "", this String is split into an Array of this.length elements, where the elements correspond to the characters of this String.
--If delimiter is not found within this String, the result is an Array with one element, which equals this String.
--If delimiter is null, the result is unspecified.
--Otherwise, this String is split into parts at each occurence of delimiter. If this String starts (or ends) with [delimiter}, the result Array contains a leading (or trailing) empty String "" element. Two subsequent delimiters also result in an empty String "" element.
local t, ll
local d = delimiter
local p = self
  t={}
  ll=0
  if(#p == 1) then return {p} end
    while true do
      l=string.find(p,d,ll,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end

function String:substr(pos, len) -- Int -> ?Int -> String
	return len and __string_sub(self, pos+1, pos+len)
  or __string_sub(self, pos+1)
end

-- temporal fix
HxOverrides_HxOverrides = HxOverrides_HxOverrides or {}
HxOverrides_HxOverrides.substr = String.substr
HxOverrides_HxOverrides.cca = String.charCodeAt

-- TEST
--S = "Returns a String"
--print(S)
--print(S.length)
--print(S:toLowerCase())
--print(S:toUpperCase())
--print(S:substring(8))
--print(S:substr(8,1))
--print(String.fromCharCode(65))
--print(S:charAt(5))
--print(S:charCodeAt(5))
--print(S:indexOf(" a "))
--print(S:lastIndexOf(" a "))
--print(S:lastIndexOf(" aa "))
--print(S:split(" "))--
-- base Object class
Object = {}
Object.__index = Object;
function Object.__tostring(o)
    --return table_print(v) --JSON:encode(v)
    local s = "{ "
    function prv(n,v)
    	s = s + n + ": " + v
    end
    local first = true
    for key, value in pairs (o) do
    	prv(first and key or (", " + key),value)
    	first = false
    end	
    return s + " }"
end
-- Array class http://api.haxe.org/Array.html
HaxeArray = {}
--HaxeArray.__index = HaxeArray;
--__inherit(HaxeArray, Object);

--HaxeArray.__index = function(self, i)
--	return __ternar(type(x) == "number",self[i+1],self[i])
--end;

--[[
var length:Int
function new():Void
function concat(a:Array<T>):Array<T>
function copy():Array<T>
function filter(f:T ->Bool):Array<T>
function indexOf(x:T, ?fromIndex:Int):Int
function insert(pos:Int, x:T):Void
function iterator():Iterator<T>
function join(sep:String):String
function lastIndexOf(x:T, ?fromIndex:Int):Int
function map<S>(f:T ->S):Array<S>
function pop():Null<T>
function push(x:T):Int
function remove(x:T):Bool
function reverse():Void
function shift():Null<T>
function slice(pos:Int, ?end:Int):Array<T>
function sort(f:T ->T ->Int):Void
function splice(pos:Int, len:Int):Array<T>
function toString():String
function unshift(x:T):Void
]]

--local HaxeArrayMeta;

--if(table.getn)then
--if(false)then	
--arr_mt = {
--	__index = function (arr, p)
--		if (p == "length") then
--			if arr[0] then return table.getn(arr) + 1 end
--			return table.getn(arr)
--		else
--			return HaxeArray[p]
--		end
--	end
--}
--else 
HaxeArrayMeta = {
	__index = function (arr, p)
		if (p == "length") then
			if arr[0] then return #arr + 1 end
			return #arr
		else
			return HaxeArray[p]
		end
	end
}
--end

function __Array(r) 
	return setmetatable(r, HaxeArrayMeta)--HaxeArray)
end

function Array()
	return __Array({})
end

function HaxeArray.push(ths, elem)
	--table.insert(ths, #ths+1, elem)
	--return ths.length
	local length = #ths
	table.insert(ths, length+1, elem)
	return length
end

function HaxeArray.__tostring(o)
    --return table_print(v) --JSON:encode(v)
    local s = "[ "
    function prv(v)
    	s = s + v
    end
    local first = true
    for key, value in pairs (o) do
    	prv(first and value or (", " + value))
    	first = false
    end	
    return s + " ]"
end

HaxeArrayMeta.__tostring = HaxeArray.__tostring;
-- abstract (non-abstract in Lua) class Map http://api.haxe.org/Map.html

-- TODO
--[[
function exists(k:K):Bool
function get(k:K):Null<V>
function iterator():Iterator<V>
function keys():Iterator<K>
function remove(k:K):Bool
function set(k:K, v:V):Void
function toString():String
]]
HaxeMap = {}
__inherit(HaxeMap, Object);
HaxeMap.__index = HaxeMap;
function HaxeMap.Map()
	local r = {}
	setmetatable(r, HaxeMap) 
	return r
end

function HaxeMap:get(self, key)
	return self[key]
end

function HaxeMap:set(self, key, value)
	self[key] = value
end

function HaxeMap:iterator(self)
	return pairs(self)
end

function HaxeMap:keys(self)
	return pairs(self)
end

haxe_ds_IntMap_IntMap = HaxeMap
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
exec()
Main_Main.main()
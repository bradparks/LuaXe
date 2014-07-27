// Copyright 2011 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package benchmark;
//======================================================
// Main Algorithm
//======================================================

typedef IntHash<T> = Map<Int, T>;

class BasicBlockEdge
{
	public function new(cfg:MaoCFG, from_name:Int, to_name:Int)
	{
		from_ = cfg.CreateNode(from_name);
		to_ = cfg.CreateNode(to_name);
		from_.AddOutEdge(to_);
		to_.AddInEdge(from_);
		cfg.AddEdge(this);
	}

	public var from_:BasicBlock;
	public var to_:BasicBlock;
}

typedef EdgeVector = Array<BasicBlock>;

// BasicBlock only maintains a vector of in-edges and
// a vector of out-edges.
//
class BasicBlock
{
	public function new(name:Int)
	{
		in_edges_ = new EdgeVector();
		out_edges_ = new EdgeVector();
		name_ = name;
	}

	public inline function GetNumPred() { return in_edges_.length; }
	public inline function GetNumSucc() { return out_edges_.length; }

	public inline function AddOutEdge(to) { out_edges_.push(to); }
	public inline function AddInEdge(from) { in_edges_.push(from); }

	public var in_edges_(default,null):EdgeVector;
	public var out_edges_(default,null):EdgeVector;
	public var name_(default,null):Int;
}

typedef  NodeMap = IntHash<BasicBlock>;
typedef EdgeList = Array<BasicBlockEdge>;

// MaoCFG maintains a list of nodes.
//
class MaoCFG
{
	var basic_block_map_:NodeMap;
	var start_node_:BasicBlock;
	var edge_list_:EdgeList;
	var node_count:Int;

	public function new()
	{
	  node_count = 0;
	  basic_block_map_ = new NodeMap();
	  edge_list_ = new EdgeList();
	}

	public function CreateNode(name:Int):BasicBlock
	{
		var first = node_count == 0;
		var node = basic_block_map_.get(name);

		if (node == null)
		{
			node = new BasicBlock(name);
			basic_block_map_.set(name,node);
			node_count++;
		}
		if (first) start_node_ = node;
		return node;
	}

	public inline function GetNumNodes() { return node_count; }

	public inline  function AddEdge(edge) { edge_list_.push(edge); }

	public inline function GetStartBasicBlock() { return start_node_; }

	public inline function GetDst(edge:BasicBlockEdge) { return edge.to_; }

	public inline function GetSrc(edge:BasicBlockEdge) { return edge.from_; }

	public inline function  GetBasicBlocks() { return basic_block_map_; }
}

//
//--- MOCKING CODE end  -------------------

//
// SimpleLoop
//
// Basic representation of loops, a loop has an entry point,
// one or more exit edges, a set of basic blocks, and potentially
// an outer loop - a "parent" loop.
//
// Furthermore, it can have any set of properties, e.g.,
// it can be an irreducible loop, have control flow, be
// a candidate for transformations, and what not.
//
//

typedef BasicBlockSet = Array<BasicBlock>;
typedef SimpleLoopSet =  Array<SimpleLoop>;

class SimpleLoop
{
	public function new()
	{
		is_root_ = false;
		nesting_level_ = 0;
		depth_level_ = 0;
		basic_blocks_ = new BasicBlockSet();
		children_ = new SimpleLoopSet();
	}

	public function AddNode(basic_block)
	{
		for(b in basic_blocks_)
		   if (b==basic_block)
			  return;
		basic_blocks_.push(basic_block);
	}

	public function AddChildLoop(loop)
	{
		for(c in children_)
			if (c==loop)
			   return;
		children_.push(loop);
	}

	public function Dump() {
		// Simplified for readability purposes.
		trace("loop-" + counter_ + ", nest: " + nesting_level_ + ", depth: " + depth_level_ );
	}

	inline public function GetChildren() { return children_; }

	// Getters/Setters
	inline public function parent() { return parent_; }
	inline public function nesting_level() { return nesting_level_; }
	inline public function depth_level() { return depth_level_; }
	inline public function counter() { return counter_; }
	inline public function is_root() { return is_root_; }

	public function set_parent(parent:SimpleLoop)
	{
		parent_ = parent;
		parent.AddChildLoop(this);
	}

	inline public function set_is_root() { is_root_ = true; }
	inline public function set_counter(value) { counter_ = value; }
	inline public function set_nesting_level(level) {
		nesting_level_ = level;
		if (level == 0)
		  set_is_root();
	}
	inline public function set_depth_level(level) { depth_level_ = level; }

	var basic_blocks_:BasicBlockSet;
	var children_:SimpleLoopSet;
	var parent_:SimpleLoop;

	var is_root_ : Bool;
	var counter_ : Int;
	var nesting_level_ : Int;
	var depth_level_ : Int;
}

//
// LoopStructureGraph
//
// Maintain loop structure for a given CFG.
//
// Two values are maintained for this loop graph, depth, and nesting level.
// For example:
//
// loop        nesting level    depth
//----------------------------------------
// loop-0      2                0
//   loop-1    1                1
//   loop-3    1                1
//     loop-2  0                2
//
typedef LoopList = Array<SimpleLoop>;

class LoopStructureGraph
{
	public function new()
	{
		root_ = new SimpleLoop();
		loops_ = new LoopList();
		loop_counter_ = 0;
		root_.set_nesting_level(0);  // make it the root node
		root_.set_counter(loop_counter_++);
		AddLoop(root_);
	}

	public function CreateNewLoop()
	{
		var loop = new SimpleLoop();
		loop.set_counter(loop_counter_++);
		return loop;
	}

	inline public function  AddLoop(loop) { loops_.push(loop); }

	public function Dump() { DumpRec(root_, 0); }

	public function DumpRec(loop:SimpleLoop, indent:Int) {
	// Simplified for readability purposes.
	loop.Dump();

	for(c in loop.GetChildren() )
	  DumpRec(c,  indent+1);
	}

	public function CalculateNestingLevel()
	{
	// link up all 1st level loops to artificial root node.
	for (loop in loops_)
	{
	  if (loop.is_root()) continue;
	  if (loop.parent()==null) loop.set_parent(root_);
	}

	// recursively traverse the tree and assign levels.
	CalculateNestingLevelRec(root_, 0);
	}


	function CalculateNestingLevelRec(loop:SimpleLoop, depth:Int)
	{
	loop.set_depth_level(depth);
	for( c in loop.GetChildren())
	{
	  CalculateNestingLevelRec(c, depth+1);

	  var loop_level =  loop.nesting_level();
	  var c_level = c.nesting_level()+1;
	  if (c_level>loop_level)
		 loop.set_nesting_level(c_level);
	}
	}

	inline public function GetNumLoops() { return loops_.length; }

	inline public function root() { return root_; }

	var  root_:SimpleLoop;
	var  loops_:LoopList;
	var  loop_counter_:Int;
}
//
// Union/Find algorithm after Tarjan, R.E., 1983, Data Structures
// and Network Algorithms.
//
class UnionFindNode
{
	public function new(bb:BasicBlock,  dfs_number:Int)
	{
		dfs_number_ = 0;
		parent_     = this;
		bb_         = bb;
		dfs_number_ = dfs_number;
	}

	// Union/Find Algorithm - The find routine.
	//
	// Implemented with Path Compression (inner loops are only
	// visited and collapsed once, however, deep nests would still
	// result in significant traversals).
	//
	public function FindSet() : UnionFindNode {
	var nodeList = new NodeList();

		var node = this;
		while (node != node.parent_) {
		  if (node.parent_ != node.parent_.parent_)
			nodeList.push(node);
		  node = node.parent_;
		}
	
		// Path Compression, all nodes' parents point to the 1st level parent.
		var p = node.parent_;
		for(n in nodeList)
		   n.set_parent(p);
	
		return node;
	}

	// Union/Find Algorithm - The union routine.
	//
	// We rely on path compression.
	//
	public inline function Union(B:UnionFindNode) { set_parent(B); }


	// Getters/Setters
	//
	public inline function parent() { return parent_; }
	public inline function bb() { return bb_; }
	public inline function loop() { return loop_; }
	public inline function dfs_number() { return dfs_number_; }

	public inline function  set_parent(parent:UnionFindNode) { parent_ = parent; }
	public inline function  set_loop(loop:SimpleLoop) { loop_ = loop; }

	var parent_:UnionFindNode;
	var bb_(default,null):BasicBlock;
	var loop_:SimpleLoop;
	var dfs_number_:Int;
}
//------------------------------------------------------------------
// Loop Recognition
//
// based on:
//   Paul Havlak, Nesting of Reducible and Irreducible Loops,
//      Rice University.
//
//   We avoid doing tree balancing and instead use path compression
//   to avoid traversing parent pointers over and over.
//
//   Most of the variable names and identifiers are taken literally
//   from this paper (and the original Tarjan paper mentioned above).
//-------------------------------------------------------------------
typedef IntVector = Array<Int>;
typedef NodeVector = Array<UnionFindNode>;
typedef BasicBlockMap = IntHash<Int>;
typedef IntSet = IntHash<Int>;
typedef IntSetVector = Array<IntSet>;
typedef IntList = Array<Int>;
typedef IntListVector = Array<IntList>;
typedef NodeList = Array<UnionFindNode>;

class MaoLoops
{
	public function new(cfg:MaoCFG, lsg:LoopStructureGraph)
	{
		CFG_= cfg;
		lsg_ = lsg;
	}

	static inline var BB_TOP=0;          // uninitialized
	static inline var BB_NONHEADER=1;    // a regular BB
	static inline var BB_REDUCIBLE=2;    // reducible loop
	static inline var BB_SELF=3;         // single BB loop
	static inline var BB_IRREDUCIBLE=4;  // irreducible loop
	static inline var BB_DEAD=5;         // a dead BB
	static inline var BB_LAST=6;         // Sentinel

	//
	// Constants
	//
	// Marker for uninitialized nodes.
	static inline var kUnvisited = -1;
	// Safeguard against pathologic algorithm behavior.
	static inline var kMaxNonBackPreds = (32*1024);//(32*1024);

	//
	// Local types used for Havlak algorithm, all carefully
	// selected to guarantee minimal complexity.
	//
	//typedef std::vector<UnionFindNode>          NodeVector;
	//typedef std::map<BasicBlock*, int>          BasicBlockMap;
	//typedef std::vector<int>                    IntVector;
	//typedef std::vector<char>                   CharVector;

	//
	// IsAncestor
	//
	// As described in the paper, determine whether a node 'w' is a
	// "true" ancestor for node 'v'.
	//
	// Dominance can be tested quickly using a pre-order trick
	// for depth-first spanning trees. This is why DFS is the first
	// thing we run below.
	//
	static inline function  IsAncestor(w:Int, v:Int, last:IntVector) : Bool {
		return ((w <= v) && (v <= last[w]));
	}

	//
	// DFS - Depth-First-Search
	//
	// DESCRIPTION:
	// Simple depth first traversal along out edges with node numbering.
	//
	function DFS(current_node : BasicBlock,
		  nodes : NodeVector,
		  number : BasicBlockMap,
		  last : IntVector,
		  current:Int ) : Int
	{
		nodes[current] = new UnionFindNode(current_node, current);
		number.set(current_node.name_,current);

		var lastid = current;
		for(target in current_node.out_edges_)
		{
		  if (number.get(target.name_) == kUnvisited)
			lastid = DFS(target, nodes, number, last, lastid + 1);
		}
		last[number.get(current_node.name_) ] = lastid;
		return lastid;
	}

	//
	// FindLoops
	//
	// Find loops and build loop forest using Havlak's algorithm, which
	// is derived from Tarjan. Variable names and step numbering has
	// been chosen to be identical to the nomenclature in Havlak's
	// paper (which is similar to the one used by Tarjan).
	//
	function FindLoops()
	{
		if (CFG_.GetStartBasicBlock()==null) return;

		var                size = CFG_.GetNumNodes();
		if (size<1)
		   return;

		var non_back_preds = new IntSetVector();
		non_back_preds[size-1] = null;

		var back_preds = new IntListVector();
		back_preds[size-1] = null;
		for(i in 0...size)
		{
		   non_back_preds[i] = new IntSet();
		   back_preds[i] = new IntList();
		}

		var header = new IntVector();
		header[size-1] = 0;

		var type = new IntVector();
		type[size-1] = 0;

		var last = new IntVector();
		last[size-1] = 0;
		var nodes = new NodeVector();
		var  number = new BasicBlockMap();

		// Step a:
		//   - initialize all nodes as unvisited.
		//   - depth-first traversal and numbering.
		//   - unreached BB's are marked as dead.
		//
		for (block in CFG_.GetBasicBlocks() )
		   number.set(block.name_,kUnvisited);

		DFS(CFG_.GetStartBasicBlock(), nodes, number, last, 0);

		// Step b:
		//   - iterate over all nodes.
		//
		//   A backedge comes from a descendant in the DFS tree, and non-backedges
		//   from non-descendants (following Tarjan).
		//
		//   - check incoming edges 'v' and add them to either
		//     - the list of backedges (back_preds) or
		//     - the list of non-backedges (non_back_preds)
		//
		for (w in 0...size)
		{
		  header[w] = 0;
		type[w] = BB_NONHEADER;

		var node_w = nodes[w].bb();
		if (node_w==null) {
			type[w] = BB_DEAD;
			continue;  // dead BB
		}

		if (node_w.GetNumPred()!=0) {
			for (node_v in node_w.in_edges_) {
			  var v:Int = number.get( node_v.name_ );
			  if (v == kUnvisited) continue;  // dead node

			  if (IsAncestor(w, v, last))
				back_preds[w].push(v);
			  else
				non_back_preds[w].set(v,v);
			}
		}
	}

	// Start node is root of all other loops.
	header[0] = 0;

	// Step c:
	//
	// The outer loop, unchanged from Tarjan. It does nothing except
	// for those nodes which are the destinations of backedges.
	// For a header node w, we chase backward from the sources of the
	// backedges adding nodes to the set P, representing the body of
	// the loop headed by w.
	//
	// By running through the nodes in reverse of the DFST preorder,
	// we ensure that inner loop headers will be processed before the
	// headers for surrounding loops.
	//
	var w = size-1;
	while( w >= 0) {
	  var node_pool = new NodeList();  // this is 'P' in Havlak's paper
	  var node_w = nodes[w].bb();
	  if (node_w==null) { --w; continue; } // dead BB

	  // Step d:
	  for (v in back_preds[w]) {
		if (v != w)
		  node_pool.push(nodes[v].FindSet());
		else
		  type[w] = BB_SELF;
	  }

	  // Copy node_pool to worklist.
	  //
	  var worklist = node_pool.copy();
	  if (node_pool.length<1)
		type[w] = BB_REDUCIBLE;

	  // work the list...
	  var jobs = worklist.length;
	  while (jobs>0) {
		var x = worklist[--jobs];

		// Step e:
		//
		// Step e represents the main difference from Tarjan's method.
		// Chasing upwards from the sources of a node w's backedges. If
		// there is a node y' that is not a descendant of w, w is marked
		// the header of an irreducible loop, there is another entry
		// into this loop that avoids w.
		//

		// The algorithm has degenerated. Break and
		// return in this case.
		//
		var non_back_size = 0;
		for (i in non_back_preds[x.dfs_number()].keys() )
		{
		  non_back_size++;
		  if (non_back_size > kMaxNonBackPreds) return;

		  var  y     = nodes[i];
		  var ydash = y.FindSet();

		  if (!IsAncestor(w, ydash.dfs_number(), last)) {
			type[w] = BB_IRREDUCIBLE;
			non_back_preds[w].set(ydash.dfs_number(),ydash.dfs_number());
		  } else {
			if (ydash.dfs_number() != w) {
			  var found = false;
			  for(n in node_pool)
				 if (n==ydash)
				 {
					found = true;
					break;
				 }

			  if (!found) {
				worklist[++jobs] = ydash;
				node_pool.push(ydash);
			  }
			}
		  }
		}
	  }

	  // Collapse/Unionize nodes in a SCC to a single node
	  // For every SCC found, create a loop descriptor and link it in.
	  //
	  if (node_pool.length>0 || (type[w] == BB_SELF)) {
		var loop = lsg_.CreateNewLoop();

		// At this point, one can set attributes to the loop, such as:
		//
		// the bottom node:
		//    IntList::iterator iter  = back_preds[w].begin();
		//    loop bottom is: nodes[*backp_iter].node);
		//
		// the number of backedges:
		//    back_preds[w].size()
		//
		// whether this loop is reducible:
		//    type[w] != BB_IRREDUCIBLE
		//
		// TODO(rhundt): Define those interfaces in the Loop Forest.
		//
		nodes[w].set_loop(loop);

		for(node in node_pool) {
		  // Add nodes to loop descriptor.
		  header[node.dfs_number()] = w;
		  node.Union(nodes[w]);

		  // Nested loops are not added, but linked together.
		  if (node.loop()!=null)
			node.loop().set_parent(loop);
		  else
			loop.AddNode(node.bb());
		}

		lsg_.AddLoop(loop);
	  }  // node_pool.size
		 --w;
		}  // Step c
	}  // FindLoops

	var CFG_:MaoCFG;      // current control flow graph.
	var lsg_:LoopStructureGraph;      // loop forest.

	public function run()
	{
		FindLoops();
		return lsg_.GetNumLoops();
	}
}
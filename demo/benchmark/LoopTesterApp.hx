package benchmark;
import benchmark.MaoLoops;

class LoopTesterApp
{
	static function buildDiamond(cfg:MaoCFG,start:Int)
	{
		var bb0 = start;

		new BasicBlockEdge(cfg, bb0, bb0 + 1);
		new BasicBlockEdge(cfg, bb0, bb0 + 2);
		new BasicBlockEdge(cfg, bb0 + 1, bb0 + 3);
		new BasicBlockEdge(cfg, bb0 + 2, bb0 + 3);
		
		return bb0 + 3;
	}

	inline static function buildConnect(cfg:MaoCFG, start:Int, end:Int) { new BasicBlockEdge(cfg, start, end); }

	static function buildStraight(cfg, start, n)
	{
		for(i in 0...n)
			buildConnect(cfg, start + i, start + i + 1);
		return start + n;
	}

	static function buildBaseLoop(cfg,from)
	{
		var header = buildStraight(cfg, from, 1);
		var diamond1 = buildDiamond(cfg, header);
		var d11 = buildStraight(cfg, diamond1, 1);
		var diamond2 = buildDiamond(cfg, d11);
		var footer = buildStraight(cfg, diamond2, 1);
		buildConnect(cfg, diamond2, d11);
		buildConnect(cfg, diamond1, header);

		buildConnect(cfg, footer, from);
		footer = buildStraight(cfg, footer, 1);
		return footer;
	}

	static inline function print(inStr:String)
	{
		trace(inStr);
	}

	public static function main()
	{
		var d = Date.now().getTime();
		var cfg = new MaoCFG();
		var lsg = new LoopStructureGraph();
		
		cfg.CreateNode(0);  // top
		buildBaseLoop(cfg, 0);
		cfg.CreateNode(1);  // bottom
		new BasicBlockEdge(cfg, 0,  2);
		
		for(dummyloops in 0...300) {
			var lsglocal = new LoopStructureGraph();
			new MaoLoops(cfg, lsglocal).run();
		}
		
		var n = 2;
   
		for(parlooptrees in 0...10) {
			cfg.CreateNode(n + 1);
			buildConnect(cfg, 2, n + 1);
			n = n + 1;
				for(i in 0...100) {
				var top = n;
				n = buildStraight(cfg, n, 1);
				for(j in 0...25) {
					n = buildBaseLoop(cfg, n);
				}
				var bottom = buildStraight(cfg, n, 1);
				buildConnect(cfg, n, top);
				n = bottom;
			}
			buildConnect(cfg, n, 1);
		}
   }
}
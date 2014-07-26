package ;

class TestLoops
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestLoops begin");

		for(i in 0...1000)
		{
			var x = 1;
		}

		if(!perf) trace("TestLoops end");
	}
}
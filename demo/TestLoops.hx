package ;

class TestLoops
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestLoops begin");
		var y = 0;

		// for
		for(i in 0...10)
		{
			var x = 1;
			y++;
		}

		// while & nested
		var x = 0;
		while(x < 10) {
			x++;
			for(i in 0...10)
			{
				var x = 1;
				for(i in 0...10)
				{
					var x = 1;
					y++;
				}
			}
			for(i in 0...10)
			{
				var x = 1;
				for(i in 0...10)
				{
					var x = 1;
					y++;
				}
			}
		}

		// TODO for in array

		if(!perf) trace("TestLoops end");
		return y;
	}
}
package ;

import Date;
import DateTools;

class TestExceptions
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestExceptions begin");

		var x:TestExceptions = null;

		try {
			x.tryMe();
		} 
		catch(e:TestExceptions)
		{
			if(!perf) trace("<TestExceptions> Exception here! " + e);
		} 
		catch(e:Dynamic)
		{
			if(!perf) trace("Exception here!");
			if(!perf) trace("Info: " + e);
		}

		if(!perf) trace("TestExceptions end");
	}
	public function tryMe() return 0;
}
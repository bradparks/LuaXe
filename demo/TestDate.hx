package ;

import Date;
import DateTools;

class TestDate
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestDate begin");

		var d = Date.now();
		trace(d.toString());
		var x = d.getTime();
		trace(x);
		trace(Date.fromTime(d).toString());
		trace(Date.fromTime(DateTools.makeUtc(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), d.getMinutes(), d.getSeconds())).toString());

		if(!perf) trace("TestDate end");
	}
}
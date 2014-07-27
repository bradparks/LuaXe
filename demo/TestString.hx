package ;

class TestString 
{
	// compared to JS/V8/NodeJS
	private static var _perf:Bool;

	private static function eq(text, bool:Bool)
	{
		if(!bool && !_perf) trace(text + " failed");
	}

	public static function test(perf = false)
	{
		_perf = perf;
		if(!perf) trace("TestString begin");

		var S = "Returns a String _!@#$%^&*()1234567890-=/*[]{}";
		eq("eq", S == "Returns a String _!@#$%^&*()1234567890-=/*[]{}");
		eq("length", S.length == 46);
		///*SLOW*/ eq("toLowerCase", S.toLowerCase() == "returns a string _!@#$%^&*()1234567890-=/*[]{}");
		///*SLOW*/ eq("toUpperCase", S.toUpperCase() == "RETURNS A STRING _!@#$%^&*()1234567890-=/*[]{}");
		eq("substring", S.substring(8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
		eq("substr", S.substr(8,1) == "a");
		eq("substring a,b", S.substring(8,10) == "a ");
		eq("substr a,b", S.substr(8,1) == "a");
		eq("substr", S.substr(8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
		eq("fromCharCode", String.fromCharCode(65) == "A");
		eq("charAt", S.charAt(5) == "n");
		eq("charCodeAt", S.charCodeAt(5) == 110);
		
		///*SLOW*/ eq("indexOf", S.indexOf(" a ") == 7);
		///*SLOW*/ eq("indexOf", S.indexOf(" @ ") == -1);

		///*SLOW*/ eq("lastIndexOf", S.lastIndexOf(" a ") == 7);
		///*SLOW*/ eq("lastIndexOf", S.lastIndexOf(" aa ") == -1);
		///*SLOW*/ eq("split", S.split(" ").length == 4);

		if(!perf) trace("TestString end");
	}
}
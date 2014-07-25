package ;

class TestString 
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestString begin");

		function test(text, bool:Bool)
		{
			if(!bool && !perf) trace(text + " failed");
		}

		var S = "Returns a String _!@#$%^&*()1234567890-=/*[]{}";
		test("eq", S == "Returns a String _!@#$%^&*()1234567890-=/*[]{}");
		test("length", S.length == 46);
		test("toLowerCase", S.toLowerCase() == "returns a string _!@#$%^&*()1234567890-=/*[]{}");
		test("toUpperCase", S.toUpperCase() == "RETURNS A STRING _!@#$%^&*()1234567890-=/*[]{}");
		test("substring", S.substring(8) == "a String _!@#$%^&*()1234567890-=/*[]{}");
		test("substr", S.substr(8,1) == "a");
		test("fromCharCode", String.fromCharCode(65) == "A");
		test("charAt", S.charAt(5) == "n");
		test("charCodeAt", S.charCodeAt(5) == 110);
		test("indexOf", S.indexOf(" a ") == 7);
		test("lastIndexOf", S.lastIndexOf(" a ") == 7);
		test("lastIndexOf", S.lastIndexOf(" aa ") == -1);
		test("split", S.split(" ").length == 4);

		if(!perf) trace("TestString end");
	}
}
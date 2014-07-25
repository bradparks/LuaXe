package ;

class TestFuncs
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestFuncs begin");

		var none22 = 0;
		// useless function
		function none(){}
		// simple func
		function none2(){none();var none22 = 0;}
		// nested
		function none3(){
			function none(){}
			function none2(){none();}
		}
		// closure
		function none4(){
			var x = 0;
			function none(){
				x++;
				function none3(){
					function none(){}
					function none2(){none();}
				}
				none3();
			}
			function none2(){
				none();
				x++;
			}
			none();
			none2();
			if(!perf) trace(x == 3);
		}

		// to var
		var fx = function() return 0;
		// result to var
		// TODO var f = (function (){none();return 5;})() == 5;
		// exec them
		none();
		none2();
		none3();
		none4();

		if(!perf) trace("TestFuncs end");
	}
}
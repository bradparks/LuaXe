package ;

class TestIfs
{
	// compared to JS/V8/NodeJS
	public static function test(perf = false)
	{
		if(!perf) trace("TestIfs begin");

		function none(){};

		var bool = true;

		// nothing to do
		if(bool){}
		if(!bool){}else{}
		if(!bool && bool){}
		if(!bool && bool || bool){}
		// chekin smart if-then-else
		if(bool){none();}
		if(bool){none();}else{}
		if(bool){}else{none();}
		if(bool){none();}else{none();}
		if(!bool && bool){none();}
		if(!bool && bool || bool){none();}
		// returns check
		function rr()
		{
			if(!bool){
				return ;
			}else{
				return ;
			}
			return ;
		}
		rr();
		function rr() // yeah, rr
		{
			if(bool){
				return 1;
			}else{
				return 2;
			}
			return 3;
		}
		rr();
		// nested
		if(bool){
			if(!bool){
				if(!bool && bool){}
			}else{
				if(!bool && bool || bool){}
			}
		}
		// nested + some code inside
		if(bool){
			none();
			if(bool){
				none();
			}else{
				if(bool){
					if(!bool && bool){
						if(bool){
							if(!bool && bool || bool){
								none();
							}
							none();
						}else{
							none();
						}
						none();
					}
				}else{
					none();
				}
			}
		}
		// etc
		var z = 5 + 5;
		var x = 0;
        if ( z > 2)	{
        	x = 7;
        } else {
        	x = 10;
        }
		// switch
		var v:Int = Math.round(Math.random() * 100);
		switch( v ) {
    	case 0:
    	    {};
    	case 1:// TODO foo(1):
    	    {};
    	case 65:
    	    {};
    	default:
    	    {};
    	}
		
		
		

		if(!perf) trace("TestIfs end");
	}
}
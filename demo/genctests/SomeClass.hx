package demo.genctests;

class SomeClass {
	public var state:String;
	
	public function new(s:String) {
		state = s;
		trace("SomeClass.new");
		trace(x);
	}
	
	public function getState() {
		return state;
	}
	
	public function setState(s) {
		return this.state = s;
	}
	
	var x = "123";
	public function getClosure(y:String) {
		trace("SomeClass.getClosure");
		trace(x);
		var f = function(z) {
			trace(x);
			return x+y+z;
		}
		return f;
	}

	public function invoke(f) {
		return f("678");
	}
}
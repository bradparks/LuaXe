(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Vehicle = function() {
	this.numberOfWheels = 0;
	this.maxPassengers = 1;
};
Vehicle.prototype = {
	description: function() {
		return "" + this.numberOfWheels + " wheels; up to " + this.maxPassengers + " passengers";
	}
};
var Bicycle = function() {
	Vehicle.call(this);
	this.numberOfWheels = 2;
};
Bicycle.__super__ = Vehicle;
Bicycle.prototype = $extend(Vehicle.prototype,{
});
var Tandem = function() {
	Bicycle.call(this);
	this.maxPassengers = 2;
};
Tandem.__super__ = Bicycle;
Tandem.prototype = $extend(Bicycle.prototype,{
});
var Car = function() {
	this.speed = 0.0;
	Vehicle.call(this);
	this.maxPassengers = 5;
	this.numberOfWheels = 4;
};
Car.stat = function() {
	console.log("static called");
};
Car.__super__ = Vehicle;
Car.prototype = $extend(Vehicle.prototype,{
	description: function() {
		return "; traveling at " + this.speed + " mph";
	}
});
var Main = function() { };
Main.main = function() {
	console.log("go -->");
	var d = new Date().getTime();
	Car.stat();
	var someVehicle = new Vehicle();
	console.log("Vehicle: " + someVehicle.description());
	var bicycle = new Bicycle();
	console.log("Bicycle: " + bicycle.description());
	var tandem = new Tandem();
	console.log(tandem);
	console.log("Tandem: " + tandem.description());
	console.log("Car: " + new Car().description());
	var arr = [5,55,555];
	var arr2 = ["a","b","c"];
	console.log(arr);
	console.log(arr[0]);
	arr.push(77);
	arr2.push("x");
	console.log(arr);
	var obj = { a : 2, b : 3};
	var b = { a : 2, b : 3};
	var factory = function() {
		return { a : 2, b : 3};
	};
	var count = 0;
	var x = 0;
	var _g = 0;
	while(_g < 100000) {
		var i = _g++;
		arr.push(i);
		arr2.push("i");
		obj = { a : 2, b : 3};
		b = factory();
		count += obj.a + b.b + arr.length;
	}
	var _g1 = 0;
	var _g2 = arr.length;
	while(_g1 < _g2) {
		var i1 = _g1++;
		count += arr[i1] + arr2.length;
		x++;
		++x;
		--x;
		x--;
	}
	console.log(count);
	console.log(arr.length);
	console.log(b);
	console.log(obj);
	console.log("[js] >");
	console.log("" + Std["int"](new Date().getTime() - d) + "ms");
	d = new Date().getTime();
	var _g3 = 0;
	while(_g3 < 100000) {
		var i2 = _g3++;
		x = 0;
		x++;
		++x;
		x--;
		--x;
	}
	console.log("LangPerfTest: " + Std["int"](new Date().getTime() - d) + "ms");
};
var Std = function() { };
Std["int"] = function(x) {
	return x | 0;
};
Main.main();
})();

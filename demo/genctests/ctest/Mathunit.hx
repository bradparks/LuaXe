package demo.genctests.ctest;
import demo.genctests.*;
class Mathunit
{
	public static function run() {
		// constants
		var zero = 0.0;
		var one = 1.0;
		//1.0 / zero == Math.POSITIVE_INFINITY;
		//-1.0 / zero == Math.NEGATIVE_INFINITY;
		trace((Math.NaN == Math.NaN) == false);
		trace(Math.isNaN(Math.NaN) == true);
		trace(Math.isNaN(Math.sqrt( -1)) == true);
		trace(Math.NEGATIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(Math.POSITIVE_INFINITY == Math.POSITIVE_INFINITY);
		// +
		trace(Math.POSITIVE_INFINITY + Math.POSITIVE_INFINITY == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY + Math.NEGATIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(Math.POSITIVE_INFINITY + one == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY + one == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.POSITIVE_INFINITY + Math.NEGATIVE_INFINITY) == true);
		trace(Math.isNaN(Math.POSITIVE_INFINITY + Math.NaN) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY + Math.NaN) == true);
		// -
		trace(one - Math.POSITIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(one - Math.NEGATIVE_INFINITY == Math.POSITIVE_INFINITY);
		trace(-Math.POSITIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(-Math.NEGATIVE_INFINITY == Math.POSITIVE_INFINITY);
		trace(Math.POSITIVE_INFINITY - one == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY - one == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.POSITIVE_INFINITY - Math.POSITIVE_INFINITY ) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY - Math.NEGATIVE_INFINITY) == true);
		trace(Math.POSITIVE_INFINITY - Math.NEGATIVE_INFINITY == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY - Math.POSITIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.POSITIVE_INFINITY - Math.NaN) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY - Math.NaN) == true);
		trace(Math.isNaN(Math.NaN - Math.POSITIVE_INFINITY) == true);
		trace(Math.isNaN(Math.NaN - Math.NEGATIVE_INFINITY) == true);
		// *
		trace(Math.POSITIVE_INFINITY * one == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY * one == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.POSITIVE_INFINITY * zero) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY * zero) == true);
		trace(Math.POSITIVE_INFINITY * Math.POSITIVE_INFINITY == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY * Math.NEGATIVE_INFINITY  == Math.POSITIVE_INFINITY);
		trace(Math.POSITIVE_INFINITY * Math.NEGATIVE_INFINITY == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.POSITIVE_INFINITY * Math.NaN) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY * Math.NaN) == true);
		// /
		trace(Math.POSITIVE_INFINITY / one == Math.POSITIVE_INFINITY);
		trace(Math.NEGATIVE_INFINITY / one == Math.NEGATIVE_INFINITY);
		//Math.POSITIVE_INFINITY / zero == Math.POSITIVE_INFINITY;
		//Math.NEGATIVE_INFINITY / zero == Math.NEGATIVE_INFINITY;
		trace(Math.isNaN(Math.POSITIVE_INFINITY / Math.POSITIVE_INFINITY) == true);
		trace(Math.isNaN(Math.POSITIVE_INFINITY / Math.NEGATIVE_INFINITY) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY / Math.POSITIVE_INFINITY) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY / Math.NEGATIVE_INFINITY) == true);
		trace(Math.isNaN(Math.NaN / Math.POSITIVE_INFINITY) == true);
		trace(Math.isNaN(Math.POSITIVE_INFINITY / Math.NaN) == true);
		trace(Math.isNaN(Math.NaN / Math.POSITIVE_INFINITY) == true);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY / Math.NaN) == true);
		
		// abs
		//Math.abs(-1.223) == 1.223;
		trace(Math.abs(1.223) == 1.223);
		trace(Math.abs(0) == 0);
		trace(Math.isNaN(Math.abs(Math.NaN)) == true);
		trace(Math.abs(Math.NEGATIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.abs(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		
		// min
		trace(Math.min(0.0, 1.0) == 0.0);
		trace(Math.min(0.0, -1.0) == -1.0);
		trace(Math.min(0.0, 0.0) == 0.0);
		trace(Math.min(1.0, 1.0) == 1.0);
		trace(Math.min(Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.min(Math.NEGATIVE_INFINITY, Math.POSITIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.min(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.min(Math.POSITIVE_INFINITY, zero) == zero);
		trace(Math.min(Math.NEGATIVE_INFINITY, zero) == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.min(Math.NEGATIVE_INFINITY, Math.NaN)) == true);
		trace(Math.isNaN(Math.min(Math.POSITIVE_INFINITY, Math.NaN)) == true);
		trace(Math.isNaN(Math.min(Math.NaN, Math.NaN)) == true);
		trace(Math.isNaN(Math.min(one, Math.NaN)) == true);
		trace(Math.isNaN(Math.min(zero, Math.NaN)) == true);
		trace(Math.isNaN(Math.min(Math.NaN, Math.NEGATIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.min(Math.NaN,Math.POSITIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.min(Math.NaN, one)) == true);
		trace(Math.isNaN(Math.min(Math.NaN, zero)) == true);
		
		// max
		trace(Math.max(0.0, 1.0) == 1.0);
		trace(Math.max(0.0, -1.0) == 0.0);
		trace(Math.max(0.0, 0.0) == 0.0);
		trace(Math.max(1.0, 1.0) == 1.0);
		trace(Math.max(Math.NEGATIVE_INFINITY, Math.NEGATIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.max(Math.NEGATIVE_INFINITY, Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.max(Math.POSITIVE_INFINITY, Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.max(Math.POSITIVE_INFINITY, zero) == Math.POSITIVE_INFINITY);
		trace(Math.max(Math.NEGATIVE_INFINITY, zero) == 0);
		trace(Math.isNaN(Math.max(Math.NEGATIVE_INFINITY, Math.NaN)) == true);
		trace(Math.isNaN(Math.max(Math.POSITIVE_INFINITY, Math.NaN)) == true);
		trace(Math.isNaN(Math.max(Math.NaN, Math.NaN)) == true);
		trace(Math.isNaN(Math.max(one, Math.NaN)) == true);
		trace(Math.isNaN(Math.max(zero, Math.NaN)) == true);
		trace(Math.isNaN(Math.max(Math.NaN, Math.NEGATIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.max(Math.NaN,Math.POSITIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.max(Math.NaN, one)) == true);
		trace(Math.isNaN(Math.max(Math.NaN, zero)) == true);
		
		// sin
		trace(Math.sin(0.0) == 0.0);
		trace(Math.sin(Math.PI / 2) == 1.0);
		trace(Math.sin(Math.PI) == 0.0);
		trace(Math.sin(Math.PI * 3 / 2) == -1.0);
		trace(Math.isNaN(Math.sin(Math.POSITIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.sin(Math.NEGATIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.sin(Math.NaN)) == true);
		
		// cos
		trace(Math.cos(0.0) == 1.0);
		trace(Math.cos(Math.PI / 2) == 0.0);
		trace(Math.cos(Math.PI) == -1.0);
		trace(Math.cos(Math.PI * 3 / 2) == 0.0);
		trace(Math.isNaN(Math.cos(Math.POSITIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.cos(Math.NEGATIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.cos(Math.NaN)) == true);
		
		// exp
		trace(Math.exp(0.0) == 1.0);
		trace(Math.exp(1.0) == 2.7182818284590452353602874713527);
		trace(Math.exp(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.exp(Math.NEGATIVE_INFINITY) == 0.0);
		trace(Math.isNaN(Math.exp(Math.NaN)) == true);
		
		// log
		trace(Math.log(0.0) == Math.NEGATIVE_INFINITY);
		trace(Math.log(2.7182818284590452353602874713527) == 1.0);
		trace(Math.isNaN(Math.log( -1.0)) == true);
		trace(Math.isNaN(Math.log(Math.NaN)) == true);
		trace(Math.isNaN(Math.log(Math.NEGATIVE_INFINITY)) == true);
		trace(Math.log(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		
		// exp + log
		var floats = [1.33, 39232.911, 12.0, -112.999992, 99999.99999, 0.0, Math.NEGATIVE_INFINITY, Math.POSITIVE_INFINITY];
		for (f in floats) {
			trace(Math.log(Math.exp(f)) == f);
		}
		
		// sqrt
		trace(Math.sqrt(4.0) == 2);
		trace(Math.sqrt(0.0) == 0.0);
		trace(Math.sqrt(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.isNaN(Math.sqrt(Math.NEGATIVE_INFINITY)) == true);
		trace(Math.isNaN(Math.sqrt(Math.NaN)) == true);
		trace(Math.isNaN(Math.sqrt( -1.0)) == true);
		
		// round
		trace(Math.round(0.0) == 0);
		trace(Math.round(0.1) == 0);
		trace(Math.round(0.4999) == 0);
		trace(Math.round(0.5) == 1);
		trace(Math.round(1.0) == 1);
		trace(Math.round(1.499) == 1);
		trace(Math.round(-0.1) == 0);
		trace(Math.round(-0.4999) == 0);
		trace(Math.round(-0.5) == 0);
		trace(Math.round(-0.50001) == -1);
		trace(Math.round(-1.0) == -1);
		trace(Math.round(-1.499) == -1);
		trace(Math.round(-1.5) == -1);
		trace(Math.round( -1.50001) == -2);
		trace(Math.fround(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.fround(Math.NEGATIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.fround(Math.NaN)) == true);
		
		// floor
		trace(Math.floor(0.0) == 0);
		trace(Math.floor(0.9999) == 0);
		trace(Math.floor(1.0) == 1);
		trace(Math.floor( -0.0001) == -1);
		trace(Math.floor( -1.0) == -1);
		trace(Math.floor( -1.0001) == -2);
		trace(Math.ffloor(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.ffloor(Math.NEGATIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.ffloor(Math.NaN)) == true);
		
		// ceil
		trace(Math.ceil(0.0) == 0);
		trace(Math.ceil(-0.9999) == 0);
		trace(Math.ceil(-1.0) == -1);
		trace(Math.ceil( 0.0001) == 1);
		trace(Math.ceil( 1.0) == 1);
		trace(Math.ceil( 1.0001) == 2);
		trace(Math.fceil(Math.POSITIVE_INFINITY) == Math.POSITIVE_INFINITY);
		trace(Math.fceil(Math.NEGATIVE_INFINITY) == Math.NEGATIVE_INFINITY);
		trace(Math.isNaN(Math.fceil(Math.NaN)) == true);
		
		// random
		// not much to test here...
		
		// isFinite
		trace(Math.isFinite(Math.POSITIVE_INFINITY) == false);
		trace(Math.isFinite(Math.NEGATIVE_INFINITY) == false);
		trace(Math.isFinite(Math.NaN) == false);
		trace(Math.isFinite(0.0) == true);
		
		// isNaN
		trace(Math.isNaN(Math.POSITIVE_INFINITY) == false);
		trace(Math.isNaN(Math.NEGATIVE_INFINITY) == false);
		trace(Math.isNaN(Math.NaN) == true);
		trace(Math.isNaN(0.0) == false);
	}
}
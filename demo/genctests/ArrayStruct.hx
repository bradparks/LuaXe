package demo.genctests;

class ArrayStruct
{
	public var _count:Int;
	public var constArray:Array<Int> = [];

	public static function createWithSize(size:Int):ArrayStruct
	{
		if (size <= 0) throw "<=";
		var ret:ArrayStruct = cast new ArrayStruct();
		ret._count = size;
		return ret;
	}
}
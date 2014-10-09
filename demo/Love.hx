
@:native("love.graphics") @dotpath
extern
class LoveGraphics {
	static public function setColor(r:Float, g:Float, b:Float, a:Float):Void;
}


class Main {
	static function main() {
		LoveGraphics.setColor(0, 0, 0, 0);
	}
}
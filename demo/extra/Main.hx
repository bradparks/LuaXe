@:keep class Main {
 @:keep static function main() {
  LoveGraphics.setColor(0, 0, 0, 0);
 }
}

@:native("love.graphics") @dotpath
@:keep extern 
class LoveGraphics {
 static public function setColor(r:Float, g:Float, b:Float, a:Float):Void {};
}
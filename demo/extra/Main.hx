@:keep class Main {
 @:keep static function main() {
  LoveGraphics.setColor(0, 0, 0, 0);
 }
}

@:native("love.graphics") extern class LoveGraphics {
 static function setColor(r:Float, g:Float, b:Float, a:Float):Void;
}
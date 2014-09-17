@:keep class Main {
 @:keep static function main() {
  //LoveGraphics.setColor(0, 0, 0, 0);
  var d = new Date(2012, 4, 25, 13, 3, 54);
  trace(d.getHours());
  var d = Date.now();
  trace(d);
  trace(d.getHours());
 }
}

@:native("love.graphics") @dotpath
@:keep extern 
class LoveGraphics {
 static public function setColor(r:Float, g:Float, b:Float, a:Float):Void {};
}
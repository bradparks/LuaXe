LuaXe
=====

Lua target for Haxe language

State: *pre-alpha*
=====
Primarily LuaJIT -> make super-optimized portable Haxe target!

I have some working *fast* (beats V8 and Neko) code otput.

**Note:** dont beleave benchmarks from *demo* folder, they show low performance just because of immature code generator. Manually tweaked code works really well. Happily, this process would be automated soon.

Require Haxe Compiler 3.1, Lua 5.2 or LuaJIT 2

Installation & Usage *it wont work for now, just template*
=====
Quick install:
```
haxelib git luaxe https://github.com/PeyTy/LuaXe.git
```
First, you need to set JS target in your HXML file: ```-js bin/hx.lua``` Note that you can set *.lua* file type. Than, add LuaXe lib: ```-lib luaxe``` Add LuaXe macro: ```--macro luaxe.LuaGenerator.use()``` Dont forget to add ```-D lua```.
Complete HXML file:
```
-cp src
-main Main
-D lua
-lib luaxe
-js bin/hx.lua
--macro luaxe.LuaGenerator.use()
-dce full
--connect 6000
```
(dce and connect is optional)

**Note:** in first compilation, it would download required *.lua* files to your project folder from Github. *Sorry, I dont know how to detect haxelib installation folder for now*

You can run your file just after compilation directly in stand-alone Lua environment:
```
-cmd /usr/local/bin/luajit bin/hx.lua
or:
-cmd /usr/local/bin/lua bin/hx.lua
```

Magic
=====
Untyped:
```haxe
untyped __lua__("_G.print('__lua__')");
untyped __call__(print, 1, 2, 3);
untyped __tail__(os, clock, 1, 2, "hi");
untyped __global__(print,'__lua__', 2);
```
```lua
_G.print('__lua__');
print(1, 2, 3);
os:clock(1, 2, "hi");
_G.print("__lua__", 2);
```
Meta`s:
```haxe
@:require("hello", "world")
class Main { ... }
```
```lua
require "hello" -- added to top of your lua file
require "world"
```

External Classes
=====
It is very easy to create external classes for LuaXe.
Create extern class definition:
```haxe
// placed inside root package TestExtern
extern class Extern {
	function new(x:Int);
	static function test():String;
	static var hi:String;
	function selfcall():String;
	var X:Int;
}
```
Create implementation of class in Lua that is fully compatible with OOP-style LuaXe API:
```lua
local Extern = {}
TestExtern_Extern = Extern -- setting proper namespace 
-- Another namespace? Use "_": namespace.TestExtern.Extern -> namespace_TestExtern_Extern
Extern.__index = Extern -- need for metatable
Extern.hi = "Hello!" -- static var

function Extern.new(x) -- constructor
	local self = { X = x } -- "X" is a class field
	setmetatable(self, Extern)
	return self
end

function Extern:selfcall() return self.X end -- public function
function Extern.test() return "static test" end -- static function
```
Everything works just as usual:
```haxe
// static:
trace(Extern.test());
trace(Extern.hi);
// fields:
var inst = new Extern(5);
trace(inst.selfcall());
trace(inst.X);
```

Links
=====
https://github.com/frabbit/hx2python
https://bitbucket.org/AndrewVernon/hx2dart
http://api.haxe.org/

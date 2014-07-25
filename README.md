LuaXe
=====

Lua target for Haxe language

State: *pre-alpha*
=====
Primarily LuaJIT -> make super-optimized portable Haxe target!

I have some working *fast* (beats V8 and Neko) code otput. Will push soon.

Require Haxe Compiler 3.1, Lua 5.2 or LuaJIT 2

Magic
=====
```haxe
untyped __lua__("_G.print('__lua__')");
untyped __call__(print, 1, 2, 3);
untyped __tail__(os, clock, 1, 2, "hi");
untyped __global__(print,'__lua__', 2);
```
Outputs:
```lua
_G.print('__lua__');
print(1, 2, 3);
os:clock(1, 2, "hi");
_G.print("__lua__", 2);
```

Links
=====
https://github.com/frabbit/hx2python
https://bitbucket.org/AndrewVernon/hx2dart
http://api.haxe.org/

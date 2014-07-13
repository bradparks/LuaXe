/*
 * Copyright (C)2005-2012 Haxe Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 *
 */
package luaxe;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.JSGenApi;
import haxe.macro.Context;
import haxe.macro.Compiler;

using Lambda;
using StringTools;

class LuaGenerator
{
    static var imports = [];

    var api : JSGenApi;
    var buf : StringBuf;
    var topLevelBuf : StringBuf;
    var storeBuf : StringBuf;
    var packages : haxe.ds.StringMap<Bool>;
    var forbidden : haxe.ds.StringMap<Bool>;

    public function new(api)
    {
        this.api = api;
        buf = new StringBuf();
        topLevelBuf = new StringBuf();
        packages = new haxe.ds.StringMap();
        forbidden = new haxe.ds.StringMap();
        api.setTypeAccessor(getType);
    }

    function getType(t : Type)
    {
        return switch(t) {
            case TInst(c, _): getPath(c.get());
            case TEnum(e, _): getPath(e.get());
            default: throw "assert";
        };
    }

    inline function print(str)
    {
        buf.add(str);
    }

    inline function newline()
    {
        print("\n");
        var x = indentCount;
        while(x-- > 0)	print("\t");
    }

    inline function genExpr(e)
    {
        var expr = haxe.macro.Context.getTypedExpr(e);
        var exprString = new LuaPrinter().printExpr(expr);

        print(exprString.replace("super(", "super.init("));
    }

    function field(p : String)
    {
        return LuaPrinter.handleKeywords(p);
//        return api.isKeyword(p) ? '$' + p : "" + p;
    }

    static var classCount = 0;

    function genPathHacks(t:Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c = c.get();
                if(!c.isExtern)classCount++;
                getPath(c);
            case TEnum(r, _):
                var e = r.get();
                getPath(e);
            default:
//                trace(t);
        }
    }

    function getPath(t : BaseType)
    {
		var fullPath = t.name;

		if(t.pack.length > 0)
		{
		    var dotPath = t.pack.join(".") + "." + t.name;
		    fullPath =  t.pack.join("_") + "_" + t.name;

		    if(!LuaPrinter.pathHack.exists(dotPath))
		        LuaPrinter.pathHack.set(dotPath, fullPath);
		}

		if(t.module != t.name)   //TODO(av) see what this does with sub classes in packages
		{
		    var modulePath = t.module + "." + t.name;
//           trace(fullPath + " " + t);
//           trace(LuaPrinter.pathHack.exists(modulePath));
		    if(!LuaPrinter.pathHack.exists(modulePath))
		        LuaPrinter.pathHack.set(modulePath, t.name);
		}
        return fullPath;
    }

    function checkFieldName(c : ClassType, f : ClassField)
    {
        if(forbidden.exists(f.name))
            Context.error("The field " + f.name + " is not allowed in Lua", c.pos);
    }

    function genClassField(c : ClassType, p : String, f : ClassField)
    {
        checkFieldName(c, f);
        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('--var $field;');
        }
        else switch( f.kind )
        {
            case FMethod(_):
                print('function $p:$field');
                genExpr(e);
                newline();
            default:
                print('var $field = ');
                genExpr(e);
                print(";");
                newline();
        }
        newline();
    }

    function genStaticField(c : ClassType, p : String, f : ClassField)
    {
        var classes = classCount > 1;

        checkFieldName(c, f);

//        var topLevel = false;
//
//        for(meta in f.meta.get())
//        {
//            if(meta.name == ":top_level")
//            {
//                topLevel = true;
//                storeBuf = buf;
//                buf = topLevelBuf;
//                break;
//            }
//        }

        var stat = classCount > 1 ? 'static' : "";

        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
            print('$stat var $field;'); //TODO(av) initialisation of static vars if needed
            newline();
        }
        else switch( f.kind ) {
            case FMethod(_):
//                if(topLevel)
//                    print('$field ');
//                else
                    //print('$stat $field ');
                    print('function ${p}.$field');
                genExpr(e);
                newline();
            default:
                print('${p}.$field = ');
                genExpr(e);
                print(";");
                newline();
//                statics.add( { c : c, f : f } );
        }

//        if(topLevel)
//            buf = storeBuf;
    }

    function genClass(c : ClassType)
    {
        for(meta in c.meta.get())
        {
            if(meta.name == ":library" || meta.name == ":feature")
            {
                for(param in meta.params)
                {
                    switch(param.expr){
                        case EConst(CString(s)):
                            if(Lambda.indexOf(imports, s) == - 1)
                                imports.push(s);
                        default:
                    }
                }
            }

            if(meta.name == ":remove")
            {
                return;
            }
        }

        api.setCurrentClass(c);
        var p = getPath(c);

        LuaPrinter.currentPath = p + ".";

        if(classCount > 1)
        {
            var psup:String = null;
            LuaPrinter.superClass = null;
            if(c.superClass != null)
            {
                psup = getPath(c.superClass.t.get());
                print('-- class $p extends $psup');
                LuaPrinter.superClass = psup;
            } else print('-- class $p');

            var ignorance = [
            "haxe_ds_IntMap", 
            "IMap", 
            "Std", 
            "Array",
            "HxOverrides",
            "js_Boot",
            "haxe_Log"];

            if(ignorance.has(p))
            {
                print('\n-- ignored --\n\n');
                return ;
            }

            if(c.isInterface)
                print(' abstract class $p');
            else
                {
                    print('\n$p = {};');
                    if(psup != null)
                    print('\n__inherit($p, ${psup});');
                    else
                    print('\n__inherit($p, Object);');
                    print('\n$p.__index = $p;');
                    //print('\n$p.__index = ${psup != null?psup : p};');
                }

            if(c.interfaces.length > 0)
            {
                var me = this;
                var inter = c.interfaces.map(function(i) return me.getPath(i.t.get())).join(",");
                print(' -- implements $inter');
            }

    //        var name = p.split(".").map(api.quoteString).join(",");
            openBlock();
        }

        if(c.constructor != null)
        {
            newline();
            print('function $p.new');
            LuaPrinter.insideConstructor = p;
            genExpr(c.constructor.get().expr());
            LuaPrinter.insideConstructor = null;
            newline();
        }

        for(f in c.statics.get())
            genStaticField(c, p, f);

        for(f in c.fields.get())
        {
            switch( f.kind ) {
                case FVar(r, _):
                    if(r == AccResolve) continue;
                default:
            }
            genClassField(c, p, f);
        }

        if(classCount > 1)
        {
            closeBlock();
        }
    }

    static var firstEnum = true;

    function genEnum(e : EnumType)
    {
        if(firstEnum)
        {
            generateBaseEnum();
            firstEnum = false;
        }

        var p = getPath(e);

        print('class $p extends Enum {');
        newline();
        print('$p(t, i, [p]):super(t, i, p);');
        newline();
        for(c in e.constructs.keys())
        {
            var c = e.constructs.get(c);
            var f = field(c.name);
            print('static final $f = ');
            switch( c.type ) {
                case TFun(args, _):
                    var sargs = args.map(function(a) return a.name).join(",");
                    print('($sargs) => new $p("${c.name}", ${c.index}, [$sargs]);');
                default:
                    print('new $p(${api.quoteString(c.name)}, ${c.index});');
            }
            newline();
        }
//        var meta = api.buildMetaData(e);
//        if(meta != null)
//        {
//            print('$p.__meta__ = ');
//            genExpr(meta);
//            newline();
//        }

        print("} --<-- huh?");
        newline();
    }


    function genStaticValue(c : ClassType, cf : ClassField)
    {
        var p = getPath(c);
        var f = field(cf.name);
        print('$p$f = ');
        genExpr(cf.expr());
        newline();
    }

    function genType(t : Type)
    {
        switch( t ) {
            case TInst(c, _):
                var c = c.get();
                if(! c.isExtern) genClass(c);
            case TEnum(r, _):
                var e = r.get();
                if(! e.isExtern) genEnum(e);
            default:
        }
    }

    function generateBaseEnum()
    {
        print("abstract class Enum {
        	String tag;
        	int index;
        	List params;
        	Enum(this.tag, this.index, [this.params]);
        	toString()=>params == null ? tag : tag + '(' + params.join(',') + ')';
        	}");	// String toString() { return haxe.Boot.enum_to_string(this); }
        newline();
    }

    public function generate()
    {
        for(t in api.types)
            genPathHacks(t);

        var starter = "";

        if(api.main != null && classCount > 1)
        {
            print("");

            genExpr(api.main);
            print(";");
            newline();

            starter = buf.toString();
            buf = new StringBuf();
        }

        for(t in api.types)
            genType(t);

        var importsBuf = new StringBuf();//currently only works within a single output file. Needs to be handled module by module

        for(mpt in imports)
            importsBuf.add("import '" + mpt + "';\n");

        //genExpr(api.main);

        var boot;
        var path = "src/luaxe";
        boot = "" + sys.io.File.getContent('$path/boot/boot.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/tostring.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/std.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/string.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/object.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/array.lua');
        boot += "\n" + sys.io.File.getContent('$path/boot/map.lua');

        var combined = importsBuf.toString() + topLevelBuf.toString() +  buf.toString();

        var r;
        r = ~/(Array<[A-z]{0,}>).new()/g;
        //combined = r.replace(combined,"{}; -- $1");
        combined = r.replace(combined,"Array(); -- $1");

        r = ~/(haxe_ds_IntMap<[A-z]{0,}>).new()/g;
        //combined = r.replace(combined,"{}; -- $1");
        combined = r.replace(combined,"Map(); -- $1");

        combined = combined.replace(";  ;","; ")
        .replace(")then return; \n",")then return; end\n");

        r = ~/\t\t([A-z]{0,}) ([+,-])= /g;
        combined = r.replace(combined,"\t\t$1 = $1 $2 ");
        //.replace(" = (  ) \n", " = function (  ) \n");

        r = ~/ = \( ([A-z,0-9]{0,}) \) \n/g;
        combined = r.replace(combined," = function ( $1 ) \n");
        
        // ultra fast to-localvar increments
        r = ~/\tlocal ([A-z,0-9]{0,}) = \(function \(\) local _r = ([A-z,0-9]{0,}) or 0; [A-z,0-9]{0,} = _r ([+-]) 1; return _r end\)\(\);\n/g;
        combined = r.replace(combined,"\tlocal $1 = $2; $2 = $2 $3 1\n");
        
        // ultra fast increments fix
        r = ~/\t\(function \(\) local _r = ([A-z,0-9]{0,}) or 0; [A-z,0-9]{0,} = _r ([+-]) 1; return _r end\)\(\);\n/g;
        combined = r.replace(combined,"\t$1 = $1 $2 1\n");
        
        r = ~/\t\(function \(\) ([A-z,0-9]{0,}) = \([A-z,0-9]{0,} or 0\) ([+-]) 1; return [A-z,0-9]{0,}; end\)\(\);\n/g;
        //combined = r.replace(combined,"\t$1 = ($1 or 0) $2 1\n");
        // TODO in haXe: always initiated?
        combined = r.replace(combined,"\t$1 = $1 $2 1\n");

        // ultra fast array push
        r = ~/\t([A-z,0-9]{0,}):push\(([A-z,0-9,"']{0,})\);\n/g;
        combined = r.replace(combined,"\ttable.insert($1, $2)\n");

        sys.io.File.saveContent(api.outputFile, 
        	"function exec()\n" +
        	combined + 
        	"\nend\n" +
        	boot + 
        	"\nexec()" +
        	"\nMain.main()");
    }

    static var indentCount : Int = 0;

    function openBlock()
    {
        newline();
        print("do --{");
        indentCount ++;
        newline();
    }

    function closeBlock()
    {
        indentCount --;
        newline();
        print("end --}");
        newline();
        newline();
    }

    #if macro
	public static function use() {
		Compiler.setCustomJSGenerator(function(api) new LuaGenerator(api).generate());
	}
	#end
}
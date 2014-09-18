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

#if (macro && lua)
import haxe.macro.Type;
import haxe.macro.JSGenApi;
import haxe.macro.Context;
import haxe.macro.Compiler;
import haxe.macro.TypedExprTools;
import haxe.Timer;

using Lambda;
using StringTools;

class LuaGenerator
{
    static var imports = [];
    var api : JSGenApi;
    var buf : StringBuf;
    static var hxClasses:Array<String> = [];

    public function new(api)
    {
        this.api = api;
        buf = new StringBuf();
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
        var expr:haxe.macro.TypedExpr = e;
        var exprString = new LuaPrinter().printExpr(expr);
        print(exprString.replace("super(", "super.init("));
    }

    function field(p : String)
    {
    	return LuaPrinter.handleKeywords(p);
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

	//	if(t.module != t.name)   //TODO(av) see what this does with sub classes in packages
		{
		    var modulePath = t.module + "." + t.name;
		    if(!LuaPrinter.pathHack.exists(modulePath))
		        LuaPrinter.pathHack.set(modulePath, t.name);
		}
        return t.module + "_" + t.name;
        return fullPath;
    }

    function checkFieldName(c : ClassType, f : ClassField)
    {
        if(luaxe.LuaPrinter.keywords.indexOf(f.name) > -1)
            Context.error("The *class* field named " + f.name + " is not allowed in Lua", c.pos);
    }

    function genClassField(c : ClassType, p : String, f : ClassField)
    {
        checkFieldName(c, f);
        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
        	#if verbose print('--var $field;'); #end
        }
        else switch( f.kind )
        {
            case FMethod(_):
                print('function $p:$field');
                luaxe.LuaPrinter.printFunctionHead = false;
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

        var stat = classCount > 1 ? 'static' : "";

        var field = field(f.name);
        var e = f.expr();
        if(e == null)
        {
        	#if verbose print('--$stat var $field;'); //TODO(av) initialisation of static vars if needed
            #end
            newline();
        }
        else switch( f.kind ) {
            case FMethod(_):
                print('function ${p}.$field');
                luaxe.LuaPrinter.printFunctionHead = false;
                genExpr(e);
                newline();
            default:
                print('${p}.$field = ');
                genExpr(e);
                print(";");
                newline();
        }

    }

    var ignorance = [
        // top classes:
        // TODO: move up and uncomment when implemented
        "String_String",
        "Array_Array",
        "HxOverrides_HxOverrides",
        "Std_Std",
        "js_Boot_Boot",   
        "haxe_Log_Log",
        "StringTools_StringTools",
        "EReg_EReg",
        "Enum_Enum",
        "Type_Type",
        "haxe_Json_Json",

        // temporal fix:

        "Class_Class",
        "Date_Date",
        "DateTools_DateTools",
        "EnumValue_EnumValue",
        "IntIterator_IntIterator",
        "Lambda_Lambda",
        "List_List",
        "Map_Map",
        "Math_Math",
        "Reflect_Reflect",
        "StdTypes_StdTypes",
        //"StringBuf", "StringBuf_StringBuf",
        "UInt_UInt",
        "Xml_Xml",
        "haxe_ds_IntMap_IntMap",
        "Map_IMap", 
    ];

    function genClass(c : ClassType)
    {
        for(meta in c.meta.get())
        {
            if(meta.name == ":require")
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
            } else
            if(meta.name == ":remove")
            {
                return;
            }
        }

        api.setCurrentClass(c);
        var p = getPath(c);
        var __name__ = p;
        p = p.replace(".","_");
        hxClasses.push(p);

        LuaPrinter.currentPath = p + ".";

        if(classCount > 1)
        {
            var psup:String = null;
            LuaPrinter.superClass = null;
            if(c.superClass != null)
            {
                psup = getPath(c.superClass.t.get());
                #if verbose print('-- class $p extends $psup'); #end
                LuaPrinter.superClass = psup;
            } else {
            	#if verbose print('-- class $p'); #end
            }       

            if(ignorance.has(p))
            {
            	#if verbose print(' ignored --\n'); #end
                return ;
            }

            if(c.isInterface)
            {
            	#if verbose print('-- abstract class $p'); #end
            }
            else
                {
                    print('\n$p = {};');
                    if(psup != null)
                    print('\n___inherit($p, ${psup});'.replace(".", "_"));
                    else
                    print('\n___inherit($p, Object);'.replace(".", "_"));

                    print('\n$p.__name__ = "$__name__";');

                    print('\n$p.__index = $p;');
                }

            if(c.interfaces.length > 0)
            {
                var me = this;
                var inter = c.interfaces.map(function(i) return me.getPath(i.t.get())).join(",");
                #if verbose print(' -- implements $inter'); #end
            }

            openBlock();
        }

        if(c.constructor != null)
        {
            newline();
            print('function $p.new');
            LuaPrinter.insideConstructor = p;
            luaxe.LuaPrinter.printFunctionHead = false;
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

        var p = getPath(e).replace(".", "_");

        #if verbose print('--class $p extends Enum {'); #end
        print('\n$p = {}');
        newline();
        #if verbose print('--$p(t, i, [p]):super(t, i, p);'); #end
        newline();
        for(c in e.constructs.keys())
        {
            var c = e.constructs.get(c);
            var f = field(c.name);
            print('$p.$f = ');
            switch( c.type ) {
                case TFun(args, _):
                    var sargs = args.map(function(a) return a.name).join(",");
                    print('function($sargs) return $p.new("${c.name}", ${c.index}, {[0]=$sargs}); end');
                default:
                    print('{[0]=${api.quoteString(c.name)}, [1]=${c.index}};');
            }
            newline();
        }

        #if verbose print("--} --<-- huh?"); #end
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
        /*print("abstract class Enum {
        	String tag;
        	int index;
        	List params;
        	Enum(this.tag, this.index, [this.params]);
        	toString()=>params == null ? tag : tag + '(' + params.join(',') + ')';
        	}");	// String toString() { return haxe.Boot.enum_to_string(this); }*/
        print("
            Enum = {}
            Enum_Enum = Enum
        ");
        newline();
    }

    public function generate()
    {
    	var now = Timer.stamp();

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
            importsBuf.add("require \"" + mpt + "\"\n");

        var boot;

		var pos = Context.getPosInfos((macro null).pos);
		var dir = haxe.io.Path.directory(pos.file);
		var path = haxe.io.Path.addTrailingSlash(dir);

        boot = "";

        #if !bootless

        boot += "___hxClasses = {";
        for (i in hxClasses) {
            boot += ''+ i +' = ' + i + ",";
        }
        boot += "}";

		boot += "" + sys.io.File.getContent('$path/boot/boot.lua');
		boot += "\n" + sys.io.File.getContent('$path/boot/tostring.lua');
		if(hxClasses.has("Std_Std")) boot += "\n" + sys.io.File.getContent('$path/boot/std.lua');
		if(hxClasses.has("Math_Math")) boot += "\n" + sys.io.File.getContent('$path/boot/math.lua');
        if(hxClasses.has("Type_Type")) boot += "\n" + sys.io.File.getContent('$path/boot/type.lua');
		boot += "\n" + sys.io.File.getContent('$path/boot/string.lua');
        if(hxClasses.has("StringTools_StringTools")) boot += "\n" + sys.io.File.getContent('$path/boot/stringtools.lua');
		boot += "\n" + sys.io.File.getContent('$path/boot/object.lua');
		if(hxClasses.has("Array_Array")) boot += "\n" + sys.io.File.getContent('$path/boot/array.lua');
		if(hxClasses.has("Map_Map")) boot += "\n" + sys.io.File.getContent('$path/boot/map.lua');
		boot += "\n" + sys.io.File.getContent('$path/boot/date.lua');
		if(hxClasses.has("List_List")) boot += "\n" + sys.io.File.getContent('$path/boot/list.lua');
        if(hxClasses.has("haxe_Json_Json")) boot += "\n" + sys.io.File.getContent('$path/boot/json.lua');
		boot += "\n" + sys.io.File.getContent('$path/boot/extern.lua'); // TODO remove from *release*
		boot += "\n" + sys.io.File.getContent('$path/boot/ereg.lua'); // TODO remove from *release*

        #end

        var combined = buf.toString();

		var r;
        /*r = ~/(Array<[A-z]{0,}>).new()/g;
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
        combined = r.replace(combined,"\ttable.insert($1, $2)\n");*/

        r = ~/\n[ \t]{0,}--[^\n]+/g;
        boot = r.replace(boot, "");
        r = ~/--[^\n]+/g;
        boot = r.replace(boot, "");
        boot = boot.replace("\n\n", "\n");

        sys.io.File.saveContent(api.outputFile,
            importsBuf.toString() +
            #if !bootless sys.io.File.getContent('$path/boot/preboot.lua') + #end
        	"\nfunction exec()\n" +
        	combined + 
        	"\nend\n" +
        	boot + 
        	"\nexec()" +
        	"\nMain_Main.main()");

        trace('Lua generated in ${Std.int((Timer.stamp() - now)*1000)}ms');
    }

    static var indentCount : Int = 0;

    function openBlock()
    {
        #if verbose newline(); print("--{"); #end
        indentCount ++;
        newline();
    }

    function closeBlock()
    {
        indentCount --;
        #if verbose newline(); print("--}"); #end
        newline();
        newline();
    }

	public static function use() {
		Compiler.allowPackage("sys");
		Compiler.setCustomJSGenerator(function(api) new LuaGenerator(api).generate());
	}
}
#end
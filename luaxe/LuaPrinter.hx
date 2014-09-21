/*
 * Copyright (C)2005-2014 Haxe Foundation
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
 */

package luaxe;

#if (macro && lua)
import haxe.ds.StringMap;

import haxe.macro.Expr.Unop;
import haxe.macro.Expr.Binop;
import haxe.macro.Expr.TypeParam;
import haxe.macro.Expr.TypePath;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.ComplexType;
import haxe.macro.Expr.Access;
import haxe.macro.Expr.Field;
import haxe.macro.Expr.TypeParamDecl;
import haxe.macro.Expr.FunctionArg;
import haxe.macro.Expr.Function;
import haxe.macro.Expr;

import haxe.macro.Type;
import haxe.macro.TypedExprTools;

using Lambda;
using haxe.macro.Tools;
using StringTools;

class LuaPrinter {

    public static var insideConstructor:String = null;
    public static var superClass:String = null;

	var tabs:String;
	var tabString:String;
    public static var currentPath = "";
    public static var lastConstIsString = false;

    // laguage keywords:
    static public var keywords = [
    "and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in",
    "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while", "_G", "_r"
    ];

    // top-level reserved:
    static public var reserved = [
    "setmetatable"
    ].concat(keywords);

    public static var pathHack = new StringMap();

    public static function handleKeywords(name)
    {
        if(keywords.indexOf(name) != -1)
            return "_" + name;
        return name;
    }

	public function new(?tabString = "\t") {
		tabs = "\t";
		this.tabString = tabString;
	}

	public function printUnop(op:Unop, val:String = null, inFront:Bool = false)
    if(val == null)
    return switch(op) {
		case OpIncrement: "++";
		case OpDecrement: "--";
		case OpNot: "!";
		case OpNeg: "-";
		case OpNegBits: "~";
	}else
    return switch(op) {
        case OpIncrement: inFront? 
        '(function () local _r = $val or 0; $val = _r + 1; return _r end)()'
        : '(function () $val = ($val or 0) + 1; return $val; end)()';
        case OpDecrement: inFront? 
        '(function () local _r = $val or 0; $val = _r - 1; return _r end)()'
        : '(function () $val = ($val or 0) - 1; return $val; end)()';
        case OpNot:       inFront? '$val!' : 'not $val';
        case OpNeg:       inFront? '$val-' : '-$val';
        case OpNegBits:   inFront? '$val~' : '~$val';
    }

	public function printBinop(op:Binop)
    return switch(op) {
		case OpAdd: "+";
		case OpMult: "*";
		case OpDiv: "/";
		case OpSub: "-";
		case OpAssign: "=";
		case OpEq: "==";
		case OpNotEq: "~=";// "!=" in Lua
		case OpGt: ">";
		case OpGte: ">=";
		case OpLt: "<";
		case OpLte: "<=";
		case OpAnd: "&";
		case OpOr: "or";//TODO "|";
		case OpXor: "^";
		case OpBoolAnd: " and ";// "&&" in Lua
		case OpBoolOr: " or ";// "||" in Lua
		case OpShl: "<<";
		case OpShr: ">>";
		case OpUShr: ">>>";
		case OpMod: "%";
		case OpInterval: "...";
		case OpArrow: "=>";
		case OpAssignOp(op): throw "Unreachable code";
	}

	public function printString(s:String) {
        lastConstIsString = true;
		return '"' + s.split("\n").join("\\n").split("\t").join("\\t").split("'").join("\\'").split('"').join("\\\"") #if sys .split("\x00").join("\\x00") #end + '"';
	}

	public function printConstant(c){
        lastConstIsString = false;
    	return switch(c) {
			case TString(s): printString(s);
            case TThis: "self";
            case TNull: "nil";
            case TBool(true): "true";
            case TBool(false): "false";
            case TInt(s): ""+s;
            case TFloat(s): s;
            case TSuper: "super";
		}
    }

	public function printAccess(access:Access) return switch(access) {
		case AStatic: "static";
		case APublic: "public";
		case APrivate: "private";
		case AOverride: "override";
		case AInline: "inline";
		case ADynamic: "dynamic";
		case AMacro: "macro";
	}

    public function printArgs(args:Array<{value:Null<TConstant>, v:TVar}>)
    {
        var argString = null;
        for(i in 0 ... args.length)
        {
            var arg = args[i];
            argString = (argString == null?"":argString+", ") + arg.v.name;
        }
        return (argString == null?"":argString);
    }

    public static var printFunctionHead = true;
	public function printFunction(func:TFunc)
	{
		var head = printFunctionHead;
		printFunctionHead = true;
		// TODO avoid printing function head in other functions inside of constructor
		
		var body:String = (head?"function":"") + "(" + printArgs(func.args) + ")";
		var returnSelf = true;

        var _tabs = tabs;
        tabs += tabString;
		
		if(insideConstructor != null)
		{
			body += '\n${tabs}local self = setmetatable({ }, $insideConstructor)';
        } else returnSelf = false;
		
		switch (func.expr.expr) {
            case TBlock(el) if (el.length == 0): body += ' end';
			case _:
				body += opt(func.expr, printExpr, '\n${tabs}');
				if (returnSelf) body += '\n${tabs}return self';
				body += '\n${_tabs}end';
        }

        tabs = _tabs;

        return body;
	}

	public function printVar(v:TVar, expr:Null<TypedExpr>)
	{
		return v.name + opt(expr, printExpr, " = ");
	}

	function printField(e1:TypedExpr, fa:FieldAccess, isAssign:Bool = false)
    {
    	var obj = switch (e1.expr) {
    		case TConst(TSuper): "super()";
    		case _: '${printExpr(e1)}';
    	}

        var closure = false;

        var name = switch (fa) {
            case FInstance(_, cf): 
			var n = cf.get().name;

			if(n == "length")
			switch( e1.expr )
            {
            	case TLocal( v ) if((""+v.t).startsWith("TInst(Array,[")):
            	return '$obj:get_length()';
            	default:
            }

            switch( e1.expr )
            {        	
            	case TLocal( v ) if( ""+v.t == "TInst(String,[])" ): 
            	
            	return
            		(switch( n )
            		{
            			case "length": '#($obj)';
            			case _: obj + "." + n;
            		});

            	case _: "." + n;
            };

            case FStatic(_,cf): "." + cf.get().name;
            case FAnon(cf): "." + cf.get().name;
            case FDynamic(s): "." + s;
            case FClosure(_,cf): closure = true; "." + cf.get().name;
            case FEnum(_,ef): "." + ef.name;
        }

        if(closure) return "___bind(" + obj + ", " + obj + name + ")";
        return obj + name;
    }

    function printCall(e1:TypedExpr, el:Array<TypedExpr>, _static = false):String
    {
        var id = printExpr(e1);

        if(id.indexOf(currentPath) == 0)
            id = id.substr(currentPath.length);

        var result =  switch(id)
        {
            case "trace" :
                formatPrintCall(el);
            case "__lua__":
                return extractString(el[0]);
            case "__hash__":
                '#${printExpr(el.shift())}';
            case "__call__":
            	var func = printExpr(el.shift());
            	if(func.indexOf("\"") == 0 || func.indexOf("\'") == 0)
            	func = func.substring(1,func.length-1);
                '${func}(${printExprs(el,", ")})';
            case "__tail__":
                '${printExpr(el.shift())}:${printExpr(el.shift())}(${printExprs(el,", ")})';    
            case "__global__":
                '_G.${printExpr(el.shift())}(${printExprs(el,", ")})';
            default:
            (function(){

                switch (e1.expr) {
                    case TField(e, field):
                        switch (e.expr) {
                            case TField(e, field):
                            {
                                return '$id(${printExprs(el,", ")})'
                                .replace(".set(", ":set(")
                                .replace(".get(", ":get(")
                                .replace(".iterator(", ":iterator(");
                            };
                            default:{};
                        }
                    default:{};
                }
				// huh, tail calls are faster
                switch( e1.expr )
            	{
            		case TField(e,a):
            		switch (e.expr) {
            			case TLocal(v) if( ""+v.t == "TInst(String,[])" ):
            			var param:String = ""+a.getParameters()[1];
            			var e:TypedExprDef = ( e1.expr.getParameters()[0].expr );
            			var name = (e.getParameters()[0].name);
            			switch(param) {
            				// TODO static
            				case "substring": return '$name:substring(1+${printExprs(el,", 0+")})';
            				//case "substr": return '$name:substr(1+${printExprs(el,", -1 +")})';
            				case _: {};
            			}
            			case _:{};
            		}
            		case _:{};
            	}

                var r = '${_static?id : id.replace(".",":")}(${printExprs(el,", ")})';
                
                if(_static && id.indexOf(".") == -1) r = currentPath + r;
                return r.replace(":new(", ".new(");
            })();
        }
        // TODO fix super calls in non-constuctors, and pointing to another funcs
        // TODO inline inheritance
        if(result.startsWith("super("))
            result = '\t\t___inherit(self, ${superClass.replace(".", "_")}.new(${printExprs(el,", ")}))';

        return result;
    }

    function extractString(e:haxe.macro.TypedExpr)
    {
        return switch(e.expr)
        {
            case TConst(TString(s)):s;
            default:throw "Unreachable code";
        }
    }

    function formatPrintCall(el:Array<TypedExpr>)
    {
        var expr = el[0];
        var posInfo = Std.string(expr.pos);
        posInfo = posInfo.substring(5, posInfo.indexOf(" "));

        var traceString = printExpr(expr);

        var toStringCall = switch(expr.expr)
        {
            case TConst(TString(_)):"";
            default:".toString()";
        }

        var traceStringParts = traceString.split(" + ");
        var toString = ".toString()";

        for(i in 0 ... traceStringParts.length)
        {
            var part = traceStringParts[i];

            if(part.lastIndexOf('"') != part.length - 1 && part.lastIndexOf(toString) != part.length-toString.length)
            {
                traceStringParts[i] += "";
            }
        }

        traceString = traceStringParts.join(" + ");

        return '_G.print($traceString)';
    }

    function print_field(e1, name)
    {
        var expr = '${printExpr(e1)}.$name';

        if(pathHack.exists(expr))
            expr = pathHack.get(expr);

        if(expr.indexOf(currentPath) == 0)
            expr = expr.substr(currentPath.length);

        if(expr.startsWith("this."))
            expr = expr.replace("this.", "self.");

        return expr;
    }

    function printBaseType(tp:BaseType):String
    {
        if(tp.isExtern == true && tp.meta.has("dotpath"))
        {
            return (tp.pack.length > 0 ? tp.pack.join(".") + "." : "") + tp.name;
        } else
        return (tp.module.length > 0 ? tp.module.replace(".", "_") + "_" : "") + tp.name;
    }

    public function printModuleType (t:ModuleType) 
    {
        return switch (t) 
        {
            case TClassDecl(ct): printBaseType(ct.get());
            case TEnumDecl(ct): printBaseType(ct.get());
            case TTypeDecl(ct): printBaseType(ct.get());
            case TAbstract(ct): printBaseType(ct.get());
        }
    }

    public function printMetadata(meta) return "";

    function printIfElse(econd:TypedExpr, eif:TypedExpr, eelse:TypedExpr)
    {
        // eliminate: if(x){} and if(x){}else{} etc
		var _tabs = tabs; tabs += tabString;
		var _cond:String, _then:String, _else:String, _type:Int;
		switch (econd.expr) {
		case TParenthesis(v): _cond = printExpr(v);
		default: _cond = printExpr(econd);
		}
		var s:String;
		// then-branch:
		switch (eif.expr) {
            case TBlock(el) if (el.length == 0): _then = null;
            case _: _then = printExpr(eif);
        }
		// else-branch:
		if (eelse != null) switch (eelse.expr) {
			case TBlock(el) if (el.length == 0): _else = null;
            case _: _else = printExpr(eelse);
		} else _else = null;
		// flags:
		_type = (_then != null ? 1 : 0) | (_else != null ? 2 : 0);
		switch (_type) {
		case 1: // if-then (no else-branch)
			s = 'if ($_cond) then'
				+ '\n${tabs}$_then'
			+ '\n${_tabs}end';
		case 2: // if-else (no then-branch)
			s = 'if not($_cond) then'
				+ '\n${tabs}$_else'
			+ '\n${_tabs}end';
		case 3: // if-then-else
			s = 'if ($_cond) then'
				+ '\n${tabs}$_then'
			+ '\n${_tabs}else'
				+ '\n${tabs}$_else'
			+ '\n${_tabs}end';
		default: // blank (no branches)
			s = 'if ($_cond) then end';
		}
		tabs = _tabs;
		return s;
    }
    
    var _continueLabel = false; // <-- not perfect, TODO improve
	public function printExpr(e:TypedExpr){        

        return e == null ? null : switch(e.expr) {
		
        case TConst(c): printConstant(c);

        case TLocal(t): (""+handleKeywords(t.name)).replace("`trace", "trace");

		case TArray(e1, e2): '${printExpr(e1)}[${printExpr(e2)}]';

		case TField(e1, fa): printField(e1, fa);

		case TParenthesis(e1): '(${printExpr(e1)})';

		case TObjectDecl(fl):
			"setmetatable({ "
             + fl.map(
                function(fld) {
                    var add = "+";
                    var add = switch (fld.expr.expr) {
                        case TFunction(
                         func): add = "function ";
                        default: "";   
                    }
                    return
                    fld.name +
                    ' = $add${printExpr(fld.expr)}'; // TODO
                }
             ).join(", ")
             + " },Object)";

		case TArrayDecl(el): {
            var temp = printExprs(el, ", ");
            'setmetatable({' + (temp.length>0? '[0]=${temp}}, Array_Array)' : '}, Array_Array)');
        };

        case TTypeExpr(t): printModuleType(t);

        case TCall(e1 = { expr : TField(_,FStatic (_))}, el): printCall(e1, el, true);
		
		// fix for untyped __lua__
		case TCall(e1 = { expr : TCall({ expr : TLocal(tc) },_)}, el)
		if(tc.name == "__lua__"): printCall(e1, el, true);

		case TCall(e1, el): printCall(e1, el);
		
        case TNew(tp, _, el): 
			var id:String = printBaseType(tp.get());
			'${id}.new(${printExprs(el,", ")})';

        //case TBinop(OpAdd, e1, e2) if (e.t.match(TInst("String"))):
        //    '${printExpr(e1)} .. ${printExpr(e2)}';

        case TBinop(OpAdd, e1, e2): // TODO extend not only for constants
        {
            var toStringCall = '${printBinop(OpAdd)}';
            '${printExpr(e1)} $toStringCall ${printExpr(e2)}';
        };

        case TBinop(OpAssignOp(op), e1, e2):
        {
            var toStringCall = '${printBinop(op)}';
            var ex1 = printExpr(e1);
            '${ex1} = ${ex1} $toStringCall ${printExpr(e2)}';
        };

        /*case TBinop(OpOr, e1, e2): 
            'OpOr(${printExpr(e1)}, ${printExpr(e2)})';*/

        case TBinop(op, e1, e2): 
            '${printExpr(e1)} ${printBinop(op)} ${printExpr(e2)}';
		
        case TUnop(op, true, e1): printUnop(op,printExpr(e1),true);
		case TUnop(op, false, e1): printUnop(op,printExpr(e1),false);
		
        case TFunction(func): printFunction(func);

        case TFor(v, e1, e2):
        //for index, value in ipairs(t) do print(index,value) end
        // TODO no (i)pairs on Maps... and Arrays
        // TODO smart ::continue::
        // TODO while-iterator
		var _tabs = tabs; tabs += tabString;
		var s = 'for ___, ${v.name} in (${printExpr(e1)}) do';
		s += '\n${tabs}' + printExpr(e2);
		s += '\n${_tabs}end';
		tabs = _tabs;
        s;

        case TVar(v,e)
        if(""+v.t == "TAbstract(Int,[])" && e != null): 
        var result = "local " + printVar(v, e);
        switch (e.expr) {
        	case TUnop(OpIncrement,true,{ expr : TLocal(tc)}):
        	if(""+tc.t == "TAbstract(Int,[])")
        	{
        		result = "local " + v.name + " = " + tc.name;
        		result += "; " + tc.name + " = " + tc.name + " + 1";
        	}
        	default:
        }
        result;

        case TVar(v,e): "local " + printVar(v, e);
		
        case TBlock([]): '';
		case TBlock(el) if (el.length == 1): printShortFunction(printExprs(el, ';\n$tabs'));
		case TBlock(el): printExprs(el, ';\n$tabs');
		
        case TIf(econd, eif, eelse): printIfElse(econd, eif, eelse);
		
        case TWhile(econd, e1, true): 
			var _tabs = tabs; tabs += tabString;
            var _cond = 'while ${printExpr(econd)} do';
            _continueLabel = true; // <-- buggy for now
            var _state = '\n${tabs}${printExpr(e1)}\n${_tabs}end';
			tabs = _tabs;
            _cond + (_continueLabel ? " ::continue::" : "") + _state;

        case TWhile(econd, e1, false): 
			var _tabs = tabs; tabs += tabString;
            _continueLabel = true; // <-- buggy for now
			var s = 'repeat\n${tabs}${printExpr(e1)}';
			if (_continueLabel) s += '\n${tabs}::continue::';
            s += '\n${_tabs}until not ${printExpr(econd)}';
			tabs = _tabs;
            s;
		
        case TSwitch(e, cases, edef):  printSwitch(e, cases, edef);

		case TReturn(eo): "return" + opt(eo, printExpr, " ");

		case TBreak: "break";
		case TContinue: 
            _continueLabel = true;
            "goto continue";
		
		case TThrow(e1): "error(" + printExpr(e1) + ")";
		
        case TCast(e1, _): printExpr(e1);
		
		case TMeta(meta, e1): printMetadata(meta) + " " +printExpr(e1);

        case TPatMatch: "" + e; // TODO WTF

        case TTry(e1, catches): printTry(e1, catches);

        case TEnumParameter( e1 /*: haxe.macro.TypedExpr */, ef /*: haxe.macro.EnumField*/ , index /*: Int */): "" + printExpr(e1) + '[$index]';
	};
    }

    function printShortFunction(value:String)
    {
    	var hasReturn = value.indexOf("return ") == 0;
    	return value + (hasReturn ? ";" : "");
    }

    function printTry(e1:haxe.macro.TypedExpr, catches: Array<{ v : haxe.macro.TVar, expr : haxe.macro.TypedExpr }>)
    {
        // TODO catch other types of exceptions
        // getting last (e:Dynamic) catch:
        var _dynCatch = catches.pop(), _tabs;
        
        // try-block:
        var s = 'local try, catch = pcall(function ()';
            _tabs = tabs; tabs += tabString;
            var tryBlock = printExpr(e1);
            s += '\n${tabs}${tryBlock}';
            var hasReturns = (tryBlock.indexOf("return") >= 0);
            var alwaysReturns = false;
            if (hasReturns) {
                switch (e1.expr) {
                case TBlock(m):
                    switch (m[m.length - 1].expr) {
                    case TReturn(_): alwaysReturns = true;
                    default:
                    }
                case TReturn(_): alwaysReturns = true;
                default:
                }
                if (!alwaysReturns) s += '\n${tabs}return undefined';
            }
            tabs = _tabs;
        s += '\n${tabs}end);';
        
        // catch-block:
        if (_dynCatch.expr != null) switch (_dynCatch.expr.expr) {
        case TBlock([]): // empty catch-block
            if (hasReturns) {
                if (!alwaysReturns) {
                    s += '\n${tabs}if try and (catch ~= undefined) then return catch end';
                } else s += '\n${tabs}if try then return catch end';
            }
        default: // print block only if it's non-empty.
            s += '\n${tabs}if (try == false) then';
                tabs += "\t";
                s += '\n${tabs}local ${_dynCatch.v.name} = catch;';
                s += '\n${tabs}${printExpr(_dynCatch.expr)}';
                tabs = _tabs;
            s += '\n${tabs}';
            if (hasReturns) {
                if (!alwaysReturns) {
                    s += 'elseif (catch ~= undefined) then return catch end';
                } else s += 'else return catch end';
            } else s += 'end';
        }
 
        return s;
    }

    function printSwitch( _e : haxe.macro.TypedExpr , cases : Array<{ values : Array<haxe.macro.TypedExpr>, expr : haxe.macro.TypedExpr }> , edef : Null<haxe.macro.TypedExpr>)
    {
        var s:String = "", e:String;
		switch (_e.expr) { // convert `(value)` to `value`, if possible
		case TParenthesis(v): e = printExpr(v);
		default: e = printExpr(_e);
		}
		var _tabs = tabs; tabs += tabString;
		
		// print case blocks:
		for (i in 0 ... cases.length) {
			var c = cases[i];
			s += (i == 0 ? 'if' : '\n${_tabs}elseif')
				+ ' ($e == ' + printExprs(c.values, ' or $e == ') + ') then'
				+ '\n${tabs}' + opt(c.expr, printExpr);
		}
		
		// print "default" block, if any:
		if (edef != null) {
			s += '\n${_tabs}else'
				+ '\n${tabs}' + opt(edef, printExpr);
		}
		
		//
		s += '\n${_tabs}end';
		tabs = _tabs;
		return s;
    }

	public function printExprs(el:Array<TypedExpr>, sep:String) {
		var result = "";
		for(i in 0...el.length)
        {
        	var ex = el[i];
            result += switch(ex.expr)
            {
            	case TUnop(OpIncrement, _, e): 
            	var v = printExpr(e);
				'$v = $v + 1';
				case TUnop(OpDecrement, _, e): 
            	var v = printExpr(e);
				'$v = $v - 1';
            	case _: printExpr(ex);
            }
            if(i < el.length - 1) result += sep;
        }
        return result;
	}

	function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}
#end
/*
 * Copyright (C)2005-2013 Haxe Foundation
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

import haxe.ds.StringMap;
import haxe.macro.Expr;
import haxe.macro.Type;
using Lambda;
using haxe.macro.Tools;
using StringTools;

//private typedef Expr = TypedExpr;

class LuaPrinter {

    public static var insideConstructor:String = null;
    public static var superClass:String = null;

	var tabs:String;
	var tabString:String;
    public static var currentPath = "";
    public static var lastConstIsString = false;

    static var keywords = [ "abstract", "as", "assert", "break", "case", "catch", "class", "const",
                            "continue", "default", "do", "dynamic", "else", "export", "external", "extends",
                            "factory", "false", "final", "finally", "for", "get", "if", "implements",
                            "import" , "in", "is", "library", "new", "null", "operator", "part",
                            "return", "set", "static", "super", "switch", "this", "throw", "true",
                            "try", "typedef", "var", "void", "while", "with" ];

    static var standardTypes:Map<String, String> = [
        "Array" => "List",
        "Int" => "int",
        "Float" => "double",
    ];

    public static var pathHack = new StringMap();

    public static function mapStandardTypes(typeName)
    {
        var mappedType = standardTypes.get(typeName);
        return mappedType == null ? typeName : mappedType;
    }

    public static function handleKeywords(name)
    {
        if(keywords.indexOf(name) != -1)
            return "$" + name;
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
		case OpAdd: "+";//lastConstIsString? ".." : "+";
		case OpMult: "*";
		case OpDiv: "/";
		case OpSub: "-";
		case OpAssign: "=";
		case OpEq: "==";
		case OpNotEq: "~=";//"!=";
		case OpGt: ">";
		case OpGte: ">=";
		case OpLt: "<";
		case OpLte: "<=";
		case OpAnd: "&";
		case OpOr: "or";//TODO "|";
		case OpXor: "^";
		case OpBoolAnd: " and ";//"&&";
		case OpBoolOr: " or ";//"||";
		case OpShl: "<<";
		case OpShr: ">>";
		case OpUShr: ">>>";
		case OpMod: "%";
		case OpInterval: "...";
		case OpArrow: "=>";
		case OpAssignOp(op):
			printBinop(op)
			+ "=";
        //lastConstIsString = false;
	}

	public function printString(s:String) {
        lastConstIsString = true;
		return '"' + s.split("\n").join("\\n").split("\t").join("\\t").split("'").join("\\'").split('"').join("\\\"") #if sys .split("\x00").join("\\x00") #end + '"';
	}

	public function printConstant(c:Constant){
        lastConstIsString = false;
    	return switch(c) {
			case CString(s): printString(s);
			case CIdent(s),CInt(s), CFloat(s):
					s;
			case CRegexp(s,opt): '~/$s/$opt';
		}
    }

	public function printTypeParam(param:TypeParam) return switch(param) {
		case TPType(ct): printComplexType(ct);
		case TPExpr(e): printExpr(e);
	}

	public function printTypePath(tp:TypePath){
        if(tp.sub != null) return tp.sub ;
        return
        (tp.pack.length > 0 ? tp.pack.join("_") + "_" : "")
        + tp.name
		+ (tp.sub != null ? '.${tp.sub}' : "")
		+ (tp.params.length > 0 ? "<" + tp.params.map(printTypeParam).join(", ") + ">" : "");
    }

	// TODO: check if this can cause loops
	public function printComplexType(ct:ComplexType) return switch(ct) {
		case TPath(tp): printTypePath(tp);
		case TFunction(args, ret): (args.length>0 ? args.map(printComplexType).join(" -> ") : "Void") + " -> " + printComplexType(ret);
		case TAnonymous(fields): "{ " + [for (f in fields) printField(f) + "; "].join("") + "}";
		case TParent(ct): "(" + printComplexType(ct) + ")";
		case TOptional(ct): "?" + printComplexType(ct);
		case TExtend(tp, fields): "";
        // '{' +
        // printTypePath(tp) + ' >,' + 
        // ' ${fields.map(printField).join(", ")} }';
	}

	public function printMetadata(meta:MetadataEntry) return
		'@${meta.name}'
		+ (meta.params.length > 0 ? '(${printExprs(meta.params,", ")})' : "");

	public function printAccess(access:Access) return switch(access) {
		case AStatic: "static";
		case APublic: "public";
		case APrivate: "private";
		case AOverride: "override";
		case AInline: "inline";
		case ADynamic: "dynamic";
		case AMacro: "macro";
	}

	public function printField(field:Field) return
		(field.doc != null && field.doc != "" ? "/**\n" + tabs + tabString + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString) + "\n" + tabs + "**/\n" + tabs : "")
		+ (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata).join(" ") + " " : "")
		+ (field.access != null && field.access.length > 0 ? field.access.map(printAccess).join(" ") + " " : "")
		+ switch(field.kind) {
		  case FVar(t, eo): 'var ${field.name}' + opt(t, printComplexType, " : ") + opt(eo, printExpr, " = ");
		  case FProp(get, set, t, eo): 'var ${field.name}($get, $set)' + opt(t, printComplexType, " : ") + opt(eo, printExpr, " = ");
		  case FFun(func): 'function ${field.name}' + printFunction(func);
		}

	public function printTypeParamDecl(tpd:TypeParamDecl) return
		tpd.name
		+ (tpd.params != null && tpd.params.length > 0 ? "<" + tpd.params.map(printTypeParamDecl).join(", ") + ">" : "")
		+ (tpd.constraints != null && tpd.constraints.length > 0 ? ":(" + tpd.constraints.map(printComplexType).join(", ") + ")" : "");

    public function printArgs(args:Array<FunctionArg>)
    {
        var argString = "";
        var optional = false;

        for(i in 0 ... args.length)
        {
            var arg = args[i];
            var argValue = printExpr(arg.value);

            if((arg.opt || argValue != "#NULL") && !optional)
            {
                optional = true;
                argString += "[";
            }
            argString += arg.name;

            if(argValue != null && argValue != "#NULL")
                argString += '= $argValue';

            if(i < args.length - 1)
                argString += ",";
        }

        if(optional) argString += "]";

        return argString;
    }

	public function printFunction(func:Function) return
		(func.params.length > 0 ? "<" + func.params.map(printTypeParamDecl).join(", ") + ">" : "")
		+ "( " + printArgs(func.args) + " )"
//		+ "( " + func.args.map(printFunctionArg).join(", ") + " )"
//		+ opt(func.ret, printComplexType, " : ")
        + (insideConstructor != null ?
            '\n\t\tlocal self = {}' +
            '\n\t\tsetmetatable(self, $insideConstructor)'
            //'\n\t\tinherit(self, $insideConstructor.new())'
        : '')
		+ opt(func.expr, printExpr, " ");

	public function printVar(v:Var)
    {
        return
        v.name
        //		+ opt(v.type, printComplexType, " : ")
        + opt(v.expr, printExpr, " = ");
    }

//    function justPath(expr)
//    {
//        return switch(expr.expr)
//        {
//            case EConst(CIdent(s)):s;
//            case EField(e, field): justPath(e) + "_" + field;
//            default:"";
//        }
//       // return printExpr(expr);
//    }

    function printCall(e1, el)
    {
        var id = printExpr(e1);

        if(id.indexOf(currentPath) == 0)
            id = id.substr(currentPath.length);

        var result =  switch(id)
        {
            case "trace" :
                formatPrintCall(el);
            case "__lua__":
                extractString(el[0]);
            case "__call__":
                '${printExpr(el.shift())}(${printExprs(el,", ")})';
            case "__assert__":
                'assert(${printExprs(el,", ")})';
            case "__new_named__":
                'new ${extractString(el.shift())}(${printExprs(el,", ")})';
            case "__call_named__":
                '${extractString(el.shift())}(${printExprs(el,", ")})';
            case "__is__":
                '(${printExpr(el[0])} is ${printExpr(el[1])})';
            case "__as__":
                '(${printExpr(el[0])} as ${printExpr(el[1])})';
            case "__call_after__":
                var methodName = extractString(el.shift());
                '(${printExpr(el[0])}).$methodName()';
            case "__cascade__":
                 '${printExpr(el.shift())}..${printExprs(el, ",")}';
            default:
               //'$id(${printExprs(el,", ")})'; // <-- here to . :

            (function(){

                switch (e1.expr) {
                    case EField(e, field):
                        switch (e.expr) {
                            case EField(e, field):
                            {
                                //trace(e1.expr);

                                return '$id(${printExprs(el,", ")})'
                                .replace(".set(", ":set(")
                                .replace(".get(", ":get(")
                                .replace(".iterator(", ":iterator(");
                            };
                            /*case EConst(c):
                            {
                                trace("const!");
                                trace(c);
                                trace(id);
                                trace('$id(${printExprs(el,", ")})');
                            };*/
                            default:{};
                        }
                    default:{};
                }
                //trace(id);
                var r = '${id.replace(".",":")}(${printExprs(el,", ")})';
                //return r.indexOf('.new(') == -1? r.replace(".",":") : r;
                //if() r = r.replace(".",":")
                return r
                    .replace(":new(", ".new(")
                    ;
            })();
        }

        if(result == "super()")
            result = '\t\t__inherit(self, $superClass.new())';//"--super()";

        return result;
    }

    function extractString(e)
    {
        return switch(e.expr)
        {
            case EConst(CString(s)):s;
            default:"####";
        }
    }

    function formatPrintCall(el:Array<Expr>)
    {
        var expr = el[0];
        var posInfo = Std.string(expr.pos);
        posInfo = posInfo.substring(5, posInfo.indexOf(" "));

        var traceString = printExpr(expr);

        var toStringCall = switch(expr.expr)
        {
            case EConst(CString(_)):"";
            default:".toString()";
        }

        var traceStringParts = traceString.split(" + ");
        var toString = ".toString()";

        for(i in 0 ... traceStringParts.length)
        {
            var part = traceStringParts[i];

            if(part.lastIndexOf('"') != part.length - 1 && part.lastIndexOf(toString) != part.length-toString.length)
            {
                traceStringParts[i] += "";//".toString()";
            }
        }

        traceString = traceStringParts.join(" .. "); //(" + ");

        return 'print($traceString)';
    }

    function print_field(e1, name)
    {
        var expr = '${printExpr(e1)}.$name';
        //var toFunc = false;

        //trace(e1);

        /*switch (e1.expr) {
            case EConst(c):
               trace(c); 
               switch (c) {
                    case CIdent(s)
                    default:{};
               }
            default:{};
        }*/

        if(pathHack.exists(expr))
            expr = pathHack.get(expr);

        if(expr.indexOf(currentPath) == 0)
            expr = expr.substr(currentPath.length);

        if(expr.startsWith("this."))
            expr = expr.replace("this.", "self.");

        return expr;
    }

    function printIfElse(econd, eif, eelse)
    {
        var ifExpr = printExpr(eif);
        var lastChar = ifExpr.charAt(ifExpr.length - 1);
        if(lastChar != ";" && lastChar != "}")
        {
            ifExpr += ";";
        }
      //  trace(ifExpr);

       return 'if(${printExpr(econd)})then $ifExpr  ${opt(eelse,printExpr,"else ")}';
    }

//    public function enterExpr(e:Expr)
//    {
//
//    }
    //var insideEObjectDecl = false;
	public function printExpr(e:Expr){
//        trace(e);
        return e == null ? "#NULL" : switch(e.expr) {
		case EConst(c): printConstant(c);
		case EArray(e1, e2): '${printExpr(e1)}[${printExpr(e2)}]';
		case EBinop(op, e1, e2): 
        //'${printExpr(e1)} ${printBinop(op)} ${printExpr(e2)}';
        (function(){
            var toStringCall = '${printBinop(op)}';
            lastConstIsString = false;

            toStringCall = switch(e1.expr)
            {
                case EConst(CString(_)):toStringCall == "+" ? '..': toStringCall;
                default:toStringCall;
            }

            toStringCall = switch(e2.expr)
            {
                case EConst(CString(_)):toStringCall == "+" ? '..': toStringCall;
                default:toStringCall;
            }

            return '${printExpr(e1)} $toStringCall ${printExpr(e2)}';
        })();

		case EField(e1, n):/* trace(e);*/ print_field(e1, n);
		case EParenthesis(e1): '(${printExpr(e1)})';
		case EObjectDecl(fl):
			"setmetatable({ "
             + fl.map(
                function(fld) {
                    //insideEObjectDecl = true;
                    //$type(fld);
                    //trace(fld.expr.expr);
                    var add = "+";
                    var add = switch (fld.expr.expr) {
                        case EFunction(no, func): add = "function ";
                        default: "";   
                    }
                    return '${fld.field} = $add${printExpr(fld.expr)}';
                }
             ).join(", ")
             + " },Object)";
		case EArrayDecl(el): {
            var temp = printExprs(el, ", ");
            'setmetatable({' + (temp.length>0? '[0]=${temp}}, HaxeArrayMeta)' : '}, HaxeArrayMeta)');
        };
		case ECall(e1, el): printCall(e1, el);
		case ENew(tp, el): '${printTypePath(tp)}.new(${printExprs(el,", ")})';
		case EUnop(op, true, e1): printUnop(op,printExpr(e1),true);//printExpr(e1) + printUnop(op);//, printExpr(e1));
		case EUnop(op, false, e1): printUnop(op,printExpr(e1),false);//printUnop(op) + printExpr(e1);
		case EFunction(no, func) if (no != null): '$no' + printFunction(func);
		case EFunction(_, func): /*"function " +*/ printFunction(func);
		case EVars(vl): "local " +vl.map(printVar).join(", ");
		case EBlock([]): '\n$tabs end';//'B{\n$tabs}B';
//		case EBlock(el) if (el.length == 1): printShortFunction(printExprs(el, ';\n$tabs'));
		case EBlock(el):
            var old = tabs;
			tabs += tabString;
			var s = /*'{'*/ '\n$tabs' + printExprs(el, ';\n$tabs');//';\n$tabs');
			tabs = old;
			s + ';\n${tabs}${insideConstructor!=null?"\treturn self\n\t":""}end'/*'}'*/;
            //insideConstructor = null;
		case EFor(e1, e2): 'for ${printExpr(e1)} do\n${tabs} ${printExpr(e2)}\n${tabs}end';//'for(${printExpr(e1)}) ${printExpr(e2)}';
		case EIn(e1, e2): 'k,${printExpr(e1)} in ${printExpr(e2)}';//'${printExpr(e1)} in ${printExpr(e2)}';
		case EIf(econd, eif, eelse): printIfElse(econd, eif, eelse); // 'if(${printExpr(econd)}) ${printExpr(eif)}  ${opt(eelse,printExpr,"else ")}';
		case EWhile(econd, e1, true): 'do while(${printExpr(econd)})do ${printExpr(e1)}';
		case EWhile(econd, e1, false): 'do ${printExpr(e1)} while(${printExpr(econd)})';
		case ESwitch(e1, cl, edef):  printSwitch(e1, cl, edef);
		case ETry(e1, cl):
			'try ${printExpr(e1)}'
			+ cl.map(function(c) return ' catch(${c.name} ) ${printExpr(c.expr)}').join("");   //: ${printComplexType(c.type)}
//		case EReturn(eo): "return " + printExpr(eo);
		case EReturn(eo): {
            //trace(eo);
            ("return" + opt(eo, printExpr, " "));
            //(eo != null ? opt(eo, printExpr, " ") : "--");
        };
		case EBreak: "break";
		case EContinue: "continue";
		case EUntyped(e1): "untyped " +printExpr(e1);
		case EThrow(e1): "throw " +printExpr(e1);
		case ECast(e1, cto) if (cto != null): '${printExpr(e1)} as ${printComplexType(cto)}';
		case ECast(e1, _): /*"cast " +*/printExpr(e1);
		case EDisplay(e1, _): '#DISPLAY(${printExpr(e1)})';
		case EDisplayNew(tp): '#DISPLAY(${printTypePath(tp)})';
		case ETernary(econd, eif, eelse): '${printExpr(econd)} ? ${printExpr(eif)} : ${printExpr(eelse)}';
		case ECheckType(e1, ct): '#CHECK_TYPE(${printExpr(e1)}, ${printComplexType(ct)})';
		case EMeta(meta, e1): printMetadata(meta) + " " +printExpr(e1);
	};
    }

    function printShortFunction(value:String)
    {
        var hasReturn = value.indexOf("return ") == 0;

        if(hasReturn) value = value.substr(7);


       return "=> " + value + (hasReturn ? ";" : "");
    }

    function printSwitch(e1, cl, edef)
    {
//        trace(e1);
//        trace(cl);
//        trace(edef);

        var old = tabs;
        tabs += tabString;
        var s = 'switch ${printExpr(e1)} {\n$tabs' +
                    cl.map(printSwitchCase).join('\n$tabs');
        if (edef != null)
            s += '\n${tabs}default: ' + (edef.expr == null ? "" : printExpr(edef) + ";");

        tabs = old;
        s += '\n$tabs}';

        return s;
    }

    function printSwitchCase(c)
    {
        return 'case ${printExprs(c.values, ", ")}'
               + (c.guard != null ? ' if(${printExpr(c.guard)}): ' : ":")
               + (c.expr != null ? (opt(c.expr, printExpr)) + "; break;" : "");
    }

	public function printExprs(el:Array<Expr>, sep:String) {

//        var id = null;
//
//        var sameID = [];
//
//        var idGroup = new Map<String, Array<Expr>>();
//
//        for(ex in el)
//        {
//            switch(ex.expr)
//            {
//                case ECall(e1, el):
//                        switch(e1.expr)
//                        {
//                            case EField(e1, n):
//                                switch(e1.expr)
//                                {
//                                    case EConst(CIdent(s)):
//                                        if(id == s){
////                                             trace(ex);
//                                            e1.expr = EConst(CIdent(""));
//                                            sameID.push(ex);
//                                        }
//                                        id = s;
//                                    default:
//                                }
//
//                            default:
//                        }
//                default:
//            }
//        }
//
//        if(id != null)
//            trace(sameID.map(printExpr).join("."));

		return el.map(printExpr).join(sep);
	}

	public function printTypeDefinition(t:TypeDefinition, printPackage = true):String {
		var old = tabs;
		tabs = tabString;

		var str = t == null ? "#NULL" :
			(printPackage && t.pack.length > 0 && t.pack[0] != "" ? "package " + t.pack.join("_") + ";\n" : "") +
			(t.meta != null && t.meta.length > 0 ? t.meta.map(printMetadata).join(" ") + " " : "") + (t.isExtern ? "extern " : "") + switch (t.kind) {
				case TDEnum:
					"enum " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "") + " {\n"
					+ [for (field in t.fields)
						tabs + (field.doc != null && field.doc != "" ? "/**\n" + tabs + tabString + StringTools.replace(field.doc, "\n", "\n" + tabs + tabString) + "\n" + tabs + "**/\n" + tabs : "")
						+ (field.meta != null && field.meta.length > 0 ? field.meta.map(printMetadata).join(" ") + " " : "")
						+ (switch(field.kind) {
							case FVar(_, _): field.name;
							case FProp(_, _, _, _): throw "FProp is invalid for TDEnum.";
							case FFun(func): field.name + printFunction(func);
						}) + ";"
					].join("\n")
					+ "\n}";
				case TDStructure:
					"typedef " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "") + " = {\n"
					+ [for (f in t.fields) {
						tabs + printField(f) + ";";
					}].join("\n")
					+ "\n}";
				case TDClass(superClass, interfaces, isInterface):
					(isInterface ? "interface " : "class ") + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
					+ (superClass != null ? " extends " + printTypePath(superClass) : "")
					+ (interfaces != null ? (isInterface ? [for (tp in interfaces) " extends " + printTypePath(tp)] : [for (tp in interfaces) " implements " + printTypePath(tp)]).join("") : "")
					+ " {\n"
					+ [for (f in t.fields) {
						var fstr = printField(f);
						tabs + fstr + switch(f.kind) {
							case FVar(_, _), FProp(_, _, _, _): ";";
							case FFun(func) if (func.expr == null): ";";
							case _: "";
						};
					}].join("\n")
					+ "\n}";
				case TDAlias(ct):
					"typedef " + t.name + (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "") + " = "
					+ printComplexType(ct)
					+ ";";
				case TDAbstract(tthis, from, to):
					"abstract " + t.name
					+ (tthis == null ? "" : "(" + printComplexType(tthis) + ")")
					+ (t.params.length > 0 ? "<" + t.params.map(printTypeParamDecl).join(", ") + ">" : "")
					+ (from == null ? "" : [for (f in from) " from " + printComplexType(f)].join(""))
					+ (to == null ? "" : [for (t in to) " to " + printComplexType(t)].join(""))
					+ " {\n"
					+ [for (f in t.fields) {
						var fstr = printField(f);
						tabs + fstr + switch(f.kind) {
							case FVar(_, _), FProp(_, _, _, _): ";";
							case FFun(func) if (func.expr == null): ";";
							case _: "";
						};
					}].join("\n")
					+ "\n}";
			}

		tabs = old;
		return str;
	}

	function opt<T>(v:T, f:T->String, prefix = "") return v == null ? "" : (prefix + f(v));
}
var sort = (require("./sequence")).sort;
var butlast = (require("./sequence")).butlast;
var last = (require("./sequence")).last;
var concat = (require("./sequence")).concat;
var rest = (require("./sequence")).rest;
var conj = (require("./sequence")).conj;
var cons = (require("./sequence")).cons;
var vec = (require("./sequence")).vec;
var map = (require("./sequence")).map;
var rest = (require("./sequence")).rest;
var third = (require("./sequence")).third;
var second = (require("./sequence")).second;
var first = (require("./sequence")).first;
var isEmpty = (require("./sequence")).isEmpty;
var count = (require("./sequence")).count;
var isList = (require("./sequence")).isList;
var list = (require("./sequence")).list;;

var isStrictEqual = (require("./runtime")).isStrictEqual;
var isEqual = (require("./runtime")).isEqual;
var vals = (require("./runtime")).vals;
var char = (require("./runtime")).char;
var subs = (require("./runtime")).subs;
var str = (require("./runtime")).str;
var reFind = (require("./runtime")).reFind;
var reMatches = (require("./runtime")).reMatches;
var rePattern = (require("./runtime")).rePattern;
var isDictionary = (require("./runtime")).isDictionary;
var isObject = (require("./runtime")).isObject;
var isBoolean = (require("./runtime")).isBoolean;
var isNumber = (require("./runtime")).isNumber;
var isString = (require("./runtime")).isString;
var isVector = (require("./runtime")).isVector;
var dec = (require("./runtime")).dec;
var inc = (require("./runtime")).inc;
var isNil = (require("./runtime")).isNil;
var keys = (require("./runtime")).keys;
var dictionary = (require("./runtime")).dictionary;
var isOdd = (require("./runtime")).isOdd;;

var name = (require("./ast")).name;
var withMeta = (require("./ast")).withMeta;
var meta = (require("./ast")).meta;
var keyword = (require("./ast")).keyword;
var isKeyword = (require("./ast")).isKeyword;
var symbol = (require("./ast")).symbol;
var isSymbol = (require("./ast")).isSymbol;;

var join = (require("./string")).join;
var split = (require("./string")).split;;

var pushBackReader = function pushBackReader(source, uri) {
  return {
    "lines": split(source, "\n"),
    "buffer": "",
    "uri": uri,
    "column": -1,
    "line": 0
  };
};
exports.pushBackReader = pushBackReader;

var peekChar = function peekChar(reader) {
  var line = ((reader || 0)["lines"])[(reader || 0)["line"]];
  var column = inc((reader || 0)["column"]);
  return isNil(line) ?
    void(0) :
    (line[column]) || "\n";
};
exports.peekChar = peekChar;

var readChar = function readChar(reader) {
  var ch = peekChar(reader);
  isNewline(peekChar(reader)) ?
    (function() {
      (reader || 0)["line"] = inc((reader || 0)["line"]);
      return (reader || 0)["column"] = -1;
    })() :
    (reader || 0)["column"] = inc((reader || 0)["column"]);
  return ch;
};
exports.readChar = readChar;

var isNewline = function isNewline(ch) {
  return "\n" === ch;
};
exports.isNewline = isNewline;

var isBreakingWhitespace = function isBreakingWhitespace(ch) {
  return (ch === " ") || (ch === "\t") || (ch === "\n") || (ch === "\r");
};
exports.isBreakingWhitespace = isBreakingWhitespace;

var isWhitespace = function isWhitespace(ch) {
  return (isBreakingWhitespace(ch)) || ("," === ch);
};
exports.isWhitespace = isWhitespace;

var isNumeric = function isNumeric(ch) {
  return (ch === "0") || (ch === "1") || (ch === "2") || (ch === "3") || (ch === "4") || (ch === "5") || (ch === "6") || (ch === "7") || (ch === "8") || (ch === "9");
};
exports.isNumeric = isNumeric;

var isCommentPrefix = function isCommentPrefix(ch) {
  return ";" === ch;
};
exports.isCommentPrefix = isCommentPrefix;

var isNumberLiteral = function isNumberLiteral(reader, initch) {
  return (isNumeric(initch)) || ((("+" === initch) || ("-" === initch)) && (isNumeric(peekChar(reader))));
};
exports.isNumberLiteral = isNumberLiteral;

var readerError = function readerError(reader, message) {
  var text = "" + message + "\n" + "line:" + ((reader || 0)["line"]) + "\n" + "column:" + ((reader || 0)["column"]);
  var error = SyntaxError(text, (reader || 0)["uri"]);
  error.line = (reader || 0)["line"];
  error.column = (reader || 0)["column"];
  error.uri = (reader || 0)["uri"];
  return (function() { throw error; })();
};
exports.readerError = readerError;

var isMacroTerminating = function isMacroTerminating(ch) {
  return (!(ch === "#")) && (!(ch === "'")) && (!(ch === ":")) && (macros(ch));
};
exports.isMacroTerminating = isMacroTerminating;

var readToken = function readToken(reader, initch) {
  return (function loop(buffer, ch) {
    var recur = loop;
    while (recur === loop) {
      recur = (isNil(ch)) || (isWhitespace(ch)) || (isMacroTerminating(ch)) ?
      buffer :
      (buffer = "" + buffer + (readChar(reader)), ch = peekChar(reader), loop);
    };
    return recur;
  })(initch, peekChar(reader));
};
exports.readToken = readToken;

var skipLine = function skipLine(reader, _) {
  return (function loop() {
    var recur = loop;
    while (recur === loop) {
      recur = (function() {
      var ch = readChar(reader);
      return (ch === "\n") || (ch === "\r") || (isNil(ch)) ?
        reader :
        (loop);
    })();
    };
    return recur;
  })();
};
exports.skipLine = skipLine;

var intPattern = rePattern("^([-+]?)(?:(0)|([1-9][0-9]*)|0[xX]([0-9A-Fa-f]+)|0([0-7]+)|([1-9][0-9]?)[rR]([0-9A-Za-z]+)|0[0-9]+)(N)?$");
exports.intPattern = intPattern;

var ratioPattern = rePattern("([-+]?[0-9]+)/([0-9]+)");
exports.ratioPattern = ratioPattern;

var floatPattern = rePattern("([-+]?[0-9]+(\\.[0-9]*)?([eE][-+]?[0-9]+)?)(M)?");
exports.floatPattern = floatPattern;

var matchInt = function matchInt(s) {
  var groups = reFind(intPattern, s);
  var group3 = groups[2];
  return !((isNil(group3)) || (count(group3) < 1)) ?
    0 :
    (function() {
      var negate = "-" === groups[1] ?
        -1 :
        1;
      var a = groups[3] ?
        [groups[3], 10] :
      groups[4] ?
        [groups[4], 16] :
      groups[5] ?
        [groups[5], 8] :
      groups[7] ?
        [groups[7], parseInt(groups[7])] :
      "else" ?
        [void(0), void(0)] :
        void(0);
      var n = a[0];
      var radix = a[1];
      return isNil(n) ?
        void(0) :
        negate * (parseInt(n, radix));
    })();
};
exports.matchInt = matchInt;

var matchRatio = function matchRatio(s) {
  var groups = reFind(ratioPattern, s);
  var numinator = groups[1];
  var denominator = groups[2];
  return (parseInt(numinator)) / (parseInt(denominator));
};
exports.matchRatio = matchRatio;

var matchFloat = function matchFloat(s) {
  return parseFloat(s);
};
exports.matchFloat = matchFloat;

var matchNumber = function matchNumber(s) {
  return reMatches(intPattern, s) ?
    matchInt(s) :
  reMatches(ratioPattern, s) ?
    matchRatio(s) :
  reMatches(floatPattern, s) ?
    matchFloat(s) :
    void(0);
};
exports.matchNumber = matchNumber;

var escapeCharMap = function escapeCharMap(c) {
  return c === "t" ?
    "\t" :
  c === "r" ?
    "\r" :
  c === "n" ?
    "\n" :
  c === "\\" ?
    "\\" :
  c === "\"" ?
    "\"" :
  c === "b" ?
    "" :
  c === "f" ?
    "" :
  "else" ?
    void(0) :
    void(0);
};
exports.escapeCharMap = escapeCharMap;

var read2Chars = function read2Chars(reader) {
  return "" + (readChar(reader)) + (readChar(reader));
};
exports.read2Chars = read2Chars;

var read4Chars = function read4Chars(reader) {
  return "" + (readChar(reader)) + (readChar(reader)) + (readChar(reader)) + (readChar(reader));
};
exports.read4Chars = read4Chars;

var unicode2Pattern = rePattern("[0-9A-Fa-f]{2}");
exports.unicode2Pattern = unicode2Pattern;

var unicode4Pattern = rePattern("[0-9A-Fa-f]{4}");
exports.unicode4Pattern = unicode4Pattern;

var validateUnicodeEscape = function validateUnicodeEscape(unicodePattern, reader, escapeChar, unicodeStr) {
  return reMatches(unicodePattern, unicodeStr) ?
    unicodeStr :
    readerError(reader, "" + "Unexpected unicode escape " + "\\" + escapeChar + unicodeStr);
};
exports.validateUnicodeEscape = validateUnicodeEscape;

var makeUnicodeChar = function makeUnicodeChar(codeStr, base) {
  var base = base || 16;
  var code = parseInt(codeStr, base);
  return char(code);
};
exports.makeUnicodeChar = makeUnicodeChar;

var escapeChar = function escapeChar(buffer, reader) {
  var ch = readChar(reader);
  var mapresult = escapeCharMap(ch);
  return mapresult ?
    mapresult :
  ch === "x" ?
    makeUnicodeChar(validateUnicodeEscape(unicode2Pattern, reader, ch, read2Chars(reader))) :
  ch === "u" ?
    makeUnicodeChar(validateUnicodeEscape(unicode4Pattern, reader, ch, read4Chars(reader))) :
  isNumeric(ch) ?
    char(ch) :
  "else" ?
    readerError(reader, "" + "Unexpected unicode escape " + "\\" + ch) :
    void(0);
};
exports.escapeChar = escapeChar;

var readPast = function readPast(predicate, reader) {
  return (function loop(_) {
    var recur = loop;
    while (recur === loop) {
      recur = predicate(peekChar(reader)) ?
      (_ = readChar(reader), loop) :
      peekChar(reader);
    };
    return recur;
  })(void(0));
};
exports.readPast = readPast;

var readDelimitedList = function readDelimitedList(delim, reader, isRecursive) {
  return (function loop(form) {
    var recur = loop;
    while (recur === loop) {
      recur = (function() {
      var ch = readPast(isWhitespace, reader);
      !(ch) ?
        readerError(reader, "EOF") :
        void(0);
      return delim === ch ?
        (function() {
          readChar(reader);
          return form;
        })() :
        (function() {
          var macro = macros(ch);
          return macro ?
            (function() {
              var result = macro(reader, readChar(reader));
              return (form = result === reader ?
                form :
                conj(form, result), loop);
            })() :
            (function() {
              var o = read(reader, true, void(0), isRecursive);
              return (form = o === reader ?
                form :
                conj(form, o), loop);
            })();
        })();
    })();
    };
    return recur;
  })([]);
};
exports.readDelimitedList = readDelimitedList;

var notImplemented = function notImplemented(reader, ch) {
  return readerError(reader, "" + "Reader for " + ch + " not implemented yet");
};
exports.notImplemented = notImplemented;

var readDispatch = function readDispatch(reader, _) {
  var ch = readChar(reader);
  var dm = dispatchMacros(ch);
  return dm ?
    dm(reader, _) :
    (function() {
      var object = maybeReadTaggedType(reader, ch);
      return object ?
        object :
        readerError(reader, "No dispatch macro for ", ch);
    })();
};
exports.readDispatch = readDispatch;

var readUnmatchedDelimiter = function readUnmatchedDelimiter(rdr, ch) {
  return readerError(rdr, "Unmached delimiter ", ch);
};
exports.readUnmatchedDelimiter = readUnmatchedDelimiter;

var readList = function readList(reader, _) {
  var form = readDelimitedList(")", reader, true);
  return withMeta(list.apply(list, form), meta(form));
};
exports.readList = readList;

var readComment = function readComment(reader, _) {
  return (function loop(buffer, ch) {
    var recur = loop;
    while (recur === loop) {
      recur = (isNil(ch)) || ("\n" === ch) ?
      reader || (list(symbol(void(0), "comment"), buffer)) :
    ("\\" === ch) ?
      (buffer = "" + buffer + (escapeChar(buffer, reader)), ch = readChar(reader), loop) :
    "else" ?
      (buffer = "" + buffer + ch, ch = readChar(reader), loop) :
      void(0);
    };
    return recur;
  })("", readChar(reader));
};
exports.readComment = readComment;

var readVector = function readVector(reader) {
  return readDelimitedList("]", reader, true);
};
exports.readVector = readVector;

var readMap = function readMap(reader) {
  var form = readDelimitedList("}", reader, true);
  return isOdd(count(form)) ?
    readerError(reader, "Map literal must contain an even number of forms") :
    withMeta(dictionary.apply(dictionary, form), meta(form));
};
exports.readMap = readMap;

var readSet = function readSet(reader, _) {
  var form = readDelimitedList("}", reader, true);
  return withMeta(concat([symbol(void(0), "set")], form), meta(form));
};
exports.readSet = readSet;

var readNumber = function readNumber(reader, initch) {
  return (function loop(buffer, ch) {
    var recur = loop;
    while (recur === loop) {
      recur = (isNil(ch)) || (isWhitespace(ch)) || (macros(ch)) ?
      (function() {
        var match = matchNumber(buffer);
        return isNil(match) ?
          readerError(reader, "Invalid number format [", buffer, "]") :
          match;
      })() :
      (buffer = "" + buffer + (readChar(reader)), ch = peekChar(reader), loop);
    };
    return recur;
  })(initch, peekChar(reader));
};
exports.readNumber = readNumber;

var readString = function readString(reader) {
  return (function loop(buffer, ch) {
    var recur = loop;
    while (recur === loop) {
      recur = isNil(ch) ?
      readerError(reader, "EOF while reading string") :
    "\\" === ch ?
      (buffer = "" + buffer + (escapeChar(buffer, reader)), ch = readChar(reader), loop) :
    "\"" === ch ?
      buffer :
    "default" ?
      (buffer = "" + buffer + ch, ch = readChar(reader), loop) :
      void(0);
    };
    return recur;
  })("", readChar(reader));
};
exports.readString = readString;

var readUnquote = function readUnquote(reader) {
  var ch = peekChar(reader);
  return !(ch) ?
    readerError(reader, "EOF while reading character") :
  ch === "@" ?
    (function() {
      readChar(reader);
      return list(symbol(void(0), "unquote-splicing"), read(reader, true, void(0), true));
    })() :
    list(symbol(void(0), "unquote"), read(reader, true, void(0), true));
};
exports.readUnquote = readUnquote;

var specialSymbols = function specialSymbols(text, notFound) {
  return text === "nil" ?
    void(0) :
  text === "true" ?
    true :
  text === "false" ?
    false :
  "else" ?
    notFound :
    void(0);
};
exports.specialSymbols = specialSymbols;

var readSymbol = function readSymbol(reader, initch) {
  var token = readToken(reader, initch);
  var parts = split(token, "/");
  var hasNs = (count(parts) > 1) && (count(token) > 1);
  var ns = first(parts);
  var name = join("/", rest(parts));
  return hasNs ?
    symbol(ns, name) :
    specialSymbols(token, symbol(token));
};
exports.readSymbol = readSymbol;

var readKeyword = function readKeyword(reader, initch) {
  var token = readToken(reader, readChar(reader));
  var parts = split(token, "/");
  var name = last(parts);
  var ns = count(parts) > 1 ?
    join("/", butlast(parts)) :
    void(0);
  var issue = last(ns) === ":" ?
    "namespace can't ends with \":\"" :
  last(name) === ":" ?
    "name can't end with \":\"" :
  last(name) === "/" ?
    "name can't end with \"/\"" :
  count(split(token, "::")) > 1 ?
    "name can't contain \"::\"" :
    void(0);
  return issue ?
    readerError(reader, "Invalid token (", issue, "): ", token) :
  (!(ns)) && (first(name) === ":") ?
    keyword(rest(name)) :
    keyword(ns, name);
};
exports.readKeyword = readKeyword;

var desugarMeta = function desugarMeta(f) {
  return isKeyword(f) ?
    dictionary(name(f), true) :
  isSymbol(f) ?
    {
      "tag": f
    } :
  isString(f) ?
    {
      "tag": f
    } :
  "else" ?
    f :
    void(0);
};
exports.desugarMeta = desugarMeta;

var wrappingReader = function wrappingReader(prefix) {
  return function(reader) {
    return list(prefix, read(reader, true, void(0), true));
  };
};
exports.wrappingReader = wrappingReader;

var throwingReader = function throwingReader(msg) {
  return function(reader) {
    return readerError(reader, msg);
  };
};
exports.throwingReader = throwingReader;

var readMeta = function readMeta(reader, _) {
  var metadata = desugarMeta(read(reader, true, void(0), true));
  !(isDictionary(metadata)) ?
    readerError(reader, "Metadata must be Symbol, Keyword, String or Map") :
    void(0);
  return (function() {
    var form = read(reader, true, void(0), true);
    return isObject(form) ?
      withMeta(form, conj(metadata, meta(form))) :
      form;
  })();
};
exports.readMeta = readMeta;

var readRegex = function readRegex(reader) {
  return (function loop(buffer, ch) {
    var recur = loop;
    while (recur === loop) {
      recur = isNil(ch) ?
      readerError(reader, "EOF while reading string") :
    "\\" === ch ?
      (buffer = "" + buffer + ch + (readChar(reader)), ch = readChar(reader), loop) :
    "\"" === ch ?
      rePattern(buffer) :
    "default" ?
      (buffer = "" + buffer + ch, ch = readChar(reader), loop) :
      void(0);
    };
    return recur;
  })("", readChar(reader));
};
exports.readRegex = readRegex;

var readParam = function readParam(reader, initch) {
  var form = readSymbol(reader, initch);
  return isEqual(form, symbol("%")) ?
    symbol("%1") :
    form;
};
exports.readParam = readParam;

var isParam = function isParam(form) {
  return (isSymbol(form)) && ("%" === first(name(form)));
};
exports.isParam = isParam;

var lambdaParamsHash = function lambdaParamsHash(form) {
  return isParam(form) ?
    dictionary(form, form) :
  (isDictionary(form)) || (isVector(form)) || (isList(form)) ?
    conj.apply(conj, map(lambdaParamsHash, vec(form))) :
  "else" ?
    {} :
    void(0);
};
exports.lambdaParamsHash = lambdaParamsHash;

var lambdaParams = function lambdaParams(body) {
  var names = sort(vals(lambdaParamsHash(body)));
  var variadic = isEqual(first(names), symbol("%&"));
  var n = variadic && (count(names) === 1) ?
    0 :
    parseInt(rest(name(last(names))));
  var params = (function loop(names, i) {
    var recur = loop;
    while (recur === loop) {
      recur = i <= n ?
      (names = conj(names, symbol("" + "%" + i)), i = inc(i), loop) :
      names;
    };
    return recur;
  })([], 1);
  return variadic ?
    conj(params, symbol(void(0), "&"), symbol(void(0), "%&")) :
    names;
};
exports.lambdaParams = lambdaParams;

var readLambda = function readLambda(reader) {
  var body = readList(reader);
  return list(symbol(void(0), "fn"), lambdaParams(body), body);
};
exports.readLambda = readLambda;

var readDiscard = function readDiscard(reader, _) {
  read(reader, true, void(0), true);
  return reader;
};
exports.readDiscard = readDiscard;

var macros = function macros(c) {
  return c === "\"" ?
    readString :
  c === ":" ?
    readKeyword :
  c === ";" ?
    readComment :
  c === "'" ?
    wrappingReader(symbol(void(0), "quote")) :
  c === "@" ?
    wrappingReader(symbol(void(0), "deref")) :
  c === "^" ?
    readMeta :
  c === "`" ?
    wrappingReader(symbol(void(0), "syntax-quote")) :
  c === "~" ?
    readUnquote :
  c === "(" ?
    readList :
  c === ")" ?
    readUnmatchedDelimiter :
  c === "[" ?
    readVector :
  c === "]" ?
    readUnmatchedDelimiter :
  c === "{" ?
    readMap :
  c === "}" ?
    readUnmatchedDelimiter :
  c === "\\" ?
    readChar :
  c === "%" ?
    readParam :
  c === "#" ?
    readDispatch :
  "else" ?
    void(0) :
    void(0);
};
exports.macros = macros;

var dispatchMacros = function dispatchMacros(s) {
  return s === "{" ?
    readSet :
  s === "(" ?
    readLambda :
  s === "<" ?
    throwingReader("Unreadable form") :
  s === "\"" ?
    readRegex :
  s === "!" ?
    readComment :
  s === "_" ?
    readDiscard :
  "else" ?
    void(0) :
    void(0);
};
exports.dispatchMacros = dispatchMacros;

var readForm = function readForm(reader, ch) {
  var start = {
    "line": (reader || 0)["line"],
    "column": (reader || 0)["column"]
  };
  var readMacro = macros(ch);
  var form = readMacro ?
    readMacro(reader, ch) :
  isNumberLiteral(reader, ch) ?
    readNumber(reader, ch) :
  "else" ?
    readSymbol(reader, ch) :
    void(0);
  return form === reader ?
    form :
  !((isString(form)) || (isNumber(form)) || (isBoolean(form)) || (isNil(form)) || (isKeyword(form))) ?
    withMeta(form, conj({
      "start": start,
      "end": {
        "line": (reader || 0)["line"],
        "column": (reader || 0)["column"]
      }
    }, meta(form))) :
  "else" ?
    form :
    void(0);
};
exports.readForm = readForm;

var read = function read(reader, eofIsError, sentinel, isRecursive) {
  return (function loop() {
    var recur = loop;
    while (recur === loop) {
      recur = (function() {
      var ch = readChar(reader);
      var form = isNil(ch) ?
        eofIsError ?
          readerError(reader, "EOF") :
          sentinel :
      isWhitespace(ch) ?
        reader :
      isCommentPrefix(ch) ?
        read(readComment(reader, ch), eofIsError, sentinel, isRecursive) :
      "else" ?
        readForm(reader, ch) :
        void(0);
      return form === reader ?
        (loop) :
        form;
    })();
    };
    return recur;
  })();
};
exports.read = read;

var readFromString = function readFromString(source, uri) {
  var reader = pushBackReader(source, uri);
  return read(reader, true, void(0), false);
};
exports.readFromString = readFromString;

var readUuid = function readUuid(uuid) {
  return isString(uuid) ?
    list(symbol(void(0), "UUID."), uuid) :
    readerError(void(0), "UUID literal expects a string as its representation.");
};

var readQueue = function readQueue(items) {
  return isVector(items) ?
    list(symbol(void(0), "PersistentQueue."), items) :
    readerError(void(0), "Queue literal expects a vector for its elements.");
};

var __tagTable__ = dictionary("uuid", readUuid, "queue", readQueue);
exports.__tagTable__ = __tagTable__;

var maybeReadTaggedType = function maybeReadTaggedType(reader, initch) {
  var tag = readSymbol(reader, initch);
  var pfn = __tagTable__[name(tag)];
  return pfn ?
    pfn(read(reader, true, void(0), false)) :
    readerError(reader, "" + "Could not find tag parser for " + (name(tag)) + " in " + ("" + (keys(__tagTable__))));
};
exports.maybeReadTaggedType = maybeReadTaggedType

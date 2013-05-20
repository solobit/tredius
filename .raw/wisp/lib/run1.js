var readFromString = (require("./reader")).readFromString;;

var prStr = (require("./ast")).prStr;
var gensym = (require("./ast")).gensym;
var name = (require("./ast")).name;
var isSyntaxQuote = (require("./ast")).isSyntaxQuote;
var isQuote = (require("./ast")).isQuote;
var isUnquoteSplicing = (require("./ast")).isUnquoteSplicing;
var isUnquote = (require("./ast")).isUnquote;
var namespace = (require("./ast")).namespace;
var keyword = (require("./ast")).keyword;
var isKeyword = (require("./ast")).isKeyword;
var symbol = (require("./ast")).symbol;
var isSymbol = (require("./ast")).isSymbol;
var withMeta = (require("./ast")).withMeta;
var meta = (require("./ast")).meta;;

var concat = (require("./sequence")).concat;
var sort = (require("./sequence")).sort;
var take = (require("./sequence")).take;
var seq = (require("./sequence")).seq;
var filter = (require("./sequence")).filter;
var map = (require("./sequence")).map;
var lazySeq = (require("./sequence")).lazySeq;
var mapList = (require("./sequence")).mapList;
var last = (require("./sequence")).last;
var vec = (require("./sequence")).vec;
var reduceList = (require("./sequence")).reduceList;
var reduce = (require("./sequence")).reduce;
var reverse = (require("./sequence")).reverse;
var conj = (require("./sequence")).conj;
var cons = (require("./sequence")).cons;
var rest = (require("./sequence")).rest;
var third = (require("./sequence")).third;
var second = (require("./sequence")).second;
var first = (require("./sequence")).first;
var list = (require("./sequence")).list;
var isList = (require("./sequence")).isList;
var count = (require("./sequence")).count;
var isEmpty = (require("./sequence")).isEmpty;;

var multiply = (require("./runtime")).multiply;
var divide = (require("./runtime")).divide;
var subtract = (require("./runtime")).subtract;
var sum = (require("./runtime")).sum;
var notGreaterThan = (require("./runtime")).notGreaterThan;
var lessThan = (require("./runtime")).lessThan;
var notLessThan = (require("./runtime")).notLessThan;
var greaterThan = (require("./runtime")).greaterThan;
var isStrictEqual = (require("./runtime")).isStrictEqual;
var isEqual = (require("./runtime")).isEqual;
var or = (require("./runtime")).or;
var int = (require("./runtime")).int;
var char = (require("./runtime")).char;
var and = (require("./runtime")).and;
var str = (require("./runtime")).str;
var dec = (require("./runtime")).dec;
var inc = (require("./runtime")).inc;
var isRePattern = (require("./runtime")).isRePattern;
var isNil = (require("./runtime")).isNil;
var isFalse = (require("./runtime")).isFalse;
var isTrue = (require("./runtime")).isTrue;
var reFind = (require("./runtime")).reFind;
var subs = (require("./runtime")).subs;
var isBoolean = (require("./runtime")).isBoolean;
var isVector = (require("./runtime")).isVector;
var isNumber = (require("./runtime")).isNumber;
var isFn = (require("./runtime")).isFn;
var isObject = (require("./runtime")).isObject;
var isString = (require("./runtime")).isString;
var mapDictionary = (require("./runtime")).mapDictionary;
var isContainsVector = (require("./runtime")).isContainsVector;
var keyValues = (require("./runtime")).keyValues;
var vals = (require("./runtime")).vals;
var keys = (require("./runtime")).keys;
var merge = (require("./runtime")).merge;
var dictionary = (require("./runtime")).dictionary;
var isDictionary = (require("./runtime")).isDictionary;
var isOdd = (require("./runtime")).isOdd;;

var replace = (require("./string")).replace;
var upperCase = (require("./string")).upperCase;
var join = (require("./string")).join;
var split = (require("./string")).split;;

var log = function log(msg) {
  return console.log(msg);
};
exports.log = log;

var kleur = require("color");
exports.kleur = kleur;

require("pkginfo");

require("latest");

require("semver");

require("latest");

var path = require("path");

var fs = require("fs-extra");

require("graceful-fs");

;

var prettyPrint = function prettyPrint(form) {
  return isDictionary(form) ?
    require("prettyjson").render(form) :
    void(0);
};

var prettyTable = (function() {
  var Table = require("cli-table");
  return new Table({
    "head": ["Kop 1", "Kop 2"],
    "colWidths": [100, 200]
  });
})();

prettyTable.push(["First val", "Second val"], ["Value 1", "Value 2"]);

log(prettyTable.toString());

var dumpPrototype = function dumpPrototype(form) {
  "Indien de vorm/gedaante een object is, dump dan de eigenschappen van het\n prototype. Dit helpt inzicht te krijgen in OOP JavaScript externe code.";
  return isObject(form) ?
    Object.getPrototypeOf(form) :
    void(0);
};

var inladenNpm = function inladenNpm() {
  return (function() {
  try {
    require("npm").load(gegevens.package);
    return console.log("NPM config loaded");
  } catch (error) {
    return {
      "error": error
    };
  }})();
};

var genereerStijlblad = function genereerStijlblad(uitvoer) {
  "Stylus is een next-gen pre-processor voor CSS stijlbladen en de meest\n  krachtige engine om nog meer uit de vormgeving van webpagina's te halen.";
  return (function() {
    var stylus = require("stylus");
    var bestand = path.join((hoofdproject || 0)["bron"], (hoofdproject || 0)["code"], (hoofdproject || 0)["stijl"]);
    var stijlblad = fs.readFileSync(bestand, "utf-8");
    var mappen = function() {
      return gegevens.stijl.paden();
    };
    var opties = {
      "filename": gegevens.stijl.uitvoer,
      "paths": [mappen, path.join(mappen, "i18n")]
    };
    return stylus.render(stijlblad, opties, function(exception, css) {
      return (function() {
      try {
        return raise(exception);
      } catch (error) {
        return recover(error);
      } finally {
        return console.error(css);
      }})();
    });
  })();
};

var lijstComponenten = function lijstComponenten() {
  return list();
};

var staticServer = function staticServer() {
  "A streaming static file server supporting partial responses (Ranges),\n  conditional-GET negotiation and granular events.";
  return (function() {
    var http = require("http");
    var url = require("url");
    var sends = require("send");
    return http.createServer(function(req, res) {
      var error = function error(err) {
        res.statusCode = err.status || 500;
        return res.end(err.message);
      };
      var redirect = function redirect() {
        res.statusCode = 301;
        res.setHeader("" + "Location" + req.url + "/");
        return res.end("" + "Redirecting to " + req.url + "/");
      };
      var file = function file() {
        return void(0);
      };
      var stream = function stream() {
        return void(0);
      };
      var end = function end() {
        return void(0);
      };
      return to(sends, req, req.url, from, "/www/example.com/public", maxage, 60000, on, "error", error, on, "directory", redirect, pipe, res);
    }, listen, 3000);
  })();
};

var startDocpad = function startDocpad() {
  "Start een docpad site generator exemplaar op.";
  return require("docpad").createInstance({});
};

var archiveer = function archiveer(soort) {
  var bestanden = Array.prototype.slice.call(arguments, 1);
  return function() {
    switch (arguments.length) {
      
      default:
        (function() { throw Error("Invalid arity"); })()
    };
    return void(0);
  };
};

var uploadFtp = function uploadFtp() {
  "Hiermee uploaden we bestanden naar een remote FTP van een server.";
  return (function() {
    var local = "boo.txt";
    var remote = "boo.remote-copy.txt";
    var client = require("ftp");
    return (function() {
      return client.put(local, remote, (function() {
      try {
        return raise(exception);
      } catch (error) {
        return recover(error);
      } finally {
        return c.end();
      }})(), c.connect());
    })();
  })();
};

var dirp = function dirp(pad, extensie) {
  "Doorloop recursief een mappenstructuur en\n  geef een stream API van bestanden retour.";
  return (function() {
    var readdirp = require("readdirp");
    var es = require("event-stream");
    var options = {
      "root": pad,
      "fileFilter": extensie
    };
    var stream = readdirp(options);
    return to(stream(on, "warn", function(error) {
      return (function() {
      try {
        return raise(exception);
      } catch (error) {
        return console.warn("" + "Non-fatal error: " + error);
      }})();
    }), on("error", function(error) {
      return (function() {
      try {
        return raise(exception);
      } catch (error) {
        return console.error("" + "Fatal: " + error);
      }})();
    }), pipe(es.mapSync(function(entry) {
      return {
        "path": entry.path,
        "size": entry.stat.size
      };
    })), pipe(es.stringify()), pipe(process.stdout()));
  })();
};

var vimeo = function vimeo(id) {
  switch (arguments.length) {
    case 0:
      return (function() {
      try {
        return raise(exception);
      } catch (error) {
        return console.log(error);
      }})();
    case 1:
      return "" + "http://player.vimeo.com/video/" + id + "?api=1&amp;player_id=VideoSpeler-" + id + "&amp;title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;color=e31741";
    
    default:
      (function() { throw Error("Invalid arity"); })()
  };
  return void(0);
};

var cultuur = function cultuur() {
  "Een site bestaat veelal uit meerdere talen, tijd of valuta moeten mee veranderen.";
  return require("i18next").init({});
};

var site = function site(bestand) {
  "Vaak zullen we een referentie tot de sitemap op moeten geven.";
  return "" + (path.join("", "", bestand));
};

var afb = function afb(bestand) {
  "Geef de locatie (map) van afbeeldingen per server, domein, onderdeel of map.";
  return "" + (path.join("", bestand));
};

var conf = function conf() {
  "Projectbestand bevat JSON notatie, lees deze eenvoudig uit met nconf.";
  return require("nconf").file({
    "file": path.join("", "")
  });
};

//It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures. - Alan Perlis
;

var gegevens = {
  "klant": {
    "naam": "Tredius"
  },
  "hoofdproject": {
    "bron": "./",
    "site": "publiek",
    "definitie": "package.json",
    "stijl": "documenten/stijlen/lib/index.styl",
    "afbeeldingen": "media/afbeeldingen"
  },
  "scripting": "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js //ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js //code.createjs.com/preloadjs-0.3.0.min.js /assets/modernizr-custom.js /assets/ui.js /assets/jquery.cookie.js /assets/jquery.circlemenu.js /assets/vimeo.froogaloop2.min.js /assets/mediaverbindingen.js /assets/dragdealer.js /assets/jquery.colorbox.js /assets/jquery.easing.min.js",
  "cssstijl": "/stijlen/algemeen.css /stijlen/circlemenu.css /stijlen/dragdealer.css /stijlen/ui.css",
  "package": {
    "name": "tredius-corporate",
    "version": "0.0.5",
    "description": "Tredius corporate web site",
    "main": "docpad.coffee",
    "private": true,
    "preferGlobal": false,
    "dependencies": {
      "docpad": "6.x",
      "docpad-plugin-cachr": "2.x",
      "docpad-plugin-coffeekup": "2.x",
      "docpad-plugin-coffeescript": "2.x",
      "docpad-plugin-cson": "2.x",
      "docpad-plugin-marked": "2.x",
      "docpad-plugin-partials": "2.x",
      "docpad-plugin-services": "2.x",
      "docpad-plugin-stylus": "2.x",
      "prompt": "~0.2.9",
      "enhanced-require": "~0.5.0-beta5",
      "cluster-live": "0.0.3",
      "i18next": "~1.6.7",
      "node-gettext": "~0.2.11",
      "better-require": "0.0.2",
      "node-minify": "~0.7.3",
      "yaml": "~0.2.3",
      "natural": "~0.1.21",
      "cson": "~1.4.1",
      "lawyer": "~0.1.0",
      "consolidate": "~0.9.1",
      "moment": "~2.0.0",
      "keypress": "~0.1.0",
      "nconf": "~0.6.7",
      "eventemitter2": "~0.4.11",
      "event-stream": "~3.0.14",
      "eyespect": "~0.1.8",
      "node-colorfactory": "~0.1.2",
      "prettyjson": "~0.8.1",
      "cli-table": "~0.2.0",
      "cluster": "~0.7.7",
      "http-proxy": "~0.10.2",
      "vague-time": "~0.5.2",
      "comb": "~0.2.1",
      "stories": "~1.0.4",
      "winston": "~0.7.1",
      "shelljs": "~0.1.4",
      "inflection": "~1.2.5",
      "nopt": "~2.1.1",
      "color": "~0.4.4",
      "latest": "~0.1.1",
      "readdirp": "~0.2.4",
      "ftp": "~0.3.1",
      "fs-extra": "~0.6.1",
      "pretty-data": "~0.40.0",
      "pkginfo": "~0.3.0",
      "archy": "0.0.2",
      "semver": "~1.1.4"
    },
    "devDependencies": {
      "ender": "1.0.1",
      "URIjs": "~1.10.2",
      "chai": "1.6.x",
      "mocha": "1.9.x",
      "docco": "0.6.x",
      "biscotto": "*",
      "grunt": "~0.4.1",
      "cluster": "~0.7.7",
      "benchmark": "~1.0.0",
      "microtime": "~0.3.3"
    },
    "scripts": {
      "test": "echo Fout! Geen test script gedefineerd. && exit 1",
      "start": "echo Fout! Geen start script gedefineerd. && exit 1"
    },
    "repository": {
      "type": "git",
      "url": "git@github.com/solobit/customers.git"
    },
    "author": "Solobit",
    "license": "MIT",
    "readmeFilename": "README.md",
    "gitHead": "185909b228cc42fa2e409a49dc1e6587dd3adf4a",
    "directories": {
      "bin": "bin",
      "lib": "lib",
      "doc": "extra/documentatie",
      "man": "extra/handleiding",
      "example": "extra/voorbeelden"
    },
    "keywords": ["accountancy", "belastingen", "pensioen", "adviseurs", "detachering", "loonadminstratie", "juridische", "diensten"]
  },
  "site": {
    "naam": "Tredius.nl",
    "url": "http//www.tredius.nl",
    "static": "http//static.tredius.nl",
    "development": "http//solobit.github.io/tredius",
    "auteur": "Solobit &amp; Edberry Creative",
    "contact": "info@tredius.nl",
    "landcode": "nl",
    "taal": {
      "xmllang": "nl"
    },
    "essentie": "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland",
    "omschrijving": "Bij Tredius hebben we de behoefte om het MKB landschap te veranderen Vrijheid, Onafhankelijkheid en Zelfstandigheid, voor iedere ondernemer.",
    "keywords": "belasting, advies, accountancy, pensioenbelasting, bedrijfsadministratie, vrijheid, onafhankelijkheid, zelfstandigheid",
    "googleanalytics": "UA-39413290-1",
    "techniek": "Node.js, Docpad, jQuery, Semantic Grid, Stylus, Jade, CoffeeScript, Markdown, Accessible Rich Internet Applications (WAI-ARIA)",
    "disclaimer": "De informatie zoals opgenomen in bovenstaand artikel is uitsluitend bestemd voor algemene informatiedoeleinden. Derhalve dienen op grond van deze informatie geen handelingen te worden verricht zonder voorafgaand deskundig advies. Voor een toelichting kunt u uiteraard contact opnemen met een van onze kantoren.",
    "support": {
      "beheerder": "Solobit",
      "emailadres": "rob.jentzema@gmail.com",
      "servicelijn": "013-5906677"
    },
    "vocabulaire": {
      "xmlns:s": "http://schema.org/",
      "xmlns:foaf": "http://xmlns.com/foaf/0.1/",
      "xmlns:xsd": "http://www.w3.org/2001/XMLSchema#",
      "xmlns:v": "http://rdf.data-vocabulary.org/#",
      "xmlns:pto": "http://www.productontology.org/id/",
      "xmlns:wn": "http://xmlns.com/wordnet/1.6/"
    }
  },
  "frontend": {
    "component": {
      "name": function() {
        return "" + gegevens.klant.naam;
      },
      "main": site("main.js"),
      "scripts": [site("main.js")],
      "styles": [site("main.css")],
      "dependencies": {
        "component/dropload": "*",
        "component/upload": "*",
        "component/file": "*",
        "component/pillbox": "*",
        "component/classes": "*",
        "component/model": "*",
        "component/histogram": "*",
        "component/progress": "*",
        "component/thumb": "*",
        "component/enumerable": "0.3.1",
        "component/dom": "0.6.0"
      }
    }
  },
  "organisatie": {
    "bedrijfsnaam": "Tredius",
    "bedrijfslogo": afb("bedrijfslogo.png"),
    "omschrijving": "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland",
    "auteursrecht": "" + (new Date()) + " © Tredius.nl",
    "bezoekadres": {
      "straat": "Zijlweg 146",
      "postcode": "2015 BH",
      "plaats": "Haarlem"
    },
    "postadres": {
      "postbus": "Postbus 992",
      "postcode": "2003 RZ",
      "plaats": "Haarlem"
    },
    "contacten": {
      "telefoon": "023 551 30 55",
      "fax": "023 551 30 35",
      "email": "info@tredius.nl"
    },
    "handelsinfo": {
      "bedrijfsvorm": "Besloten Venootschap (BV)",
      "kvk": "3782878",
      "btw": "NL8124.72.792.B01"
    }
  },
  "contactpersonen": {
    "marco": {
      "naam": "Marco Krijger MB FB",
      "aanhef": "",
      "titel": "Partner Tredius Fiscalisten",
      "email": "m.krijger@tredius.nl"
    },
    "linda": {
      "naam": "Linda Honig",
      "aanhef": "Mevr.",
      "telefoon": "023 551 30 55",
      "email": ""
    },
    "lennard": {
      "naam": "Lennard Honig",
      "aanhef": "Dhr.",
      "titel": "",
      "telefoon": "023 551 30 55",
      "email": ""
    },
    "luuk": {
      "naam": "Luuk Oosting",
      "aanhef": "Dhr.",
      "titel": "",
      "telefoon": "0299 651 987",
      "email": ""
    },
    "wil": {
      "naam": "Wil Buffing",
      "titel": "Mevr.",
      "telefoon": "0299 411 345",
      "email": ""
    }
  },
  "vestigingen": {
    "purmerend": {
      "bezoekadres": ["Wielingenstraat 119", "1441 ZN", "Purmerend", "Noord-Holland", "Nederland"],
      "geocode": ["52.503605", "4.958375"],
      "rest": "geocode=Cc9PzZeFjzXfFYEnIQMdp59LACmPF3Re0AbGRzF_fLmc8BNprg&amp;sll=52.504454,4.956079&amp;sspn=0.009065,0.019054&amp;mra=pd&amp;t=m&amp;spn=0.0064,0.013282",
      "postadres": ["Postbus 258", "1440 AG", "Purmerend"],
      "telefoon": "0299 411 345",
      "fax": "0299 411 348",
      "email": "info@tredius.nl"
    },
    "monnickendam": {
      "bezoekadres": ["Haringburgwal 17", "1141 AT", "Monnickendam", "Noord-Holland", "Nederland"],
      "geocode": ["52.462874", "5.035343"],
      "rest": "geocode=CXRphrBe0kPwFRuFIAMdStVMACln1vctrAXGRzHfFo4FDFJsxg&amp;aq=&amp;sll=52.505806,4.827991&amp;sspn=0.269159,0.835648&amp;mra=pd&amp;spn=0.006406,0.013282",
      "postadres": ["Postbus 48", "1140 AA", "Monnickendam"],
      "telefoon": "0299 651 987",
      "fax": "0299 653 004",
      "email": "info@tredius.nl"
    },
    "alkmaar": {
      "bezoekadres": ["Professor van der Waalsstraat 3K", "1821 BT", "Alkmaar", "Noord-Holland", "Nederland"],
      "geocode": ["52.625092", "4.770384"],
      "rest": "spn=0.006382,0.013282",
      "postadres": ["Professor van der Waalsstraat 3K", "1821 BT", "Alkmaar"],
      "telefoon": "072 564 4203",
      "fax": "072 564 3019",
      "email": "info@tredius.nl"
    },
    "haarlem": {
      "bezoekadres": ["Zijlweg 146", "2015 BH", "Haarlem", "Noord-Holland", "Nederland"],
      "geocode": ["52.386457", "4.620631"],
      "rest": "geocode=CWxUaXo29tzfFddYHwMdWoFGACkH_TJiEO_FRzHom-tyuYRbow&amp;sll=52.386457,4.620631&amp;sspn=0.008434,0.026114&amp;mra=iwd&amp;spn=0.006417,0.013282",
      "postadres": ["Postbus 992", "2003 RZ", "Haarlem"],
      "telefoon": "023 551 30 55",
      "fax": "023 551 30 35",
      "email": "info@tredius.nl"
    }
  },
  "vormgeving": {
    "typografisch": {
      "primair": ["Open Sans", "400italic", "600italic", "700italic", "400", "600", "700"],
      "alternatief": ["Dosis", "400", "500", "600"]
    },
    "illustraties": {
      "bedrijfslogo": afb("bedrijfslogo.jpg"),
      "site-icoon": afb("favicon.png")
    },
    "vlakindeling": {
      "kolommen": 12,
      "soort": "fixed",
      "breedte": 960
    },
    "kleuren": {
      "oranje": "#F2A34F",
      "wit": "#ffffff",
      "zwart": "#363636",
      "geel": "#7A6A42",
      "goud": "#b88d74",
      "groen": "#7FC028",
      "turquoise": "#6CBBB8",
      "bruin": "#6b4c39",
      "licht-bruin": "#b88c74",
      "paars": "#47427A",
      "licht-paars": "#6664a0",
      "blaauw": "#0183b5",
      "licht-blauw": "#0183b5",
      "donker-blauw": "#403e6b",
      "grijs": "#e0e0e0",
      "licht-grijs": "#f8f8f8",
      "donker-grijs": "#919191",
      "rood": "#e31741",
      "licht-rood": "#6b4c39"
    },
    "stijl": {
      "invoer": "index.styl",
      "uitvoer": "algemeen.css",
      "paden": ["documenten/stijlen/lib/cultivus"]
    }
  },
  "config": {
    "ftp": {
      "source": "https://github.com/mscdex/node-ftp",
      "host": "ftp.tredius.nl",
      "port": 21,
      "secure": true,
      "user": "solobit",
      "password": "secret",
      "connTimeout": 10000,
      "pasvTimeout": 10000,
      "keepalive": 10000
    },
    "i18n": {
      "source": "https://github.com/jamuhl/i18next",
      "help": "http://i18next.com/pages/doc_init.html",
      "preload": ["nl-NL"],
      "lng": "nl-NL",
      "fallbackLng": "en",
      "load": "current",
      "detectLngQS": "taal",
      "useCookie": true,
      "debug": true,
      "keyseparator": "::",
      "nsseparator": ":::",
      "resGetPath": site("/etc/i18n", "/__lng__/__ns__.json"),
      "ns": {
        "namespaces": ["app"],
        "defaultNs": "app"
      }
    }
  },
  "navigatie": {
    "hoofdmenu": {
      "home": "Home",
      "missie": "Wie zijn wij",
      "diensten": {
        "fiscaal": {
          "advies": "Belastingadvies",
          "pensioen": "Pensioen",
          "estate-plan": "Estate Planning"
        },
        "juridisch": {
          "advies": "Juridisch Advies",
          "abonnement": "Juridisch Abonnement"
        },
        "debiteuren": {
          "beheer": "Debiteurenbeheer",
          "werkwijze": "Onze Werkwijze",
          "abonnement": "Abonnement"
        },
        "accountancy": {
          "hr-payroll": "Salaris- en Personeelszaken",
          "accountancy": "Accountancy"
        },
        "risicoadvies": {
          "verzekeren": "Risico-advies & Verzekeringen",
          "pensioen": "Pensioenadvies",
          "overstappen": "Schoenendoos Overstapservice"
        }
      },
      "t-time": {
        "videos": "Tredius vertelt...",
        "nieuwsbrief": "Nieuwsbrief",
        "columns": "Onze columns",
        "special": "Specials"
      },
      "werken-bij": {
        "tredius": "Werken bij Tredius",
        "vacatures": "Vacatures",
        "stages": "Stageplekken",
        "wie-ben-jij": "Wie ben jij?"
      },
      "vestiging": {
        "alkmaar": "Alkmaar",
        "haarlem": "Haarlem",
        "monnickendam": "Monnickendam",
        "purmerend": "Purmerend"
      },
      "contact": "contact"
    }
  }
};

var palet = gegevens.vormgeving.kleuren;

var color = require("color");
exports.color = color;

isObject(color);

log(isObject(color("#363636")));

log(prettyPrint(dumpPrototype(color("#232323"))))

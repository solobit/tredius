
(import [nil? vector? fn? number? string? dictionary?
         key-values str dec inc merge] "./runtime")

;;
;; Special forms
;;

;; Wisp doesn’t have `unless` special form or a macro, but it's trivial
;; to implement it via macro. Although let's try implemting it as a
;; function to understand a use case for macro!

;; We want to execute body unless condition is `true`.
(defn unless-fn [condition body]
  (if condition nil body))

;; Although following code will log "should not print" anyway, since
;; function arguments are exectued before function is called.
(unless-fn true (console.log "should not print"))


;;
;; Convenience methods
;;

 (defn exit
  "Exit the running process having number as exit code."
  ^{
      :inline (fn [x] (.exit process x))
   }
  [x] (.exit process x))


 (defn println
  "Print a new line to the console"
  ^{
      :inline (fn [x] (.log console x))
    }
    [x] (.log console x))


 ;; ((open)) Meta-data left to right-hand side? Creates a new Var and copies the root
 ;; binding? Rebind or alter (set! value) one Var it does not affect the other?
 (defmacro alias
  "Quote splicing the name and body to the use of def. Returns a new Var bound to the symbol"
  {
    :author "R. Jentzema"
    :status "unstable"
    :inline (fn [name & body] `(def ~name ~@body))
   }
    [name & body]
    `(def ~name ~@body))

 ;; Testing
 ; (println "Hello")

 (alias log println)


;; Every function in JavaScript is actually a `Function` object.

;; Function objects created with the Function constructor are parsed when the
;; function is created.

;; This is less efficient than declaring a function and calling it within your
;; code, because functions declared with the function statement are parsed with
;; the rest of the code.


;; All arguments passed to the function are treated as the names of the
;; identifiers of the parameters in the function to be created, in the order in
;; which they are passed.

;; Note: Functions created with the Function constructor do not create closures
;; to their creation contexts; they always run in the window context (unless the
;; function body starts with a "use strict"; statement, in which case the
;; context is undefined).

;; Invoking the Function constructor as a function (without using the new
;; operator) has the same effect as invoking it as a constructor.


(log (Function.)) ;=> [Function] ;<= console.log(new Function());
(log (Object.))
(log (Array.))

(== (Array.) [])
(log (== {} {}))
(log (== (typeof []) (typeof {})))

(def funky (fn [] (Function.)))

(def arr1 (Array.))
(def arr2 [])

; (def predicates {:hello {}})
; (def myself {:plugins {} :functions {} :meta {} :predicates {}} )
(def wisp (require "wisp"))
(log wisp)
;(def func [args & body] (new Function(a) ))


;(defn xa [] (fn [] (.log console "x")))

;; note the even number of forms key/value pairs
;(require "stylus")
;(log this)

;; (def today (Date.))

;; Translation / i18n

;; (def slang (log process.env.LANG))
;; (defn tl [& translations] (log translations))
;; (T  :en "Some sentence is important?" 
;;    :nl "Sommige zinnen zijn belangrijk?"
;;    :fr "Pour la mon de notre song"
;;






;; Predicates ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; A boolean-valued function, a predicate or a proposition, is a function of the
;; type f : X → B, where X is an arbitrary set and where B is a boolean domain.
;; In other words, it returns a true or false value.
;;


 (defn is [x y]
    (== x y))
 
 (defn isNil [x]
  ^{:usage  "(nil? x)"
    :doc    "Returns true if num is nil, else false"
    :inline (fn [x] `(is ~x nil))}
  (is x nil))

 (defn isType
  "Returns a string representation of the (data) type of the variable."
  [x]
  (typeof x))

 (defn isUndef
  "Defines a functional predicate `undef?`"
  [x]
    (log (typeof x)))

 (defn isObj
  "Defines a functional predicate `obj?`"
  [x]
    (is (typeof x) "object"))

 (defn isNumber 
  "Defines a functional predicate `num?`"
  [x] 
    (is (typeof x) "number"))
 
 (defn isStr
  "Defines a functional predicate `num?`"
  [x]
    (is (typeof x) "string"))
 
 (defn isBool [x]
  "Defines a functional predicate `bool?` "
    (is (typeof x) "boolean"))

 (defn isList
  "Defines a functional predicate `list?`"
  [x]
    (is (typeof x) "list"))

 (defn isZero [x]
  "Defines a functional predicate `zero?`"
    (is x 0))


(log (type? [])) ;=> object



;;
;; Creational
;;

 (defn create-object [] {})
 (defn create-list [] [])

 (def object {})
 (def array [])






;(.slice [1 2 3 4])

;(log (obj? []))



;;
;; Macros
;;

;; don't use defmacro if defn will work fine
;(defmacro Square [x] 
;  (* x x))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Import required modules
;;

;; Internals
;;

;; Node.js core modules
(def fs (require "fs"))
(def path (require "path"))
(def doms (require "domain"))

;; Externals
;;

;; Configuration
(def nconf (require "nconf"))

;; Events
(def events (require "eventemitter2"))

;; Testing
(def bm (require "benchmark"))

;; Koffie
(def cc (require "coffeecup"))
(def coffee (require "coffee-script"))

;; Terminal console
(def eye (require "eyespect"))
(def colors (require "colors"))

;; Colors
(def colorfactory (require "node-colorfactory"))
(def ppjson (require "prettyjson"))


;; Generators, engines
(def docpad (require "docpad"))
(def stylus (require "stylus"))

;; Talen
(def consolidate (require "consolidate"))

;; Internationaal taalondersteuning
(def moment (require "moment"))
(.lang moment "nl")     ; setter
(log (.lang moment))    ; getter
(log (.format (moment))) ; nl tijd

(def dtIso "Wed May 15 2013 22:21:10 GMT+0200 (CEST)")
(log (.format (moment dtIso)))
(log (String. "foo"))


;; Testing
(def benchmark (.Benchmark bm))
;(log benchmark)





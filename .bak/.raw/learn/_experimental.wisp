
(import [cons conj list list? seq vec
         empty? count
         first second third rest last butlast
         take drop
         concat reverse sort
         map filter reduce] "./sequence")
(import [str inc dec even? odd? vals key-values keys =] "./runtime")

;; situation : we have a number of functions to do with moving that essentially
;; involved passing different keys to a map under different symbols that could
;; be used in the REPL.

(defn log [msg] (.log console msg))


;; Ruby way of meta-programming

;; Generic abstracted function
(defn operation [code]

  ;; some other stuff
)

(def awesome {
  :open     (operation \o)
  :close    (operation \c)
  :find     (operation \f)
  :look     (operation \l)
  :iterate  (operation \i)
  :verbose  (operation \v)
  })


(import repl "repl")
(import vm "vm")
(import [transpile] "./engine/node")
(import [count list] "./sequence")
(import [compile compile-program] "./compiler")
(import [pr-str] "./ast")
(import [read push-back-reader] "./reader")
(import [upper-case lower-case capitalize split join] "./string")
(import [subs = nil? vector? fn? number? string? dictionary?
         key-values str dec inc merge] "./runtime")


(defn println [x]
  "Print to the console (naive)"
  (.log console x))

;; TODO: dynamic compiler flag not implemented yet
(def ^:dynamic bar 10)


(println (vector? [])) ;=> true
(println (Object.prototype.toString.call [])) ;=> [object Array]
(println (Object.prototype.toString.call bar)) ;
(number? bar)


(.log console bar)
(set! bar 11)
(.log console bar)

(defmacro defonce
  "defs name to have the root value of the expr iff the named var has no root value,
  else expr is unevaluated"
  {:added "1.0"}
  [name expr]
  `(let [v# (def ~name)]
     (when-not (.hasRoot v#)
       (def ~name ~expr))))

;(.log console 'defonce)
(def
 ^{ :doc "Bind to true if you want write to use pretty printing"
    :added "a.b.c"}
 *print-pretty* true)


(import [str inc dec even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third
         rest last butlast take drop count concat reverse sort map filter
         reduce] "./sequence")

(defn unless-fn [condition body]
  (if condition nil body))

(unless-fn true (console.log "should not print"))

;(.log console (cons 1 (cons 2 (cons 3 nil))))
;(.log console (cons "abcd" (cons "efgh")))

(def foo "singleton")
(.log console (cons foo nil))

(defmacro unless
  [condition form]
  (list 'if condition nil form))

(def x '(1 2 3 4))
(def y '(5 6 7 8))

(.log console (conj '(1 2 3) x ))

(unless true (console.log "should not print"))


;; wisp {:key "value"}    ~> json {"key": "value"}
;; coffee {key: 'value'}  ~>
(import [str inc dec even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third
         rest last butlast take drop count concat reverse sort map filter
         reduce] "./sequence")

;; Evaluation can occur in many contexts: * Interactively, in the REPL * On a
;; sequence of forms read from a stream, via load / load-file / load- reader /
;; load-string * Programmatically, via eval

;; Wisp programs are composed of expressions. Every form not handled
;; specially by a special form or macro is considered by the compiler to be an
;; expression, which is evaluated to yield a value.

"hello" ;=> "hello"

;; There are no declarations or statements, although sometimes expressions may
;; be evaluated for their side- effects and their values ignored.

;;...

;; unquote-splice is unquote which merges the list to the position where it's
;; used. Difference looks like this:

(.log console `("dit is isee" ))
(.log console
 (let [a `(\f\u\n\k\y \s\h\i\t)]
  (.log console a)
  (.log console (first a))
  (.log console (rest a))))

(.log console `(1 2 ~(list 3 4)))   ;=>  (1 2 (3 4))
(.log console `(1 2 ~@(list 3 4)))  ;=>  (1 2 3 4)

;(import "prettyjson" "cli-table")

;; `  == syntax-quote
;; ~  == unquote
;; ~@ == unquote-splice

;; So ~@unquote-splice just flattens a list


;; In all cases, evaluation is the same - a single object is considered by the
;; compiler, evaluated, and its result returned. If an expression needs to be
;; compiled, it will be. There is no separate compilation step, nor any need to
;; worry that a function you have defined is being interpreted. Clojure has no
;; interpreter.

;; They are kind of dummy values. The reader expands ~x to (unquote x) and ~@x
;; to (unquote-splice x). Lists of these types are then handled specially in
;; syntax-quote. Their declaration allows also their use outside of syntax-
;; quote, e.g. in your own macros. Since they are not bound to anything, their
;; use outside of syntax-quote or a macro which handles them throws an
;; exception.


(import [transpile] "./engine/node")

(import path "path")

(.log console (transpile "(. console log \"thisthat\")"))


;(def gegevens {:stijl {:invoer "index.styl" :uitvoer "algemeen.css" :locaties (get gegegevens (.-invoer stijl))}})

(. console log (get 1 (get 1 2)))

(def stylustr "

thema()
  .someClass
    background grey

thema()
")

(defn- render-stylus [x]
  "Render a string of stylus"
  (let [stylus (require "stylus")]
    (. stylus render x
      (fn [exception css]
        (try
          (throw exception)
          (catch error (.log console error))
          (finally (.log console css)))))))

(render-stylus stylustr)



(defn split-splices "" [form fn-name]
  (defn make-splice "" [form]

    ;; Strings, numbers, characters, true, false, nil and keywords evaluate to
    ;; themselves.
    (if (or (self-evaluating? form)
            (symbol? form))
        (apply-unquoted-form fn-name (list form))
        (apply-unquoted-form fn-name form)))
  (loop [nodes form
         slices '()
         acc '()]
   (if (empty? nodes)
       (reverse
        (if (empty? acc)
            slices
            (cons (make-splice (reverse acc)) slices)))
       (let [node (first nodes)]
        (if (unquote-splicing? node)
            (recur (rest nodes)
                   (cons (second node)
                         (if (empty? acc)
                             slices
                             (cons (make-splice (reverse acc)) slices)))
                   '())
            (recur (rest nodes)
                   slices
                   (cons node acc)))))))


;(split-splices)

 ;(loop [form '() names imports]
     ;    (if (empty? names)
      ;              (.log console "xxx")



;(import "prettyjson")
;(.log console prettyjson)

;
;(def tables (require "cli-table"))
;
;(defn pprint
; (let [ write (. (require "prettyjson") render) ]
; ([] nil)
; ([kvs] (write  kvs))
; ([kvs color] (. get-pretty-writer kvs color))))
;
;;; test pp
;
;
;
;(def kvs {:data { :foo ["Hello" "Cruel" "World"] :ages [1 2 3 4 5 6 7 8]
;                  :name "Robby Reborn" :dowhat "Fckn everything"}
;          :color { :keysColor "rainbow" :dashColor "magenta" :stringColor "white"}})
;
;(pprint kvs.data)
;(pprint kvs.data kvs.color)
;
;
;(def Table (require "cli-table"))
;
;(def table (Table. {:head ["TH 1 label" "TH 2 label"]
;                    :colWidths [100 200]}))
;
;(defn set-table-heads)
;
;;// table is an Array, so you can `push`, `unshift`, `splice` and friends
;;table.push(
;;    ['First value', 'Second value']
;;  , ['First value', 'Second value']
;;
;console.log(table.toString());


(defmacro chain
  ([x form] (list '. x form))
  ([x form & more] (concat (list 'chain (list '. x form)) more)))

(def pointless (fn [n] n))
(log (pointless (+ 3 4)))

(log (.join path proj-dir "/abc.com"))
;(log (:configfile docpad))

;(log (:licenses docpad))
;(log (:instance docpad))
;(log process)
;(log module)
;(chain nconf env (file {:file "../../../../package.json"}))

(defn exampl1 []
(log (map list [1 2 3]
              '(\a \b \c)
              '(4 9 3 5 6 5))))












;;dp config

;; ((__indexOf.call(process.argv "-d") >= 0) ? 7 : 6)
;;process.argv.join("").indexOf("test") === -1
;;process.argv.join("").indexOf("test") === -1

;; :checkVersion process.argv.length >= 2 && /docpad$/.test(process.argv[1])
;; :welcome process.argv.length >= 2 && /docpad$/.test(process.argv[1])
;; :prompts process.argv.length >= 2 && /docpad$/.test(process.argv[1]
;;   :getPreparedTitle function() {
;;     if (this.document.title) {
;;       return "" + this.document.title + " | " + this.site.title;
;;     } else {
;;       return this.site.title;
;;     }
;;   }
;;   :getPreparedDescription function() {
;;     return this.document.description || this.site.description;
;;   }
;;   :getPreparedKeywords function() {
;;     return this.site.keywords.concat(this.document.keywords || []).join(" ");
;;   }
;; Generated by CoffeeScript 1.6.2
;; var __indexOf = [].indexOf || function(item) { for (var i = 0 l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };
;;   function(opts) {
;;     var docpad server;

;;     server = opts.server;
;;     return docpad = this.docpad;
;;   }
;; }

(import fs "fs")
(import path "path")

(import [cons conj list list? seq vec empty? count first second third rest last butlast take drop concat reverse sort map filter reduce] "./sequence")
(import [str inc dec nil? even? odd? vals key-values keys =] "./runtime")

;; (def tree1 {:val 5, :l nil, :r nil})


(defn xconj [t v]
  (cond
    (nil? t) {:val v, :l nil, :r nil}))

(defn xseq [t]
  (when t
    (concat (xseq (:l t)) [(:val t)] (xseq (:r t)))))

(defn mktree
  ([label l r] (cons label (cons l r)))
  ([leaf] (cons leaf (cons nil nil))))
(defn getlabel [t] (first t))
(defn getchildren [t] (rest t))
(defn getleft [t] (first (getchildren t)))
(defn getright [t] (rest (getchildren t)))

(mktree 'A (mktree 'B (mktree 'D) (mktree 'E)) (mktree 'C nil (mktree 'F)))

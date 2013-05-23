


(import path "path")


;; Wisp reader
(import [breaking-whitespace? whitespace? read read-lambda
         lambda-params-hash newline? numeric? comment-prefix? number-literal?
         read-from-string] "../reader")

;; Wisp Abstract Syntax Tree
(import [meta with-meta symbol? symbol keyword? keyword namespace
         unquote? unquote-splicing? quote? syntax-quote? name gensym pr-str] "../ast")

;; TODO JavaScript reader, parser

(import [empty? count list? list first second third rest cons conj
         reverse butlast reduce reduce-list vec last map-list lazy-seq
         map take butlast sort  drop filter seq take sort concat] "../sequence")

(import [odd? even? dictionary? dictionary merge keys vals key-values contains-vector?
         map-dictionary string? object? fn? number? vector? boolean? subs re-find
         true? false? nil? re-pattern? inc dec str and char int
         or = == > >= < <= + - / *] "../runtime")

(import [split join upper-case replace] "../string")


;; MOVE to wisp libs should alias to console.log probably
(defn println [x] (. console log x))

(defn- dump-prototype [form]
 "Dump properties of an Object's prototypical ancestor to the console."
  (if (object? form) (.get-prototype-of Object form) nil))



(defmacro dbg[x] `(let [x ~x] (println '~x "=" x) x))

(defn pythag [ x y ]  (dbg (* (dbg (* x x)) (dbg (* y y)))))

(pythag 4 5)


(defn dbg-code [s]
  (list 'let ['a s] (list 'println (list 'quote s) "=" 'a) 'a))

(defmacro dbg-1 [s]
  (list 'let ['a s] (list 'println (list 'quote s) "=" 'a) 'a))


;; (defn factorial [n]
;;  (if (< n 2) n
;;      (dbg-1 (* n (factorial (dec n))))))

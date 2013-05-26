
;; Clojure is a functional programming language. It provides the tools to avoid
;; mutable state, provides functions as first-class objects, and emphasizes
;; recursive iteration instead of side-effect based looping.

;; The philosophy behind Clojure is that most parts of most programs should be
;; functional, and that programs that are more functional are more robust.

;; The following function symbols are imported into the scope of this file. We
;; reference `.wisp` files here.
(import [str inc dec even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third
         rest last butlast take drop count concat reverse sort map filter
         reduce] "./sequence")


;;
;; Function objects
;;

;; `fn` creates a function object. It yields a value like any other - you can
;; store it in a var, pass it to functions etc.

(def log (fn [msg] (.log console msg)))

(def hello (fn [] "Hello world"))

(log (hello)) ;=> "Hello world"

;; Overloading

;; `defn` is a macro that makes defining functions a little simpler. Wisp supports
;; arity overloading in a single function object, self-reference, and variable-
;; arity functions using `&`

(defn argcount
  ([] 0)
  ([x] 1)
  ([x y] 2)
  ([x y & more] (+ (argcount x y) (count more))))

(log (argcount 1 2 3 4 5 6)) ;=> 6


;; You can create local names for values inside a function using let. The scope
;; of any local names is lexical, so a function created in the scope of local
;; names will close over their values:

(defn make-adder [x]
  (let [y x]
    (fn [z] (+ y z))))
(def add2 (make-adder 2))

(log (add2 4)) ;=> 6


;; Locals created with let are not variables. Once created their values never
;; change!

(def
 ^{:arglists '([map key val] [map key val & kvs])
   :doc "assoc[iate]. When applied to a map, returns a new map of the
    same (hashed/sorted) type, that contains the mapping of key(s) to
    val(s). When applied to a vector, returns a new vector that
    contains val at index. Note - index must be <= (count vector)."
   :added "1.0"
   :static true}
 assoc
 (fn ^:static assoc
   ;;([map key val] (. clojure.lang.RT (assoc map key val)))
   ([map key val & kvs]
    (let [ret (assoc map key val)]
      (if kvs
        (recur ret (first kvs) (second kvs) (nnext kvs))
        ret)))))

(assoc [1 2 3 4] 1 5)

;; (let [my-vector [1 2 3 4]
;;       my-map {:fred "ethel"}
;;       my-list (list 4 3 2 1)]
;;   (list
;;     (conj my-vector 5)
;;     (assoc my-map :ricky "lucy")
;;     (conj my-list 5)
;;     ;the originals are intact
;;     my-vector
;;     my-map
;;     my-list))


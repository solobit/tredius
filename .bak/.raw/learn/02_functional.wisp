

(import [read-from-string] "./reader")
(import [str inc dec even? odd? vals key-values keys =] "./runtime")
(import [cons conj list list? seq vec empty? count first second third
         rest last butlast take drop count concat reverse sort map filter
         reduce] "./sequence")


(def strx "some string")

(.log console (read-from-string strx))


(defn double [x] (* 2 x))
(.log console (map double [1 2 3 4 5]))

(def conf {
  :akey "value"
  :bkey "valse"
  :ckey "vluee"
  })


(defn make-adder [y]
 "Constructs an anonymous function, closing over the parameter y."
  (fn [x] (+ x y)))

;; apply an newly constructed adder to all elements of a collection
(.log console (map (make-adder 10) [1 2 3 4 5]))

(.log console (map (make-adder 10) [2 3 4]))

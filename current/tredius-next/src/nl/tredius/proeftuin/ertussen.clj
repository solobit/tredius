
(defn ertussen?
  "Returns true if the first argument x is equal to or greater than
  the first element of y, and less than the tail of y."
  [x y]
  (if (and (>= x (y 0)) (< x (y 1)))
    true false))

(ertussen? 33 [1 44])

(defn zoeken
  [pc]
  (loop [x postcode-gebieden
         i 0]
    ;;(if (ertussen? pc [(second x) (last x)])
      (get x i)
    (recur x (inc i))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defmacro defpredicate
  [form-name logical-test]
  `(defn ~form-name
     [] (if ~logical-test true false)))


(map-indexed vector postcode-gebieden)



(defpredicate doen? (= true true))


;(map #(println %) (iterate inc 0) ["Hello" "World" "Test" "This"])


(seq? (seq [1 2 4]))


(> 3444 9400)


(defn opzoeken-postcode
  [invoer]
  (for [i postcode-gebieden
        :when (and (< invoer (i 1))
                   (< invoer (i 2)))]
  i))

(opzoeken-postcode 4444)
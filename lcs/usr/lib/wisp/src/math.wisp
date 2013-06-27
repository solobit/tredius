
;;
;; Wisp math module
;;

(def version "0.0.1")

;; Public functions <http://goo.gl/mGr0K>

(defn factorial [n] (if (< n 2) 1 (* n (factorial (- n 1)))))

(defn average [v1 v2] (/ (+ v1 v2) 2))

(defn square [n] (* n n))

(defn abs [n] (if (< n 0) (* -1 n) n))

(defn sqrt [n]
  (def improve (fn [guess]
    (average guess (/ n guess))))
  (def good-enough? (fn [guess]
    (< (abs (- (square guess) n)) 0.0000000001)))
  (def tryit (fn [guess]
    (if (good-enough? guess)
      guess
      (tryit (improve guess)))))
  (tryit 1))

;(. console log this)


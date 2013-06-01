(ns foo
  (:refer-clojure :exclude [==])
  (:use [clojure.core.logic]))

(run* [q]
  (== q true))





(defn adler-32 [s]
  (let [base 65521
        [low high] (reduce (fn [[a b] ch] [(+ a (int ch))
                                           (+ b a (int ch))])
                           [1 0]
                           s)]
    (+ (bit-shift-left (mod high base) 16) (mod low base))))

(adler-32 "This is a fun job")

(defn Y
  "The Y combinator is a higher-order function which computes a fixed point of other functions.
  It is a kind of fixed-point combinator studied in the lambda calculus."
  [m]
 ((fn [future]
    (m (fn [arg]
         ((future future) arg))))
  (fn [future]
    (m (fn [arg]
         ((future future) arg)))) ))


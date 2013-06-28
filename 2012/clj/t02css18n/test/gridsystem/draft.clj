
(ns foo
  (:require [garden.units :refer (px+ px* px- px-div px pt)]))

(reduce + (range 1 100 2))


(defn make-columns
  "Creates a range of column sizes."
  [width columns gutter]
  (let [rng (map #(px %) (range 0 width columns))]
    (doall (interpose (px gutter) rng))


   ))

(println (make-columns 1024 60 10))
(ns tredius.assets.styles.main
  (:refer-clojure :exclude [+ - * /])
  (:use cssgen cssgen.types clojure.test
    [clojure.algo.generic.arithmetic :only (+ - * /)]))

(rule "a"
      :color "#aaa")


;; Mixin (functions)
(defn anchor []
  (mixin
    :padding 0
    (rule "a"
      :color :blue)))

;; Multiple rules and props
(rule ".block, .group"
  (anchor))

;; Mixin (properties)
(def prop1
  (mixin :color :#fff
        :background-color "black"))

(def prop2
  (mixin :width "100%"
        :display "block"))

(def prop3
  (mixin :height :100px))



(clojure.string/reverse (subs (clojure.string/reverse "100%") 1))
(def ^:dynamic *columns* 12)
(def ^:dynamic *column-width* 80)
(def ^:dynamic *gutter-width* 0)

(defn- grid-system-width [c cw gw] (str (* c (+ cw gw)) "px"))

(defn total-width
  ([] (grid-system-width *columns* *column-width* *gutter-width*))
  ([n] (if (= (first (clojure.string/reverse n)) \%) n)))





(defn row [col]
  (mixin :display "inline-block"
         :overflow "hidden"
         :width (* total-width (* (/ grid-system-width (+ *gutter-width* grid-system-width))) -1)))






;(total-width "100%")

(defn column [n]
  (if (<= n *columns*) (mixin :width (str (* n *column-width*) "px")) ))




(column 12)
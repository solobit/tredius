;; Semantic.gs Stylus
(ns tredius.assets.styles.main
  (:refer-clojure :exclude [+ - * /])
  (:use cssgen cssgen.types clojure.test
    [clojure.algo.generic.arithmetic :only (+ - * /)]))

;; Defaults which you can freely override
(def column-width 60)
(def gutter-width 20)
(def columns 12)
(defn fluid? [] false)

(def gridsystem-width (* columns (+ column-width gutter-width)))

;; Set total-width to (% 100) for a fluid layout
(defn total-width [] (if fluid? (% 100) (gridsystem-width)))


;;;;;;;;;;
;; GRID ;;
;;;;;;;;;;

(rule "body"
  :width (% 100)
  :float :left)

(defn row [col]
  (mixin
   :display  :inline-block
   :overflow :hidden
   :width (* total-width (/ (+ gutter-width gridsystem-width) gridsystem-width))

   :margin 0 (* total-width (* (/ (* 0.5 gutter-width) gridsystem-width) -1 ))))


(defn column [x]
  (mixin
    :display  :inline
    :float    :left
    :overflow :hidden
    :width     (* total-width (/ (- (* x (+ gutter-width column-width)) gutter-width) gridsystem-width))

    :margin 0 (px (* total-width (/ (* gutter-width 0.5) gridsystem-width)))))


;(column 12)
(ns none)
(def ^:dynamic column-width 60)
(def ^:dynamic gutter-width 20)
(def ^:dynamic columns 12)
(def ^:dynamic total-width gridsystem-width)
(def ^:dynamic min-width 960)

(defn- gridsystem-width
  "Internal calculation for grid width."
  [] (keyword (str (* (+ (* column-width columns)
                         (* gutter-width columns))) "px")))

(defn correction
  [] (format "%.5f" (* 100 (float (/ 0.5 min-width)))))

(defn clearfix [x]
  (css "
    .clearfix() {
      *zoom:1;

      &:before,
      &:after {
          content:"";
          display:table;
      }
      &:after {
          clear:both;
      }
    }"))

(cs/defrule body :grid
            [:width "100%"])




;(defn min? [x y] (> x y))
;(min? (gridsystem-width) min-width)

(binding [column-width 70
          gutter-width 0
          columns 10]
  (keyword (str (px (* columns
     (+ column-width gutter-width))))))

;;(defmacro defgrid
;;  [name cols gutter]
;;  `(cs/defmixin ))
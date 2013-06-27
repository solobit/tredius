;;
;; 07 - Style sheets unification
;;

;; Problem: there aren't many CSS Clojure libraries and the two best,
;; both have functionality that I want. So we must combine the best.

(ns nl.tredius.lab.07
  (:use [cssgen])
  (:require [gaka.core :as gaka]))


;;
;; cssgen (> 1 year)
;;

;; Constants
(def width (px 960))

;; Expressions (using constant)
(def main-width (* width 0.62))

;; Rules (nested)
(rule "a.plain"
      :color           :inherit
      :text-decoration :inherit
      :cursor          :inherit
      (rule "&:active, &:focus"
        :outline :none))

;; Reusable
(def has-layout
  (mixin
   ; This makes ie6 get layout
   :display "inline-block"
   ; and this puts it back to block
   (rule "&" :display :block)))

(def clearfix
  (mixin
   :overflow :hidden
   has-layout))


;;
;; Gaka (> 11 mo)
;;

;; Rules as hiccup-like DSL of arrays
(def rules [:div#foo
            :margin "0px"
            [:span.bar
             :color "black"
             :font-weight "bold"
             [:a:hover
              :text-decoration "none"]]])

;; Print CSS output (indented)
(println (gaka/css rules))

;; No indention
(binding [gaka/*print-indent* false]
        (println (gaka/css rules)))

;; Uses a list (to be flattened) for attributes
(def standard-attrs (list :margin 0 :padding 0 :font-size "12px"))
(println (gaka/css [:div standard-attrs :color "red"]))

;; Reuse components to create mixins
(defn color [x] (list :color x))
(println (gaka/css [:div (color "red")]))

;; WRONG! (println (gaka/css [:a {:border 0 :border-left "1px"}]))
;; The order of map keys/values is unpredictable.

(println (gaka/css [:a :border 0 :border-left "1px"])) ;; none
(println (gaka/css [:a (list :border 0 :border-left "1px")])) ;; list
(println (gaka/css [:a :border 0 {:border-left "1px"}])) ;; closing map
(println (gaka/css [:a {:border 0} {:border-left "1px"}])) ;; two maps

;; Fancy selector attribute but not as keyword
(println (gaka/css ["input[type=text]" :font-family "\"Bitstream Vera Sans\", monospace"]))

;; Suitable for inline CSS
(println (str "<div style=\""
              (gaka/inline-css :color :red)
              "\">foo</div>"))





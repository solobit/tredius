(ns nl.tredius.mailer.style
  (:require [clj-style.core :as cs]))

;;
;; Rules
;;

(cs/defrule div-foo
  [:div#foo
   :margin "0px"
   [:span.bar
    :color "black"
    :font-weight "bold"
    [:a:hover
     :text-decoration "none"]]])

div-foo

;;
;; Groups I
;;

(cs/defrule div-baz :screen
  [:div#baz
   :padding :5px
   :margin :10px])

div-baz

;;
;; Printing
;;

(cs/render div-baz)
(println (cs/render div-baz))

;;
;; Mixins
;;

(cs/defmixin blue []
  :color :blue)

(blue)

(cs/defmixin wrapper [width]
  :margin :0px
  :width width)

(wrapper :750px)

;; mixin mixin
(cs/defmixin blue-on-black []
  (blue)
  :background-color :black)

(blue-on-black)

(cs/defrule blue-div
  [:div
   :width :100px
   (blue-on-black)])

blue-div

;;
;; Inline suitable CSS
;;

(cs/render (blue))

(cs/render (blue-on-black))

(str "<p style=\"" (cs/render (blue)) "\">hello world</p>")

;;
;; Groups II
;;

(cs/defrule div-foo :main
  [:div#foo
   :padding :5px
   :margin :10px])

(cs/defrule div-bar :main
  [:div#bar
   :padding :10px
   :margin :20px])

(cs/defrule div-baz :extra
  [:div#baz
   :padding :20px
   :margin :30px])

(cs/render :main)

(cs/render :extra)

;(cs/save "styles-main.css" :main)
;(cs/save "styles-extra.css" :extra)

(cs/defrule div-foo :screen
  [:div#foo
   :padding :5px
   :margin :10px])

(cs/defrule div-bar :screen
  [:div#bar
   :padding :10px
   :margin :20px])

(cs/defrule div-foo-p :print
  [:div#foo
   :padding :20px
   :margin :30px])

(cs/defrule div-bar-p :print
  [:div#bar
   :padding :20px
   :margin :30px])

;(cs/save "out/browser-styles.css" :screen)
;(cs/save "out/printer-styles.css" :print)


;;
;; Reset
;;

(cs/reset-rules!)

;;
;; Nesting without duplicates use :ignore
;;
(cs/defrule link :ignore [:a :text-decoration :none])

(cs/defrule widget [:.widget :color :black link])

(cs/render) ;; :default

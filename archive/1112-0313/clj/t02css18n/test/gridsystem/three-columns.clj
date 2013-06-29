(ns gridsystem.three-columns
  "Seperated out 3-columns"
  (:use [gridsystem.rules]
        [gridsystem.core]
        [compojure.core]
        [ring.adapter.jetty])
  (:refer-clojure :exclude [+ - * /])
  (:require [taoensso.tower :as tower
             :refer (with-locale with-scope t style)]
            [compojure.handler :as handler]
            [compojure.route :as route]
            [garden.units :as gu :refer [px em]]
            [garden.color :as gc :refer [hsl]]
            [garden.arithemetic :refer [+ - * /]]
            [garden.def :refer [defrule]]
            [garden.core :refer [css]]
            [hiccup.page :refer [html5]]))


;; Define our "fixed" grid CSS.
(def three-columns
  ;; Create a standard grid and bind the key values.
  (let [{:keys [row column push pull]} (create-grid)]
    (styles
     ["*" "*:after" "*:before"
      {:box-sizing "border-box"}]

     [:body
      {:width (gu/percent 100)
       :font-family [["Georgia" :sans-serif]]
       :padding 0
       :margin 0}
      clearfix]

     (headings
      {:font-weight "normal"})

     (center
      {:width (px 960)
       :margin [0 "auto"]
       :overflow "hidden"})

     (top
      (column 12)
      {:margin-bottom (em 1)
       :color (hsl [0 0 100])
       :background (hsl [0 0 0])
       :padding (px 20)})

     (left
      center-text
      (column 4)
      {:color (hsl [0 0 40])
       :background (hsl [0 0 80])
       :padding (px 20)})

     (middle
      center-text
      (column 4)
      {:color (hsl [0 0 40])
       :background (hsl [0 0 80])
       :padding (px 20)})

     (right
      center-text
      (column 4)
      {:color (hsl [0 0 40])
       :background (hsl [0 0 80])
       :padding (px 20)}))))
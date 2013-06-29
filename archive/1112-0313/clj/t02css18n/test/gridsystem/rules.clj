(ns gridsystem.rules
  "Common defrules"
  (:use [compojure.core])
  (:refer-clojure :exclude [+ - * /])
  (:require [garden.def :refer [defrule]]))


;; With our grid factory in place let's put together a demo. For
;; demonstration purposes we'll take the easy route and build the
;; "fixed" grid (http://semantic.gs/examples/fixed/fixed.html).

;; I like to create this alias because it better expresses the intent
;; in the context of gardening.
(def styles list)

;; Define a few rule functions to make the code more expressive and
;; readable.

;(defrule center :div.center)
(defrule top :section#top)
(defrule main :section#main)
(defrule sidebar :section#sidebar)
(defrule left :section#left)
(defrule right :section#right)
(defrule middle :section#middle)
(defrule headings :h1 :h2 :h3)

;; I like this approach as well.
(def center-text {:text-align "center"})


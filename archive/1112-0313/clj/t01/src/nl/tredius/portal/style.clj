(ns nl.tredius.portal.style.core
  (:require [clj-style.core :as cs]
            [garden.core :refer [css]]
            [garden.units :refer [px pt]])
  (:use [clojure.string]))

(replace (with-out-str (clojure.repl/dir garden.units)) #"\n" " ")


(defmacro defcolor
  "Macro which allows for a tad friendlier color defs, parses to lower-case."
  [name hexstr]
  `(cs/defmixin ~name [] :color
                (clojure.string/lower-case ~hexstr)))




(defcolor orange "#F2A34F")
(defcolor white "#ffffff")
(defcolor black "#363636")
(defcolor yellow "#7A6A42")
(defcolor gold "#b88d74")
(defcolor green "#7FC028")
(defcolor turquoise "#6CBBB8")
(defcolor brown "#6b4c39")
(defcolor light-brown "#b88c74")
(defcolor purple "#47427A")
(defcolor light-purple "#6664a0")
(defcolor blue "#0183b5")
(defcolor light-blue "#0183b5")
(defcolor dark-blue "#403e6b")
(defcolor gray "#e0e0e0")
(defcolor light-gray "#f8f8f8")
(defcolor dark-gray "#919191")
(defcolor rood "#e31741")
(defcolor light-red "#6b4c39")

;(cs/save "browser-styles.css" :screen)
;(cs/save "printer-styles.css" :print)
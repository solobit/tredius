(ns nl.tredius.util
  (:require [noir.io :as io]
            [markdown.core :as md]))

(defn format-tijd
  "Geef de tijd in SimpleDateFormat weer, standaard format is
   \"dd MMM, yyyy\" en als tweede argument kan custom zijn."
  ([time] (format-tijd time "dd MMM, yyyy"))
  ([time fmt]
    (.format (new java.text.SimpleDateFormat fmt) time)))

(defn md->html
  "Leest een Markdown bestand uit de map public/md en geeft HTML terug."
  [bestandsnaam]
  (->>
    (io/slurp-resource bestandsnaam)
    (md/md-to-html-string)))

(defmacro synoniem [s s′]
  (list 'defmacro s′ (str s) '[& rest]
     (list 'cons (list 'quote s) 'rest)))
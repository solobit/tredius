(ns nl.tredius.portal.util
  (:refer-clojure :exclude [or replace and remove])
  (:use [net.cgrand.enlive-html :only [html html-resource]]
        [clojure.contrib.seq-utils :only [indexed]]
        ;[me.raynes.laser :exclude [parse]]
        [clojure.contrib.str-utils :only [re-sub re-gsub]])
  (:import java.io.StringReader)
  (:require [noir.io :as io]
            [clojure.pprint :refer [pprint]]
            [markdown.core :as md]
            [pl.danieljanus.tagsoup :as ts]))


;;
;; Date / time locale specifics
;;

(defn format-time
  "Formateer de tijd door SimpleDateFormat te gebruiken, standaard is deze
   \"dd MMM, yyyy\" en een maatwerk variant optioneel als tweede argument."
  ([time]
   (format-time time "dd MMM, yyyy"))
  ([time fmt]
    (.format (new java.text.SimpleDateFormat fmt) time)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Conversion from one format to another
;; Note: hiccup->html and vice-versa available through hiccup-bridge

(defn md->html
  "Leest een 'Markdown' bestand uit public/md een geeft een HTML string terug."
  [filename]
  (->>
    (io/slurp-resource filename)
    (md/md-to-html-string)))

(defn enlive->hiccup
  "Converteer Clojure Enlive DSL naar Hiccup DSL."
   [el]
   (if-not (string? el)
     (->> (map enlive->hiccup (:content el))
       (concat [(:tag el) (:attrs el)])
       (keep identity)
       vec)
     el))

(defn html->enlive
  "Converteer een string HTML opmaak elementen en attributen
  naar Clojure Enlive DSL."
  [html]
  (first (html-resource (StringReader. html))))

(defn html->hiccup
  "Converteert een string HTML opmaak elementen en attributen
  naar Clojure Hiccup DSL (via Enlive)."
  [html]
  (-> html
      html->enlive
      enlive->hiccup))


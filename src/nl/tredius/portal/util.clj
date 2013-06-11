(ns nl.tredius.portal.util
  (:require [noir.io :as io]
            [markdown.core :as md]))

(defn format-time
  "Formateer de tijd door SimpleDateFormat te gebruiken, standaard is deze
   \"dd MMM, yyyy\" en een maatwerk variant kan als tweede argument ingegeven worden."
  ([time]
   (format-time time "dd MMM, yyyy"))
  ([time fmt]
    (.format (new java.text.SimpleDateFormat fmt) time)))

(defn md->html
  "Leest een 'Markdown' bestand uit public/md een geeft een HTML string terug."
  [filename]
  (->>
    (io/slurp-resource filename)
    (md/md-to-html-string)))

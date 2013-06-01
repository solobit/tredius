(ns examples.web-tag
  (:require [clojure.repl :refer [doc dir source]])
  (:use [opennlp.nlp]
        [clojure.pprint :only [pprint]]))

(def ^:dynamic *num-sentences* 3)

(def get-sentences (make-sentence-detector "models/nl/nl-sent.bin"))
(def tokenize (make-tokenizer "models/nl/nl-token.bin"))
(def pos-tag (make-pos-tagger "models/nl/nl-pos-maxent.bin"))

(defn strip-html-tags
  "Messily strip html tags from a web page"
  [string]
  (-> string
      (.replaceAll "<script .*?>.*?</script>" " ")
      (.replaceAll "<style .*?>.*?</style>" " ")
      (.replaceAll "<.*?>" " ")
      (.replaceAll "[ ]+" " ")))

(defn fetch-page
  [url]
  (let [html (.replaceAll (slurp url) "[\t\n\r]" " ")]
    (re-find #"<body.*?</body>" html)))

(defn fetch-plain-page
  [url]
  (strip-html-tags (fetch-page url)))

(defn- tag-sentences
  [sent-seq]
  (map #(pos-tag (tokenize %)) sent-seq))



(defn tag-page
  [url]
  (let [page (fetch-plain-page url)
        sentences (get-sentences page)
        sent-seq (partition-all *num-sentences* sentences)]
    (pmap tag-sentences sent-seq)))


; (tag-page "http://www.geenstijl.nl")

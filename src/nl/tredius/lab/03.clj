;;
;; Googlebot
;;

(ns nl.tredius.lab.03
 "Genereert diagrammen aan de hand van Google zoekopdrachten."
  (:gen-class)
  (:use [incanter core charts stats bayes io]
        [incanter.processing :only (norm)])
  (:require [clojure.math.combinatorics :as comb]
            [clojure.repl :as repl]))

(def ^:dynamic *search-provider* "http://www.google.com/search?hl=en&q=")

(def ^:dynamic *search-pattern* #"About.*?([\d,]+).*?")


; Sample data set provided by Incanter
(def plotData (read-dataset
            "https://raw.github.com/liebke/incanter/master/data/iris.dat"
            :delim \space
            :header true))

(def data (read-dataset
                "https://raw.github.com/liebke/incanter/master/data/iris.dat"
                :delim \space
                :header true))

(defn normalize
  "Normalizes a set of data"
  [data]
  (let [start     (apply min data)
        stop      (apply max data)]
    (map #(norm % start stop) data)))

(def plot (scatter-plot
           (normalize (sel data :cols 0))
           (normalize (sel data :cols 1))
           :x-label "Sepal Length"
           :y-label "Sepal Width"
           :group-by (sel data :cols 4)))


(defn -main [& args]
  (view plot))

;(-main)




(defn search-for-term
  "Encodes a term for use in the query string sent to Google.
  Get the results from that search query and map these."
  [term]
  (let [encoded-term (.replaceAll (apply str term) " " "+")
        qstring (str *search-provider* encoded-term)
        page (:body (http-client/get qstring))
        hits (second (re-find *search-pattern* page))
        nhits (Integer/parseInt (.replaceAll hits "," ""))]
    (hash-map term nhits)))



(defn view-bar-chart
  "View search result in chart."
  [mcoll]
  (view (bar-chart (keys mcoll) (vals mcoll)
	 :x-label "Search terms"
	 :y-label "Search results")))



(defn search-view-terms
  "Monadic map reduce to view terms."
  [terms]
  (->> (reduce merge (map search-for-term terms))
       (view-bar-chart)))

;(search-view-terms ["Functional programming" "Object oriented programming" "Functional Object oriented programming"])

; vector with outcome of elections, next divided by total response
(def y [727 583 137])
(div y 1447)

; How good is our estimate? We can use confidence intervals for the parameters of a
; multinomial distribution, which is a Dirichlet distribution.
(def  theta (sample-multinomial-params 1000 y))


; This returns 1000 samples of the multinomial parameters, or probabilities of each of the outcomes in the data.
; Now, create variables representing the samples for each parameter,
(def theta1 (sel theta :cols 0))
(def theta2 (sel theta :cols 1))
(def theta3 (sel theta :cols 2))




(macroexpand '(whems (pos? a) (println "positive") (/ b a)))




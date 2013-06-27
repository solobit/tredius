;;
;; Googlebot
;;

(ns nl.tredius.lab.03
 "Genereert diagrammen aan de hand van:
  * Google zoekopdrachten
  * Iris data
  * Zinstructuur"
  (:gen-class)
  (:import java.io.File)
  (:use [clojure.walk]
        [hickory core zip]
        [incanter core charts stats bayes io]
        [incanter.processing :only (norm)])
  (:require [clojure.math.combinatorics :as comb]
            [clojure.pprint :refer [pprint]]
            [hickory.select :as s]
            [clojure.string :as string]
            [clojure.repl :as repl]
            [clojure.zip :as zip]
            [swiss-arrows.core :refer :all]
            [clj-http.client :as http-client]))

(def ^:dynamic *framenet2* "https://framenet2.icsi.berkeley.edu/fnReports/data/frameIndex.xml?frame=")

(def ^:dynamic *search-provider* "http://www.google.com/search?hl=en&q=")

(def ^:dynamic *search-pattern* #"About.*?([\d,]+).*?")

(def ^:dynamic *thesaurus* "http://synoniemen.net/index.php?zoekterm=")

; -----------------------------------------------------------------------------
; Sample data set provided by Incanter. Famous 'hello world' data used
; for demonstrations in machine learning and (big) data computations.
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

;(view plot)

(def directory (clojure.java.io/file "."))
(def files (file-seq directory))
;(clojure.pprint/pprint (doall (take 10 files)))
;(defn wie? [zin] (some zin 1))





(defn mapinhoud
  [path]
  (println "Files in " (.getName path))
  (doseq [f (.listFiles path)]
    (if (.isDirectory f)
      (print "📂 ")
      (print "📄 "))
    (println (.getName f))))

(defn bestandslocatie
  "Stomme wrappert."
  [x]
  (File. x))

;(mapinhoud (bestandslocatie "."))








;(wie? "Ik gaat lopen")

(defn search-synonyms-nl
  [term]
  (let [encoded-term (.replaceAll (apply str term) " " "+")
        qstring (str *thesaurus* encoded-term)
        page (:body (http-client/get qstring))]
    page))

(def parsed-doc (as-hickory (parse (search-synonyms-nl ["ondernemer"]))))
(def site-htree (-> (http-client/get "http://synoniemen.net/index.php?zoekterm=ondernemer") :body parse as-hickory))

(-<> (s/select (s/descendant (s/class "alstrefwoordtabel")
                             (s/child (s/tag :tr)
                                      (s/tag :td))
                             (s/tag :a))
               site-htree)


    ;(subvec (*))
    ;first
    ;last

    (pprint <>)
    ;; either
    ;seq
    ;count
    ;(range 0 <>)


    ;; or
    ;; type
    ;; PersistentVector


;   seq
;    partition 3
;    first
    ;string/trim
    )




(def framenet (slurp "https://framenet2.icsi.berkeley.edu/fnReports/data/frameIndex.xml?frame=War"))







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
  "View search engine hits per term result in a bar chart."
  [mcoll]
  (view (bar-chart (keys mcoll) (vals mcoll)
	 :x-label "Search terms"
	 :y-label "Search results")))

(defn search-view-terms
  "Monadic map-reduce to search for terms and view the result in a bar chart."
  [terms]
  (->> (reduce merge (map search-for-term terms))
       (view-bar-chart)))



(search-view-terms ["Accountantskantoor" "Administrateur" "Randstad Finance"])






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













(conj [1 2 3] 4)
(-<>> "dat wil ik graag!"
      (conj ["Want meedoen" "," "dat gaat toch boven alles" "?" "Ja" ","]))

(-<> 4 (cons [1 2 3]) reverse (map inc <>))
(-<> 4 (cons [1 2 3]) reverse (map inc <>))

(def statement '("Jan" "kan" "niet" "mee"))
(def question '("Waarom" "?"))

(conj statement (first question))



;;
;; Thread-Last (secret name)
;;
;; Threads the expr through the forms. Inserts x as the
;; last item in the first form, making a list of it if it is not a
;; list already. If there are more forms, inserts the first form as the
;; last item in second form, etc.

(->> (range)
     (map #(* % %))
     (filter even?)
     (take 10)
     (reduce +))

(->> {:foo 15 :bar 15}
     (:foo)
     (dec)
     (:bar)
     (dec)

     )


(-> {:foo "bar"}
    (assoc :baz ["quux" "you"])
    (-!> :baz second (prn "got here"))
    (-!>> :baz first (prn "got here"))
    (-!<> :baz second (prn "got" <> "here"))
    (assoc :bar "foo"))

(def c 5)
(->> c (+ 3) (/ 2) (- 1))

;; start right ;]
(macroexpand-all '(->> c (+ 3) (/ 2) (- 1)))





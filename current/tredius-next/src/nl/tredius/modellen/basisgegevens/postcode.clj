(ns nl.tredius.modellen.basisgegevens
  (:require [digest :as digest]
            [clojure.string :as string]
            [clojure.contrib.seq :refer [positions]]
            [clojure.contrib.seq-utils :refer [find-first]]
            [clojure.repl :refer [dir]]
            [clojure.data.csv :as csv]
            [dire.core :refer [with-precondition! with-handler!
                               supervise with-postcondition!]])
  (:use clojure.test
        csvlib.core
        clojure.java.io))

(def bestand (read-csv "resources/ppps.csv" :headers? true))


(find-first #(= "5014 LT" (get % "Postcode")) bestand)


;; Niet zeer recent, vermoed ca. 2011 laatste update?
(def bestand "resources/ppps.csv")

;; postcode, provincie, plaatsnaam, straatnaam
(def gegevens (with-open [in-file (reader bestand)]
                (csv/read-csv (reader bestand))))


(defn patronen
  "Geeft een Java regular expression (regex of re) retour."
  [input]
  (cond
   (= input :postcode) #"^([1-9]\d{3})(\ ?)([aA-zZ]{2})"))


(defn- onveilige-gebruikersinvoer
  "Voorwaardelijk binden van de onveilige waarde, mits aan de voorwaarde van
  het patroon (Java regular expression) voldaan is. Geeft eenduidige postcode."
  [invoer]
  (if-let [s (re-matches (patronen :postcode) invoer)]
    (str (second s) " " (string/upper-case (last s)))))

(defn opzoeken-postcode
  "Zoekt, onder voorwaarde van correct gegeven invoer, de postcode op."
  [postcode]
  (if-let [pc (onveilige-gebruikersinvoer postcode)]
      (nth gegevens (.indexOf (map #(first %) gegevens) pc))))

(time (opzoeken-postcode "5014LT"))

;;
;; Onveilige invoer die we ooit moeten gebruiken
;; :postcode
;; :kilometers
;; :brandstof


;; (with-handler! #'plakken-onveilige
;;   "Here's an optional docstring about the handler."
;;   java.lang.ClassCastException
;;   ;;; 'e' is the exception object, 'args' are the original arguments to the task.
;;   (fn [e & args] (println "Invoer moet uit een string bestaan.")))

;; (with-handler! #'plakken-onveilige
;;   {:precondition :geen-keyword}
;;   (fn [e & args] (apply str "Invoer mag geen sleutelwoord zijn " (vector args))))


;; (with-handler! #'plakken-onveilige
;;   {:precondition :geen-symbool}
;;   (fn [e & args] (apply str "Invoer mag geen symbool zijn " (vector args))))

;; (with-precondition! #'plakken-onveilige
;;   "An optional docstring."
;;   ;;; Name of the precondition
;;   :geen-keyword (fn [n & args] (not= (keyword? n)))
;;   :geen-symbool (fn [n & args] (not= (symbol? n)))
;;   )

;; (with-precondition! #'plakken-onveilige
;;   "An optional docstring."
;;   ;;; Name of the precondition
;;   )


;(time (opzoeken-postcode "5014 LT"))

;; DROPPED in favor of reader
;;(def gegevens-old (parse-csv (slurp bestand)))
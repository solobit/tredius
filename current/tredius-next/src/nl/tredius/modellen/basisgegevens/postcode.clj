(ns nl.tredius.modellen.basisgegevens.postcode
  (:import [java.io StringReader])
  (:require [clojure.string :as string]
            [clojure.contrib.seq :refer [positions]]
            [clojure.repl :refer [dir]]
            [dire.core :refer [with-precondition! with-handler!]]
            [clojure.contrib.seq-utils :as su])
  (:use clojure.test
        clojure.java.io
        clojure-csv.core))

;; postcode, provincie, plaatsnaam, straatnaam
(def gegevens (parse-csv (slurp "resources/ppps.csv")))

(defn- plakken-onveilige
  "Voorwaardelijk binden van de (onveilige!) ingevoerde waarde, veelal
  afkomstig uit het veld van een gebruikersformulier."
  [string]
  (when (string? string)
    (if-let [s (re-matches #"^([1-9]\d{3})(\ ?)([aA-zZ]{2})" string)]
      (str (second s) " " (string/upper-case (last s))))))

(defn opzoeken-postcode
  "Zoekt, onder voorwaarde van correct gegeven invoer, de postcode op."
  [postcode]
  (if-let [pc (plakken-onveilige postcode)]
    (try
      (nth gegevens (.indexOf (map #(first %) gegevens) pc))
      (catch Exception e))))

(opzoeken-postcode 1234)

;(second (opzoeken-postcode "5014 LT"))
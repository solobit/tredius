(ns nl.tredius.modellen.basisgegevens
  (:use hiccup.core)
  (:require [clojure.string :as string]
            [swiss-arrows.core :refer :all]
            [dire.core :refer [with-precondition! with-handler!]]))

;; postcode, provincie, plaatsnaam, straatnaam
(def mrb (with-open [in-file (reader "resources/mrb.csv")]
                (csv/read-csv in-file)))



(-> "5014LT" ;; veilig ge-parsed
    opzoeken-postcode
    (-> second
        naar-sleutelwoord)
     ;second ;; provincie
    ;
    ;html-selectie-gewicht
    ;opzoeken-belasting
    )


(-<> ["5014LT"]
     (first <>)
     (opzoeken-postcode <>)
     (second <>)
     (naar-sleutelwoord <>)
     [<> :benzine])

(defn naar-sleutelwoord
  "Converteert een string invoer naar sleutelwoord als \"sleutel\" => :sleutel"
  [invoer]
  (keyword (string/lower-case invoer)))


(defn keuzelijst-brandstoffen
  "Selecteer 1 van de 4 mogelijke brandstoffen als keuze element HTML select."
  [] (html
      [:select
       [:option {:value :benzine} "Benzine"]
       [:option {:value :diesel} "Diesel"]
       [:option {:value :lpg3} "LPG3/Aardgas"]
       [:option {:value :overig} "LPG/Overig"]]))

(defn keuzelijst-gewicht
  "Maakt een hiccup HTML select/option element door de hash-map van
  de belastingdienst te doorlopen."
  [provincie]
  (let [prov (naar-sleutelwoord provincie)]
    (html
     [:select
      (for [x (map #(val (first %)) (prov opcenten-tabel))]
        [:option {:value x} x])])))

;(time (html-selectie-gewicht "Noord-Brabant"))
(-<> :noord-brabant
     (<> opcenten-tabel))

(defn opzoeken-belasting
  [provincie]
  (provincie opcenten-tabel))

  ;(positions #{*gewicht*} (map *brandstof* (provincie opcenten-tabel))))

(defn opzoeken-brandstof
  [provincie]
  (pmap *brandstof* (provincie opcenten-tabel)))



(defn opzoeken-mrb
  [brandstof provincie RIJ]
  (brandstof (nth (provincie opcenten-tabel) RIJ)))

(opzoeken-mrb :diesel :noord-brabant 6)

(:mrb-zuid-holland mrb-tabellen)

;; (defn zoek-belasting
;;   [postcode gewicht brandstof]
;;   (if-let [provincie (zoek-provincie postcode)]
;;     (if-let [opcenten (provincie data2)]
;;       (for [x opcenten]
;;         (when (< (:gewicht x) gewicht)
;;           (doall x))))))

;(zoek-belasting 5014 4333 :lpg3)

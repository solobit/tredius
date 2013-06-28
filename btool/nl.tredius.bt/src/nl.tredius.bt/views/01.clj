(ns nl.tredius.bt.views.01
  (:require [compojure.core :refer [defroutes GET POST ANY]]
            [compojure.handler :refer [site]]
            [ring.middleware.stacktrace :as trace]
            [ring.adapter.jetty :as jetty]
            [environ.core :refer [env]]
            [formative.core :as f]
            [formative.parse :as fp]
            [hiccup.page :as page]
            [clojure.pprint :refer [pprint]])
  (:use hiccup.core))

(def ^:dynamic *postcode*)

(def ^:dynamic *bruto-salaris-per-maand*)
(def ^:dynamic *bruto-salaris-per-maand-partner*)
(def ^:dynamic *netto-salaris-per-maand*)
(def ^:dynamic *bruto-salaris-per-maand-partner*)

(def ^:dynamic *huur-of-koop*)
(def ^:dynamic *voorlopige-teruggaaf-per-maand*)
(def ^:dynamic *woz-waarde*)

(def ^:dynamic *type-woning*)
(def ^:dynamic *aantal-huishouden*)
(def ^:dynamic *aantal-kinderen*)
(def ^:dynamic *honden*)

(def ^:dynamic *woz-waarde*)
(def ^:dynamic *woz-waarde*)
(def ^:dynamic *woz-waarde*)
(def ^:dynamic *woz-waarde*)


(def vragenlijst-form
  {:enctype "multipart/form-data"
   :fields [{:name :h2 :type :heading :text "De Tredius-tool"}
            {:name :note :type :html
             :html [:div.alert.alert-info "Verklaring."]}
            {:name :spam :type :checkbox :label "U geeft toestemming om deze gegevens te gebruiken voor het genereren statistieken. Leest u hier onze privacy verklaring."}
            {:name :email :type :email}
            {:name :state :type :us-state
             :placeholder "Selecteer uw huishouden"}
;;defaults
;http://www.nibud.nl/uitgaven/huishouden/gas-elektriciteit-en-water.html
;gas;;flat 900 67 tussenwoning 1.350 92 hoekwoning 1.590 105 2 onder 1 kap 1.670 110 vrijstaand 2.220 140 gemiddeld alle woningen 1.440 97
;elec ;; 1 2.010 30 2 3.360 56 3 4.120 71 4 4.580 79 5 5.450 96 6 5.790 102
;water ;; 1 45 8,50 2 91 12,70 3 137 16,80 4 169 19,60 5 201 22,40
            {:name :h2 :type :heading :text "Accijns"}
            {:name :h2 :type :heading :text "Auto"}
            {:name :spam :type :checkbox :label "Ja, ik heb een prive auto."}
            {:name :brandstof :type :checkboxes
             :options ["Benzine" "Diesel" "LPG"]}

            ;; Omschrijving	Benzine	Diesel	Lpg
            ;; Heffingen	42,7%	29,9%	11,2%
            ;; Btw	21,0%	21,0%	21,0%
            ;; Subtotaal overheidsafdrachten	63,7%	50,9%	32,2%

            ;; Benzineprijs dagelijks importeren van statline

            ;; of : reisafstand per week + verbruik + prijs
            ;; dropdown 0 - 10, 10-20, etc...
            ;; of : benzine per week + percentage accijns


            ;; Roken?
            ;; shag? sigaretten? sigaren?
            ;; roken zo ja, hoeveel pakjes per week


            ;; Alcoholisch en niet-alc

            ;; Bier
            ;; Wijn
            ;; Fris
            ;; Sterke drank
            ;; Mineraalwater
            ;;zie .txt










            {:name :explanation :type :textarea :label "Explain yourself"}
            {:name :picture :type :file :title "Choose a file"}]

   :validations [[:required [:full-name :email :password :state]]
                 [:min-length 8 :password]
                 [:equal [:password :password-confirm]]
                 [:min-length 2 :flavors "Please select two or more flavors"]]
   :validator validate-upload})

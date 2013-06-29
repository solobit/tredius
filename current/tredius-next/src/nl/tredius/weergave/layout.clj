(ns nl.tredius.weergave.layout
  (:use noir.request)
  (:require [clabango.parser :as parser]
            [noir.session :as sessie]))

(def sjabloon-pad "nl/tredius/weergave/sjablonen/")

(defn render
  "Weergeven van het bestandsjabloon met contextuele gegevens
  voor de huidige ingelogde gebruiker."
  [sjabloon & [parameters]]
  (parser/render-file (str sjabloon-pad sjabloon)
                      (assoc (or parameters {})
                        :context (:context *request*)
                        :gebruiker-id (sessie/get :gebruiker-id))))

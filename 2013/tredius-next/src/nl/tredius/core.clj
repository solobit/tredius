(ns nl.tredius.core
  (:require
    [nl.tredius.handler :refer [web-archief]]
    [ring.middleware.reload :as reload]
    [org.httpkit.server :refer [run-server]]
    [taoensso.timbre :as logboek])
  (:gen-class))

(defn dev?
  "Geeft 'waar' als de server in ontwikkelomgeving opgestart moet worden."
  [argumenten]
  (some #{"-dev"} argumenten))

(defn poort
  "Defineer welke poort door de webserver gebruikt moet worden."
  [argumenten]
  (if-let [poort (first (remove #{"-dev"} argumenten))]
    (Integer/parseInt poort)
    8080))

(defn -main
  "Hoofdroutine aan te roepen als standaard ingang voor applicaties
  van buitenaf. Wordt uitgevoerd bij opstarten van de applicatie."
  [& argumenten]
  (run-server
    (if (dev? argumenten)
      (reload/wrap-reload web-archief) web-archief)
    {:port (poort argumenten)})

  (logboek/info (str "Server gestart op poort")))
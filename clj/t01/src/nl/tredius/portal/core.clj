(ns nl.tredius.portal.core
  (:require
    [nl.tredius.portal.handler :refer [war-handler]]
    [ring.middleware.reload :as reload]
    [org.httpkit.server :as http-kit]
    [taoensso.timbre :as timbre])
  (:gen-class))

(defn dev?
  "Geeft 'true' indien de server voor ontwikkeling gebruikt wordt."
  [args]
  (some #{"-dev"} args))

(defn port
  "Geeft het poortnummer waarop de webserver aangesloten wordt."
  [args]
  (if-let [port (first (remove #{"-dev"} args))]
    (Integer/parseInt port)
    8080))

(defn -main
  "Hoofdroutine en standaard toegangspunt voor deze applicatie."
  [& args]
  (http-kit/run-server
    (if (dev? args) (reload/wrap-reload war-handler) war-handler)
    {:port (port args)})

  (timbre/info
   (str "Server gestart op poort "
        (port args))))
(ns nl.tredius.handler
  (:require [nl.tredius.routes.auth :refer [auth-routes]]
            [nl.tredius.routes.home :refer [home-routes]]
            [nl.tredius.routes.vbcljs :refer [cljs-routes]]
            [nl.tredius.modellen.schema :as schema]
            [noir.util.middleware :as middleware]
            [compojure.core :refer [defroutes]]
            [compojure.route :as route]
            [taoensso.timbre :as logboek]
            [com.postspectacular.rotor :as logrotatie]))

(defroutes
  app-routes
  (route/resources "/")
  (route/not-found "Pagina niet gevonden."))


(defn opstarten
  "Initialisatie uitgevoerd wanneer de applicatie start en controleert of het
  databankschema aanwezig is, roept maak-tabellen functie aan bij afwezig."
  []
  (logboek/set-config!
    [:appenders :rotor]
    {:min-level :info,
     :enabled? true,
     :async? false,
     :max-message-per-msecs nil,
     :fn logrotatie/append})
  (logboek/set-config!
    [:shared-appender-config :rotor]
    {:path "tredius.log", :max-size (* 512 1024), :backlog 10})
  (if-not (schema/geïnitialiseerd?) (schema/maak-tabellen))
  (logboek/info "Tredius Luminus omgeving succesvol opgestart."))

(defn vernietig
  "Aangeroepen bij afsluiten van deze tool. Speciale code benodigd voor het
  schoonmaken van tijdelijke bestanden e.d. kan hieronder."
  []
  (logboek/info "De Tredius Luminus omgeving wordt afgesloten."))

(def app
 (middleware/app-handler
   [auth-routes home-routes app-routes]
   :middleware
   []
   :access-rules
   []))


(def web-archief (middleware/war-handler app))
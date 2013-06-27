(ns nl.tredius.portal.handler
  (:require [compojure.core :refer [defroutes]]
            [nl.tredius.portal.routes.auth :refer [auth-routes]]
            [nl.tredius.portal.routes.home :refer [home-routes]]
            [noir.util.middleware :as middleware]
            [noir.session :as session]
            [compojure.route :as route]
            [nl.tredius.portal.models.schema :as schema]
            [taoensso.timbre :as timbre]
            [com.postspectacular.rotor :as rotor]
            [nl.tredius.portal.routes.cljsexample :refer [cljs-routes]]))

(defroutes app-routes
  "Standaard routes van de applicatie."
  (route/resources "/")
  (route/not-found "Niet gevonden."))


(defn init
  "Draait wanneer de applicatie start en controleert of het database-
  schema bestaat, roept schema/create-tables indien niet het geval."
  []
  (timbre/set-config!
    [:appenders :rotor]
    {:min-level :info,
     :enabled? true,
     :async? false,
     :max-message-per-msecs nil,
     :fn rotor/append})

  (timbre/set-config!
    [:shared-appender-config :rotor]
    {:path "nl/tredius/portal/log",
     :max-size (* 512 1024),
     :backlog 10})

  (if-not (schema/initialized?) (schema/create-tables))
  (timbre/info "Tredius corporate web portal succesvol gestart"))



(defn destroy
  "De functie destroy wordt aangeroepen wanneer de applicatie
   afsluit, plaats benodigde schoonmaak- / opruimcode hier"
  []
  (timbre/info "nl.tredius.portal is aan het afsluiten..."))


(def app
  "Definitie van de applicatie door middleware af laten handelen
  als implementatie van enerzijds routes en anderzijds toestemming."
 (middleware/app-handler
   [auth-routes home-routes app-routes]
   :middleware
   []
   :access-rules
   []))


(comment "
  A JAR file used to distribute a collection of JavaServer Pages, Java Servlets,
  Java classes, XML files, tag libraries, static Web pages (HTML and related
  files) and other resources that together constitute a Web application.
  One disadvantage of web deployment using WAR files in very dynamic
  environments is that minor changes cannot be made during runtime. Any change
  whatsoever requires regenerating and redeploying the entire WAR file.")

(def war-handler
  "Een Java Web ARchief om de applicatie in een container te kunnen draaien."
  (middleware/war-handler app))


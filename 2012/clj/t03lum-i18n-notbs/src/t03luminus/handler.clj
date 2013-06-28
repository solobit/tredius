(ns t03luminus.handler
  (:require [taoensso.tower :as tower
             :refer (with-locale with-scope t style)]
            [compojure.core :refer [defroutes]]
            [t03luminus.routes.home :refer [home-routes]]
            [noir.util.middleware :as middleware]
            [compojure.route :as route]
            [taoensso.timbre :as timbre]
            [com.postspectacular.rotor :as rotor]))

(tower/set-config! [:dictionary :nl :basis ]
                   {:page-not-found "Pagina niet gevonden!"
                    :gallery-shutdown "Afbeeldingengallerij is aan het afsluiten."
                    :app-startup "Applicatie succesvol opgestart."
                    :app-shutdown "Applicatie is aan het afsluiten..."})

(defroutes app-routes
  (route/resources "/")
  (route/not-found (with-locale :nl (t :basis/page-not-found))))

(defn destroy []
  (timbre/info (with-locale :nl (t :gallery-shutdown))))

(defn init
  "Eenmalig aangeroepen zodra app ontplooid is als een servlet op een
  app server zoals Tomcat. Plaatst initializatie code hier."
  []
  (timbre/set-config!
    [:appenders :rotor]
    {:min-level :info
     :enabled? true
     :async? false ; should be always false for rotor
     :max-message-per-msecs nil
     :fn rotor/append})

  (timbre/set-config!
    [:shared-appender-config :rotor]
    {:path "t03luminus.log" :max-size (* 512 1024) :backlog 10})

  (timbre/info (with-locale :nl (t :basis/app-startup))))



(defn destroy
  "Aangeroepen zodra uw applicatie afsluit. Plaats opruimcode hier."
  []
  (timbre/info (with-locale :nl (t :app-shutdown))))

(def app (middleware/app-handler
           ;;add your application routes here
           [home-routes app-routes]
           ;;add custom middleware here
           :middleware []
           ;;add access rules here
           ;;each rule should be a vector
           :access-rules []))

(def war-handler (middleware/war-handler app))

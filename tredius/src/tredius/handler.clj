(ns tredius.handler
  (:use tredius.routes.home compojure.core)
  (:require [noir.util.middleware :as middleware]
            [compojure.route :as route]
            [taoensso.timbre :as timbre]
            [com.postspectacular.rotor :as rotor]
            [tredius.routes.cljsexample :refer [cljs-routes]]))

(defroutes
  app-routes
  (route/resources "/")
  (route/not-found "Niet gevonden."))

(defn destroy [] (timbre/info "Gallerij aan het afsluiten..."))

(defn init
  "init will be called once when
   app is deployed as a servlet on
   an app server such as Tomcat
   put any initialization code here"
  []
  ;; initialize logs
  (timbre/set-config!
    [:appenders :rotor]
    {:min-level :info,
     :enabled? true,
     :async? false,
     :max-message-per-msecs nil,
     :fn rotor/append})
  (timbre/set-config!
    [:shared-appender-config :rotor]
    {:path "tredius.log", :max-size 10000, :backlog 10})
  (timbre/info "tredius succesvol gestart"))

(defn destroy
  "destroy will be called when your application
   shuts down, put any clean up code here"
  []
  (timbre/info "tredius is aan het afsluiten..."))

(def all-routes [cljs-routes home-routes app-routes])

(def app (-> all-routes middleware/app-handler))

(def war-handler (middleware/war-handler app))


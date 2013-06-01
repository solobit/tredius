(ns nl.tredius.portal.handler
  (:use nl.tredius.portal.routes.home compojure.core)
  (:require [noir.util.middleware :as middleware]
            [compojure.route :as route]
            [taoensso.timbre :as timbre]
            [com.postspectacular.rotor :as rotor]
            [nl.tredius.portal.routes.cljsexample :refer [cljs-routes]]))

(defroutes
  app-routes
  (route/resources "/")
  (route/not-found "Not Found"))

(defn destroy [] (timbre/info "picture-gallery is shutting down"))

(defn init
  "init will be called once when
   app is deployed as a servlet on
   an app server such as Tomcat
   put any initialization code here"
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
    {:path "nl.tredius.portal.log", :max-size 10000, :backlog 10})
  (timbre/info "nl.tredius.portal started successfully"))

(defn destroy
  "destroy will be called when your application
   shuts down, put any clean up code here"
  []
  (timbre/info "nl.tredius.portal is shutting down..."))

(def all-routes [cljs-routes home-routes app-routes])

(def app
 (middleware/app-handler all-routes :middleware [] :access-rules []))

(def war-handler (middleware/war-handler app))


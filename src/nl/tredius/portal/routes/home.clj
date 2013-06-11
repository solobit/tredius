(ns nl.tredius.portal.routes.home
  (:use compojure.core)
  (:require [nl.tredius.portal.views.layout :as layout]
            [nl.tredius.portal.util :as util]
            [liberator.core :refer [resource defresource]]))

(def counter (ref 0))

(defn home-page
  "Weergave van de pagina 'home' verwerken."
  []
  (layout/render
    "home.html" {:content (util/md->html "/md/docs.md")}))

(defn about-page
  "Weergave van de pagina 'Wie zijn wij?' vaak aangeduid als 'about'."
  []
  (layout/render "about.html"))

(defroutes home-routes
  (GET "/" [] (home-page))
  (GET "/about" [] (about-page))

  (ANY "/foo" []
       (resource :available-media-types ["text/html"]
                 :handle-ok (fn [ctx] (format "<html>It's %d milliseconds since the beginning of the epoch."
                                              (System/currentTimeMillis)))))

  (ANY "/bar" []
       (resource :available-media-types ["text/html"]
                 :handle-ok (fn [_] (format "The counter is %d" @counter))))

  (ANY "/bara" []
       (defresource parameter [txt]
         :available-media-types ["text/plain"]
         :handle-ok (fn [_] (format "The text is %s" txt)))))
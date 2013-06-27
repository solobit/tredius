(ns nl.tredius.portal.routes.home
  (:use [compojure.core])
  (:require [nl.tredius.portal.views.layout :as layout]
            [nl.tredius.portal.util :as util]
            [liberator.core :refer [resource defresource]]
            [formative.core :as f]
            [formative.parse :as fp]))


(defn home-page
  "Weergave van de pagina 'home' verwerken."
  []
  (layout/render
    "home.html" {:content (util/md->html "/md/docs.md")}))

(defn about-page
  "Weergave van de pagina 'Wie zijn wij?' vaak aangeduid als 'about'."
  []
  ;(f/render-form example-form))
  (layout/render "about.html"))

(defroutes home-routes
  (GET "/" [] (home-page))
  (GET "/about" [] (about-page)))
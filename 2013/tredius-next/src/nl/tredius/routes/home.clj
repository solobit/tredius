(ns nl.tredius.routes.home
  (:use compojure.core)
  (:require [nl.tredius.weergave.layout :as layout]
            [nl.tredius.util :as util]))

(defn home-page []
  (layout/render
    "home.html" {:content (util/md->html "/md/docs.md")}))

(defn about-page []
  (layout/render "overtuiging.html"))

(defroutes home-routes
  (GET "/" [] (home-page))
  (GET "/overtuiging" [] (about-page)))

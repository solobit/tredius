(ns nl.tredius.bt.routes.home
  (:use compojure.core)
  (:require [nl.tredius.bt.views.layout :as layout]
            [nl.tredius.bt.util :as util]))

(defn home-page []
  (layout/render
    "home.html" {:content (util/md->html "/md/docs.md")}))

(defn about-page []
  (layout/render "about.html"))

(defroutes home-routes
  (GET "/" [] (home-page))
  (GET "/about" [] (about-page)))

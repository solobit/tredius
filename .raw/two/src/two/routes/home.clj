(ns two.routes.home
  (:use compojure.core
        [clabango.parser :only [render-file]])
  (:require [two.views.layout :as layout]
            [two.util :as util]))

;(defn home-page []
;  (layout/render
;    "home.html" {:content (util/md->html "/md/references/luminus.origin.md")}))

(defn index [request]
  (render-file "index.html"
               {:name "John"}))

(println "test")

;(defn home-page []
;  (layout/render
;  "home.html" {:content (layout/render "landing.html")
;               :menubar (layout/render "components/menubar.html")}))

(defn about-page []
  (layout/render "overige/overtuiging.html"))

(defroutes home-routes
  (GET "/" [] (home-page))
  (GET "/about" [] (about-page)))

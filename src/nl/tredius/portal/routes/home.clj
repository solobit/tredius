(ns nl.tredius.portal.routes.home
  (:use [c2.core :only [unify]]
        [c2.maths :only [extent floor]]
        [c2.geo.core :only [geo->svg]]
        [c2.geo.projection :only [albers-usa]]
        ;[vomnibus.geo.us.states :only [states]]
        [compojure.core])
  (:require [nl.tredius.portal.views.layout :as layout]
            [nl.tredius.portal.util :as util]
            [c2.scale :as scale]
            [vomnibus.color-brewer :as color-brewer]
            [liberator.core :refer [resource defresource]]
            [formative.core :as f]
            [formative.parse :as fp]))


(let [width 500, bar-height 20
      data {"A" 1, "B" 2, "C" 4, "D" 3}
      s (scale/linear :domain [0 (apply max (vals data))]
                      :range [0 width])]

  [:div#bars
   (unify data (fn [[label val]]
                 [:div {:style {:height bar-height
                                :width (s val)
                                :background-color "gray"}}
                  [:span {:style {:color "white"}} label]]))])




(def example-form
  "Voorbeeld hoe men een webformulier kan maken."
  {:fields [{:name :secret-code :type :hidden :datatype :int}
            {:name :email :type :email}
            {:name :password :type :password}
            {:name :remember :type :checkbox}]
   :validations [[:required [:secret-code :email :password]]
                 [:min-length 8 :password]]
   :values {:secret-code 1234
            :remember true}})


(def counter (ref 0))

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
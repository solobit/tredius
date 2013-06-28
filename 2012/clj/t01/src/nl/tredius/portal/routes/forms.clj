(ns nl.tredius.portal.routes.home
  (:use [compojure.core])
  (:require [nl.tredius.portal.views.layout :as layout]
            [nl.tredius.portal.util :as util]
            [formative.core :as f]
            [formative.parse :as fp]))




(def contact-form
  "Voorbeeld hoe men een webformulier kan maken."
  {:renderer :table
   :fields [{:name :secret-code :type :hidden :datatype :int}
            {:name :email :type :email}
            {:name :password :type :password}
            {:name :remember :type :checkbox}]
   :validations [[:required [:secret-code :email :password]]
                 [:min-length 8 :password]]
   :values {:secret-code 1234
            :remember true}})

contact-form

(defn applications-page
  "Een formulier om interesse te tonen in Tredius."
  []
  (layout/render
    "home.html" {:content (util/md->html "/md/docs.md")}))

(defn contact-page
  "Een eenvoudig contactformulier."
  []
  ;(f/render-form example-form))
  (layout/render "forms/contact.html"))

(defroutes form-routes
  (GET "/wbt-form.html" [] (applications-page))
  (GET "/contact" [] (contact-page)))
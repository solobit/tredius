(ns nl.tredius.portal.views.layout
  (:use noir.request)
  (:require [clabango.parser :as parser]
            [noir.session :as session]))

(def template-path "nl/tredius/portal/views/templates/")

(defn render
  "Voert het verwerken van sjablonen, paginas en argumenten uit."
  [template & [params]]
  (parser/render-file (str template-path template)
                      (assoc (or params {})
                        :context (:context *request*)
                        :user-id (session/get :user-id))))
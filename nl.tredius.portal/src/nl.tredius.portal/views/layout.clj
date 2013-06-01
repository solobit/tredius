(ns nl.tredius.portal.views.layout
  (:use noir.request)
  (:require [clabango.parser :as parser]))

(def template-path "nl.tredius.portal/views/templates/")

(defn render [template & [params]]
  (parser/render-file (str template-path template)
                      (assoc params :context (:context *request*))))


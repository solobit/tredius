(ns nl.tredius.weergave.hiccup.base
  (:use noir.request)
  (:use hiccup.core)
  (:require [clojure.repl :refer [dir source doc]]
            [clabango.parser :as parser]
            [noir.session :as sessie]))

;; (def template-path "belastingtool/views/sjablonen/")

;; (defn render [template & [params]]
;;   (parser/render-file (str template-path template)
;;                       (assoc (or params {})
;;                         :context (:context *request*)
;;                         :user-id (session/get :user-id))))

(html [:span {:class "foo"} "bar"])

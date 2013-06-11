(ns nl.tredius.portal.routes.cljsexample
  (:require [compojure.core :refer :all]
            [noir.response :as response]
            [nl.tredius.portal.views.layout :as layout]))

(def messages
  "Demonstratie van opgeslagen berichten letterlijke waardes."
  (atom [{:message "Hello world" :user "Foo"}
         {:message "Ajax is fun" :user "Bar"}]))


(defroutes cljs-routes
  "Routes gebruikt om ClojureScript te demonstreren."

  (GET "/cljsexample"
       []
       (layout/render "cljsexample.html"))

  (GET "/messages"
       []
       (response/edn @messages))

  (POST "/add-message"
        [message user]
        (response/edn
          (swap! messages conj {:message message :user user}))))
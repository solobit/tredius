(ns nl.tredius.routes.vbcljs
  (:require [compojure.core :refer :all]
            [noir.response :as antwoord]
            [nl.tredius.weergave.layout :as layout]))

(def berichten
  (atom
    [{:bericht "Hallo wereld"
      :gebruiker "Foo"}
     {:bericht "Ajax is leuk"
      :gebruiker "Bar"}]))

(defroutes cljs-routes

  (GET "/voorbeeld"
       []
       (layout/render "voorbeeldcljs.html"))

  (GET "/berichten"
       []
       (antwoord/edn @berichten))

  (POST "/maak-bericht"
        [bericht gebruiker]
        (antwoord/edn
         (swap! berichten conj
                {:bericht bericht
                 :gebruiker gebruiker}))))

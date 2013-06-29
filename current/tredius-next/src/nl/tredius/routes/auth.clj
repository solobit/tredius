(ns nl.tredius.routes.auth
  (:use compojure.core)
  (:require [nl.tredius.modellen.db :as db]
            [nl.tredius.weergave.layout :as layout]
            [noir.session :as sessie]
            [noir.response :as antwoord]
            [noir.validation :as vali]
            [noir.util.crypt :as versleutel]))

(defn valide?
  "Controleert of de invoer geldig is, aan de hand van een aantal
  regels die men hier kan defineren."
  [id ww ww1]
  (vali/rule (vali/has-value? id)
             [:id "Gebruikersnaam is verplicht!"])
  (vali/rule (vali/min-length? ww 5)
             [:ww "Wachtwoord moet minimaal 5 tekens bevatten!"])
  (vali/rule (= ww ww1)
             [:ww1 "Ingevoerde wachtwoorden komen niet overeen!"])
  (not (vali/errors? :id :ww :ww1)))

(defn registreer
  "Verwerk de registratie / aanmeldingen pagina."
  [& [id]]
  (layout/render
    "aanmelden.html"
    {:id id
     :id-fout (vali/on-error :id first)
     :ww-fout (vali/on-error :ww first)
     :ww1-fout (vali/on-error :ww1 first)}))

(defn afhandelen-registratie
  "Handelt de noodzakelijke acties af die na geldige registratie volgen."
  [id ww ww1]
  (if (valide? id ww ww1)
    (try
      (do
        (db/maak-gebruiker {:id id :ww (versleutel/encrypt ww)})
        (sessie/put! :gebruiker-id id)
        (antwoord/redirect "/"))
      (catch Exception fout
        (vali/rule false [:id (.getMessage fout)])
        (registreer)))
    (registreer id)))

(defn profiel
  "Genereer een pagina voor de weergave van het gebruikersprofiel."
  []
  (layout/render
    "profiel.html"
    {:gebruiker (db/geef-gebruiker
                 (sessie/get :gebruiker-id))}))

(defn wijzig-profiel
  "Wijzig het gebruikersprofiel van de huidige gebruiker."
  [{:keys [voornaam achternaam email]}]
  (db/wijzig-gebruiker (sessie/get :gebruiker-id)
                       voornaam achternaam email)
  (profiel))

(defn afhandelen-login
  "Handelt de noozakelijke acties bij een aanlog pogin af."
  [id wachtwoord]
  (let [gebruiker (db/geef-gebruiker id)]
    (if (and gebruiker
             (versleutel/compare wachtwoord
                            (:wachtwoord gebruiker)))

      (sessie/put! :gebruiker-id id))
    (antwoord/redirect "/")))

(defn uitloggen
  "Sessie afsluiten en gebruiker uitloggen."
  []
  (sessie/clear!)
  (antwoord/redirect "/"))

(defroutes auth-routes
  (GET "/aanmelden" []
       (registreer))

  (POST "/aanmelden"
        [id ww ww1]
        (afhandelen-registratie id ww ww1))

  (GET "/profiel" [] (profiel))

  (POST "/wijzig-profiel"
        {params :params}
        (wijzig-profiel params))

  (POST "/inloggen" [id ww]
        (afhandelen-login id ww))

  (GET "/uitloggen" []
        (uitloggen)))

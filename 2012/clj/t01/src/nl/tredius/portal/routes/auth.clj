(ns nl.tredius.portal.routes.auth
  (:use compojure.core)
  (:require [nl.tredius.portal.views.layout :as layout]
            [noir.session :as session]
            [noir.response :as resp]
            [noir.validation :as vali]
            [noir.util.crypt :as crypt]
            [nl.tredius.portal.models.db :as db]))

(defn valid?
  "Geeft 'true' indien de aanmelding van de gebruiker geldig is."
  [id pass pass1]
  (vali/rule (vali/has-value? id)
             [:id "Gebruikersnaam is verplicht."])
  (vali/rule (vali/min-length? pass 5)
             [:pass "Wachtwoord moet uit tenminste 5 tekens bestaan."])
  (vali/rule (= pass pass1)
             [:pass1 "Ingevoerde wachtwoorden komen niet overeen."])
  (not (vali/errors? :id :pass :pass1)))

(defn register
  "Verwerken van pagina voor registratie nieuwe gebruikers."
  [& [id]]
  (layout/render
    "registration.html"
    {:id id
     :id-error (vali/on-error :id first)
     :pass-error (vali/on-error :pass first)
     :pass1-error (vali/on-error :pass1 first)}))

(defn handle-registration
  "Behandel aanmeldingen van nieuwe gebruikers."
  [id pass pass1]
  (if (valid? id pass pass1)
    (try
      (do
        (db/create-user {:id id :pass (crypt/encrypt pass)})
        (session/put! :user-id id)
        (resp/redirect "/"))
      (catch Exception ex
        (vali/rule false [:id (.getMessage ex)])
        (register)))
    (register id)))

(defn profile
  "Verwerken van pagina en sessiegegevens met gebruikersprofiel."
  []
  (layout/render
    "profile.html"
    {:user (db/get-user (session/get :user-id))}))

(defn update-profile
  "Bijwerken van profielgegevens in de databank."
  [{:keys [first-name last-name email]}]
  (db/update-user (session/get :user-id) first-name last-name email)
  (profile))

(defn handle-login
  "Behandelt het aanloggen van gebruikers."
  [id pass]
  (let [user (db/get-user id)]
    (if (and user (crypt/compare pass (:pass user)))
      (session/put! :user-id id))
    (resp/redirect "/")))

(defn logout
  "Sessie van aangelogde gebruiker eindigen en de pagina omleiden."
  []
  (session/clear!)
  (resp/redirect "/"))

(defroutes auth-routes
  (GET "/register" [] (register))
  (POST "/register" [id pass pass1] (handle-registration id pass pass1))
  (GET "/profile" [] (profile))
  (POST "/update-profile" {params :params} (update-profile params))
  (POST "/login" [id pass] (handle-login id pass))
  (GET "/logout" [] (logout)))
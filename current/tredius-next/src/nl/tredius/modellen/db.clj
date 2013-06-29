(ns nl.tredius.modellen.db
  (:require [nl.tredius.modellen.schema :as schema])
  (:use [korma.core]
        [korma.db :only (defdb)]))

(defdb db schema/db-instellingen)

(defentity gebruikers)

(defn maak-gebruiker
  "Maakt een nieuwe gebruiker aan."
  [gebruiker]
  (insert gebruikers
          (values gebruiker)))

(defn wijzig-gebruiker
  "Wijzigt de gegevens van een gebruiker in de databank."
  [id voornaam achternaam email]
  (update gebruikers
  (set-fields {:voornaam voornaam
               :achternaam achternaam
               :email email})
  (where {:id id})))

(defn geef-gebruiker
  "Geeft de gebruikersgegevens aan de hand van de gebruiker identificatie."
  [id]
  (first (select gebruikers
                 (where {:id id})
                 (limit 1))))

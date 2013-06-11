(ns nl.tredius.portal.models.db
  (:use korma.core
        [korma.db :only (defdb)])
  (:require [nl.tredius.portal.models.schema :as schema]))

(defdb db schema/db-spec)

(defentity users)

(defn create-user
  "Aanmaken van een nieuwe gebruiker in de databank."
  [user]
  (insert users
          (values user)))

(defn update-user
  "Bijwerken van een gebruiker in de databank bij."
  [id first-name last-name email]
  (update users
  (set-fields {:first_name first-name
               :last_name last-name
               :email email})
  (where {:id id})))

(defn get-user
  "Inlezen van gebruikersgegevens uit de databank."
  [id]
  (first (select users
                 (where {:id id})
                 (limit 1))))

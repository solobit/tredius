(ns nl.tredius.portal.models.schema
  (:require [clojure.java.jdbc :as sql]
            [noir.io :as io]))

(comment "Defineer naam van het databank bestand.")
(def db-store "site.db")

(def db-spec
  "Defineer databank opties en instellingen."
  {:classname "org.h2.Driver"
   :subprotocol "h2"
   :subname (str (io/resource-path) db-store)
   :user "sa"
   :password ""
   :naming {:keys clojure.string/lower-case
            :fields clojure.string/upper-case}})

(defn initialized?
  "Geeft 'true' indien het databankschema aanwezig is."
  []
  (.exists
   (new java.io.File
        (str (io/resource-path) db-store ".h2.db"))))

(defn create-users-table
  "Aanmaken van een gebruikerstabel in de databank."
  []
  (sql/with-connection db-spec
    (sql/create-table
      :users
      [:id "varchar(20) PRIMARY KEY"]
      [:first_name "varchar(30)"]
      [:last_name "varchar(30)"]
      [:email "varchar(30)"]
      [:admin :boolean]
      [:last_login :time]
      [:is_active :boolean]
      [:pass "varchar(100)"])))

(defn create-tables
  "Maakt de databank tabellen gebruikt door de applicatie aan."
  []
  (create-users-table))
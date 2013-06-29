(ns nl.tredius.modellen.schema
  (:require [clojure.java.jdbc :as sql]
            [clojure.string :as string]
            [clojure.string :refer [lower-case upper-case]]
            [noir.io :as io]))

;;
;; H2 database
;;

(def db-bestand "site.db")

(def db-instellingen
  {:classname "org.h2.Driver"
   :subprotocol "h2"
   :subname (str (io/resource-path) db-bestand)
   :user "sa"
   :password ""
   :naming {:keys lower-case
            :fields upper-case}})

(defn geïnitialiseerd?
  "Controleert of het databankschema aanwezig is."
  []
  (.exists
   (new java.io.File
        (str (io/resource-path)
             db-bestand ".h2.db"))))

(defn maak-gebruikers-tabel
  "Maak tabel met de gebruikersgegevens aan. Dit zijn personen die op de site
  kunnen inloggen en hiermee bepaalde handelingen uit kunnen voeren."
  []
  (sql/with-connection db-instellingen
    (sql/create-table
      :gebruikers
      [:id "varchar(20) PRIMARY KEY"]
      [:voornaam "varchar(30)"]
      [:achternaam "varchar(30)"]
      [:email "varchar(30)"]
      [:beheerder :boolean]
      [:laatste_login :time]
      [:is_ingeschakeld :boolean]
      [:wachtwoord "varchar(100)"])))

(defn maak-abonnees-tabel
  "Maak tabel met de gegevens van abonnees, lezers van de nieuwsbrieven aan."
  []
  (sql/with-connection db-instellingen
    (sql/create-table
      :abonnees
      [:id "varchar(20) PRIMARY KEY"]
      [:voornaam "varchar(30)"]
      [:achternaam "varchar(30)"]
      [:email "varchar(30)"]
      [:beheerder :boolean]
      [:laatste_login :time]
      [:is_ingeschakeld :boolean]
      [:wachtwoord "varchar(100)"])))



(defn dump-tabellen
  [tabel]
  (try
    (sql/drop-table tabel)
    (catch Exception _)))

(def alle-tabellen [:gebruikers
                    :abonnees])

(defn reset-db
  "Databank gegevensopslag naar begintoestand terugzetten."
  [db]
  (sql/with-connection
   db
   (dorun (map #(dump-tabellen %) alle-tabellen))
   (sql/transaction
    (try
      (dorun (map #((eval
                     (read-string
                      (str "nl.tredius.modellen.schema/"
                           "maak-" (string/replace (subs (str %) 4) "_" "-")
                           "-tabel"))))
                    alle-tabellen))
        (catch Exception ex
          (spit "log/error.log" ex))))
    nil))

(defn maak-tabellen
  "Maakt de database tabellen gebruikt door de applicatie. Verzamel benodigde
  tabellen en voeg ze hieronder toe om een succesvol verloop van de installatie
  mogelijk te maken (mochten de tabellen nog niet bestaan)."
  []
  (maak-gebruikers-tabel))

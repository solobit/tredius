(ns nl.tredius.portal.examplefrm
  (:require [formative.core :as f]
            [formative.parse :as fp]))

(def example-form
  "Voorbeeld hoe men een webformulier kan maken."
  {:fields [{:name :secret-code :type :hidden :datatype :int}
            {:name :email :type :email}
            {:name :password :type :password}
            {:name :remember :type :checkbox}]
   :validations [[:required [:secret-code :email :password]]
                 [:min-length 8 :password]]
   :values {:secret-code 1234
            :remember true}})


(f/render-form example-form)
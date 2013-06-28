(ns nl.tredius.portal.data.logic
  (:refer-clojure :exclude [==])
  (:use [clojure.core.logic]))

(def therefore-sign (char 8756))

(defn therefore
  "Prefixes the output with the therefore sign."
  [conclusion] (when (and (string? conclusion)
                          (run* [q] (== q true)))
                 (println therefore-sign conclusion)))

(therefore "Socrates is mortal")




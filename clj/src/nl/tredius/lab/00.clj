(ns nl.tredius.lab.00)


;; Deze expressie wordt achter de schermen uitgevoerd ergens, op een andere
;; locatie. Ook hier gebruik ik een future of actie uit te stellen en demonstreren.
;; Notice how I used another
(defn some-sexp
  []
  ;; hier hadden we bijv. ook fibonacci kunnen gebruiken, of Pi berekenen.
  (future
    (Thread/sleep 5000) ; kunstmatige tijdsduur van computation simuleren
    (println "Done, evaluate (deref f) to return 100, the result of heavy computation.")
    ;; closing over = laatste expressie wordt aan de functie teruggegeven
    100))


;; In the promise you are explicitly delivering a value
(def a-promise (promise))

;; ...that you select in a later computation (:fred in this case).
;(deliver a-promise :fred)

;; The future, on the other hand, is being consumed in the same place that it was created.
;(def f (future (some-sexp)))

;; ...but if it remains unevaluated by the time it is accessed the thread blocks until it is available.
;(deref f)
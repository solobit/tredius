(ns nl.tredius.repl
  (:use nl.tredius.handler
        ring.server.standalone
        [ring.middleware file-info file]))

(defonce server (atom nil))

(defn geef-afhandelaar
  "De quoted #'app Var is een truc waardoor, wanneer we onze code
  herladen, de server gedwongen wordt het symbool in de variabele
  aan te roepen, in plaats van een eigen kopie toe te staan. Wanneer
  de stamverbanden (root binding) verandert, merkt de server dit op
  zonder opnieuw te hoeven starten."
  []
  (-> #'app
      ; Stelt de `static assets` in $PROJECT_DIR/resources/public/ beschikbaar
      (wrap-file "resources")
      ; Content-Type, Content-Length en Last Modified headers voor de bestanden
      ; in body van het HTTP protocol verzoek/antwoord
      (wrap-file-info)))

(defn start-server
  "Wordt gebruikt om vanuit de REPL de server te starten, bijv. met $ lein run"
  [& [poort]]
  (let [poort (if poort (Integer/parseInt poort) 8080)]
    (reset! server
            (serve (geef-afhandelaar)
                   {:port poort
                    :init opstarten
                    :auto-reload? true
                    :destroy vernietig
                    :join? true}))
    (println (str "U kunt de site bekijken door met de web browser naar
                  http://localhost:" poort " te navigeren."))))

(defn stop-server []
  (.stop @server)
  (reset! server nil))

;(start-server)
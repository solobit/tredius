(ns nl.tredius.portal.repl
  (:use nl.tredius.portal.handler
        ring.server.standalone
        [ring.middleware file-info file]))

(defonce server (atom nil))

(defn get-handler
  "Zorgt voor het soepel verlopen van code die herladen moet worden
  zonder dat de server opnieuw gestart hoeft te worden."
  []
  ;; #'app expands to (var app) so that when we reload our code,
  ;; the server is forced to re-resolve the symbol in the var
  ;; rather than having its own copy. When the root binding
  ;; changes, the server picks it up without having to restart.
  (-> #'app
    ; Makes static assets in $PROJECT_DIR/resources/public/ available.
    (wrap-file "resources")
    ; Content-Type, Content-Length, and Last Modified headers for files in body
    (wrap-file-info)))

(defn start-server
  "Gebruikt voor het starten van de server in ontwikkelmodus vanaf de opdrachtregel."
  [& [port]]
  (let [port (if port (Integer/parseInt port) 8080)]
    (reset! server
            (serve (get-handler)
                   {:port port
                    :init init
                    :auto-reload? true
                    :destroy destroy
                    :join? true}))
    (println (str "U kunt de site bekijken op http://localhost:" port))))

(defn stop-server
  "Stop het lopende exemplaar van de webserver."
  []
  (.stop @server)
  (reset! server nil))


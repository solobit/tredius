(ns tredius.core
  (:require
    [tredius.handler :refer [war-handler]]
    [ring.middleware.reload :as reload]
    [org.httpkit.server :as http-kit]
    [taoensso.timbre :as timbre])
  (:gen-class))


;; Recognize development builds
(defn dev? [args] (some #{"-dev"} args))

;; Set HTTP server port
(defn port [args]
  (if-let [port (first (remove #{"-dev"} args))]
    (Integer/parseInt port)
    8080))

;; Entry point
(defn -main [& args]
  (http-kit/run-server
    (if (dev? args) (reload/wrap-reload war-handler) war-handler)
    {:port (port args)})
  (timbre/info "server started on port"))
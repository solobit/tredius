




(defn- static-server []
  "A streaming static file server supporting partial responses (Ranges),
  conditional-GET negotiation and granular events."
  (let [http     (require "http")  ;; Hypertext Transfer Protocol (HTTP) is het protocol voor de communicatie tussen een webclient (meestal een webbrowser) en een webserver.
        url      (require "url")   ;; Node.JS url module
        sends    (require "send")] ;; https://github.com/visionmedia/send
    ;; Function body, wrap inside
    (. http createServer
       (fn [req res]

         ;; Custom logic
         (defn error [err]
           (set! res.statusCode (or err.status 500))
           (res.end err.message))
         (defn redirect []
            (set! res.statusCode 301)
            (res.setHeader (str "Location" req.url "/"))
            (res.end (str "Redirecting to " req.url "/")))

         ;; TODO logic
         (defn file [] nil)
         (defn stream [] nil)
         (defn end [] nil)

         (->
          sends req req.url ;;(url.parse req.url) pathname
          from "/www/example.com/public"
          maxage 60000
          on "error" error
          on "directory" redirect
          pipe res))
       listen 3000)))

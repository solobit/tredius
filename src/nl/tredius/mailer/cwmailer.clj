(ns nl.tredius.mailer.cwmailer
  (:use [clojurewerkz.mailer.core])
  (:require [clostache.parser :as cl]
            [clojure.pprint :refer [pprint]]))

;; set default delivery mode (:smtp, :sendmail or :test)
(delivery-mode! :test)

;(clojure.repl/dir clojurewerkz.mailer.core)

(defn send-warnings
  "Stub method for sending out a warning."
  [] (println "WARNING SENT!"))

(defn do-something
  "Another stub method for doing stuff."
  [] (println "Busy doing stuff!"))

(defn do-something-that-delivers-email-over-smtp
  "Yet another stub function"
  []
  (println "Begin SMTP mail delivery stub...")
  (future
       (Thread/sleep 5000)
    (println "...done") 100))

;; build a message (can be used in unit tests or for various forms of delayed delivery)
;;
;; Pleasen note that email/templates/warning.mustache should be on your classpath. For example, with Leiningen 2,
;; you would use :resource-paths for this, like so: :resource-paths ["src/resources"]
(build-email {:from "Joe The Robot", :to ["ops@megacorp" "oncall@megacorp"] :subject "OMG everything is down!"}
  "email/templates/warning.mustache" {:name "Joe" :host "ares.domain.tld"})

;; build a message using an HTML template
;; FIXME specify parameter mime type :text/html
(build-email {:from "Joe The Robot", :to ["ops@megacorp" "oncall@megacorp"] :subject "OMG everything is down!"}
  "email/templates/warning.html.mustache" {:name "Joe" :host "ares.domain.tld"})

;; deliver mail, uses *delivery-mode* value to determine how exactly perform the delivery, defaults to :text/plain
(deliver-email {:from "Joe The Robot", :to ["baal@ares.domain.tld" "oncall@megacorp"] :subject "OMG everything is down!"}
  "email/templates/warning.mustache" {:name "Joe" :host "ares.domain.tld"})

;; deliver mail, specify html content type
(deliver-email {:from "Joe The Robot", :to ["baal@ares.domain.tld" "oncall@megacorp"] :subject "OMG everything is down!"}
  "email/templates/warning.html.mustache" {:name "Joe" :host "ares.domain.tld"})



;; alter message defaults, for example, From header
(with-defaults { :from "Joe The Robot <robot@megacorp>" :subject "[Do Not Reply] Warning! Achtung! Внимание!" }
  (send-warnings))

;; alter delivery mode (effective for current thread only):
(with-delivery-mode :smtp
  (do-something))

;; alter SMTP settings (effective for current thread only, only makes sense for :smtp delivery mode):
(with-settings { :host "smtp.ares.domain.tld" }
  (with-delivery-mode :smtp
    (do-something-that-delivers-email-over-smtp)))

;; render a template
(render "templates/hello.mustache" {:name "Joe"}) ;; => "Hello, Joe"
(println (cl/render "
           {{#h2}}
           h2 .h2{
            color:{{color}};
            display:block;
            /*@editable*/ font-family:Arial;
            /*@editable*/ font-size:30px;
            /*@editable*/ font-weight:bold;
            /*@editable*/ line-height:100%;
            margin-top:0 !important;
            margin-right:0 !important;
            margin-bottom:10px !important;
            margin-left:0 !important;
            /*@editable*/ text-align:left;
           }
           {{/h2}}
			" {:h2 {:color "Rob"}}))

(render "templates/conditional_hello.mustache" {:person {:name "Jim"}})
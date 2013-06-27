
(def conf (. (require "convict") {

  :env {:doc         "De Applicatie-omgeving"
        :format      ["production" "development" "test"]
        :default     "development"
        :env         "NODE_ENV"}

  :ip  {:doc         "Het IP adres om aan te binden."
        :format      "ipaddress"
        :default     "127.0.0.1"
        :env         "IP_ADDRESS"}

  :port {:doc        "De poort waaraan we binden."
         :format     "port"
         :default    8080
         :env        "PORT"}
  :key {:doc "API key"
        :format (fn [val] (check val "should be a 64 character hex key" (regex "/^[a-fA-F0-9]{64}$/")))}
        :default "3cec609c9bc601c047af917a544645c50caf8cd606806b4e0a23312441014deb"}

  :database {:host {:default  "localhost:8091"
                    :env      "DB_HOST"}}
}))

(try
  (raise exception)
  (catch error (recover error))
  (finally (.log console "That was a close one!")))

(if (== (conf.get "env") "production")
  (conf.load {:port 8080 :database {:host "tredius.nl:8091"}}))

(conf.validate)


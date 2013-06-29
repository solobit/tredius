(ns nl.tredius.budget.messages.example
  (:gen-class)
  (:require [langohr.core      :as rmq]
            [langohr.channel   :as lch]
            [langohr.queue     :as lq]
            [langohr.exchange  :as le]
            [langohr.consumers :as lc]
            [langohr.basic     :as lb]))

(def ^{:const true}
  weather-exchange "weathr")

(defn start-consumer
  "Starts a consumer bound to the given topic exchange in a separate thread"
  [ch topic-name queue-name]
  ;; local binding scope
  (let [queue-name' (.getQueue (lq/declare ch queue-name
                                           :exclusive false
                                           :auto-delete true))

        handler     (fn [ch {:keys [routing-key] :as meta} ^bytes payload]
                      (println
                       (format
                        "[consumer] Consumed '%s' from %s, routing key: %s"
                        (String. payload "UTF-8") queue-name' routing-key)))]

    ;; function body
    (lq/bind ch queue-name' weather-exchange :routing-key topic-name)

    (.start (Thread.
             (fn [] (lc/subscribe ch queue-name' handler :auto-ack true))))))



(defn publish-update
  "Publishes a weather update"
  [ch payload routing-key]
  (lb/publish ch weather-exchange
              routing-key payload
              :content-type "text/plain"
              :type "weather.update"))

;;
;; Main entry point
;; Use $ lein run -m nl.tredius.budget.messages.example
;;

(defn -main
  [& args]
  (let [conn      (rmq/connect)
        ch        (lch/open conn)
        locations {""               "americas.north.#"
                   "americas.south" "americas.south.#"
                   "us.california"  "americas.north.us.ca.*"
                   "us.tx.austin"   "#.tx.austin"
                   "it.rome"        "europe.italy.rome"
                   "asia.hk"        "asia.southeast.hk.#"}]

    (comment "
      -----------------------------------------------------------------------
     | We use a topic exchange here. Topic exchanges are used for multicast
     | messaging where consumers indicate which topics they are interested in
     | (think of it as subscribing to a feed for an individual tag in your
     | favourite blog as opposed to the full feed). ")

    (le/declare ch weather-exchange "topic" :durable false :auto-delete true)
    (doseq [[k v] locations]
      (start-consumer ch v k))
    (publish-update ch "San Diego update" "americas.north.us.ca.sandiego")
    (publish-update ch "Berkeley update"  "americas.north.us.ca.berkeley")
    (publish-update ch "SF update"        "americas.north.us.ca.sanfrancisco")
    (publish-update ch "NYC update"       "americas.north.us.ny.newyork")
    (publish-update ch "São Paolo update" "americas.south.brazil.saopaolo")
    (publish-update ch "Hong Kong update" "asia.southeast.hk.hongkong")
    (publish-update ch "Kyoto update"     "asia.southeast.japan.kyoto")
    (publish-update ch "Shanghai update"  "asia.southeast.prc.shanghai")
    (publish-update ch "Rome update"      "europe.italy.roma")
    (publish-update ch "Paris update"     "europe.france.paris")
    (Thread/sleep 2000)
    (rmq/close ch)
    (rmq/close conn)))
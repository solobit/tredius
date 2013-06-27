(defproject gridsystem "0.1.0-SNAPSHOT"
   :dependencies [[org.clojure/clojure "1.5.1"]
                 [compojure "1.1.5"]
                 [garden "0.1.0-beta5"]
                 [ring/ring-jetty-adapter "0.2.5"]
                 [com.taoensso/tower "1.7.1"]
                 [hiccup "1.0.3"]]
  :plugins [[lein-ring "0.8.5"]]
  :ring {:handler semantic-gs.handler/app}
  :profiles
  {:dev {:dependencies [[ring-mock "0.1.5"]]}})
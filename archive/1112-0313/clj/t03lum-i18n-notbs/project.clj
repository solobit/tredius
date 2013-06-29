(defproject t03luminus "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [lib-noir "0.6.4"]
                 [compojure "1.1.5"]
                 [ring-server "0.2.8"]
                 [clabango "0.5"]
                 [garden "0.1.0-beta5"]
                 [com.taoensso/tower "1.7.1"]
                 [com.taoensso/timbre "2.1.2"]
                 [com.postspectacular/rotor "0.1.0"]
                 [com.taoensso/tower "1.7.1"]
                 [markdown-clj "0.9.27"]]
  :plugins [[lein-ring "0.8.5"]]
  :ring {:handler t03luminus.handler/war-handler
         :init    t03luminus.handler/init
         :destroy t03luminus.handler/destroy}
  :profiles
  {:production {:ring {:open-browser? false
                       :stacktraces?  false
                       :auto-reload?  false}}
   :dev {:dependencies [[ring-mock "0.1.5"]
                        [ring/ring-devel "1.1.8"]]}}
  :min-lein-version "2.0.0")
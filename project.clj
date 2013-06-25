(defproject

  nl.tredius "0.1.2"

  :url               "http://tredius.nl"

  :main              nl.tredius.portal.core

  :description       "Tredius next-gen web portal. Corporate platform with
  high-performance HTTP server tested at 600.000 concurrent connections,
  grade-A middleware through the ring suite protocols, web and data mining,
  advanced mathematics and other multi-threaded, multi-core STM enabled
  sweetness from Java and Google."

  :hooks             [environ.leiningen.hooks]

  :min-lein-version  "2.0.0"

  :repositories      {"project" "file:repo"}

  :resource-paths    ["src/resources"]

  :jvm-opts          ["-Xmx2048m"]

  :plugins
  [[environ/environ.lein "0.3.0"]
   [local/hiccup-bridge "1.0.0"]]

  ;------------
  :dependencies
  ;------------

  [[enlive "1.1.1"] ; scraping
   [domina "1.0.1"] ; dom           >?
   [hiccup "1.0.3"] ; html tpl
   [hickory "0.4.1"] ; html tree zip
   [environ "0.4.0"] ; environment vars
   [cheshire "5.2.0"] ; json lib
   [http-kit "2.1.4"] ; web server
   [lib-noir "0.6.4"] ;                   ?
   [incanter "1.5.1"] ; stats/data vis
   [ring "1.2.0-RC1"] ; just all
   [clj-style "1.0.1"] ; css styles
   ;[ring-mock "0.1.5"] ; mocking ring data
   [cljs-ajax "0.1.3"] ; ajax support
   ;[ring-server "0.2.8"] ; ring-server           (take all?)
   [swiss-arrows "0.6.0"] ; monadic functors
   [garden "0.1.0-beta3"] ; css styles
   [markdown-clj "0.9.28"] ; html tpl
   [prismatic/dommy "0.1.1"] ; dom    >?
   [com.taoensso/tower "1.7.1"] ; multilang
   [com.taoensso/timbre "2.1.2"] ; logs
   [com.h2database/h2 "1.3.172"] ; db
   [org.clojure/clojure "1.5.1"]
   [com.draines/postal "1.10.3"] ; email
   ;[ring/ring-devel "1.2.0-beta3"] ; >>>>
   [org.clojure/core.logic "0.8.3"] ; needed?
   ;[ring/ring-jetty-adapter "1.1.8"] ; >>>>>
   [com.postspectacular/rotor "0.1.0"] ; ?????
   [org.clojure/clojure-contrib "1.2.0"]
   [com.novemberain/langohr "1.0.0-beta14"] ; rabbitmq
   [de.ubercode.clostache/clostache "1.3.1"] ; templates

   ;; DISABLED
   ;;
   ;;[cssgen "0.3.0-alpha1"]
   ;;[com.keminglabs/c2 "0.2.3"] ;; graph rendering
   ;;[com.keminglabs/vomnibus "0.3.2"] ;; geo data
   ;;[me.raynes/laser "1.1.1"]

   ;; EXCLUSIONS
   ;;
   [formative "0.3.2" :exclusions [ring/ring-core]]
   [liberator "0.9.0" :exclusions [org.clojure/data.json]]
   [clj-tagsoup "0.3.0" :exclusions [org.clojure/clojure]]
   [itsy "0.1.1" :exclusions [clj-http org.apache.poi/poi
                              org.clojure/core.incubator]] ; spider
   [clabango "0.5" :exclusions [commons-codec joda-time]] ; html tpl
   [org.clojure/clojurescript "0.0-1820" :exclusions [com.google.guava/guava]]
   [korma "0.3.0-RC5" :exclusions [org.clojure/java.jdbc]] ; css styles  (dep clj-style?)
   [clojurewerkz/mailer "1.0.0-alpha3" :exclusions [clojurewerkz/support]] ; also email?
   [compojure "1.1.5" :exclusions [ring/ring-core
                                   lib-noir ring-server
                                   org.clojure/core.incubator]]
   [log4j "1.2.17" :exclusions [javax.mail/mail
                                javax.jms/jms
                                com.sun.jdmk/jmxtools
                                com.sun.jmx/jmxri]]]

  :cljsbuild
  {:builds
   [{:source-paths ["src-cljs"],
     :compiler
     {:pretty-print false,
      :output-to "resources/public/js/site.js",
      :optimizations :advanced}}]}

  :ring
  {:handler nl.tredius.portal.handler/war-handler,
   :init nl.tredius.portal.handler/init,
   :destroy nl.tredius.portal.handler/destroy}

  :profiles
  {:production
   {:ring
    {:open-browser? false, :stacktraces? false, :auto-reload? false}},
   :dev
   {:dependencies []}}

  ) ;; FIN

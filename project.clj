(defproject

  nl.tredius "0.1.2"

  :url               "http://tredius.nl"

  :main              nl.tredius.portal.core

  :description       "Tredius next-gen web portal. Corporate platform with
                      high-performance HTTP server tested at 600.000 concurrent
                      connections, grade-A middleware through the ring suite protocols,
                      web and data mining, advanced mathematics and other multi-threaded,
                      multi-core STM enabled sweetness from Java and Google."

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
   [domina "1.0.1"] ; jquery-like
   [hiccup "1.0.3"] ; html templ
   [hickory "0.4.1"] ; html tree zip
   [environ "0.4.0"] ; environ vars
   [cheshire "5.2.0"] ; json functs
   [http-kit "2.1.4"] ; web server
   [lib-noir "0.6.4"] ; ring-buildutil
   [incanter "1.5.1"] ; stats/data vis
   [ring "1.2.0-RC1"] ; just use all !!
   [clj-style "1.0.1"] ; css styles
   [ring-mock "0.1.5"] ; mocking suprt
   [cljs-ajax "0.1.3"] ; ajax support
   ;[ring-server "0.2.8"] ; ring-server
   [swiss-arrows "0.6.0"] ; monadic functors
   [garden "0.1.0-beta3"] ; css styles
   [markdown-clj "0.9.28"] ; html tpl
   [prismatic/dommy "0.1.1"] ; cljs dom/events
   [com.taoensso/tower "1.7.1"] ; multilang
   [com.taoensso/timbre "2.1.2"] ; log system
   [com.h2database/h2 "1.3.172"] ; database
   [org.clojure/clojure "1.5.1"] ; the language
   [com.draines/postal "1.10.3"] ; email send/rec
   ;[ring/ring-devel "1.2.0-beta3"] ;
   [org.clojure/core.logic "0.8.3"] ; needed ??
   ;[ring/ring-jetty-adapter "1.1.8"] ;
   [com.postspectacular/rotor "0.1.0"] ; rot. log append
   [org.clojure/clojure-contrib "1.2.0"] ; clojure extra
   [incanter/incanter-processing "1.3.0"] ; proc.module
   [com.novemberain/langohr "1.0.0-beta14"] ; rabbitmq msg
   [de.ubercode.clostache/clostache "1.3.1"] ; templates

   ;; DISABLED
   ;;
   ;;[cssgen "0.3.0-alpha1"]
   ;;[com.keminglabs/c2 "0.2.3"] ;; graph rendering
   ;;[com.keminglabs/vomnibus "0.3.2"] ;; geo data
   ;;[me.raynes/laser "1.1.1"]

   ;; EXCLUSIONS
   ;;
   [formative "0.3.2"   :exclusions [ring/ring-core]]
   [liberator "0.9.0"   :exclusions [org.clojure/data.json]]
   [clj-tagsoup "0.3.0" :exclusions [org.clojure/clojure]]
   [korma "0.3.0-RC5"   :exclusions [org.clojure/java.jdbc]]
   [clabango "0.5"      :exclusions [commons-codec joda-time]]
   [itsy "0.1.1"        :exclusions [clj-http org.apache.poi/poi
                                     org.clojure/core.incubator]]
   [compojure "1.1.5"   :exclusions [ring/ring-core
                                     lib-noir ring-server
                                     org.clojure/core.incubator]]
   [org.clojure/clojurescript "0.0-1820" :exclusions [com.google.guava/guava]]
   [clojurewerkz/mailer "1.0.0-alpha3"   :exclusions [clojurewerkz/support]]
   [log4j "1.2.17"      :exclusions [javax.mail/mail
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

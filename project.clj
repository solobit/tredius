(defproject

  nl.tredius.portal
  "0.1.0-SNAPSHOT"

  :min-lein-version "2.0.0"

  :url "http://tredius.nl"

  :main nl.tredius.portal.core

  :description
  "Tredius next-gen web portal by Solobit."

  :hooks
  [environ.leiningen.hooks]

  :plugins
  [[environ/environ.lein "0.3.0"]
   [local/hiccup-bridge "1.0.0"]]

  :dependencies
  [[http-kit "2.1.3"]
   [lib-noir "0.6.1"]
   [enlive "1.1.1"]
   ;[cssgen "0.3.0-alpha1"]
   [clabango "0.5"] ;; (html) templates
   [com.taoensso/timbre "2.1.2"] ;; logger
   [com.postspectacular/rotor "0.1.0"]
   [com.taoensso/tower "1.7.1"]
   [markdown-clj "0.9.26"]
   [domina "1.0.1"]
   [prismatic/dommy "0.1.1"]
   [cljs-ajax "0.1.3"] ;; ajax interop
   [com.h2database/h2 "1.3.172"] ;; db adapter
   [korma "0.3.0-RC5"] ;; database clean dsl
   [garden "0.1.0-beta3"] ;; css parser
   [hiccup "1.0.3"] ;; html parsing
   [environ "0.3.0"] ;; operating system env
   [me.raynes/laser "1.1.1"] ;; html transform
   [ring-mock "0.1.5"] ;; mockup
   [ring-server "0.2.8"]
   [org.clojure/clojure "1.5.1"]
   [ring/ring-devel "1.2.0-beta3"]
   [ring/ring-jetty-adapter "1.1.8"]
   [org.clojure/clojure-contrib "1.2.0"]
   [com.novemberain/langohr "1.0.0-beta14"] ;; message brokers

   ;; DISABLED
   ;;
   ;;[com.keminglabs/c2 "0.2.3"] ;; graph rendering
   ;;[com.keminglabs/vomnibus "0.3.2"] ;; geo data

   ;; EXCLUSIONS
   ;;
   [formative "0.3.2" :exclusions [ring/ring-core]]
   [liberator "0.9.0" :exclusions [org.clojure/data.json]]
   [clj-tagsoup "0.3.0" :exclusions [org.clojure/clojure]]
   [compojure "1.1.5" :exclusions [ring/ring-core lib-noir ring-server]]
   [org.clojure/clojurescript "0.0-1820" :exclusions [com.google.guava/guava]]
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

  :repositories {"project" "file:repo"}

  :profiles
  {:production
   {:ring
    {:open-browser? false, :stacktraces? false, :auto-reload? false}},
   :dev
   {:dependencies [[hiccup "1.0.2"]
                   [environ "0.3.0"]
                   [ring-mock "0.1.5"]
                   [ring/ring-devel "1.2.0-beta3"]
                   [ring/ring-jetty-adapter "1.1.7"]]}}

  ) ;; FIN

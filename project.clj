(defproject

  nl.tredius.portal
  "0.1.0-SNAPSHOT"

  :min-lein-version "2.0.0"

  :url "http://tredius.nl"

  :main nl.tredius.portal.core

  :description
  "Tredius next-gen web portal made by Solobit."

  :plugins
  [[lein-ring "0.8.5"]
   [lein-cljsbuild "0.3.2"]]

  :dependencies
  [[org.clojure/clojure "1.5.1"]
   [http-kit "2.1.3"]
   [lib-noir "0.6.1"]
   [enlive "1.1.1"]
   ;[cssgen "0.3.0-alpha1"]
   [ring-server "0.2.8"]
   [clabango "0.5"]
   [com.taoensso/timbre "2.1.2"]
   [com.postspectacular/rotor "0.1.0"]
   [com.taoensso/tower "1.7.1"]
   [markdown-clj "0.9.26"]
   [domina "1.0.1"]
   [prismatic/dommy "0.1.1"]
   [cljs-ajax "0.1.3"]
   [com.h2database/h2 "1.3.172"] ;; db adapter
   [korma "0.3.0-RC5"] ;; database clean dsl
   [com.keminglabs/c2 "0.2.3"] ;; graph rendering
   [com.keminglabs/vomnibus "0.3.2"] ;; geo data
   [log4j
    "1.2.17"
    :exclusions
    [javax.mail/mail
     javax.jms/jms
     com.sun.jdmk/jmxtools
     com.sun.jmx/jmxri]]
   [garden "0.1.0-beta3"]
   [com.novemberain/langohr "1.0.0-beta14"]
   [formative "0.3.2" :exclusions [ring/ring-core]]
   [liberator "0.9.0" :exclusions [org.clojure/data.json]]
   [clj-tagsoup "0.3.0" :exclusions [org.clojure/clojure]]
   [compojure "1.1.5" :exclusions [ring/ring-core lib-noir ring-server]]
   [org.clojure/clojurescript "0.0-1820" :exclusions [com.google.guava/guava]]
   ]

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
   {:dependencies [[ring-mock "0.1.5"]
                   [ring/ring-devel "1.2.0-beta3"]]}}

  ) ;; FIN

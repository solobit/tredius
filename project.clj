(defproject

  nl.tredius.portal
  "0.1.0-SNAPSHOT"

  :min-lein-version "2.0.0"

  :url "http://tredius.nl"

  :main nl.tredius.portal.core

  :description
  "Tredius next-gen web portal made by Solobit."

  :plugins
  [;[lein-ring "0.8.5"] ; using http-kit
   [lein-cljsbuild "0.3.2"]]

  :dependencies
  [[org.clojure/clojure "1.5.1"]
   [clj-tagsoup "0.3.0"]
   [http-kit "2.1.3"]
   [lib-noir "0.6.1"]
   [compojure "1.1.5"]
   ;[ring-server "0.2.8"] ; using http-kit
   [clabango "0.5"]
   [com.taoensso/timbre "2.1.2"]
   [com.postspectacular/rotor "0.1.0"]
   [com.taoensso/tower "1.7.1"]
   [markdown-clj "0.9.26"]
   [org.clojure/clojurescript "0.0-1806"]
   [domina "1.0.0"]
   [prismatic/dommy "0.1.1"]
   [cljs-ajax "0.1.3"]
   [com.h2database/h2 "1.3.170"]
   [korma "0.3.0-RC5"]
   [log4j
    "1.2.15"
    :exclusions
    [javax.mail/mail
     javax.jms/jms
     com.sun.jdmk/jmxtools
     com.sun.jmx/jmxri]]
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
   {:dependencies [[ring-mock "0.1.5"] [ring/ring-devel "1.1.8"]]}}

  ) ;; FIN
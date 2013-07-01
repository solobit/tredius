(defproject

  nl.tredius

  "0.1.0-SNAPSHOT"

  :min-lein-version "2.0.0"

  :url "http://www.tredius.nl/tool"

  :main nl.tredius.core

  :description
  "Tredius tool voor vergelijken van belasting en accijns
  met andere huishoudens in vergelijkbare situaties."

  :repositories      {"project" "file:repo"}

  :resource-paths    ["src/resources"]

  :jvm-opts          ["-Xmx1024m"]

  :plugins
  [[lein-ring "0.8.5"]
   [lein-cljsbuild "0.3.2"]]

  :dependencies
  [[clabango "0.5"]
   [domina "1.0.1"]
   [hickory "0.4.1"]
   [lib-noir "0.6.4"]
   [cljs-ajax "0.1.3"]
   [compojure "1.1.5"]
   [ring-server "0.2.8"]
   [prismatic/dommy "0.1.1"]
   [com.taoensso/tower "1.7.1"]
   [com.taoensso/timbre "2.1.2"]
   [org.clojure/clojure "1.5.1"]
   [com.postspectacular/rotor "0.1.0"]
   [org.clojure/clojurescript "0.0-1806"]
   [local/clojure-csv "2.0.0-alpha2"]
   [com.h2database/h2 "1.3.172"]
   [markdown-clj "0.9.28"]
   [korma "0.3.0-RC5"]
   [http-kit "2.1.4"]
   [log4j
    "1.2.17"
    :exclusions
    [javax.mail/mail
     javax.jms/jms
     com.sun.jdmk/jmxtools
     com.sun.jmx/jmxri]]]

  ;[org.clojure/data.finger-tree "0.0.1"]

  :cljsbuild
  {:builds
   [{:source-paths ["src-cljs"],
     :compiler
     {:pretty-print false,
      :output-to "resources/public/js/site.js",
      :optimizations :advanced}}]}

  :ring
  {:handler nl.tredius.handler/web-archief,
   :init nl.tredius.handler/opstarten,
   :destroy nl.tredius.handler/vernietig}

  :profiles
  {:production {:ring {:open-browser? false
                       :stacktraces? false
                       :auto-reload? false}}

   :dev {:dependencies [[ring-mock "0.1.5"]
                        [ring/ring-devel "1.1.8"]]}})
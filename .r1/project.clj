(defproject
  tredius       "0.1.0-SNAPSHOT"
  :url          "http://www.tredius.nl"
  :description  "Corporate platform for Tredius"
  :main          tredius.core
  :min-lein-version "2.0.0"

  :dependencies
    [[domina "1.0.0"]
     [lib-noir "0.5.6"]
     [http-kit "2.1.3"]
     [cljs-ajax "0.1.1"]
     [criterium "0.3.1"]
     [ring-server "0.2.8"]
     [markdown-clj "0.9.25"]
     [prismatic/dommy "0.1.1"]
     ;[stringtemplate-clj "0.1.0"]
     [com.taoensso/tower "1.5.1"]
     [org.clojure/clojure "1.5.1"]
     [org.clojure/core.logic "0.8.3"]
     ;[commons-codec "1.2"] ; base64
     [com.taoensso/timbre "1.6.0"] ; log
     [com.postspectacular/rotor "0.1.0"]
     ;[com.palletops/pallet "0.8.0-beta.10"]
     ;[org.bituf/clj-stringtemplate "0.2"]
     ;[org.antlr/stringtemplate "4.0.2"]
     [org.clojure/clojurescript "0.0-1806"]
     [clabango "0.5" :exclusions [cheshire]]
     [enlive "1.1.1" :exclusions [org.clojure/clojure]]
     [cssgen "0.2.6" :exclusions [org.clojure/clojure]]
     [compojure "1.1.5" :exclusions [ring/ring-core org.clojure/tools.macro]]
     [org.apache.opennlp/opennlp-tools "1.5.2-incubating"]]

  :plugins [[lein-ring "0.8.5" :exclusions [org.clojure/clojure]]
            [lein-cljsbuild "0.3.2"]]

  :profiles {:1.2 {:dependencies [[org.clojure/clojure "1.2.1"]]}
             :1.3 {:dependencies [[org.clojure/clojure "1.3.0"]]}
             :1.4 {:dependencies [[org.clojure/clojure "1.4.0"]]}
             :1.5 {:dependencies [[org.clojure/clojure "1.5.1"]]}}

  :aliases {"all" ["with-profile" "dev,1.2:dev,1.3:dev:dev,1.5"]}
  :jvm-opts ["-Xmx2048m"]
  :cljsbuild

  {:builds
   [{:source-paths ["src-cljs"],
     :compiler
     {:pretty-print false,
      :output-to "resources/public/js/site.js",
      :optimizations :advanced}}]}

  :ring
  {:handler tredius.handler/war-handler,
   :init tredius.handler/init,
   :destroy tredius.handler/destroy}

  :profiles
  {:production
   {:ring
    {:open-browser? false, :stacktraces? false, :auto-reload? false}},
   :dev
     {:dependencies [[ring-mock "0.1.3"]
                     [ring/ring-devel "1.1.8" :exclusions [hiccup]]]}})

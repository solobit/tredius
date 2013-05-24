(defproject
  tredius       "0.1.0-SNAPSHOT"
  :url          "http://www.tredius.nl"
  :description  "Corporate platform for Tredius"

  :dependencies
    [[org.clojure/clojure "1.5.1"]
     [lib-noir "0.5.6"]
     [enlive "1.1.1"]
     [compojure "1.1.5"]
     [ring-server "0.2.8"]
     [clabango "0.5"]
     [com.taoensso/timbre "1.6.0"]
     [com.postspectacular/rotor "0.1.0"]
     [com.taoensso/tower "1.5.1"]
     [markdown-clj "0.9.25"]
     [domina "1.0.0"]
     [prismatic/dommy "0.1.1"]
     [cljs-ajax "0.1.1"]
     [http-kit "2.1.3"]
     [com.palletops/pallet "0.8.0-beta.10"]
     [org.clojure/clojurescript "0.0-1806"]]

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
     {:dependencies [[ring-mock "0.1.3"] [ring/ring-devel "1.1.8"]]}}

  :main tredius.core
  :plugins [[lein-ring "0.8.5"] [lein-cljsbuild "0.3.2"]]
  :min-lein-version "2.0.0")
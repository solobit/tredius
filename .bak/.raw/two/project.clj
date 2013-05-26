
(defproject two "0.1.0-SNAPSHOT"

  :url "http://wwww.tredius.nl"
  :description "Tredius corporate web platform"
  :min-lein-version "2.0.0"

  :dependencies
  [[org.clojure/clojure "1.5.1"]
   [lib-noir "0.5.6"]
   [cljs-ajax "0.1.1"]
   [http-kit "2.1.2"] ; 600k
   [domina "1.0.2-SNAPSHOT"] ; DOM
   [prismatic/dommy "0.1.1"]
   [ring-server "0.2.8"] ; obsolete?
   [com.taoensso/timbre "1.6.0"]
   [com.taoensso/tower "1.5.1"]
   [markdown-clj "0.9.25"] ; Markdown->HTML
   [com.postspectacular/rotor "0.1.0"]
   [org.clojure/clojurescript "0.0-1806"]
   [clabango "0.5" :exclusions [cheshire]] ; HTML templates
   [ring/ring-devel "1.1.8" :exclusions [hiccup]]
   [ring-reload-modified "0.1.1" :exclusions [org.clojure/tools.namespace]]
   [compojure "1.1.5" :exclusions [[org.clojure/tools.macro]
                                   [ring/ring-core] clout]]]

  :cljsbuild {

     :repl-listen-port 9000

     :repl-launch-commands {"firefox" ["firefox" :stdout ".repl-firefox-out"
                                                 :stderr ".repl-firefox-err"]}

     ; Sun Web application ARchives
     :ring {:handler two.handler/war-handler
            :init    two.handler/init
            :destroy two.handler/destroy}


     :builds { ; $ lein help cljsbuild

        :dev ; Lowest level of optimizations, useful when debugging the app.

          {:jar true
           :source-paths ["src-cljs"]
           :compiler { :output-to     "resources/public/js/main-debug.js"
                       :optimizations :whitespace
                       :pretty-print  true}}

        :prod ; Highest level of optimizations, efficient when running in production.

          {:source-paths ["src-cljs"]
           :compiler { :output-to     "resources/public/js/main.js"
                       :optimizations :advanced
                       :pretty-print  false}}

        :test ; Unit tests for ClojureScript using PhantomJS.

          {:source-paths ["test-cljs"]
           :compiler { :output-to     "resources/private/js/unit-test.js"
                       :optimizations :whitespace
                       :pretty-print  true}} }


  ;; These can also be defined (for :user and custom profiles)
  ;; inside ~/.lein see $ lein help profiles
  :profiles {
             :production {
                          :ring {
                                 :open-browser? false
                                 :stacktraces?  false
                                 :auto-reload?  false}}

             :dev {
                   :dependencies [[ring-mock "0.1.3"]
                                  [ring/ring-devel "1.1.8" :exclusions [hiccup]]]}

                   :ring {:open-browser? false
                          :stacktraces?  false
                          :auto-reload?  false}} }


  :plugins [[lein-ring "0.7.0" :exclusions [org.clojure/clojure]]
            [lein-cljsbuild "0.3.2"]] )

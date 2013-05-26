(import [empty? count list? list first second third rest cons conj
         reverse reduce reduce-list vec last map-list lazy-seq
         map filter seq take sort concat] "../core/sequence")

(import [odd? dictionary? dictionary merge keys vals key-values contains-vector?
         map-dictionary string? object? fn? number? vector? boolean? subs re-find
         true? false? nil? re-pattern? inc dec str and char int
         or = == > >= < <= + - / *] "../core/runtime")

(import [split join upper-case replace] "../core/string")

;; Custom meta-object
(def ^:private software-managers
{ :npm        {:name        "Node Packaged Modules"
              :description  "A package manager for node"
              :entry-point  "npm"
              :references   {:home       "https://npmjs.org/"
                            :readme     "https://npmjs.org/doc/README.html"
                            :registry   "https://registry.npmjs.org/" ;; <pkgname>
                            :format     "https://npmjs.org/doc/json.html"
                            :example    "http://package.json.nodejitsu.com"
                            :faq        "https://npmjs.org/doc/faq.html"
                            :source     "https://github.com/isaacs/npm"
                            :other      []}
              :configure    {:localcfg   ""
                            :package     "$PROJECT/package.json"
                            :profile     "$HOME/.npmrc"}}

  :bower      {:name        "Twitter Bower"
              :description  "Web developer front-endpackage manager with flat dependency tree over git."
              :repositories "server"
              :entry-point  "bower"
              :references   {:home       "https://github.com/bower/bower"
                            :readme      "https://github.com/bower/bower/blob/master/README.md"
                            :registry    "http://sindresorhus.com/bower-components/"
                            :configure   "https://github.com/bower/bower#configuration"
                            :format      "https://github.com/bower/bower#defining-a-package"
                            :example     "https://gist.github.com/facultymatt/5482781#file-bower-json"
                            :faq         ""
                            :source      "https://github.com/bower/bower"
                            :other       []}
              :configure    {:packages   "$PROJECT/bower.json"
                            :localcfg    "$PROJECT/.bowerrc"
                            :profile     "$HOME/.bowerrc"}}

  :volo       {:name        "volo"
              :description  "Dependency manager and project creation tool, at its heart a generic command runner - create new commands and use commands from others"
              :repositories "git"
              :entry-point  "volo"
              :references   {:home       "http://volojs.org/"
                            :readme      "https://github.com/volojs/volo/blob/master/README.md"
                            :registry    "https://github.com/search?q=volo&nwo=volojs%2Fvolo&search_target=global&ref=cmdform"
                            :configure   "https://github.com/volojs/volo/wiki/Creating-a-volo-command"
                            :format      "https://github.com/volojs/volo/wiki/Creating-a-volofile"
                            :example     "https://github.com/volojs/volo/wiki/Library-best-practices#wiki-singleexample"
                            :discussion  "https://groups.google.com/forum/?fromgroups#!forum/volojs"
                            :source      "https://github.com/volojs/volo"}
              :configure    {:packages   "./volofile"}}
  :ender {}
  :component {}
  :yeoman {}
  :support {:pkginfo {}
            :latest {}   ;; Laatste versies
            :semver {}   ;; Semantische nummering
            :npm-research {} } ;; Onderzoek packages
})


(defn- inladen-npm
 "Interne node.js pakketbeheer en download tool."
 []
  (try
     (. (require "npm") load gegevens.package)
     (. console log "NPM config loaded")
   (catch error {:error error})))



;; Package / dependency managers
;; (defn software-beheer
;;  [pm]
;;  (let [pm ])
;;  (require "npm")))

;(require "pkginfo")


;; Het semantische versie-nummeringsysteem, een afspraak tussen ontwikkelaars
;; van software op basis van conventies (overeenkomst) logisch te nummeren.
;(require "semver")

;; De laatste versies van programmas vinden kan lastig zijn, hulp is welkom.
;(require "latest")

;(require "npm-research")


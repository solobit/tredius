
;; Core modules
(import fs "fs")
(import path "path")

;; Additional muscle
(require "shelljs/global")

;; Additional tongue
(import i18n "i18next")

;; Sequences, lists, collections
(import [cons conj list list? seq vec
         empty? count
         first second third rest last butlast
         take drop
         concat reverse sort
         map filter reduce] "../sequence")
(import [str inc dec even? odd? vals key-values keys =] "../runtime")

(defmacro ->
  "Threads the expr through the forms. Inserts x as the
  second item in the first form, making a list of it if it is not a
  list already. If there are more forms, inserts the first form as the
  second item in second form, etc."
  {:added "1.0"}
  ([x] x)
  ([x form] (if (seq? form)
              (with-meta `(~(first form) ~x ~@(next form)) (meta form))
              (list form x)))
  ([x form & more] `(-> (-> ~x ~form) ~@more)))

;; Variables
(def proj-dir (. path resolve "../../../../../"))
(def Stream (. (require "stream") Stream))

;; Helper functions
(defn log [msg] (. console log msg))
(defn time-ago [x] (.get (require "vague-time") getVagueTime x))

;; External tools
(def filter (require "fuzzy-filter")) ; (log (filter "cs" ["cheese", "pickles", "crackers", "pirate attack", "cs!!"]))
(def inflect (require "inflection"))  ; https://github.com/dreamerslab/node.inflection



;;
;; Main hash
;;

(def docpad
 {
  :location     proj-dir
  :options      ((require "nopt") known-opts short-hands process.argv 2)
  :numcpus      (:length (.cpus (require "os")))
  :configfile   (. (require "nconf") file {:file (.join path proj-dir "/package.json")})
  :dependencies (. (require "nconf") get "dependencies")
  :instance     (. (require "docpad") createInstance config-docpad)
  :licenses     (. (require "lawyer") checkLicenses proj-dir)
  :polyglot     (require "consolidate") ;; still needs their native compilers!
  :stylesheets  nil ;; TODO implement
  })


;;
;; Config data (literal hashes)
;;

;; Internationalization and cultures
;; http://i18next.com/
(def config-i18n {
  :preload        ["nl-NL"]
  :lng            "nl-NL"
  :fallbackLng    false ;; en
  :load           "current"
  :detectLngQS    "taal'"
  :useCookie      true
  :debug          true
  :keyseparator   "::"
  :nsseparator    ":::"
  :resGetPath     (.join path proj-dir "/etc/i18n" "/__lng__/__ns__.json")
  :ns             {:namespaces ["app"] :defaultNs "app"}
  })

;; Docpad sample config
;; http://docpad.org/docs/config
(def config-docpad {
  :airbrakeToken nil
  :catchExceptions true
  :checkVersion false
  :collections {}
  :configPaths ["docpad.js" "docpad.coffee" "docpad.json" "docpad.cson"]
  :detectEncoding false
  :documentsPaths ["documents"]
  :enabledPlugins {:pokemon false :digimon true}
  :enabledUnlistedPlugins true
  :env nil
  :environments {:development {:maxAge false :port 9005}}:pluginsPaths ["node_modules" "plugins"]
  :events {:serverExtend (fn nil)}
  :extendServer true
  :filesPaths ["files" "public"]
  :growl true
  :helperUrl "https//docpad.org/helper/"
  :ignoreCommonPatterns true
  :ignoreCustomPatterns false
  :ignoreHiddenFiles false
  :ignorePaths false
  :layoutsPaths ["layouts"]
  :localeCode nil
  :logger nil
  :logLevel nil
  :maxAge 86400000
  :middleware404 true
  :middleware500 true
  :middlewareBodyParser true
  :middlewareExpressRouter true
  :middlewareMethodOverride true
  :middlewareStandard true
  :mixpanelToken nil
  :outPath "out"
  :packagePath "package.json"
  :pluginPaths []
  :plugins {:stylus {:useNib false } }
  :port nil
  :prompts false
  :regenerateDelay 100
  :regenerateEvery false
  :regeneratePaths []
  :reloadPaths []
  :renderPasses 1
  :renderSingleExtensions false
  :reportErrors nil
  :reportStatistics nil
  :rootPath (process.cwd)
  :safeMode false
  :serverExpress nil
  :serverHttp nil
  :skipUnsupportedPlugins true
  :srcPath "src"
  :welcome false
  :templateData {
    :site {
      :url "http//website.com"

      :title  "Your Website"

      :description "When your website appears in search
       results in say Google the text here will be shown
       underneath your websites title."

      :keywords "place your website keywoards here keep them
       related to the content of your website"}}
})

;; Winston loggers
;; https://github.com/flatiron/winston
(def config-logger {
  :levels {:silly 0 :verbose 1 :info 2 :data 3 :warn 4 :debug 5 :error 6}
  :colors {:silly "magenta" :verbose "cyan" :info "green" :data "grey"
           :warn "yellow":debug "blue":error "red"}})

;; Node options parser
(def known-opts { :foo [String, null]
                  :bar [Stream, Number]
                  :baz path
                  :bloo [ "big", "medium", "small" ]
                  :flag Boolean
                  :pick Boolean
                  :many [String, Array]
                  })

(def short-hands { :foofoo ["--foo", "Mr. Foo"]
                   :b7 ["--bar" "7"]
                   :m ["--bloo" "medium"]
                   :p ["--pick"]
                   :f ["--flag"]
                   })


(log docpad)



;;
;; Side effect generating functions
;;


(defn dp [] (:instance docpad x))

(defn t [] (. i18n init config-i18n))

(def winston (require "winston"))

(def logger (new winston.Logger) {
  :transports [ (Console. winston.transports {:colorize true}) ]
  :levels (:levels config-logger)
  :colors (:colors config-logger)})

;;(logger.data "hello")

(def Table (require "cli-table"))
(def table (Table. {:head ["TH 1 label" "TH 2 label"] :colWidths [100 200]}))

(. table push ["first" "second"])



;(map (table.push) (keys config-docpad) (vals config-docpad))

(.log console (. table toString))


(def optionals {
  :awssum "https://github.com/awssum/awssum"
  })

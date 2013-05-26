(import fs "fs")
;(import [dictionary?] "../sequence")
(import [string? nil? dictionary?] "../runtime")
(import [load-config] "./projects")

;; data

;; Often these modules are simply (a) wrapper(s) for some already great node.js
;; packages out there. config. for comfort this data is exposed from with. Some
;; expose Object instances, others functions, even literal objects, or functions
;; (anon or named) attached to object keys (assoc arrays).

(def ^:private defaults {
  :source     "https://github.com/jamuhl/i18next"
  :help       "http://i18next.com/pages/doc_init.html"
  :resGetPath "../../../../data/locale/__lng__/__ns__.json"
  ;; Set static route to load resources. Will load 'locales/en-US/translation.json'. If language is set to 'en-US' following resource files will be loaded one-by-one: en-US, en, dev (default fallback language). Hint: to lowercase countryCode in requests, eg. to 'en-us' set option lowerCaseLng = true
  :preload         ["nl-NL"]   ;; array    - The additional languages will be preloaded.
  :lng              "nl-NL"    ;; string   - Resolve order: 1) languageCode plus countryCode, eg. 'en-US' 2) languageCode only, eg. 'en' 3) finally fallback language, default: 'dev' If language is not set explicitly i18next tries to detect the user language by: 1) querystring parameter (?setLng=en-US) 2) cookie (i18next) 3) language set in navigator
  :fallbackLng      "en"       ;; str/bool - If not set it will default to 'dev'. If turned on, all missing key/values will be sent to this language. (use e.g. 'en' for production). False: As the fallbackLng will default to 'dev' you can turn it off by setting the option value to false. This will prevent loading the fallbacks resource file and any futher look up of missing value inside a fallback file.
  :load             "current"  ;; string   - If load option is set to current i18next will load the current set language (this could be a specific (en-US) or unspecific (en) resource file).
  :detectLngQS      "taal"     ;; string   - The current locale to set will be looked up in the new parameter: ?lang=en-US Hint: default would be ?setLng=en-US
  :useCookie        true       ;; boolean  - Use this only if your sure that language will be provided by the other lookup options or set programatically.
  :debug            true       ;; boolean  - If something went wrong you might find some helpful information on console log.
  :keyseparator     "::"       ;; string   - Seperator for keys
  :nsseparator      ":::"      ;; string   - Seperator for namespaces
  :ns {:namespaces ["app"]     ;; array    - The additional namespaces will be loaded.
       :defaultNs   "app"      ;; string   - The default namespace to load)
}})



(. console log (load-config "../../../package.json")));{:a "aa" :b "bb"}))



;; i18n
(def get-message
  "Obtains a user-visible string text message that has been translated to
  support localization/internationalization of your applications."
 [msgname]
 (cond (if (string? msgname) "")))








;; automate

(defn translate
 "Translates English to Dutch using a secret backdoor for the now paid
 Google translate services (booooo)"
 [words]
   (let [http (require "http")
         options {:host "http://translate.google.com" :port 80
                 :path (str "http://translate.google.com/translate_a/t?client=t&text="words"&hl=en&sl=nl&tl=en&multires=1&otf=2&pc=1&ssel=0&tsel=0&sc=1")}]

    (. http get options (fn [res, req]
      (. console log (str "Got response: " res.statusCode))
       (res.on "error" (fn [error]
        (try (raise exception)
          (catch error (. console log error)))))))))


(defn opt [words]
 (let [x {:host "http://translate.google.com" :port 80 :path (str "/translate_a/t?client=t&text=" words "&hl=en&sl=nl&tl=en&multires=1&otf=2&pc=1&ssel=0&tsel=0&sc=1")}]
 (. console log (str (:host x)(:path x)))))

;(opt "hello%20world")

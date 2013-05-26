
;; Tredius project * final upgrade

;; 1. Inleiding
;; ------------

;; JavaScript is een scripttaal die veel gebruikt wordt om webpagina's interactief te maken en webapplicaties te ontwikkelen. JavaScript kan ook gebruikt worden voor server-side scripting. De laatste jaren maakt node.js een grote opgang.

;; Hypertext Transfer Protocol (HTTP) is het protocol voor de communicatie tussen een webclient (meestal een webbrowser) en een webserver.
(require "http")

;; NPM is volgens de maker van Node.js geen acroniem voor "Node Package Manager". Het lost een groot deel van de problemen met 'dependency hell' (letterlijke betekenis: hel van de onderling afhankelijke software bibliotheken) op.
(require "npm")

;; Versiebeheer is een van deze zaken die van belang is voor het delen van bibliotheken zodat deze ook binnen andere programmas werkzaam en werkbaar is.

;; Het semantische versie systeem is een afspraak tussen ontwikkelaars van software. Het volgt een op conventies (overeenkomsten) gebaseerd systeem van versie-nummers: 1.0.2 -> geen grote wijzigingen, 1.1.0 -> mogelijk breekt de software, Majors 2.0.0 -> gegarandeerd problemen indien geen conversie plaats vindt.
(require "semver")

;; De laatste versies van programmas vinden kan lastig zijn, hulp is welkom.
(require "latest")

;; Belangrijk is dat Node.js interactie met het bestandssysteem mogelijk maakt. Dit doen wij ook, voor onze site-generator onder andere. Node.js heeft hiervoor een aantal interne bibliotheken
(import path "path")
(import fs "fs")

;; Ook andere talen zijn mogelijk te gebruiken, een bekende taal die naar JavaScript transcompileert is CoffeeScript:
(require "coffee-script")

;; Ook de taal die ik gebruik is er een die naar een 'schone' functionele stijl van JavaScript compileert (zie rechtervlak) en welke gebaseerd is op de taal. Clojure gemaakt door Rich Hickey. Wisp is een taal die schone "Homoiconic JS with clojure syntax, s-expressions & macros" naar het web brengt. In tegenstelling tot ClojureScript die een oerwoud aan Google Closure Library code genereert.
(require "wisp")

;; Node.js projecten worden, indien gewenst ingelezen door het 'npm' programma en kan hier uit diverse gegevens over afhankelijke software, auteurs(rechten), onderhoud, downloads, en dergelijke meta-gegevens uitlezen. De `./` verwijst naar de bronmap.


;; 2. Gegevensopslag
;; -----------------

;; Cf doctrine: beter 1 datastructuur met 100 functies dan 10 functies over 10 datastructuren
;; Sleutelwoorden `:sleutel` bevatten veel paden en teksten, herhaling voorkomen met de functies
(def ^:private gegevens {

  ;; De belangrijkste gegevens die we nodig hebben om ons project in te laden.
  :hoofdproject {:bron "./" :site "www" :definitie "package.json"
                 :stijl "documenten/stijlen/lib/index.styl"
                 :afbeeldingen "media/afbeeldingen" :code "src"}

  ;; We erkennen een corporate identity als belangrijke data structuur voor gebruik op de site. De huisstijl is een van haar onderdelen.
  :typografisch {:primair     ["Open Sans" "500,600,700" "italic"]
                 :alternatief ["Dosis" "500,600,700"] }

  ;; Regelmatig benodigde informatie van illustraties, afbeeldingen, mappen en logo's of art-work kan hier.
  :illustraties {:bedrijfslogo (afb "bedrijfslogo.jpg") }

  ;; Semantic grid system
  :vlakindeling {:kolommen 12 :soort "fixed" :breedte 960}

  ;; TODO: ; (. Color desaturate 0.5)
  ;; Kleuren lichter, donkerder, transformeren van en naar CSS.
  :kleuren {:fn (require "color")
            :wit   "#ffffff" :zwart "#000000"
            :paars "1234"    :licht-paars "1234"
            :blauw "1234"    :licht-blauw "1234"
            :groen "1234"    :turquoise   "1234"
            :rood  "1234"    :lichtrood   "1234"
            :grijs "1234"    :licht-grijs "1234" :donker-grijs ""}

  ;; Configuratie van talen, remote servers, accounts e.d.
  :config {:ftp  {:source "https://github.com/mscdex/node-ftp"
                  :host "ftp.tredius.nl" ;; string - The hostname or IP address of the FTP server. Default: 'localhost'
                  :port 21 ;; integer - The port of the FTP server. Default: 21
                  :secure true ;; mixed - Set to true for both control and data connection encryption, 'control' for control connection encryption only, or 'implicit' for implicitly encrypted control connection (this mode is deprecated in modern times, but usually uses port 990)
                  :user "solobit" ;; string - Username for authentication. Default: 'anonymous'
                  :password "secret" ;; string - Password for authentication. Default: 'anonymous@'
                  :connTimeout 10000 ;; integer - How long (in milliseconds) to wait for the control connection to be established. Default: 10000
                  :pasvTimeout 10000 ;; integer - How long (in milliseconds) to wait for a PASV data connection to be established. Default: 10000
                  :keepalive 10000 ;; integer - How often (in milliseconds) to send a 'dummy' (NOOP) command to keep the connection alive. Default: 10000
                        }

           :i18n {:source "https://github.com/jamuhl/i18next"
                  :help "http://i18next.com/pages/doc_init.html"
                  :preload ["nl-NL"] ;; array - The additional languages will be preloaded.
                  :lng "nl-NL" ;; Resources will be resolved in this order: 1) try languageCode plus countryCode, eg. 'en-US' 2) alternative look it up in languageCode only, eg. 'en' 3) finally look it up in definded fallback language, default: 'dev' If language is not set explicitly i18next tries to detect the user language by: 1) querystring parameter (?setLng=en-US) 2) cookie (i18next) 3) language set in navigator
                  :fallbackLng "en" ;; string/boolean - If not set it will default to 'dev'. If turned on, all missing key/values will be sent to this language. (use e.g. 'en' for production). False: As the fallbackLng will default to 'dev' you can turn it off by setting the option value to false. This will prevent loading the fallbacks resource file and any futher look up of missing value inside a fallback file.
                  :load "current" ;; string - If load option is set to current i18next will load the current set language (this could be a specific (en-US) or unspecific (en) resource file).
                  :detectLngQS "taal" ;; string - The current locale to set will be looked up in the new parameter: ?lang=en-US Hint: default would be ?setLng=en-US
                  :useCookie true ;; boolean - Use this only if your sure that language will be provided by the other lookup options or set programatically.
                  :debug true ;; boolean - If something went wrong you might find some helpful information on console log.
                  :keyseparator "::" ;; string - Seperator for keys
                  :nsseparator ":::" ;; string - Seperator for namespaces
                  :resGetPath (uri "/etc/i18n" "/__lng__/__ns__.json") ;; Set static route to load resources. Will load 'locales/en-US/translation.json'. If language is set to 'en-US' following resource files will be loaded one-by-one: en-US, en, dev (default fallback language). Hint: to lowercase countryCode in requests, eg. to 'en-us' set option lowerCaseLng = true
                  :ns {:namespaces ["app"] ;; array - The additional namespaces will be loaded.
                       :defaultNs "app" ;; string - The default namespace to load
                  }}

  ;; Vertaalbaar met i18next: menu structuur
  :navigatie {:hoofdmenu {:home   "Home"

                          :missie "Wie zijn wij"

                          :diensten    {:fiscaal      {:advies      "Belastingadvies"
                                                       :pensioen    "Pensioen"
                                                       :planning    "Estate Planning"}

                                        :juridisch    {:advies      "Juridisch Advies"
                                                       :abonnement  "Juridisch Abonnement"}

                                        :debiteuren   {:beheer      "Debiteurenbeheer"
                                                       :werkwijze   "Onze Werkwijze"
                                                       :abonnement  "Abonnement"}

                                        :accountancy  {:hr-payroll  "Salaris- en Personeelszaken"
                                                       :accountancy "Accountancy"}

                                        :risicoadvies {:verzekeren  "Risico-advies & Verzekeringen"
                                                       :pensioen    "Pensioenadvies"
                                                       :overstappen "Schoenendoos Overstapservice"}

                          :t-time      {:videos       "Tredius vertelt..."
                                        :nieuwsbrief  "Nieuwsbrief"
                                        :columns      "Onze columns"
                                        :special      "Specials"}

                          :werken-bij  {:tredius      "Werken bij Tredius"
                                        :vacatures    "Vacatures"
                                        :stages       "Stageplekken"
                                        :wie-ben-jij  "Wie ben jij?"}

                          ;; TODO Toevoegen van adresgegevens
                          :vestiging   {:alkmaar      "Alkmaar"
                                        :haarlem      "Haarlem"
                                        :monnickendam "Monnickendam"
                                        :purmerend    "Purmerend"}
                          }}
                }}
  })


;; Main routines
;; -------------

;; deployment
(defn upload-ftp []
 "Hiermee uploaden we bestanden naar een remote FTP van een server."
  (let [local "boo.txt" ;; TODO mapping to out/ folder
        remote "boo.remote-copy.txt"
        client (require "ftp")]
    (do
      (.put client local remote
        (try
          (raise exception)
          (catch error (recover error))
          (finally (.end c)))
      (c.connect)))))


;; Overige functies
;; ----------------

;; In het algemeen gezegd, is een functie een 'subprogramma' dat door externe (of interne in geval van 'recursion') code aangeroepen kan worden. Net als het programma zelf, is een functie opgemaakt uit een sequence van statements aangeroepen vanuit het functie lichaam. Waardes kunnen aan een functie doorgegeven worden en kunnen een waarde terug geven. In JavaScript zijn functie eerste-klasse objecten, m.a.w. het zijn objecten en kunnen gemanipuleerd en rondgegeven worden, net als ieder ander object. Meer specifiek, het zijn Function objecten: iedere functie in JavaScript is in feite een Function object. Om een waarde te retourneren moet een JS functie onder meer uit een 'return' statement bestaan die aangeeft welke (berekende) waarde terug gegeven wordt. Een functie zonder return waarde geeft een 'undefined' De parameters van een functieaanroep worden argumenten genoemd. Argumenten worden aan functies per 'value' doorgegeven. Indien een functie de waarde van het argument wijzigt, is dit niet globaal merkbaar (buiten de functie of in die hem aanroept). Maar referentie waardes zijn ook ook waardes en dus is het mogelijk een globaal object als referentie waarde door te geven en dus vanuit het functielichaam te wijzigen en dit dus globaal merkbaar is. Dat laatste maakt ontzettend giftige code mogelijk die ookwel 'neveneffecten' genoemd worden. Met deze programmeerstijl proberen we die zoveel mogelijk te voorkomen.

;; vormgeving

(defn- maak-stijlblad []
  "Stylus is een next-generation pre-processor voor CSS stijlbladen en de meest krachtige
  'engine' om nog meer uit de vormgeving van webpagina's te halen."
  (. (require "stylus") render
     (. fs readFileSync
        (.join path (:bron hoofdproject)
                    (:code hoofdproject)
                    (:stijl hoofdproject)) "utf-8")))


;; vaak gebruikte locaties

(defn- cultuur []
  "Een site bestaat veelal uit meerdere talen, tijd of valuta moeten mee veranderen. Dit wordt
  ook wel internationalization, localization of i18n."
  (. (require "i18next") init
     (:taal-en-land hoofdproject)))

(defn- site [bestand]
  "Vaak zullen we een referentie tot de sitemap op moeten geven."
  (.join path (:bron hoofdproject)
              (:site hoofdproject) bestand))

(defn- afb [bestand]
  "Geef de locatie (map) van afbeeldingen per server, domein, onderdeel of map."
  (.join path (:bron hoofdproject)
              (:site hoofdproject)
              (:afbeeldingen hoofdproject) bestand))

(defn- conf []
  "Ons projectbestand bevat in eerste aanleg in JSON genoteerde gegevens. Lees
  met nconf de velden eenvoudig uit."
  (. (require "nconf") file
     {:file (.join path (:bron hoofdproject) (:definitie hoofdproject)) }))


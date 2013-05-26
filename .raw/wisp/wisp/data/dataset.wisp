
(comment "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures. - Alan Perlis")
(def ^:private gegevens {
  ;; De belangrijkste gegevens die we nodig hebben om ons project in te laden.
  :klant {:naam "Tredius" }
  :hoofdproject {:bron      "./"               ;; folder - Bronmap van het gehele hoofdproject
                 :site      "publiek"          ;; folder - Website uitvoer map, veelal wordt een browsebaar 'site' ingericht - al is het maar voor documentatie
                 :definitie "package.json"     ;; file   - Node.js package definition with meta-data
                 :stijl     "documenten/stijlen/lib/index.styl"
                 :afbeeldingen "media/afbeeldingen"}

  ;; TODO maak asynchronous component based UI voor eeuwig plezier
  :scripting "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js //ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js //code.createjs.com/preloadjs-0.3.0.min.js /assets/modernizr-custom.js /assets/ui.js /assets/jquery.cookie.js /assets/jquery.circlemenu.js /assets/vimeo.froogaloop2.min.js /assets/mediaverbindingen.js /assets/dragdealer.js /assets/jquery.colorbox.js /assets/jquery.easing.min.js"
  :cssstijl  "/stijlen/algemeen.css /stijlen/circlemenu.css /stijlen/dragdealer.css /stijlen/ui.css"
  ;;//yui.yahooapis.com/3.8.0/build/yui/yui-min.js /assets/ender.min.js

  ;; Node.js project definitie
  :package {:name "tredius-corporate"
            :version "0.0.5"
            :description "Tredius corporate web site"
            :main "docpad.coffee"
            :private true
            :preferGlobal false
            :dependencies {:docpad "6.x"
                           :docpad-plugin-cachr "2.x"
                           :docpad-plugin-coffeekup "2.x"
                           :docpad-plugin-coffeescript "2.x"
                           :docpad-plugin-cson "2.x"
                           :docpad-plugin-marked "2.x"
                           :docpad-plugin-partials "2.x"
                           :docpad-plugin-services "2.x"
                           :docpad-plugin-stylus "2.x"
                           :prompt "~0.2.9"
                           :enhanced-require "~0.5.0-beta5"
                           :cluster-live "0.0.3"
                           :i18next "~1.6.7"
                           :node-gettext "~0.2.11"
                           :better-require "0.0.2"
                           :node-minify "~0.7.3"
                           :yaml "~0.2.3"
                           :natural "~0.1.21"
                           :cson "~1.4.1"
                           :lawyer "~0.1.0"
                           :consolidate "~0.9.1"
                           :moment "~2.0.0"
                           :keypress "~0.1.0"
                           :nconf "~0.6.7"
                           :eventemitter2 "~0.4.11"
                           :event-stream "~3.0.14"
                           :eyespect "~0.1.8"
                           :node-colorfactory "~0.1.2"
                           :prettyjson "~0.8.1"
                           :cli-table "~0.2.0"
                           :cluster "~0.7.7"
                           :http-proxy "~0.10.2"
                           :vague-time "~0.5.2"
                           :comb "~0.2.1"
                           :stories "~1.0.4"
                           :winston "~0.7.1"
                           :shelljs "~0.1.4"
                           :inflection "~1.2.5"
                           :nopt "~2.1.1"
                           :color "~0.4.4"
                           :latest "~0.1.1"
                           :readdirp "~0.2.4"
                           :ftp "~0.3.1"
                           :fs-extra "~0.6.1"
                           :pretty-data "~0.40.0"
                           :pkginfo "~0.3.0"
                           :archy "0.0.2"
                           :semver "~1.1.4"}

            :devDependencies {:ender "1.0.1"
                              :URIjs "~1.10.2"
                              :chai "1.6.x"
                              :mocha "1.9.x"
                              :docco "0.6.x"
                              :biscotto "*"
                              :grunt "~0.4.1"
                              :cluster "~0.7.7"
                              :benchmark "~1.0.0"
                              :microtime "~0.3.3"}

            :scripts {:test  "echo Fout! Geen test script gedefineerd. && exit 1"
                      :start "echo Fout! Geen start script gedefineerd. && exit 1"}
            :repository {:type "git"
                         :url  "git@github.com/solobit/customers.git"}
            :author "Solobit"
            :license "MIT"
            :readmeFilename "README.md"
            :gitHead "185909b228cc42fa2e409a49dc1e6587dd3adf4a"
            :directories {:bin "bin"
                          :lib "lib"
                          :doc "extra/documentatie"
                          :man "extra/handleiding"
                          :example "extra/voorbeelden"}
            :keywords ["accountancy" "belastingen" "pensioen" "adviseurs"
                       "detachering" "loonadminstratie" "juridische" "diensten"]
            }

  :site {:naam             "Tredius.nl"
         :url              "http//www.tredius.nl"
         :static           "http//static.tredius.nl"
         :development      "http//solobit.github.io/tredius"
         :auteur           "Solobit &amp; Edberry Creative"
         :contact          "info@tredius.nl"
         :landcode         "nl"
         :taal             {:xmllang "nl" }
         :essentie         "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland"
         :omschrijving     "Bij Tredius hebben we de behoefte om het MKB landschap te veranderen Vrijheid, Onafhankelijkheid en Zelfstandigheid, voor iedere ondernemer."
         :keywords         "belasting, advies, accountancy, pensioenbelasting, bedrijfsadministratie, vrijheid, onafhankelijkheid, zelfstandigheid"
         :googleanalytics  "UA-39413290-1"
         :techniek         "Node.js, Docpad, jQuery, Semantic Grid, Stylus, Jade, CoffeeScript, Markdown, Accessible Rich Internet Applications (WAI-ARIA)"
         :disclaimer       "De informatie zoals opgenomen in bovenstaand artikel is uitsluitend bestemd voor algemene informatiedoeleinden. Derhalve dienen op grond van deze informatie geen handelingen te worden verricht zonder voorafgaand deskundig advies. Voor een toelichting kunt u uiteraard contact opnemen met een van onze kantoren."
         :support         {:beheerder      "Solobit"
                           :emailadres     "rob.jentzema@gmail.com"
                           :servicelijn    "013-5906677"}
         :vocabulaire     {"xmlns:s"     "http://schema.org/"
                           "xmlns:foaf"  "http://xmlns.com/foaf/0.1/"
                           "xmlns:xsd"   "http://www.w3.org/2001/XMLSchema#"
                           "xmlns:v"     "http://rdf.data-vocabulary.org/#"
                           "xmlns:pto"   "http://www.productontology.org/id/"
                           "xmlns:wn"    "http://xmlns.com/wordnet/1.6/"}}

  ;; Component.io: systeem van componenten JS/CSS/HTML stand-alone, geen gezeur meer met require, of AMD, jQuery bloat, namespaces, synchroon vs asynchroon, package managers, build stages, scripting, dependencies en nog 20 dramas. Dit, Werkt. Gewoon.
  ;; Noot: dit is een baseline en eventuele updates kunnen separaat toegevoegd zijn aan component.json ;; Allow some use of anonymous functions to retrieve non-DRY customer name repetitions so we keep this object in tact for the API
  :frontend   { :component {:name (fn [] (str gegevens.klant.naam))
                :main      (site "main.js")
                :scripts [ (site "main.js")  ]
                :styles  [ (site "main.css") ]

                :dependencies {"component/dropload"   "*"
                               "component/upload"     "*"
                               "component/file"       "*"
                               "component/pillbox"    "*"
                               "component/classes"    "*"
                               "component/model"      "*"
                               "component/histogram"  "*"
                               "component/progress"   "*"
                               "component/thumb"      "*"
                               "component/enumerable" "0.3.1"
                               "component/dom"        "0.6.0"}}}

  :organisatie {:bedrijfsnaam    "Tredius"
                :bedrijfslogo    (afb "bedrijfslogo.png")
                :omschrijving    "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland"
                :auteursrecht    (str (new Date) " © Tredius.nl")

                :bezoekadres     {:straat       "Zijlweg 146"
                                  :postcode     "2015 BH"
                                  :plaats       "Haarlem"}

                :postadres       {:postbus      "Postbus 992"
                                  :postcode     "2003 RZ"
                                  :plaats       "Haarlem"}

                :contacten       {:telefoon     "023 551 30 55"
                                  :fax          "023 551 30 35"
                                  :email        "info@tredius.nl"}

                :handelsinfo     {:bedrijfsvorm "Besloten Venootschap (BV)"
                                  :kvk          "3782878"
                                  :btw          "NL8124.72.792.B01"}}

  :contactpersonen {:marco     {:naam         "Marco Krijger MB FB"
                                :aanhef       ""
                                :titel        "Partner Tredius Fiscalisten"
                                :email        "m.krijger@tredius.nl"}
                    :linda     {:naam         "Linda Honig"
                                :aanhef       "Mevr."
                                :telefoon     "023 551 30 55"
                                :email        ""}
                    :lennard   {:naam         "Lennard Honig"
                                :aanhef       "Dhr."
                                :titel        ""
                                :telefoon     "023 551 30 55"
                                :email        ""}
                    :luuk      {:naam         "Luuk Oosting"
                                :aanhef       "Dhr."
                                :titel        ""
                                :telefoon     "0299 651 987"
                                :email        ""}
                    :wil       {:naam         "Wil Buffing"
                                :titel        "Mevr."
                                :telefoon     "0299 411 345"
                                :email        ""}}

  :vestigingen  {:purmerend    {:bezoekadres ["Wielingenstraat 119" "1441 ZN" "Purmerend" "Noord-Holland" "Nederland"]
                                :geocode     ["52.503605" "4.958375"]
                                :rest         "geocode=Cc9PzZeFjzXfFYEnIQMdp59LACmPF3Re0AbGRzF_fLmc8BNprg&amp;sll=52.504454,4.956079&amp;sspn=0.009065,0.019054&amp;mra=pd&amp;t=m&amp;spn=0.0064,0.013282"
                                :postadres   ["Postbus 258" "1440 AG" "Purmerend"]
                                :telefoon     "0299 411 345"
                                :fax          "0299 411 348"
                                :email        "info@tredius.nl"}
                 :monnickendam {:bezoekadres ["Haringburgwal 17" "1141 AT" "Monnickendam" "Noord-Holland" "Nederland"]
                                :geocode     ["52.462874" "5.035343"]
                                :rest         "geocode=CXRphrBe0kPwFRuFIAMdStVMACln1vctrAXGRzHfFo4FDFJsxg&amp;aq=&amp;sll=52.505806,4.827991&amp;sspn=0.269159,0.835648&amp;mra=pd&amp;spn=0.006406,0.013282"
                                :postadres   ["Postbus 48" "1140 AA" "Monnickendam"]
                                :telefoon     "0299 651 987"
                                :fax          "0299 653 004"
                                :email        "info@tredius.nl"}
                 :alkmaar      {:bezoekadres ["Professor van der Waalsstraat 3K" "1821 BT" "Alkmaar" "Noord-Holland" "Nederland"]
                                :geocode     ["52.625092" "4.770384"]
                                :rest         "spn=0.006382,0.013282"
                                :postadres   ["Professor van der Waalsstraat 3K" "1821 BT""Alkmaar"]
                                :telefoon     "072 564 4203"
                                :fax          "072 564 3019"
                                :email        "info@tredius.nl"}
                 :haarlem      {:bezoekadres ["Zijlweg 146" "2015 BH" "Haarlem" "Noord-Holland" "Nederland"]
                                :geocode     ["52.386457" "4.620631"]
                                :rest         "geocode=CWxUaXo29tzfFddYHwMdWoFGACkH_TJiEO_FRzHom-tyuYRbow&amp;sll=52.386457,4.620631&amp;sspn=0.008434,0.026114&amp;mra=iwd&amp;spn=0.006417,0.013282"
                                :postadres   ["Postbus 992" "2003 RZ" "Haarlem"]
                                :telefoon     "023 551 30 55"
                                :fax          "023 551 30 35"
                                :email        "info@tredius.nl"}}
  :vormgeving {

    ;; We erkennen een corporate identity als belangrijke data structuur voor gebruik op de site. De huisstijl is een van haar onderdelen.
    ;;  //fonts.googleapis.com/css?family=Dosis:400,500,600|Open+Sans:400italic,600italic,700italic,400,600,700
    :typografisch {:primair     ["Open Sans" "400italic" "600italic" "700italic" "400" "600" "700"]
                   :alternatief ["Dosis" "400" "500" "600"] }

    ;; Regelmatig benodigde informatie van illustraties, afbeeldingen, mappen en logo's of art-work kan hier.
    :illustraties {:bedrijfslogo (afb "bedrijfslogo.jpg")
                   :site-icoon   (afb "favicon.png")}

    ;; Het 'Semantic grid' systeem is een manier om een breed scala aan indelingen in vlakken te maken
    :vlakindeling {:kolommen 12 :soort "fixed" :breedte 960}

    ;; Kleuren lichter, donkerder, transformeren van en naar CSS.
    :kleuren {:oranje  "#F2A34F"
              :wit     "#ffffff"   :zwart        "#363636"
              :geel    "#7A6A42"   :goud         "#b88d74"
              :groen   "#7FC028"   :turquoise    "#6CBBB8"
              :bruin   "#6b4c39"   :licht-bruin  "#b88c74"
              :paars   "#47427A"   :licht-paars  "#6664a0"
              :blaauw  "#0183b5"   :licht-blauw  "#0183b5"   :donker-blauw "#403e6b"
              :grijs   "#e0e0e0"   :licht-grijs  "#f8f8f8"   :donker-grijs "#919191"
              :rood    "#e31741"   :licht-rood   "#6b4c39"}

    :stijl {:invoer "index.styl" :uitvoer "algemeen.css"
            :paden ["documenten/stijlen/lib/cultivus"]}}

    ;; Configuratie van talen, remote servers, accounts e.d.
  :config {  :ftp  {:source "https://github.com/mscdex/node-ftp"
                    :host "ftp.tredius.nl"       ;; string   - The hostname or IP address of the FTP server. Default: 'localhost'
                    :port 21                     ;; integer  - The port of the FTP server. Default: 21
                    :secure true                 ;; mixed    - Set to true for both control and data connection encryption, 'control' for control connection encryption only, or 'implicit' for implicitly encrypted control connection (this mode is deprecated in modern times, but usually uses port 990)
                    :user "solobit"              ;; string   - Username for authentication. Default: 'anonymous'
                    :password "secret"           ;; string   - Password for authentication. Default: 'anonymous@'
                    :connTimeout 10000           ;; integer  - How long (in milliseconds) to wait for the control connection to be established. Default: 10000
                    :pasvTimeout 10000           ;; integer  - How long (in milliseconds) to wait for a PASV data connection to be established. Default: 10000
                    :keepalive 10000}             ;; integer  - How often (in milliseconds) to send a 'dummy' (NOOP) command to keep the connection alive. Default: 10000
             :i18n {:source "https://github.com/jamuhl/i18next"
                    :help "http://i18next.com/pages/doc_init.html"
                    :preload ["nl-NL"]           ;; array    - The additional languages will be preloaded.
                    :lng "nl-NL"                 ;; string   - Resolve order: 1) languageCode plus countryCode, eg. 'en-US' 2) languageCode only, eg. 'en' 3) finally fallback language, default: 'dev' If language is not set explicitly i18next tries to detect the user language by: 1) querystring parameter (?setLng=en-US) 2) cookie (i18next) 3) language set in navigator
                    :fallbackLng "en"            ;; str/bool - If not set it will default to 'dev'. If turned on, all missing key/values will be sent to this language. (use e.g. 'en' for production). False: As the fallbackLng will default to 'dev' you can turn it off by setting the option value to false. This will prevent loading the fallbacks resource file and any futher look up of missing value inside a fallback file.
                    :load "current"              ;; string   - If load option is set to current i18next will load the current set language (this could be a specific (en-US) or unspecific (en) resource file).
                    :detectLngQS "taal"          ;; string   - The current locale to set will be looked up in the new parameter: ?lang=en-US Hint: default would be ?setLng=en-US
                    :useCookie true              ;; boolean  - Use this only if your sure that language will be provided by the other lookup options or set programatically.
                    :debug true                  ;; boolean  - If something went wrong you might find some helpful information on console log.
                    :keyseparator "::"           ;; string   - Seperator for keys
                    :nsseparator ":::"           ;; string   - Seperator for namespaces
                    :resGetPath (site "/etc/i18n" "/__lng__/__ns__.json") ;; Set static route to load resources. Will load 'locales/en-US/translation.json'. If language is set to 'en-US' following resource files will be loaded one-by-one: en-US, en, dev (default fallback language). Hint: to lowercase countryCode in requests, eg. to 'en-us' set option lowerCaseLng = true
                    :ns {:namespaces ["app"]     ;; array    - The additional namespaces will be loaded.
                         :defaultNs "app"}}        ;; string   - The default namespace to load
             :log  {:levels {:silly   0
                             :verbose 1
                             :info    2
                             :data    3
                             :warn    4
                             :debug   5
                             :error   6}
                    :colors {:silly    "magenta"
                             :verbose  "cyan"
                             :info     "green"
                             :data     "grey"
                             :warn     "yellow"
                             :debug    "blue"
                             :error    "red"
                             ;; Noot: dit zijn terminal colors (ANSI 8-kleuren)
                             }}}

  ;; Vertaalbaar met i18next: menu structuur
  :navigatie {:hoofdmenu {:home   "Home"

                          :missie "Wie zijn wij"

                          :diensten    {:fiscaal      {:advies      "Belastingadvies"
                                                       :pensioen    "Pensioen"
                                                       :estate-plan "Estate Planning"}

                                        :juridisch    {:advies      "Juridisch Advies"
                                                       :abonnement  "Juridisch Abonnement"}

                                        :debiteuren   {:beheer      "Debiteurenbeheer"
                                                       :werkwijze   "Onze Werkwijze"
                                                       :abonnement  "Abonnement"}

                                        :accountancy  {:hr-payroll  "Salaris- en Personeelszaken"
                                                       :accountancy "Accountancy"}

                                        :risicoadvies {:verzekeren  "Risico-advies & Verzekeringen"
                                                       :pensioen    "Pensioenadvies"
                                                       :overstappen "Schoenendoos Overstapservice"}}

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

                          :contact     "contact"}}
})

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

;; Wat wisp doet: transpileren (transformeren/compileren) naar JavaScript
(.log console (transpile "(. console log \"thisthat\")"))

;; Node.js projecten worden, indien gewenst ingelezen door het 'npm' programma en kan hier uit diverse gegevens over afhankelijke software, auteurs(rechten), onderhoud, downloads, en dergelijke meta-gegevens uitlezen. De `./` verwijst naar de bronmap.

;; 2. Gegevensopslag
;; -----------------

;; Sleutelwoorden `:sleutel` bevatten veel paden en teksten, herhaling voorkomen met de functies
(comment "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures. - Alan Perlis")
(def ^:private gegevens {
  ;; De belangrijkste gegevens die we nodig hebben om ons project in te laden.
  :hoofdproject {:bron "./"                            ;; folder - Bronmap van het gehele hoofdproject
                 :site "www"                           ;; folder - Website uitvoer map, veelal wordt een browsebaar 'site' ingericht - al is het maar voor documentatie
                 :definitie "package.json"             ;; file   - Node.js package definition with meta-data
                 :stijl "documenten/stijlen/lib/index.styl"
                 :afbeeldingen "media/afbeeldingen"
                 :code "src"}

  ;; TODO maak asynchronous component based UI voor eeuwig plezier
  :scripting "//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js //ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js //code.createjs.com/preloadjs-0.3.0.min.js /assets/modernizr-custom.js /assets/ui.js /assets/jquery.cookie.js /assets/jquery.circlemenu.js /assets/vimeo.froogaloop2.min.js /assets/mediaverbindingen.js /assets/dragdealer.js /assets/jquery.colorbox.js /assets/jquery.easing.min.js"
  :cssstijl  "/stijlen/algemeen.css /stijlen/circlemenu.css /stijlen/dragdealer.css /stijlen/ui.css"
  ;;//yui.yahooapis.com/3.8.0/build/yui/yui-min.js /assets/ender.min.js

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
                           "xmlns:wn"    "http://xmlns.com/wordnet/1.6/"}
         :helpers {:vimeo (fn)}

        } ;; site

  :organisatie {:bedrijfsnaam    "Tredius"
                :bedrijfslogo    (afb "bedrijfslogo.png")
                :omschrijving    "Tredius verleent financiële-, fiscale-, juridische-, personele- en bedrijfsadministratieve diensten aan het MKB van Nederland"
                :auteursrecht    (str (. (Date) getFullYear) " © Tredius.nl")

                :bezoekadres     {:straat       "Zijlweg 146"
                                  :postcode     "2015 BH"
                                  :plaats       "Haarlem"}

                :postadres       {:postbus      "Postbus 992"
                                  :postcode     "2003 RZ"
                                  :plaats       "Haarlem"}

                :contacten       {:telefoon     "023 551 30 55"
                                  :fax          "023 551 30 35"
                                  :email        "info@tredius.nl"}

                :handelsinfo     {:kvk          "3782878"
                                  :btw          "NL8124.72.792.B01"
                                  :bedrijfsvorm "Besloten Venootschap (BV)"}

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

                :vestigingen  {:purmerend    {:bezoekadres ["Wielingenstraat 119"
                                                            "1441 ZN"
                                                            "Purmerend"
                                                            "Noord-Holland"
                                                            "Nederland"]
                                              :geocode     ["52.503605" "4.958375"]
                                              :rest         "geocode=Cc9PzZeFjzXfFYEnIQMdp59LACmPF3Re0AbGRzF_fLmc8BNprg&amp;sll=52.504454,4.956079&amp;sspn=0.009065,0.019054&amp;mra=pd&amp;t=m&amp;spn=0.0064,0.013282"
                                              :postadres   ["Postbus 258"
                                                            "1440 AG"
                                                            "Purmerend"]
                                              :telefoon     "0299 411 345"
                                              :fax          "0299 411 348"
                                              :email        "info@tredius.nl"}

                               :monnickendam {:bezoekadres ["Haringburgwal 17"
                                                            "1141 AT"
                                                            "Monnickendam"
                                                            "Noord-Holland"
                                                            "Nederland"]
                                              :geocode     ["52.462874" "5.035343"]
                                              :rest         "geocode=CXRphrBe0kPwFRuFIAMdStVMACln1vctrAXGRzHfFo4FDFJsxg&amp;aq=&amp;sll=52.505806,4.827991&amp;sspn=0.269159,0.835648&amp;mra=pd&amp;spn=0.006406,0.013282"
                                              :postadres   ["Postbus 48"
                                                            "1140 AA"
                                                            "Monnickendam"]
                                              :telefoon     "0299 651 987"
                                              :fax          "0299 653 004"
                                              :email        "info@tredius.nl"}

                               :alkmaar      {:bezoekadres ["Professor van der Waalsstraat 3K"
                                                            "1821 BT"
                                                            "Alkmaar"
                                                            "Noord-Holland"
                                                            "Nederland"]
                                              :geocode     ["52.625092" "4.770384"]
                                              :rest         "spn=0.006382,0.013282"
                                              :postadres   ["Professor van der Waalsstraat 3K"
                                                            "1821 BT"
                                                            "Alkmaar"]
                                              :telefoon     "072 564 4203"
                                              :fax          "072 564 3019"
                                              :email        "info@tredius.nl"}

                               :haarlem      {:bezoekadres ["Zijlweg 146"
                                                            "2015 BH"
                                                            "Haarlem"
                                                            "Noord-Holland"
                                                            "Nederland"]
                                              :geocode     ["52.386457" "4.620631"]
                                              :rest         "geocode=CWxUaXo29tzfFddYHwMdWoFGACkH_TJiEO_FRzHom-tyuYRbow&amp;sll=52.386457,4.620631&amp;sspn=0.008434,0.026114&amp;mra=iwd&amp;spn=0.006417,0.013282"
                                              :postadres   ["Postbus 992"
                                                            "2003 RZ"
                                                            "Haarlem"]
                                              :telefoon     "023 551 30 55"
                                              :fax          "023 551 30 35"
                                              :email        "info@tredius.nl"}}
         };; org


  ;; We erkennen een corporate identity als belangrijke data structuur voor gebruik op de site. De huisstijl is een van haar onderdelen.
  ;;  //fonts.googleapis.com/css?family=Dosis:400,500,600|Open+Sans:400italic,600italic,700italic,400,600,700
  :typografisch {:primair     ["Open Sans" "400italic" "600italic" "700italic" "400" "600" "700"]
                 :alternatief ["Dosis" "400" "500" "600"] }

  ;; Regelmatig benodigde informatie van illustraties, afbeeldingen, mappen en logo's of art-work kan hier.
  :illustraties {:bedrijfslogo (afb "bedrijfslogo.jpg")
                 :site-icoon   (afb "favicon.png")}

  ;; Het 'Semantic grid' systeem is een manier om een breed scala aan indelingen in vlakken te maken
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

  :stijl {:invoer "index.styl" :uitvoer "algemeen.css" :locaties []}

  ;; Configuratie van talen, remote servers, accounts e.d.
  :config {:ftp  {:source "https://github.com/mscdex/node-ftp"
                  :host "ftp.tredius.nl"       ;; string   - The hostname or IP address of the FTP server. Default: 'localhost'
                  :port 21                     ;; integer  - The port of the FTP server. Default: 21
                  :secure true                 ;; mixed    - Set to true for both control and data connection encryption, 'control' for control connection encryption only, or 'implicit' for implicitly encrypted control connection (this mode is deprecated in modern times, but usually uses port 990)
                  :user "solobit"              ;; string   - Username for authentication. Default: 'anonymous'
                  :password "secret"           ;; string   - Password for authentication. Default: 'anonymous@'
                  :connTimeout 10000           ;; integer  - How long (in milliseconds) to wait for the control connection to be established. Default: 10000
                  :pasvTimeout 10000           ;; integer  - How long (in milliseconds) to wait for a PASV data connection to be established. Default: 10000
                  :keepalive 10000             ;; integer  - How often (in milliseconds) to send a 'dummy' (NOOP) command to keep the connection alive. Default: 10000
                  }

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
                  :resGetPath (uri "/etc/i18n" "/__lng__/__ns__.json") ;; Set static route to load resources. Will load 'locales/en-US/translation.json'. If language is set to 'en-US' following resource files will be loaded one-by-one: en-US, en, dev (default fallback language). Hint: to lowercase countryCode in requests, eg. to 'en-us' set option lowerCaseLng = true
                  :ns {:namespaces ["app"]     ;; array  - The additional namespaces will be loaded.
                       :defaultNs "app"        ;; string - The default namespace to load
                  }
  } ;; config

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
;; =============

;; Web site
;; Momenteel is de site omschreven in CoffeeScript HTML. De variabelen bevinden zich in een centraal docpad config bestand. Daarnaast is er meta-data omschreven in de koppen



;; Stijlen
;; -------

;; Gebruik: (genereer-stijlblad "huisstijl.css")
;; TODO parameters........v
(defn- genereer-stijlblad [uitvoer]
  "Stylus is een next-gen pre-processor voor CSS stijlbladen en de meest krachtige
  engine om nog meer uit de vormgeving van webpagina's te halen."

  ;; Local variables binding scope
  (let [stylus    (require "stylus") 
        bestand   (. path join (:bron hoofdproject) (:code hoofdproject) (:stijl hoofdproject))
        stijlblad (. fs readFileSync bestand "utf-8")
        mappen    (site "documenten/stijlen/lib/cultivus")
        opties    {:filename gegevens.stijl.uitvoer
                   :paths    [mappen (. path join mappen "i18n")]} ]

    ;; Function body met try/catch/finaly
    (. stylus render stijlblad opties 
       (fn [exception css]
         (try
          (raise exception)
          (catch error (recover error))
          (finally (. console log css)))
          ;; TODO uitvoeren naar bestand
         ))))

;; Functies
;; ========
;; In het algemeen gezegd, is een functie een 'subprogramma' dat door externe (of interne in geval van 'recursion') code aangeroepen kan worden. Net als het programma zelf, is een functie opgemaakt uit een sequence van statements aangeroepen vanuit het functie lichaam. Waardes kunnen aan een functie doorgegeven worden en kunnen een waarde terug geven. In JavaScript zijn functie eerste-klasse objecten, m.a.w. het zijn objecten en kunnen gemanipuleerd en rondgegeven worden, net als ieder ander object. Meer specifiek, het zijn Function objecten: iedere functie in JavaScript is in feite een Function object. Om een waarde te retourneren moet een JS functie onder meer uit een 'return' statement bestaan die aangeeft welke (berekende) waarde terug gegeven wordt. Een functie zonder return waarde geeft een 'undefined' De parameters van een functieaanroep worden argumenten genoemd. Argumenten worden aan functies per 'value' doorgegeven. Indien een functie de waarde van het argument wijzigt, is dit niet globaal merkbaar (buiten de functie of in die hem aanroept). Maar referentie waardes zijn ook ook waardes en dus is het mogelijk een globaal object als referentie waarde door te geven en dus vanuit het functielichaam te wijzigen en dit dus globaal merkbaar is. Dat laatste maakt ontzettend giftige code mogelijk die ookwel 'neveneffecten' genoemd worden. Met deze programmeerstijl proberen we die zoveel mogelijk te voorkomen.

;; Private, geen neveneffecten

;; deployment, backups

;; stub - TODO
(defn- archiveer
  "Maakt een nieuw archief in .zip, .tar of .tgz (gzip)"
  [soort & bestanden] (fn))

(defn- upload-ftp []
 "Hiermee uploaden we bestanden naar een remote FTP van een server."
  (let [local    "boo.txt" ;; TODO mapping to out/ folder
        remote   "boo.remote-copy.txt"
        client   (require "ftp")]
    (do
      (.put client local remote
        (try
          (raise exception)
          (catch error (recover error))
          (finally (.end c)))
      (c.connect)))))


(defn- dirp [pad extensie]
  "Doorloop recursief een mappenstructuur en geef een stream API retour."
  (let [readdirp (require "readdirp")
        es       (require "event-stream")
        options  {:root       pad
                  :fileFilter extensie }
        stream   (readdirp options)]
    ;; Functielichaam aanhaken gebeurtenisluisteraars
    (.on stream "warn"
         (fn [error]
           (try (raise exception)
             (catch error (.log console (str "Non-fatal error: " error))))))

    (.on stream "error"
         (fn [error]
           (try (raise exception)
             (catch error (.log console (str "Fatal: " error))))))

    (.pipe stream (es.mapSync (fn [entry] {:path entry.path :size entry.stat.size})))
    (.pipe stream (.stringify es))
    (.pipe stream (.stdout process))))

(defn- vimeo
  "Geeft een hyperlink naar de vimeo bibliotheek retour indien een 'id' gegeven wordt als functie argument."
   ([] (try (raise exception) (catch error (.log console error))))
   ([id] (str "http://player.vimeo.com/video/" id "?api=1&amp;player_id=VideoSpeler-" id "&amp;title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;color=e31741")))

(defn- cultuur []
  "Een site bestaat veelal uit meerdere talen, tijd of valuta moeten mee veranderen."
  (. (require "i18next") init
     (:taal-en-land hoofdproject)))

(defn- site [bestand]
  "Vaak zullen we een referentie tot de sitemap op moeten geven."
  (. path join (:bron hoofdproject)
               (:site hoofdproject) bestand))

(defn- afb [bestand]
  "Geef de locatie (map) van afbeeldingen per server, domein, onderdeel of map."
  (. path join (:bron hoofdproject)
               (:site hoofdproject)
               (:afbeeldingen hoofdproject) bestand))

(defn- conf []
  "Ons projectbestand bevat in eerste aanleg in JSON genoteerde gegevens. Lees
  met nconf de velden eenvoudig uit."
  (. (require "nconf") file
     {:file (.join path (:bron hoofdproject) (:definitie hoofdproject)) }))


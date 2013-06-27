
(import fs "fs")
(import path "path")

(. console log module) ;;  this.file_location  = path.resolve(__filename)
(. process exit 1)


(def proj-dir (. path resolve "../../../../../"))



(defn )

    this.path_minified  = '../docpad.js'
    this.path_compiled  = 'docpad.compiled.js'
    this.file_database  = 'continents-cities-nl_NL.mo'
    path_languages      = "i18n/languages/"



    afbeelding      = (img) -> return '/media/afbeeldingen/' + img
    splits          = (txt) -> return txt.trim().split('\n')
    egaliseer       = (txt) -> return txt.replace(/\s+/g, " ")
    geenspaties     = (txt) -> return txt.replace(/\s+/g, "")
    log             = console.log

;; It is better to have 100 functions operate on one data structure than to have 10 functions operate on 10 data structures.
;; -- Alan J. Perlis

(def settings {
              :docpad {
                        :port 1337   ,  :srcPath "site"  ,  :outPath "www"  ,  :cfgPath "etc"

                        :plugins-paths    ["node_modules" , "modules/node_modules" , "modules/plugins"]
                        :documents-paths  ["documents" "documenten"]
                        :files-paths      ["files" "public" "bestanden"]
                        :layouts-paths    ["layouts" "sjablonen"]

                        :image-paths     {:default  "/media/afbeeldingen"
                                          :products "/media/afbeeldingen/producten"
                                          :themes   "/media/themas/afbeeldingen" }

                        :enabled-plugins {:absolutepath  true
                                          :pathtoroot    false
                                          :munge         false
                                          :text          false
                                          :literate      false }

                        :plugins { :partials { :partialsPath "bouwstenen" }
                                   :sitemap  { :cachetime 600000 :changefreq "yearly" :priority 0.8 } }

                        :templateData {
                          :org {
                            :bedrijfsnaam "Tredius"

                                }

                              }}})


                bedrijfslogo:     afbeelding('bedrijfslogo.png')

                omschrijving:     egaliseer """

                    Tredius verleent financiële-, fiscale-, juridische-,
                    personele- en bedrijfsadministratieve diensten aan
                    het MKB van Nederland

                """

                auteursrecht:     "#{new Date().getFullYear() + ' © Tredius.nl'}"

                bezoekadres:

                    straat:       'Zijlweg 146'
                    postcode:     '2015 BH'
                    plaats:       'Haarlem'

                postadres:

                    postbus:      'Postbus 992'
                    postcode:     '2003 RZ'
                    plaats:       'Haarlem'

                contactgegevens:

                    telefoon:     '023 551 30 55'
                    fax:          '023 551 30 35'
                    email:        'info@tredius.nl'

                handelsgegevens:

                    kvk:          '3782878'
                    btw:          'NL8124.72.792.B01'
                    bedrijfsvorm: 'Besloten Venootschap (BV)'


                contactpersonen:

                    marco:
                        naam:       'Marco Krijger MB FB'
                        aanhef:     ''
                        titel:      'Partner Tredius Fiscalisten'
                        email:      'm.krijger@tredius.nl'

                    linda:
                        naam:       'Linda Honig'
                        aanhef:      'Mevr.'
                        telefoon:   '023 551 30 55'
                        email:      ''

                    lennard:
                        naam:       'Lennard Honig'
                        aanhef:     'Dhr.'
                        titel:      ''
                        telefoon:   '023 551 30 55'
                        email:      ''

                    luuk:
                        naam:       'Luuk Oosting'
                        aanhef:     'Dhr.'
                        titel:      ''
                        telefoon:   '0299 651 987'
                        email:      ''

                    wil:
                        naam:       'Wil Buffing'
                        titel:      'Mevr.'
                        telefoon:   '0299 411 345'
                        email:      ''

                vestigingen:

                    purmerend:

                        bezoekadres: splits "
                            Wielingenstraat 119
                            1441 ZN
                            Purmerend
                            Noord-Holland
                            Nederland
                            "

                        geocode:    ['52.503605', '4.958375']
                        rest: "geocode=Cc9PzZeFjzXfFYEnIQMdp59LACmPF3Re0AbGRzF_fLmc8BNprg&amp;sll=52.504454,4.956079&amp;sspn=0.009065,0.019054&amp;mra=pd&amp;t=m&amp;spn=0.0064,0.013282"

                        postadres: splits "
                            Postbus 258
                            1440 AG
                            Purmerend
                            "

                        telefoon:   "0299 411 345"

                        fax:        "0299 411 348"

                        email:      "info@tredius.nl"

                    monnickendam:

                        bezoekadres: splits "
                            Haringburgwal 17
                            1141 AT
                            Monnickendam
                            Noord-Holland
                            Nederland
                            "

                        geocode:    ['52.462874', '5.035343']
                        rest: "geocode=CXRphrBe0kPwFRuFIAMdStVMACln1vctrAXGRzHfFo4FDFJsxg&amp;aq=&amp;sll=52.505806,4.827991&amp;sspn=0.269159,0.835648&amp;mra=pd&amp;spn=0.006406,0.013282"

                        postadres: splits "
                            Postbus 48
                            1140 AA
                            Monnickendam
                            "

                        telefoon:   '0299 651 987'

                        fax:        '0299 653 004'

                        email:      'info@tredius.nl'

                    alkmaar:


                        bezoekadres: splits "
                            Professor van der Waalsstraat 3K
                            1821 BT
                            Alkmaar
                            Noord-Holland
                            Nederland
                            "

                        geocode:    ['52.625092', '4.770384']
                        rest:       "spn=0.006382,0.013282"

                        postadres: splits "
                            Professor van der Waalsstraat 3K
                            1821 BT
                            Alkmaar
                            "



                        telefoon:   '072 564 4203'

                        fax:        '072 564 3019'

                        email:      'info@tredius.nl'



                    haarlem:


                        bezoekadres: splits "
                            Zijlweg 146
                            2015 BH
                            Haarlem
                            Noord-Holland
                            Nederland
                            "

                        geocode:    ['52.386457', '4.620631']
                        rest: "geocode=CWxUaXo29tzfFddYHwMdWoFGACkH_TJiEO_FRzHom-tyuYRbow&amp;sll=52.386457,4.620631&amp;sspn=0.008434,0.026114&amp;mra=iwd&amp;spn=0.006417,0.013282"

                        postadres: splits "
                            Postbus 992
                            2003 RZ
                            Haarlem
                            "

                        telefoon:   '023 551 30 55'

                        fax:        '023 551 30 35'

                        email:      'info@tredius.nl'


            site:

                naam:             'Tredius.nl'

                url:              'http://www.tredius.nl'

                static:           'http://static.tredius.nl'

                development:      'http://solobit.github.io/tredius'

                auteur:           'Solobit &amp; Edberry Creative'

                contact:          'info@tredius.nl'

                landcode:         'nl'

                taal:             { 'xml:lang': 'nl' }

                essentie: egaliseer "

                Tredius verleent financiële-, fiscale-, juridische-,
                personele- en bedrijfsadministratieve diensten aan het MKB
                van Nederland
                "



                omschrijving: egaliseer "

                Bij Tredius hebben we de behoefte om het MKB landschap te
                veranderen: Vrijheid, Onafhankelijkheid en Zelfstandigheid,
                voor iedere ondernemer.
                "


                keywords: egaliseer "

                belasting, advies, accountancy, pensioenbelasting,
                bedrijfsadministratie, vrijheid, onafhankelijkheid,
                zelfstandigheid
                "

                googleanalytics:  'UA-39413290-1'

                techniek: egaliseer "

                Node.js, Docpad, jQuery, Semantic Grid, Stylus, Jade,
                CoffeeScript, Markdown, Accessible Rich Internet
                Applications (WAI-ARIA)
                "

                disclaimer: egaliseer "

                De informatie zoals opgenomen in bovenstaand artikel is
                uitsluitend bestemd voor algemene informatiedoeleinden.
                Derhalve dienen op grond van deze informatie geen
                handelingen te worden verricht zonder voorafgaand deskundig
                advies. Voor een toelichting kunt u uiteraard contact
                opnemen met een van onze kantoren.
                "

                support:

                    beheerder:      'Solobit'

                    emailadres:     'rob.jentzema@gmail.com'

                    servicelijn:    '013-5906677'



                blockingScripts: splits "
                    //ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js
                    //ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js
                    //code.createjs.com/preloadjs-0.3.0.min.js
                    /assets/modernizr-custom.js
                    "
                    #//yui.yahooapis.com/3.8.0/build/yui/yui-min.js
                    #/assets/ender.min.js


                nonBlocking: splits "
                    /assets/ui.js
                    /assets/jquery.cookie.js
                    /assets/jquery.circlemenu.js
                    /assets/vimeo.froogaloop2.min.js
                    /assets/mediaverbindingen.js
                    /assets/dragdealer.js
                    /assets/jquery.colorbox.js
                    /assets/jquery.easing.min.js
                    "



                stijl:

                    icoon: afbeelding('favicon.png')

                    lettertype: geenspaties "
                    //fonts.googleapis.com/css?family=Dosis:400,500,600
                    |Open+Sans:400italic,600italic,700italic,400,600,700
                    "



                    volatile: [
                        '/stijlen/algemeen.css' + '?' + new Date().getTime() / 1000
                    ]


                    bladen: [
                        '/stijlen/algemeen.css' + '?' + new Date().getTime() / 1000
                        '/stijlen/circlemenu.css'
                        '/stijlen/dragdealer.css'
                        '/stijlen/ui.css'
                    ]




                snelkoppelingen:

                    debiteuren:
                        tekst:  'Tredius Debiteurenbeheer'
                        url:    '/diensten/debiteurenbeheer/index.html'
                        titel:  'Tredius Debiteurenbeheer is duurzaamheid voorop'

                    stappenplan:
                        tekst:  'Tredius Debiteurenbeheer Stappenplan'
                        url:    '/diensten/debiteurenbeheer/stappenplan.html'
                        titel:  'Neem nu een Tredius Debiteurenbeheer Abonnement'

                    debiteurenabo:
                        tekst: 'Tredius Debiteuren Abonnement'
                        url:    '/diensten/debiteurenbeheer/abonnement.html'
                        titel:  'Neem nu een Tredius Debiteurenbeheer Abonnement'

                    voorwaarden:
                        tekst:  'voorwaarden'
                        url:    '/overig/voorwaarden.html'
                        titel:  'Lees onze algemene voorwaarden'



                vocabulaire: {'xmlns:s'     : 'http://schema.org/'
                            , 'xmlns:foaf'  : 'http://xmlns.com/foaf/0.1/'
                            , 'xmlns:xsd'   : 'http://www.w3.org/2001/XMLSchema#'
                            , 'xmlns:v'     : 'http://rdf.data-vocabulary.org/#'
                            , 'xmlns:pto'   : 'http://www.productontology.org/id/'
                            , 'xmlns:wn'    : 'http://xmlns.com/wordnet/1.6/'}



            getVimeoUri: (id) ->
                return "http://player.vimeo.com/video/#{id}?api=1&amp;player_id=VideoSpeler-#{id}&amp;title=0&amp;byline=0&amp;portrait=0&amp;badge=0&amp;color=e31741"

            getMailUri: ({id,ds}) ->

                return "" if id? or ds?

                formulier =
                    #  frm    MailingListID - DatasetID
                    nieuwsbrief: [ 145464     , 20853 ]
                    neemcontact: [ 145467     , 20853 ]
                    jabonnement: [ 145467     , 20853 ]
                    dabonnement: [ 145467     , 20853 ]
                    vacaturescv: [ 145472     , 20853 ]



                api     = encodeURI          "http://www.graphicmail.nl/api.aspx?"
                sid     = encodeURIComponent "SID=4"
                b64     = encodeURIComponent "&Credentials=DtZEdUEEcUap7RsVxnxyWux37VTOip2Xp2M+gIusSMwpc9Hu7nDCFm2LffostDgC/8lkV84pfIARSyMl/Hfamx4oG8mt/mk8o+UsteAhNqMs/qO3lhsagAKn4EtikhystNc17yejBNe2b+pfgz1pwRTA3F1AwxkI87/m5D+5kPkj2DLiRn/CFk4UBeiBT37fW+kniU94iIxHeoOThig3YRuLGaxd3LeSloSHW1xcaEhMpaP+uFozdVPBBf5cVZwjx63xVLa5+jQZBf7UM9zaew=="
                func    = encodeURIComponent "&Function=post_add_email_and_data"
                mlid    = encodeURIComponent "&MailingListID=#{id}"
                dsid    = encodeURIComponent "&DatasetID=#{ds}"

                api + sid + mlid + dsid + b64 + func # <-- closure


            uri: (document) ->
                return @site.url + (document.url or document.get?('url'))

            plaatsLink: (naam) ->
                link = @site.snelkoppelingen[naam]
                anker = """
                    <a href="#{link.url}" title="#{link.titel}" class="#{link.cssKlasse or ''}">#{link.tekst}</a>
                    """
                return anker



            verzameling: (query) -> @getCollection('documents').findAllLive(query).toJSON()


    module.exports      = docpadConfig




(. (require "docpad") createInstance config-docpad)



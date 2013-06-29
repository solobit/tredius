

# DocPad instellingen

    fs          = require 'fs'
    path        = require 'path'

## Bron

Een befaamde oproep in web development kringen is: "don't polute the global
namespace" en "globals are evil". Feit is dat dit CoffeeScript is en daarnaast
onderdeel van een groter geheel aan wrappers. Ik expose hiermee.......`(((T)))`
better understanding.

    this.file_location  = path.resolve(__filename)
    this.path_minified  = '../docpad.js' 
    this.path_compiled  = 'docpad.compiled.js'
    this.file_database  = 'continents-cities-nl_NL.mo'
    path_languages      = "i18n/languages/"


Dit bestand is het belangrijkste, althans meest prominent zichtbare,
bestand in een reeks welke op een of andere wijze uw site instellen.

## Interne Helpers

Dit zijn functies die ons hier, vanuit de buitenste scope, kunnen assisteren met
het eenvoudiger werken in dit bestand. Deze functies zijn dus niet elders in de
site documenten te gebruiken omdat ze niet aan diens scope blootgesteld worden.
Maak hiervoor anders een sleutel in docpadConfig aan. Zoals met alleen
kh `afbeelding('plaatje.img')` het gehele pad ophalen:

Of teksten met veel witte regels netjes splitsen in een array die we kunnen
benaderen als gegevens[0] of gegevens[1] voor iedere regel (voor bij
adresblokken bijvoorbeeld). Ook zijn er velden die veelal geen witruimte pruimen
in de zin dat deze ze letterlijk weergeven terwijl we dit niet zouden willen. We
maken van iedere nieuwe regel simpel een spatie en halen alle spaties aan het
begin en einde van het blok weg. Veel regels worden er dus 1, gladmaken of
vereffenen zou een ander woord zijn. Tot slot een handig logje.

    afbeelding      = (img) -> return '/media/afbeeldingen/' + img
    splits          = (txt) -> return txt.trim().split('\n')
    egaliseer       = (txt) -> return txt.replace(/\s+/g, " ")
    geenspaties     = (txt) -> return txt.replace(/\s+/g, "")
    log             = console.log

> ((@)) Introductie hash en node.js

    docpadConfig =


Welke server poort gebruiken we? De `1337`-port aka 'elite' is tijdens
development in gebruik.

        port: 1337


Localized path names

        srcPath:        'site'

        outPath:        'www-uitvoer'  #'data/uitvoer'

        cfgPath:        'etc'

Arrays to allow more than one path also localized

        pluginsPaths:   ['node_modules', 'modules/node_modules', 'modules/plugins']

        documentsPaths: ['documents', 'documenten']

        filesPaths:     ['files', 'public', 'bestanden']

        layoutsPaths:   ['layouts', 'sjablonen']


## Plugins

Plugins worden vrij eenvoudig automatisch gevonden door de centrale docpad
regiekamer, hiermee kun je ze ook weer uitzetten als er eentje kapot is en wacht
bijvoorbeeld op een nieuwe versie, van tijdelijke aard dus meestal.

        enabledPlugins:

            absolutepath:           true

            pathtoroot:             false

            munge:                  false

            text:                   false

            literate:               false

**Plugins configureren**

Veelal in de plugin map zelf. Maar ook vanuit hier aan te passen, toe te voegen,
modificeren...*((+))*

        plugins:

#### Plugin: Partials

            partials:

                partialsPath:       'bouwstenen'

Since partials are not part of the core framework localize the path name here

#### Plugun: Sitemap

            sitemap:

                cachetime:          600000

                changefreq:         'yearly'

                priority:           0.8

Something:

* `name` string, name of the download, for logging purposes only
* `path` string, path that the completed download is placed
* `url` string, url the download is retrieved from
* `deflate` boolean, whether or not we should deflate the response when
  fetching the download (auto-detected if not set)
* `gzip` boolean, whether or not we should unzip the response when
  fetching the download (auto-detected if not set)
* `tarExtract` boolean, whether or not we should extract tar downloads
  (auto-detected if not set)
* `tarExtractClean` boolean, whether or not when performing a tar
  extraction if we should remove the root directory of the extracted
  files


Template data zijn gegevens die door uw sjablonen en documenten heen gebruikt
kan worden. Erg handig dus: we hoeven alleen hier bijvoorbeeld de bedrijfsnaam
te vermelden, en kunnen deze dan uniform, door de site heen gebruiken.

        templateData:

## Organisatie

Uw organisatie, dat *bent* u. Met uw medewerkers, (zaken)partners,
materieel kortom: mensen en middelen. Daarmee heeft uw bedrijf, o.a. een
identiteit. *((+))* 

            org:

                bedrijfsnaam:     'Tredius'

                bedrijfslogo:     afbeelding('bedrijfslogo.png')

                omschrijving:     egaliseer """

                    Tredius verleent financiële-, fiscale-, juridische-,
                    personele- en bedrijfsadministratieve diensten aan
                    het MKB van Nederland

                """

                auteursrecht:     "#{new Date().getFullYear() + ' © Tredius.nl'}"

Het adres van het hoofdfileaal kan afzonderlijk gebruikt worden als velden.
Hiervan nemen we dus aan dat deze het meest gebruikt wordt.

                bezoekadres:

                    straat:       'Zijlweg 146'
                    postcode:     '2015 BH'
                    plaats:       'Haarlem'

Dit geldt tevens voor het merendeel aan post dat naar een ander adres verzonden
moet worden.

                postadres:

                    postbus:      'Postbus 992'
                    postcode:     '2003 RZ'
                    plaats:       'Haarlem'

Telefoonnummers en email die vaak gepubliceerd worden. Om spambots (die email
verzamelen op het web) tegen te gaan werkt de module 'munge' achteraf alle
paginas door op zoek naar email om deze te verbergen voor bijna alle machines.
Noot: individuele vertegenwoordigers krijgen een apart blok met nummers en
adressen.

                contactgegevens:

                    telefoon:     '023 551 30 55'
                    fax:          '023 551 30 35'
                    email:        'info@tredius.nl'

Informatie die veelal op geschreven stukken zoals briefpapier, factuur
enzovoorts terug te vinden is. Veelal ook wettelijk verplicht dit beschikbaar te
stellen als informatie dus ook bij financiele producten zal deze vaker terug
komen maar bijvoorbeeld ook in een rapportage functie.

                handelsgegevens:

                    kvk:          '3782878'
                    btw:          'NL8124.72.792.B01'
                    bedrijfsvorm: 'Besloten Venootschap (BV)'

Belangrijke (!) personen zijn hen die over het algemeen, bij grotere bedrijven,
als de contact persoon aangemeld staan. Vakspecialisten, de hoofdverkoper,
kwaliteitsmanager enzovoorts.

Komen ze niet voor op de site? Dan horen ze hier niet: dit is `geen`
*personeelsadministratiesysteem*!

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



### Vestigingen, regio-. hoofdkantoren en overige locaties

Afdelingen of vestigingen op die geografische locaties anders dan de
hoofdafdeling / organisatie. Deze kunnen zowel national als
internationaal gelegen zijn *((..))*

                vestigingen:


                    purmerend:

##### Bezoek- en postadres

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

##### Telefoon, fax en email

                        telefoon:   "0299 411 345"

                        fax:        "0299 411 348"

                        email:      "info@tredius.nl"

                    monnickendam:

##### Bezoek- en postadres

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

##### Telefoon, fax en email

                        telefoon:   '0299 651 987'

                        fax:        '0299 653 004'

                        email:      'info@tredius.nl'

                    alkmaar:

##### Bezoek- en postadres

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

##### Telefoon, fax en email

                        telefoon:   '072 564 4203'

                        fax:        '072 564 3019'

                        email:      'info@tredius.nl'

#### Haarlem

                    haarlem:

##### Bezoek- en postadres

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

##### Telefoon, fax en email

                        telefoon:   '023 551 30 55'

                        fax:        '023 551 30 35'

                        email:      'info@tredius.nl'



## De website

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

Dit is een baseline omschrijving van de website zoals deze letterlijk in Google
weergegeven gaat worden. Moet dus vooral geen harde nieuwe regel `\n` bevatten
want dit wordt door de HTML/Browser allemaal prima uitgelijnd.

                omschrijving: egaliseer "

                Bij Tredius hebben we de behoefte om het MKB landschap te
                veranderen: Vrijheid, Onafhankelijkheid en Zelfstandigheid,
                voor iedere ondernemer.
                "

Sleutelwoorden die in de `<meta>` van de `<head>` gebruikt worden als baseline
voor documenten waar we dit niet uit de inhoud weten te herleiden. Deze moeten
als een string met kernwoorden gescheiden door comma's opgegeven worden.

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

## Client-side browser JavaScript

Dit kan een gecompliceerd onderwerp zijn. Het probleem zit hem onder
andere in het volgende:

* JavaScript kan geminimaliseerd worden (spaties en nieuwe regels
  verwijderen). Een vorm van compressie waardoor JS nog steeds werkt
  maar de bestandsgrootte kleiner is geworden. Dit is alleen niet handig
  tijdens ontwikkeling van scripts en moet dus tot het einde uitgesteld
  worden, ook tijdens het draaien in de browser van de ontwikkelaar.
  Maar er zijn tools die automatisch die bestanden in de gaten houden
  wanneer ze opgeslagen worden, daarna minimize deze. Maar hoe zie je ze
  in de browser? Compressed, dus tool nodig voor uncompress in Browser!

* Scripts kunnen `sync` of `defer` zijn (`defer` is uitgesteld synchroon)
* niet alle scripts zijn geschikt voor defer want JS in een modulaire
  pagina kan al geladen zijn terwijl de dependency niet in de head zat
  en dus te laat binnen is en niets meer werkt.

> ((!!)) Prio: omzetten naar AMD met Volo

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



### Vormgeving

Hier komt een stukje over stijlen die gebruikt zijn.
TODO: automatisch toevoegen van random voor cache tijdens development fase en niet comprimeren (volatile).
Deze wel compressen (bladen) abstracten naar eigen pagina ((T))

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


### Snelkoppelingen

Veel gebruikte snelkoppelingen / hyperlinks

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


### (Web 3.0) Vocabularies of web ontologies

                vocabulaire: {'xmlns:s'     : 'http://schema.org/'
                            , 'xmlns:foaf'  : 'http://xmlns.com/foaf/0.1/'
                            , 'xmlns:xsd'   : 'http://www.w3.org/2001/XMLSchema#'
                            , 'xmlns:v'     : 'http://rdf.data-vocabulary.org/#'
                            , 'xmlns:pto'   : 'http://www.productontology.org/id/'
                            , 'xmlns:wn'    : 'http://xmlns.com/wordnet/1.6/'}


Vimeo en mail API

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

Samenstellen en encoden van mail API URI

                api     = encodeURI          "http://www.graphicmail.nl/api.aspx?"
                sid     = encodeURIComponent "SID=4"
                b64     = encodeURIComponent "&Credentials=DtZEdUEEcUap7RsVxnxyWux37VTOip2Xp2M+gIusSMwpc9Hu7nDCFm2LffostDgC/8lkV84pfIARSyMl/Hfamx4oG8mt/mk8o+UsteAhNqMs/qO3lhsagAKn4EtikhystNc17yejBNe2b+pfgz1pwRTA3F1AwxkI87/m5D+5kPkj2DLiRn/CFk4UBeiBT37fW+kniU94iIxHeoOThig3YRuLGaxd3LeSloSHW1xcaEhMpaP+uFozdVPBBf5cVZwjx63xVLa5+jQZBf7UM9zaew=="
                func    = encodeURIComponent "&Function=post_add_email_and_data"
                mlid    = encodeURIComponent "&MailingListID=#{id}"
                dsid    = encodeURIComponent "&DatasetID=#{ds}"

                api + sid + mlid + dsid + b64 + func # <-- closure

Daadwerkelijke pad achterhalen

            uri: (document) ->
                return @site.url + (document.url or document.get?('url'))

            plaatsLink: (naam) ->
                link = @site.snelkoppelingen[naam]
                anker = """
                    <a href="#{link.url}" title="#{link.titel}" class="#{link.cssKlasse or ''}">#{link.tekst}</a>
                    """
                return anker

QueryEngine / Backbone modellen

            verzameling: (query) -> @getCollection('documents').findAllLive(query).toJSON()


Expose scope

    module.exports      = docpadConfig
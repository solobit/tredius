# Hoofdsjabloon Tredius

<!--
comment '.cookieWarningBox'
script type: 'text/javascript', '(function() {\n  $("#position3").position({\n    my: "right center",\n    at: "right bottom",\n    of: "#targetElement"\n  });\n\n}).call(this);'
comment '[if lt IE 7]>\n    <p class="chromeframe">Uw browser is<em>antiek!</em></p><a href="http://browsehappy.com/">Upgrade</a><span>de browser of</span><a href="http://www.google.nl/chromeframe/?redirect=true">installeer Google Chrome Frame</a><span>om deze site te ervaren.</span><![endif]'
-->

Dynamische meta-gegevens (LET OP: bovenaan declareren variabelen voor
toegang hieronder!!!)

    benamingDocument    = if @document.titel then "#{@document.titel} | #{@site.naam}" else @site.naam
    metaKernwoorden     = @site.keywords.concat(@document.sleutelwoorden or []).join(', ')
    metaOmschrijving    = @document.omschrijving or @site.omschrijving
    hoofdIllustratie    = "background: url('/media/afbeeldingen/#{@document.bannier}') repeat-x;"
    soortDocument       = @document.soort or "s:Article"

<http://www.w3.org/QA/Tips/Doctype>


Elke HTML-pagina moet beginnen met een DocType-Declaratie, oftewel
Document Type Definition (DTD). Deze komt voor de `<html>` tag. De
DocType geeft de browser informatie over het type HTML waarmee de pagina
is gecodeerd.

    doctype 5

In het Nederlands: geef wijzigingen aan met betrekking tot de
oorspronkelijke taal van de tekst van een document, inclusief andere
tekstuele elementen (zoals bijschriften).

    html '.PaginaStructuur'

Ondanks het feit dat het specificeren van de oorspronkelijke taal van
het document op zich een prioriteit 3-ijkpunt is – en dus optioneel – is
het specificeren van wijzigingen met betrekking tot deze oorspronkelijke
taal een prioriteit 1-ijkpunt – en daarmee een minimumeis van de WCAG en
deze handleiding. Omdat het aangeven van deze wijzigingen afhankelijk is
van de specificatie van de oorspronkelijke taal, wordt het specificeren
van de oorspronkelijke taal binnen deze handleiding verplicht geacht.

    , lang:         'nl'


Webontwikkelaars moeten de basistaal van een pagina specificeren in de
markup. Meestal zal dit Nederlands zijn. Dit hoeft maar één keer op een
pagina te gebeuren, in de `<html>` tag, door middel van het lang
attribuut.


    ,               @site.taal





    , version:      'HTML+RDFa 1.1'



    , prefix:       'og: http://ogp.me/ns#'




    , itemscope:    'itemscope'


    , itemtype:     "s:WebPage"


    , ->


## HTML Documentkop

Voor robots (niet zichtbaar)

        head ->

            #base href: @site.url       # Disable in local

            meta charset: 'utf-8'

            meta 'http-equiv': 'content-language'  , content: 'nl'

            meta 'http-equiv': 'cache-control'     , content: 'Public'

            meta 'http-equiv': 'X-UA-Compatible'   , content: 'IE=edge,chrome=1'


            text @getBlock('meta').toHTML()

### De titel


            title benamingDocument

### Robots en caching


            meta name:     'robots'         , content: 'all'

            meta name:     'rivist-after'   , content: '1 days'

### Auteurs- en publicatiegegevens creatief werk


            meta name:     'author'         , content: @site.auteur

            meta name:     'email'          , content: @site.contact

            meta name:     'copyright'      , content: @org.auteursrecht

### Web 1.0 era


            meta name:     'keywords'       , content: metaKernwoorden
            meta name:     'description'    , content: metaOmschrijving

### Web 3.0 semantisch web


            meta name:     'rating'         , content: 'General'

### Facebook OpenGraph


            meta property: 'og:title'       , content: benamingDocument

            meta property: 'og:url'         , content: @document.urls[0]

            meta property: 'og:type'        , content: @document.type

            meta property: 'og:image'       , content: @org.bedrijfslogo


### Google +1


            meta itemprop: 'name'
            , content: @document.soort or 's:WebPage'

            meta itemprop: 'description'
            , content: @document.samenvatting or metaOmschrijving

            meta itemprop: 'image'
            , content: @org.bedrijfslogo

### Weergave schermen


            meta name: 'viewport'
            , content: 'width=device-width, initial-scale=0.7'

### Stijlbladen en vormgeving (ook die van plugins)


            text @getBlock("styles").add(@site.stijl.bladen).toHTML()

            link rel: 'shortcut icon'       , href: @site.stijl.icoon, type: 'image/png'
            link rel: 'stylesheet'          , href: @site.stijl.lettertype


### Scripts

Regelmatig plaatst men diverse JavaScript code blokken in de kop van een
HTML document. Dit heeft echter mogelijk een, niet gering en te
onderschatten, [effect op de rest van het document][blockjs]. Omdat deze
scripts in de kop staan, is het mogelijk dat - in geval van een fout -
deze de doorvoer van de rest van het document volledig blokkeren. Een
zeer ongewenste situatie, zo mag u wel stellen! 

Helaas is het niet altijd mogelijk om de kop van het HTML document vrij
te houden van scripts. Soms is het plaatsen noodzakelijk ter
ondersteuning van oudere browsers, bepaalde scripts werken alleen als
deze in de kop definitie opgenomen zijn. Relevant is wel dat we trachten
dit zoveel mogelijk te voorkomen, door het gros van de scripts die dit
wel toelaten, naar de bodem te verplaatsen en deze [asynchroon][defer]
uit te voeren


            script src:  url for url in @site.blockingScripts


## HTML Documentopmaak: het lichaam

De daadwerkelijke inhoud van een webpagina bevindt zich binnen het
`BODY` element. Bij het opzetten van de inhoud van een pagina is het aan
te raden om deze in volgorde van belangrijkheid in de HTML te zetten.
Dat wil zeggen: belangrijkste inhoud eerst, en de minst belangrijke
inhoud (zoals secundaire navigatie bijvoorbeeld) onderaan. Let wel: het
plaatsen van inhoud op de weergegeven pagina wordt geregeld via
[CSS][css]; de visuele indeling hoeft niet dezelfde te zijn als de
structuur. Het structureren van de inhoud op deze manier verhoogt de
vindbaarheid, toegankelijkheid en bruikbaarheid van de informatie. >
Bron: [webrichtlijnen.nl][wrbody]

Dit is waar de meeste sites ongeveer ophouden met het faciliteren
daarvan. Vooropgesteld: de ontwikkelingen op het web gaan sneller dan
menigeen van ons bij kan houden, en ten dele is dit een gunstige zaak.
De ene na de andere widget spettert van het scherm en voorheen
onmogelijk geachte trucs komen binnen handbereik van de ontwikkelaar
(zgn. holy grails). Dit kent echter een keerzijde: veelal is het niet
mogelijk deze effect met alleen HTML opmaak te bewerkstelligen. En dat
is waar de toegankelijkheid eindigt.

### Toegankelijkheid van uw site

De informatie op uw site ontsluiten en visueel aantrekkelijk brengen is
een, maar hoe zit het met hen die niet (meer) *kunnen* lezen? Wat kunnen
zij met deze sites? Veelal erg weinig tot niets. De `hacker`-cultuur is
er een die van oudherre prat gaat op haar sociale inborst, hackers
helpen elkaar, door kennis te delen en anderen de weg te wijzen. Wij
zijn van mening dat dit verder gaat dan alleen in de eigen gemeenschap,
grensoverschrijdend, door het web toegankelijker te maken voor minder
validen en zodoende een stukje bij te kunnen dragen door
maatschappelijkbewust te ontwikkelen - juist ook voor hen die
hulpmiddelen nodig hebben om op het web te navigeren. One site at a
time.

Toegegeven, het aantal bezoekers dat gebruik maakt van een zogenaamde
[screen reader][scrreader] om uw site te bezoeken zal laag, zo niet
nihil zijn, en ontwikkelingen in standardisatie gaan traag, dit
weerhoudt ons er niet van om door de gehele site heen, zogenaamde
[Accessible Rich Internet Applications (WAI-ARIA)][wpwai] elementen te
incorporeren. WAI-ARIA bevat richtlijnen voor het toegankelijk
ontwikkelen van dynamische content en geavanceerde user interfaces met
[AJAX][ajax], HTML, JavaScript en gerelateerde technologieën.

[WAI-ARIA 1.0][aria] is nog niet officieel gepubliceerd, maar zit in de
laatste fase en is dus zo goed als klaar - en reeds geimplementeerd op
uw web site!

We zijn dus aangekomen bij een van de belangrijkste definities van het
HTML document: het `BODY` element. Dit bevat al die zaken welke nu net
voor mensen bedoeld zijn en als onderdeel daarvan noemen we een `role`
van de ARIA specificatie welke schermlezers op weg moeten helpen door de
rol van het opmaakelement te specificeren. Daarnaast geven we een
`typeof` van het document aan, deze bepalen we per pagina opnieuw, de
ene keer is het een [Artikel][sArticle] de andere keer een
[video][sVideo] of gewoon, een webpagina.


        body '.PaginaOpmaak'


        , role:         'document'


        , 'typeof':     soortDocument


        ,               @site.vocabulaire


        ,->


### Paginakop

De identiteit van een organisatie of een project of product heeft
verschillende namen. De een spreekt van `corporate identity`, de ander
van huisstijl. Soms gaat het over branding, of de identiteit van het
merk. De belangrijkste componenten hiervan, althans die het meest
herkenbaar zouden moeten zijn, komen als eerst aan bod.


            section '.PaginaKop', ->


We maken met deze sectie definitie hierboven een rij (aan de achterkant,
via CSS!) met daarin een aantal elementen verwerkt. Zoals gezegd, de
belangrijkste elementen dienen zoveel mogelijk als eerst geplaatst te
worden. Met behulp van web 3.0 semantische opmaak verklaren we een
nieuwe `itemscope`, oftewel een bereik voor het definieren van onze
identiteit.


                header '.Bedrijf'
                , itemscope:        'itemscope'

                , itemtype:         'gr:BusinessEntity'

                , about:            '#company', ->


                    meta property: 'gr:legalName'

                    , content:      @org.bedrijfsnaam


                    a '.Snelkoppeling-afbeelding'

                    , href:         @site.url

                    , alt:          "Naar #{@site.url}"

                    , rel:          'foaf:page'

                    , resource:     @site.url

                    , ->


                        img '.PaginaLogo'

                        , width:    '160'
                        , height:   '59'

                        , rel:      'foaf:logo'

                        , alt:      "Terug naar #{@site.naam}"

                        , title:    @site.naam

                        , src:      @org.bedrijfslogo

                        , resource: @org.bedrijfsogo


Als laatste onderdeel van de 'eerste rij van boven', rechts-bovenin,
plaatsen we een knop naar een externe site. Dit is conform indeling van
de voorgaande site-opmaak. Deze knop verwijst slechts naar een een login
formulier op deze site en er is expliciet geen login op voor dit
formulier op deze site geplaatst vanwege het feit dat wij zenden vanaf
HTTP en de ontvanger HTTPS voert. [Lees hier meer][badid] over het
waarom dit zenden van formuliergegevens van HTTP naar HTTPS (of
andersom) een slecht idee is.


                aside ->

                    a '.login.knop'

                    , href: 'https://login.twinfield.com/'

                    , 'Inloggen'


#### Navigatie (globaal) - horizontaal menubalk bovenaan
<http://www.tredius.nl/site/handleiding/navigatie.html>

Vrijwel geen onderdeel van site ontwikkeling is zo onderhevig geweest
aan onderzoek en wetenschappelijke studie als het onderdeel 'navigatie'.
Vanwege het volume aan materiaal wordt deze daarom in een afzonderlijk deel
behandeld.

Door middel van een zgn. `partial` kunnen we eenvoudig de logica van het
besturingselement 'menubalk' weghalen uit dit document en deze elders
onderbrengen. Hiervoor hebben we een map 'blok' (site componenten van
overkoepelende aard) toegevoegd aan de map 'bouwstenen'. In de map
'blok' bevindt zich nog een map, genaamd 'navigatie' en hier kunnen we
alle navigatie elementen eenvoudig en uniform onderbrengen.

Oorspronkelijk was de hoofdmap van de partials genaamd 'partials', deze
is in de 'docpad-plugin-partials' configuratie plugin hernoemd naar een
Nederlandstalige equivalent.


                text @partial "blok/navigatie/kop-horizontaal", @


#### Illustratie prominent

Het zal u wellicht al opgevallen zijn: de site kenmerkt zich in grote
mate door de aanwezigheid van, veelal thematisch gerelateerde, handmatig
geselecteerde afbeeldingen van niet geringe omvang. De 'officiele' term
hiervoor (nog in vorming wegens beperkt gebruik in natuurlijke
taal/vakjargon): de [Hero Banner][hero]. De term is afkomstig van,
althans voor zover bekend, het veelgebruikte [Twitter Bootstrap][tbs]
patroon voor snelle - `boilerplate` - ontwikkeling van web sites. Mede
vanwege gebrek aan een betere term voor dit component zullen we deze
aanduiden als 'bannier' of 'paginakop illustratie' al naargelang.

            header '.PaginaContext-afbeelding'

            , role: 'banner'

            , 'aria-labelledby': 'label_titel'

            , style: hoofdIllustratie

            , ->

> TODO: geen idee waarom ook al weer de h1 hier geplaatst is.

                h1 '.PaginaTitel'
                , title: @org.bedrijfsnaam

Over de breedte van de illustratie, loopt een element met daarin een
aantal onderdelen voor het plaatsen en prominent weergeven van
belangrijke gegevens over de pagina. Omdat ook deze gegevens, net als de
afbeelding, afhankelijk zijn van de `context` (d.w.z. afhankelijk van de
inhoud, het onderwerp en de intentie van de boodschap op die specifieke
pagina), hebben wij deze `PaginaContext` gelabeld.

> TODO: WebPage wel of niet dynamisch? Google? SEO? Of penalty?

                div '.PaginaContext'

                , itemscope:    'itemscope'

                , itemtype:     's:WebPage'
                
                , -> div ->

Achtereenvolgens geven we weer:
* de pagina hoofdtitel (of de categorie/groepering afhankelijk van
  omstandigheden en ruimte)
* de pagina ondertitel, een tweede - relevante subtitel - om zo beter
  het onderwerp te kunnen duiden.
* een korte samenvatting of 'pakkende' tekst die weergeeft wat de inhoud
  van de pagina omhelst of, welke bijvoorbeeld moet uitnodigen tot
  verder klikken / zoeken.
* en tot slot een tweetal onzichtbare `META` elementen welke verder aan
  zoekmachines moeten verklaren waar de pagina over gaat (aan de hand
  van een kort aantal sleutelwoorden) en wie deze gemaakt heeft.

                    h1 '.PaginaContext-hoofdtitel'
                    , itemprop: 'name'
                    , @document.titel

                    h2 '.PaginaContext-ondertitel'
                    , itemprop: 'about'
                    , @document.subtitel

                    p '.PaginaContext-beknopt'
                    , itemprop: 'description'
                    , @document.samenvatting

                    meta itemprop: 'keywords'
                    , content: @document.labels

                    meta itemprop: 'creator'
                    , content: @org.bedrijfsnaam

Al deze informatie wordt gevoerd vanuit de afzonderlijke documenten
(paginas) om een volledig uniek HTML document telkens opnieuw te
genereren.

### Inhoud

Vervolgens zijn we bij het meest significante, en tevens hier minst
beschreven onderdeel, aangekomen. De daadwerkelijke inhoud. Deze site is
gemaakt door een site generator welke, onafhankelijk van de gebruikte
technologie en taal, een site samenstelt aan de hand van sjablonen
(zoals deze) en documenten (zoals hier ingevoegd worden). Een derde
onderdeel, partials oftewel de bouwblokken, hebben we al kort aangehaald
en het laatste onderdeel betreft eenvoudigweg 'bestanden' waar verder
niets mee gebeurt.

            section '.PaginaInhoud', role: 'main', ->

Uiteraard is als rol van de sectie een belangrijk kenmerk toegevoegd,
`main` kan daarom ook maar beperkt ingezet worden voor datgene waar het
om gaat. We genereren een uniek `id` attribuut en maken dynamisch een
klasse specifiek voor die documenten die we zo ingesteld hebben.

> TODO (overblijfsel van : verwijderen)


                article id: @document.kenmerk
                , class: "PaginaInhoud Pagina-#{@document.kenmerk}"
                , -> @content

Helemaal onderaan verwijzen we de functie naar onze document inhoud, met
een simpel `@content` voegen we de teksten en broncode in.

### Paginavoet

De paginavoet is een van oudsher ietwat onderontwikkeld gedeelte van een
web site maar juist de laatste tijd bezig met een 'revival'. Ook bij
deze site neemt de voet een belangrijke rol in door te zorgen voor een
secundaire navigatierol en met additionele media/bronnen zoals videos en
een aanmeldingsknop voor nieuwsbrieven.

Navigatie onderaan wordt dus steeds gebruikelijker, ten behoeve van
metanavigatie of (globale) sitemaps. Bekende voorlopers hiervan zijn
Apple en Amazon.

            text @partial 'blok/multimedia' , @

Tot slot hebben we helemaal onderaan de site, in kleinere tekst
weergegeven, de colofoon van de organisatie. Hierin staan overige
snelkoppelingen naar bijvoorbeeld algemene voorwaarden, het cookie-
beleid, telefoonnummers en auteursrechtelijke bepalingen. Dit is met
name door overlevering zo bepaald en veelal zal men er ook op deze
plaats naar zoeken.

            text @partial 'blok/voettekst'  , @

Als allerlaatste afsluiting, eindelijk, de scripts die we hebben kunnen
uitstellen en welke, door `defered execution` onze pijpleiding niet meer
kunnen blokkeren.

            text @getBlock("scripts").add(@site.nonBlockingScripts).toHTML()





<!--
coffeescript ->

    queue = new createjs.LoadQueue()
    queue.installPlugin(createjs.Sound)
    queue.addEventListener("complete", handleComplete)
    queue.loadFile({id:"sound", src:"http://path/to/sound.mp3"})
    queue.loadManifest([
        {id: "myImage", src:"path/to/myImage.jpg"}
    ])
    handleComplete: () ->
        createjs.Sound.play("sound")
        image = queue.getResult("myImage")
        document.body.appendChild(image)
-->

[tbs]: <http://twitter.github.io/bootstrap/>
[hero]: <http://en.wikipedia.org/wiki/Hero_graphic>
[dopper]: <http://www.den-dopper.com/2009/10/19/website-navigatie-denk-na-over-plaatsing-weergavestijl-en-interactie/>
[wpwai]: <http://en.wikipedia.org/wiki/WAI-ARIA>
[aria]: <http://www.w3.org/TR/wai-aria/>
[ajax]: <http://nl.wikipedia.org/wiki/Asynchronous_JavaScript_and_XML>
[scrreader]: <http://nl.wikipedia.org/wiki/Screenreader>
[defer]: <https://developer.mozilla.org/en-US/docs/HTML/Element/script#attr-defer>
[blockjs]: <http://www.stevesouders.com/blog/2009/04/27/loading-scripts-without-blocking/>
[badid]: <http://paulmakowski.wordpress.com/2009/07/20/http-post-https-bad-idea/>
[css]: <http://nl.wikipedia.org/wiki/Cascading_Style_Sheets>
[wrbody]: <http://www.webrichtlijnen.nl/aan-de-slag/paginastructuur-in-abbr-langen-xmllangen-titlehyper-text-markup-languagehtmlabbr#body>
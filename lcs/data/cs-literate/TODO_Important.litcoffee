
# Tredius corporate web site

## Structuur van een hypertext opmaakdocument

Helemaal aan het begin van een document wordt de `DOCTYPE`-declaratie
(document type) opgenomen. Deze is ervoor bedoeld aan te geven aan welke HTML-
versie het document voldoet. De `DOCTYPE`-declaratie verwijst naar een
document type definition (`DTD`).

In dit geval declareren we een HTML document type **5**. 

    doctype 5

Op het moment van schrijven is dat de meest recente en gebruikte versie van
het protocol, al zal de transitie van oudere talen (vocabularies) naar een
nieuwere altijd enige tijd in beslag nemen. De standaarden zoals welbekend
`HTML` of `XHTML`, `XML` en `CSS` onder andere worden uitgegeven en beheerd
door het [World Wide Web Consortium][w3c] (W3C).

In de HTML definitie (het `html`-element) geven we gegevens op als de taal van
het document. Ook het [Resource Description Framework][rdf] of `RDF` - hier
samen met het HTML protocol gedeclareerd - is een standaard van het W3C -
oorspronkelijk ontworpen als een metadata-model - maar gaandeweg gebruikt als
een formaat om gegevens in het algemeen voor te stellen en uit te wisselen.


    html lang: 'nl'                 , 
    version: 'HTML+RDFa 1.1'        , 
    prefix: 'og: http://ogp.me/ns#' , ->


Tot slot zagen we een derde attribuut hierboven, deze is genaamd `prefix`, en
het prefix 'attribute' wordt hier hier gebruikt om de site toegankelijk te
maken voor - met name - de sociale netwerken op internet. De meest bezochte
van het stel,  [Facebook][fog], is dan ook eigenaar en de grootste gebruiker
van [Open Graph][ogp]. De mogelijkheden hiervan lopen uiteen, zo is het
bijvoorbeeld zeer eenvoudig deze site in Facebook te integreren, alle data
deelt zich automatisch.

Met dit vrij korte overzicht, zijn we aan het einde gekomen van het eerste
'niveau' in het document. De hier boven behandelde elementen, afwisselend vaak
ook wel (HTML) tags genoemd, valt misschien wel het beste te zien als de
verpakking van een modern boek, met een barcode - enkele chip wellicht en
welke taal je nodig hebt om het te lezen. Niet alles van een document wordt
uitgelezen, scripts bijvoorbeeld dus niet, maar voor de rest kan men veel
informatie herleiden uit een enkel document. Hieronder staat een mogelijke web
site weergegeven:

![http://cs.lmu.edu/~ray/images/htmlelements.png][Web site van cs.lmu.edu]

Meer informatie staat op [deze pagina][lmu], het biedt een goed overzicht van de
ontwikkeling van deze web technologieen.


Zo'n boek gaat dan van de uitgever,
langs een aantal kanalen totdat het uiteindelijk ook door een aantal grote ketens
opgepikt wordt, om deze vervolgens ten toon te stellen. Maar hierbij geldt
even goed: het helpt als je ze op je bestaan attendeert en, mocht je zo
fortuinlijk zijn een prominente plaats te krijgen, op veel afname kunt rekenen
- soms meer, veel meer, dan gewenst of gehoopt (virals, slash-dotten).


### De documentkop

Merk op dat we hieronder naar een niveau 'dieper' gaan ten opzicht van de
vorige elementen `doctype` en `html`. Deze code, hier genesteld in een
literair CoffeeScipt/Cup document, vertaalt zich uiteindelijk - via een
transformatieproces - tot HTML, CSS en JavaScript. Dit zijn de drie disciplines
waar het moderne web op draait en, veel belangrijker of juist inherent daaraan,
ook door de meeste aanbieders van diensten aan geconformeerd wordt.

Het volgende element is de `head` tag en deze krijgt verder geen attributen
mee. Deze sectie (want dat is het feitelijk, een inkapseling van meer
elementen) bevat een belangrijk gedeelte van het document: de kopteksten. En
net als bij belangrijke rapportages en publicaties, kan hieruit veel
informatie over de inhoud afgeleid worden. Deze is dan ook gewoonlijk niet
zichtbaar voor de bezoeker en alleen bestemd voor machines.


    head ->


We zakken meteen weer een niveau en, zoals ook bij gebruik van 'puur' HTML,
deze wordt daarmee een 'genest' of kind (`child`-element) van de ouder. Men
spreekt ook wel van `ancestors` en `descendants`. Het element dat we hierop
doen volgen is `base`. Dit relatief onbekende en niet vaak gebruikte element
zorgt ervoor dat alle adressen (URL's) in dit document, zoals die van
afbeeldingen of videos, niet door het gehele domeinnaam vooraf gegaan hoeven
te worden. Een link met de snelkoppeling `/artikelen/2013.html` wordt dan
automatisch voorafgegaan (prefixed) door het domein.


        base href: '#{@site.url}'


Dit element, het `meta` element met het `charset` argument is zeer belangrijk.
Het kan de gebruikte set karakters(set) aangeven welke voor een goede weergave
van uw webpagina's erg belangrijk is.


        meta charset: 'utf-8'


Uiteraard mag u de metatags op alle pagina's plaatsen, dus niet alleen de
eerste index. Zorg er wel voor dat iedere pagina zijn eigen relevante tags
krijgt, met steekwoorden en begrippen die betrekking hebben op de inhoud. In
ons geval worden deze automatisch uit de teksten van de inhoud afgeleid en
tijdens het generen van de statische paginas 'ingeplakt'. Dit geeft ons een
gigantisch voordeel over de dynamische (PHP, Single Page, ASP etc.) gemaakt
websites. Zij moeten veel moeite doen om hun pakketen in te richten voor Web
3.0 terwijl in een aantal gevallen het gewoon helemaal kansloos is. Het lijkt
misschien veel werk om voor iedere pagina aparte metatags te verzinnen maar
het werkt, en met onze methode besparen we ons veel tijd, geld en energie.

De onderstaande `meta` tags zijn ietwat afwijkend van de rest in die zin, zij
hebben meer betrekking op de feitelijk web servers zelf, dan op de inhoud van
het document en hiermee kunnen via een omweg nog opdrachten en informatie aan
machines verstrekken (pragma's of ook wel macro's genoemd).
        

        meta 'http-equiv': 'content-language'   , content: 'nl'
        meta 'http-equiv': 'cache-control'      , content: 'Public'
        meta 'http-equiv': 'content-tsype'      , content: 'text/html; charset=UTF-8'
        meta 'http-equiv': 'X-UA-Compatible'    , content: 'IE=edge,chrome=1'


Een wat vreemde eend in de bijt, voor hen die al wat HTML tags herkend menen
te hebben, is de onderstaande `text` tag. De `@getBlock` methode die er op
volgt, wordt door onze statische generator gebruikt om verdere informatie uit
een ander (administratief) bestand in te voegen.


        text @getBlock('meta').toHTML()


Als de site eenmaal in de index van een zoekmachine is opgenomen, is het
uiteraard van belang dat een bezoeker hem zo hoog/goed mogelijk in de
zoekresultaten tegenkomt. Je kunt dat beïnvloeden door de documenten een goede
titel te geven en door het opnemen van een korte omschrijving en relevante
sleutelwoorden. Daarnaast helpt het als er vanaf andere sites links naar uw
site staan. 


### Documenttitel

Met het `title` element wordt een titel voor het document vastgelegd. Deze
titel wordt niet weergegeven in het documentvenster, maar in de titelbalk van
het venster. Daarnaast wordt de titel door zoekmachines geplaatst als kopje
boven een zoekresultaat en gebruiken browsers hem als iemand de pagina
toevoegt aan de bookmarks. Elk document **moet** een `title` element bevatten.
Het is verstandig een titel te gebruiken, die duidelijk maakt waar het
document over gaat en op basis waarvan bijvoorbeeld gebruikers van een
zoekmachine kunnen beslissen, of het bekijken van het document zinvol is.


        title @geefTitel()


### Meta-gegevens zoekmachines en waarderingen

Op het gebied van [Search Engine Optimization][seo] (SEO) spelen de metatags
nog steeds een belangrijke rol. Vooral de **titel** en de meta **description**
tag zijn erg van invloed want deze wordt weergegeven als de tekst bij de
zoekresultaten. We zorgen er dus voor dat deze voor elke pagina zo uniek
mogelijk gegenereerd worden*. 

Als eerste verwelkomen we onze gemechaniseerde vrienden: de robots. We zijn
erg blij met bezoek, en daarom ook tolerant ten opzichte van indexatie: zowel
onze inhoud als links van sites naar wie wij verwijzen, mogen ingezien en
opgeslagen worden. Wel willen we, als een verliefde bakvis, onze vriend graag
snel weer terug zien! Een dag vinden we voldoende tijd uit elkaar en verzoeken
de bot daarom dan terug te komen naar onze site.

        meta name: 'robots'         , content: 'all'
        meta name: 'rivist-after'   , content: '1 days'

Een vooralsnog niet gebruikte meta tag op onze site is de onderstaande. Een
beetje vreemd, maar dit zijn de 5 sterretjes die je misschien wel eens bij
Google zoekresultaten hebt zien verschijnen. Feitelijk is dit een rating van
de producten van een site, dit kan een artikel zijn als in een krant, of een
artikel dat verkocht wordt zoals een stofzuiger of restaurant. Deze kan men
dus eenvoudig per (product)pagina koppelen aan hun interne database met klant
waarderingen.

        meta name: 'rating'         

        , 

        content: 'General'

Wellicht dat ik op een later tijdstip me hier nog mee bezig kan houden.
Vooralsnog doen we hier niet echt iets mee.

### Auteurs(recht) en samenvattingen inhoud

> Lorem ipsum Id Duis culpa ad exercitation quis voluptate Duis Duis adipisicing
dolor irure eiusmod laboris do non laborum fugiat id laborum qui Excepteur ex
id aute exercitation aliquip irure consequat ad exercitation elit in nisi sint
quis sint velit.

        meta name: 'author'         , content: @site.auteur
        meta name: 'email'          , content: @site.contact
        meta name: 'copyright'      , content: @site.rechten


> Lorem ipsum Et reprehenderit sit est proident adipisicing Ut labore aliqua
velit minim proident exercitation anim id pariatur nostrud quis velit sint
anim occaecat ex ea in eu do Duis minim eu adipisicing reprehenderit qui
labore aliqua pariatur ut.
        
        meta name: 'abstract'       , content: @site.essentie
        meta name: 'keywords'       , content: @geefSleutelwoorden()
        meta name: 'description'    , content: @geefOmschrijving()
        

        meta name: 'viewport'       , content: 'width=device-width, initial-scale=0.7'

        
        # ## Open Graph protocol for social networks (FB)
        meta property: 'og:url'     , content: @document.url
        meta property: 'og:type'    , content: @document.type
        meta property: 'og:title'   , content: @document.titel
        meta property: 'og:image'   , content: @merknaam.logo

        # ## Styles ###
        text @getBlock('styles').toHTML()

        link rel: 'shortcut icon'   , href: '/media/afbeeldingen/favicon.png', type: 'image/png'
        link rel: 'stylesheet'      , href: @site.stijl.lettertypen

        # ## Scripts (blocking ones) ###
        for js in @blockingScripts
        script src: 

    # Body -------------------------------------------------
    body role: 'document', "typeof": @geefEntiteit(), ->

        #comment '.cookieWarningBox'
        #script type: 'text/javascript', '(function() {\n  $("#position3").position({\n    my: "right center",\n    at: "right bottom",\n    of: "#targetElement"\n  });\n\n}).call(this);'
        #comment '[if lt IE 7]>\n    <p class="chromeframe">Uw browser is<em>antiek!</em></p><a href="http://browsehappy.com/">Upgrade</a><span>de browser of</span><a href="http://www.google.nl/chromeframe/?redirect=true">installeer Google Chrome Frame</a><span>om deze site te ervaren.</span><![endif]'

        section '#paginakop', ->

            header itemscope: 'itemscope', itemtype: 'gr:BusinessEntity', about: '#company', ->
                div property: 'gr:legalName', content: @org.naam
                a href: @site.url, alt: 'Terug naar startpagina', rel: 'foaf:page', resource: @site.url, ->
                    img width: '160', height: '59', rel: 'foaf:logo', title: @site.naam, alt: "Ga terug naar #{@site.naam}", src: @org.merknamen.bedrijfslogo, resource: @org.merknamen.bedrijfslogo

            aside -> a '.login.knop', href: 'https://login.twinfield.com/', 'Inloggen'

            text @partial("blok/navigatie", @)

        header '#bannier', role: 'banner', "aria-labelledby": 'label_titel',style: 'background: url("#{@document.bannier}") repeat-x;', ->

            h1 '#label_titel', title: @org.naam

            div '#menucontext', itemscope: 'itemscope', itemtype: 's:WebPage', ->

                div '.pagina-info', ->

                    h1 '#pagina_titel', itemprop: 'name', @document.titel
                    h2 '#pagina_subtitel', itemprop: 'about', @document.subtitel

                    p itemprop: 'description', @document.samenvatting

                    meta itemprop: 'keywords', content: @document.labels
                    meta itemprop: 'creator', content: @org.naam

        section '#pagina', role: 'main', ->

            article '#document.kenmerk.inhoud', -> @content

        text @partial("blok/multimedia", @)

        text @partial("blok/voettekst", @)

        # Scripts
        text @getBlock("scripts").add(@site.scripts).toHTML()


[rdf]: <http://www.rdfabout.com/>
[w3c]: <http://www.w3c.nl/>
[fog]: <http://developers.facebook.com/docs/opengraph/>
[seo]: <http://nl.wikipedia.org/wiki/Zoekmachineoptimalisatie>
[lmu]: <http://cs.lmu.edu/~ray/notes/introhtml/>
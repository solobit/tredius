### cson
voetmenu:   1
naam:       'Belastingadvies'
titel:      'Belasting'
subtitel:   'Belastingadvies'
kenmerk:    'belastingadvies'
layout:     'standaard'
bannier:    'bg_belastingadvies.jpg'
menu:       "<ul class: 'menu circleMenu-closed' id: 'menu16'><li style: 'display: block;'><a href: '#' style: 'display: block; font-size:14px; position:relative;font-weight:400; top:1px; color:#fff;'><p>BELASTING ADVIES</p></a></li><li style: 'display: block;'><a href: '/diensten/belastingadvies.html' alt: 'Belastingadvies' title: 'Belastingadvies'><p>BELASTING ADVIES</a></p></li><li style: 'display: block;'><a href: '/diensten/pensioen.html' alt: 'Pensioen' title: 'Pensioen'><p>PENSIOEN</a></p></li><li style: 'display: block;'><a href: '/diensten/estateplanning.html' alt: 'Estate Planning' title: 'Estate Planning'><p>ESTATE PLANNING</a></p></li></ul>"
###

blockquote '.newQuote', -> p "U mag van ons verwachten dat wij u
 gedurende het jaar op risico’s, problemen en uiteraard kansen wijzen"

p "De fiscalisten van Tredius stellen altijd één vraag extra: 'Wat
 kunnen we nog net extra doen om risico’s en problemen te voorkomen en
 extra kansen te creëren?' Met altijd in het achterhoofd te streven naar
 uw vrijheid en onafhankelijkheid in ondernemen en leven."

p 'In een tijd waarin wetten en regels steeds sneller wijzigingen is up-
 to-date belastingadvies van groot belang, zowel voor u privé als voor
 uw onderneming. De fiscalisten van Tredius hebben continue de nieuwste
 wet- en regelgeving op het netvlies. Op die manier garanderen wij u het
 beste belastingadvies, zodat  u optimaal kunt blijven ondernemen.'

h1 '.Tagline', 'Onze fiscale adviezen moet u dan ook veel meer zien als een
 onderdeel van het geheel'

ul '.Checklist', ->
    li 'Iedere belastingaangifte die bij ons de deur uit gaat, wordt
     gecheckt door een fiscalist. Niet alleen om te controleren of alles
     wel naar waarheid is ingevuld - maar veel belangrijker - om uw
     aangiften te optimaliseren.'
    li 'Zo zullen tijdens de jaarlijkse bespreking van uw cijfers,
     altijd de fiscale risico’s en kansen met u worden besproken om te
     zorgen voor vrijheid en onafhankelijkheid'
    li 'Wanneer u een boekenonderzoek krijgt van de belastingdienst, dan
     staan de fiscalisten van Tredius klaar om u hierin van a tot z te
     begeleiden. Indien nodig gaan we voor u procederen.'
    li "U wilt gaan groeien, overnemen of fuseren: Tredius staat u met
     raad en daad bij om het  fiscale, 'proces - samen met onze overname'
     adviseurs - te begeleiden."
    li 'U denkt over een eventuele bedrijfsopvolging na: een tijdig
     fiscaal advies is dan onontbeerlijk en dit kan u veel
     belastingvoordeel opleveren.'

# Belastingadvies dienstenaanbod  scope:  schema.org
h2 itemscope: 'itemscope', itemtype: 's:Offer', itemid: '#offer', itemprop: 'about'
, 'Uiteraard doen wij het standaard belastingadvies, te denken valt aan:'

# Augment schema.org aanbod met GoodRelations meta-data
div '.Lijst-dienstenwijzer', 'typeof': 'gr:Offering', about: '#offering', ->

    meta property: 'gr:name', content: 'Belastingadvies', @site.taal
    meta property: 'gr:description', @site.taal, content: 'Tredius fiscale diensten'

    # Bedrijf sactiviteiten koppelen
    meta rev: 'gr:offers'              , resource: '#company'
    meta rel: 'gr:hasBusinessFunction' , resource: 'gr:ProvideService'
    meta rel: 'foaf:page'              , resource: @document.url

    # Belastingaangiften
    ul class: 'first-list tax-products category', rel: 'gr:includes', ->

        figure ->

            img src: "/media/afbeeldingen/icon_opstellenvanaangiften.png"
            , width: '86', height: '86', alt: 'Tredius helpt u bij het
             opstellen van belastingaangiften'

            figcaption class: 'category value-title', title: 'Opstellen belastingaangifte'
            , 'Opstellen van aangiften'

        li 'typeof': 'gr:SomeItems, pto:Income_Tax'     , about: '#product', 'Inkomstenbelasting'
        li 'typeof': 'gr:SomeItems, pto:Corporate_tax'  , about: '#product', 'Vennootschapsbelasting'
        li 'typeof': 'gr:SomeItems, pto:Value_Added_Tax', about: '#product', 'Omzetbelasting'
        li 'typeof': 'gr:SomeItems, pto:Dividend_tax'   , about: '#product', 'Dividendbelasting'
        li 'typeof': 'gr:SomeItems, pto:Inheritance_tax', about: '#product', 'Schenking &amp; Erfrechtbelasting'

    # Belastingtechnischadvies
    ul '.Lijst-advies', class: 'second-list tax-products category', rel: 'gr:includes', ->

        figure class: 'category value-title', title: 'Belastingtechnischadvies', ->

            img src: '/media/afbeeldingen/icon_adviseren.png'
            , width: '86', height: '86', alt: 'Tredius adviseert in
             belastingtechnische zaken'

            figcaption class: 'category value-title', title: 'Adviseren van onze klanten'
            , 'Adviseren'

        li 'typeof': 'gr:SomeItems, pto:Estate_Planning', about: '#product', 'Estate Planning'
        li 'typeof': 'gr:SomeItems, pto:Pension'        , about: '#product', 'Pensioenen'
        li 'typeof': 'gr:SomeItems, pto:Limited_company', about: '#product', 'Naar de BV'
        li '&nbsp;'
        li '&nbsp;'

    # Herstructuren
    ul class: 'third-list tax-products category', rel: 'gr:includes', ->

        figure class: 'category value-title', title: 'Herstructuren bedrijven', ->

            img src: '/media/afbeeldingen/icon_herstructureringen.png'
            , width: '86', height: '86', alt: 'Tredius helpt bij
             herstructureringen in uw bedrijf'

            figcaption class: 'category value-title', title: 'Herstructureringen'
            , 'Herstructureringen'

        li 'typeof': 'gr:SomeItems, pto:Entrepreneurship'   , about: '#product', 'Opzetten nieuwe onderneming'
        li 'typeof': 'gr:SomeItems, pto:Legal_personality'  , about: '#product', 'Keuze rechtsvorm'
        li 'typeof': 'gr:SomeItems, pto:Restructuring'      , about: '#product', 'Reorganisatie &amp; bezuinigingen'
        li 'typeof': 'gr:SomeItems, pto:Corporate_finance'  , about: '#product', 'Begeleiding bij financieringen'
        li '&nbsp;'


# Oº°‘¨ widget ¨‘°ºO ══════════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.marco     #  \\════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan een professioneel en gedegen
 belastingadvies of wilt u eens sparren met een van onze fiscalisten?",
 "Neemt u dan contact op met:"]
# ══════════════════════════════════════════════════════════════════════


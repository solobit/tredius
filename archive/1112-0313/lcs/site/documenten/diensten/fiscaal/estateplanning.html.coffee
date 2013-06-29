### cson
voetmenu:     1
layout:       'standaard'
entiteit:     's:Article'
naam:         'Estate Planning'
titel:        'Belasting'
subtitel:     'Estate Planning'
kenmerk:      'estateplanning'
bannier:      'bg_belastingadvies.jpg'
###


p 'Niet alleen gedurende uw werkende leven streeft u naar vrijheid,
 onafhankelijkheid en zelfstandigheid. Ook na uw werkende leven en voor
 uw nabestaanden is dit streven belangrijk. Het is geruststellend als u
 weet dat uw dierbaren prettig kunnen doorleven.'
p 'Heel belangrijk is daarin hoe u uw vermogen, uw huis of uw bedrijf
 overdraagt of nalaat aan uw dierbaren. Een gedachte waar u liever niet
 aan denkt, maar die grote gevolgen kan hebben als u dit niet goed en
 tijdig regelt.'
p 'De fiscalisten van Tredius kunnen u adviseren wat betreft uw estate
 planning. Geheel naar uw eigen situatie, wensen en moment leveren wij u
 maatwerk, zodat u met een geruststellende gedachte uw dierbaren kunt
 achterlaten.'

# Estate_Planning: Semantische productopmaak

h1 '.Tagline', itemscope: 'itemscope', itemtype: 's:Offer', itemid: '#offer'
, 'Om u een beeld te geven wat onze fiscalisten voor u kunnen betekenen,
 hierbij enkele adviezen:'

# Productaanbod publiceren via meta-gegevens
section '.ProductAanbod', 'typeof': 'gr:Offering', about: '#offering', ->

    meta rev: 'gr:offers'   , resource: '#company'
    meta property: 'gr:name', content: 'Estate_Planning', @site.taal
    meta property: 'gr:description', @site.taal
    , content: 'Wat Tredius voor uw estateplanning kan betekenen'

    meta rel: 'gr:hasBusinessFunction', resource: 'gr:ProvideService'
    meta rel: 'foaf:page'             , resource: @document.url
    meta rel: 'gr:includes'

    # Vermogensplanning
    figure 'typeof': 'gr:SomeItems, pto:Estate_planning'
    , about: '#product', ->

        img src: '/media/afbeeldingen/icon_vermogensplanning.png'

        figcaption property: 'gr:name'
        , content: 'Vermogensplanning'
        , "Vermogensplanning"

        meta property: 'gr:description'
        , content: 'Tredius verzorgt uw vermogensplanning'

    # Testament opstellen, executeurschap, aangiften erfbelasting
    figure 'typeof': 'gr:SomeItems, pto:Estate_planning'
    , about: '#product', ->

        img src: '/media/afbeeldingen/icon_testamentopstellen.png'

        figcaption property: 'gr:name'
        , content: "Testament, executeurschap, erfbelasting"
        , "Testament opstellen,<br />executeurschap,<br />aangiften erfbelasting"

        meta property: 'gr:description'
        , content: "Tredius verzorgt uw testament, executeurschap
         en de erfbelasting"

    # Schenkingen & daarbij behorende aangiften
    figure 'typeof': 'gr:SomeItems, pto:Estate_planning'
    , about: '#product', ->

        img src: '/media/afbeeldingen/icon_schenkingen.png'

        figcaption property: 'gr:name'
        , content: 'Schenkingen en aangiften'
        , "Schenkingen &amp; <br />daarbij behorende<br />aangiften"

        meta property: 'gr:description'
        , content: 'Tredius verzorgt uw schenkingen en de aangifte hiervan'

    # Bedrijfsopvolging
    figure 'typeof': 'gr:SomeItems, pto:Estate_planning'
    , about: '#product', ->

        img src: '/media/afbeeldingen/icon_bedrijfsopvolging.png'

        figcaption property: 'gr:name', content: 'bedrijfsopvolging'
        , 'Bedrijfsopvolging'

        meta property: 'gr:description'
        , content: 'Tredius verzorgt uw bedrijfsopvolging'

# Prikkel
p 'Bovenstaande advisering staat natuurlijk niet op zichzelf. Het is
 vaak een combinatie van adviezen die zorgen dat u uw vermogen of bedrijf
 fiscaal optimaal kunt nalaten.'

# Lijst afvinken
ul '.Checklist', ->

    li 'Dat kan bijvoorbeeld betekenen dat u gedurende uw leven al een
     deel van uw vermogen schenkt aan uw kinderen of kleinkinderen om de
     fiscale regelgeving optimaal te benutten.'

    li 'Een advies over uw testament, waarin u nauwkeurig laat
     vastleggen wat er met uw vermogen mag gebeuren als u er niet meer
     bent. Zeker in het geval van jonge kinderen is het belangrijk hier
     goed over na te denken en dit duidelijk in uw testament te
     omschrijven.'

    li 'Wellicht willen uw kinderen het bedrijf overnemen en werken zij
     inmiddels in het familiebedrijf. Ook in deze situatie zal goed en
     tijdig advies uw een hoop geld kunnen besparen.'

# Oº°‘¨ widget ¨‘°ºO ══════════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.marco     #  \\════════════════════════════╝
, txt: [ "Mocht u eens willen sparren of advies willen krijgen omtrent
 estate planning", "neemt u dan contact op met:"]
# ══════════════════════════════════════════════════════════════════════



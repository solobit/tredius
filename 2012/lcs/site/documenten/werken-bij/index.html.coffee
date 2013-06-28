### cson
voetmenu:       2
titel:          'Werken bij Tredius'
naam:           'Werken bij Tredius'
layout:         'standaard'
kenmerk:        'werkenbij'
bannier:        'bg_bruin.gif'
extra:          "<a href='/werken-bij/vacatures '#overzicht',' class='knop context' title='Klik hier voor een overzicht van onze actuele vacatures...'>Actuele vacatures &raquo;</a>"

samenvatting:   "Bij Tredius hebben we de behoefte het huidige werken te
 veranderen. Wij geloven de status quo te kunnen doorbreken. Door jou
 continue te (laten) ontwikkelen en je als medewerker kansen te bieden om
 duurzaam succesvol te zijn. Zo gaan we samen jouw carrière in een
 volgende versnelling zetten, met als doel te streven naar vrijheid,
 onafhankelijkheid en zelfstandigheid, voor iedere medewerker."

###

coffeescript ->

    $ ->
        $('.artikel_paragraaf').hyphenate 'nl'

# Artikel
article '.wbt-paginainhoud', ->

    section '.wbt-content-voorpagina', ->

        h1 '.Tagline.wbt-titel1', 'Jij werkt, Tredius helpt daarbij'
        p '.wbt-content' , 'Bij Tredius hebben we de behoefte om het
         huidige werken te veranderen. Wij geloven de status quo te
         kunnen doorbreken. Door jou continue te (laten) ontwikkelen en
         je als medewerker kansen te bieden om duurzaam succesvol te
         zijn. Zo gaan we samen jouw carrière in een volgende versnelling
         zetten, met als doel te streven naar vrijheid, onafhankelijkheid
         en zelfstandigheid, voor iedere medewerker.'
        p '.wbt-content', 'In alles wat wij doen geloven we in ons
         waarom. Het waarom van Tredius loopt door onze aderen. We
         streven iedere dag naar vrijheid, onafhankelijkheid en
         zelfstandigheid voor iedere ondernemer: groot of klein, oud of
         jong, startend of door de wol geverfd. Onze overtuiging kunnen
         wij alleen verwezenlijken als onze medewerkers dezelfde
         overtuiging hebben.'
        p '.wbt-content', 'Bij Tredius werken doe je dan ook niet puur
         voor je financiële vergoeding, status of gemak. Nee, bij
         Tredius werken mensen die zich willen ontwikkelen. Of je nu
         stagiair, starter of (zeer) ervaren bent, je hebt altijd de
         behoefte je te blijven ontwikkelen. Dat doe je niet alleen op
         vaktechnisch niveau, ook persoonlijke ontwikkeling is
         belangrijk.'

    # Herhaling blok 3 kolommen
    section '.wbt-content-vervolgblok', ->

        # Nadruk subtitel
        h2 '.Steunlijn.wbt-titel2', 'Je blijft je ontwikkelen, Tredius helpt daarbij'
        p '.wbt-content', 'Als organisatie hebben wij dan ook de
         overtuiging dat medewerkers die zich blijven ontwikkelen het
         bestaansrecht zijn voor een goedlopende onderneming. Dat is de
         reden om de ontwikkeling van onze mensen aan te moedigen, actief
         te faciliteren en – zij het zonder regels - te verplichten. Onze
         eigen ambitie is om de komende jaren gedegen te groeien naar een
         vooraanstaande speler in de Randstad. Uiteraard altijd dichtbij
         je in de buurt, laagdrempelig en persoonlijk.'
        p '.wbt-content', 'Dus geen grote gebouwen en verre reizen, maar
         in de buurt op een plek waar je altijd kunt binnen lopen zonder
         aan te bellen. Aan de achterkant zullen wij door groei groot
         genoeg zijn om de specialisten in huis te hebben die zorgen voor
         het perfecte MKB maatadvies op het juiste moment. Niet alleen
         voor jaarrekeningen en assurantiën, maar ook op het gebied van
         ondernemerschap en bijbehorende subsidies.'
        p '.wbt-content', 'Deze ambitie geldt niet alleen voor de
         organisatie, maar ook voor onze medewerkers. Wij geloven dat
         wanneer onze mensen prettig kunnen werken, dat tot uiting zal
         komen in een uitmuntende dienstverlening. Dat betekent dat
         Tredius als werkgever bij jou in de buurt is gevestigd. Je hoeft
         dus niet ver te reizen. Verder werken wij in kleine teams. Dat
         geeft een hechte band. Als werkgever stimuleren wij de teams,
         door de lunch te faciliteren en altijd samen een broodje te
         eten.'

        # Concluderen / samenvatten / binden

        h3 '.Steunlijn.wbt-titel3' , 'Dus klein genoeg voor een prettige
         bedrijfscultuur, maar groot genoeg om je kansen te bieden.'

        span '.wbt-slot', 'Wie je ook bent, als je een stap in je
         carrière wilt zetten, ben je bij Tredius aan het juiste adres.
         We zijn een jonge, dynamische organisatie. Daarnaast zitten wij
         vol enthousiasme en ambitie om te groeien.  De groei van Tredius
         als organisatie zorgt er voor dat onze mensen ook weer  kunnen
         groeien. Dus in welke fase van je carrière je ook zit, een
         overstap naar Tredius, is een stap voorwaarts.'

h4 '.wbt-titel4', 'Volop carrièrekansen bij een werkgever die
nét die ene stap extra zet!'

div '.vacature-knop', ->

    a '.knop', href: '/werken-bij/vacatures.html'
    , 'Bekijk onze vacatures &raquo;'



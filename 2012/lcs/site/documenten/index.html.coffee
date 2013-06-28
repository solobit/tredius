### cson
titel:          'Waarom Tredius'
layout:         'standaard'
kenmerk:        'voorpagina'
bannier:        'bg_blauw.gif'
extra:          "<a href='./overtuiging.html' alt='Lees meer over onze overtuiging' class='knop context'> Lees meer &raquo;</a>"

samenvatting:   "Bij Tredius hebben we de behoefte om het MKB landschap
 te veranderen. Wij geloven de status quo te kunnen doorbreken. Drempels
 moeten omlaag, ondernemers verdienen eerlijke kansen om duurzaam
 succesvol te zijn en samen de motor van de economie in een volgende
 versnelling te zetten. Streven naar vrijheid, onafhankelijkheid en
 zelfstandigheid, voor iedere ondernemer."
###

h1 '.Tagline', 'U onderneemt, Tredius doet de rest'

# Vrijheid
figure '.artikel-illustratief', ->

    img '.icoon-basis'
    , src:      '/media/afbeeldingen/vrij.png'
    , alt:      'Vrijheid is een kernbegrip van Tredius'
    , height:   '100'
    , width:    '100'

    figcaption 'Vrij'

# Onafhankelijk
figure '.artikel-illustratief', ->

    img '.icoon-basis'
    , src:    '/media/afbeeldingen/onafhankelijk.png'
    , alt:    'Onafhankelijkheid voor iedere ondernemer'
    , width:  '100'
    , height: '100'

    figcaption 'Onafhankelijk'

# Zelfstandig
figure '.artikel-illustratief', ->

    img '.icoon-basis'
    , src: '/media/afbeeldingen/zelfstandig.png'
    , alt: 'Zelfstandigheid is ultieme vrijheid'
    , width: '100'
    , height: '100'

    figcaption 'Zelfstandig'

h2 "Adviseren op cruciale punten, binnen alle facetten.<br />
 Een geruststellende gedachte. Dat is onze overtuiging."

a '.knop.verder', href: '/overtuiging.html'
, 'Lees Onze Overtuiging &raquo;'


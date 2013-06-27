### cson
voetmenu:       1
layout:         'standaard'
soort:          's:Product'
titel:          'Juridisch'
categorie:      'Juridisch'
naam:           'Juridisch Abonnement'
subtitel:       'Juridisch Abonnement'
kenmerk:        'juridisch_abonnement'
bannier:        'bg_juristen.jpg'
labels:         ['randstad', 'belastingen', 'juridisch', 'abonnement']

omschrijving:   "Met het Tredius Juridisch abonnement bent u altijd van
kwalitatief juridisch advies verzekerd."

product:
    code:       'jabo'
    naam:       'Juridisch Abonnement'

formulier:
    id:         'frmJuridischAbo'
    uri:        'uri'
    name:       'juridisch-abo'
    title:      'Sluit hier uw % af'
    method:     'post'
    classes:    'AchtergrondKleur-groen Kolom-9'
    fields:      ['achternaam','telefoon','email','postcode','woonplaats','bevestigen','knoppen' ]
    buttons:     ['wissen', 'verzenden']

###

OF = -> (li '.amp--', -> hr ''; p 'of')
EN = -> (li '.amp--', -> hr ''; p '&amp;')

h1 '.Tagline', "'Tredius staat voor gemak', met het Tredius Juridisch Abonnement"
p "Om dit in de praktijk te brengen hebben wij het
 <strong>Tredius Juridisch Abonnement</strong>
 in het leven geroepen."
p 'Voor € 295 excl. BTW per jaar bent u van juridisch advies gegarandeerd.'
p "Onze slogan is dan ook &ldquo;Gemak dient de ondernemer&rdquo;"

#
# Linker kolom paars
#
section '.ProductInformatie'
, id:           @document.product.code
, class:       'FormulierInfo-sectie'
, itemscope:    'itemscope'
, itemtype:     's:Offer'
, itemid:       '#offer', ->

    # Productafbeelding
    img itemprop: 'image', alt: @document.naam
    , src: '/media/afbeeldingen/producten/juridisch_abonnement2.png'

    # Aanbieding!
    h3 '.Formulier-titel', 'typeof': 'gr:Offering', about: '#offering'
    , @document.naam

    # Productomschrijving, bedrijfsactiviteiten en koppelingen
    meta rev:"gr:offers", resource:"#company"
    meta rel: 'gr:hasBusinessFunction', resource: 'gr:ProvideService'
    meta rel: 'foaf:page', resource: @document.url
    meta property: 'gr:name', @site.taal, content: @document.naam
    meta property: 'gr:description', @site.taal, content: @document.omschrijving

    h4 "Voor slechts <span itemprop:'price'>€ 295</span> ontvangt u"
    ul ->
        li '2 contracten per jaar gratis'
        OF()
        li -> '3 uur gratis juridisch advies'
        EN()
        li -> '15% korting op het uurtarief van de juristen'
        EN()
        li -> 'Wanneer u 3 jaar geen gebruik maakt van deze dienst, <br /> krijgt u 50% terug'


#text @partial 'widgets/formulieren', @

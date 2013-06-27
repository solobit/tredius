### cson
voetmenu:       1
entiteit:       's:Article'
titel:          'Juridisch'
subtitel:       'Juridisch Advies'
naam:           'Juridisch Advies'
kenmerk:        'juradvies'
layout:         'standaard'
bannier:        'bg_juristen.jpg'
###

p 'De wereld wordt steeds juridischer – en wat dat betreft ook steeds
 complexer, vooral voor ondernemers. Dit kan betekenen dat uw vrijheid,
 onafhankelijkheid of zelfstandigheid in het geding komt. Dit wilt u
 uiteraard voorkomen. U bent niet voor niets ooit als ondernemer
 begonnen.'
#=======================================================================
blockquote '.newQuote', -> p 'Het belangrijkste is dat u vrij en onafhankelijk kunt blijven bewegen in een steeds complexere wereld.'
#=======================================================================
p 'Een sparringpartner op juridisch gebied is dan een prettig gevoel.
 Zeker in de grote hoeveelheid rechtsgebieden waar u iedere dag mee te
 maken heeft of kunt krijgen. Het belangrijkste is dat u vrij en
 onafhankelijk kunt blijven bewegen in een steeds complexere wereld.'
p 'De juristen van Tredius helpen u hier graag mee. Dat kan bijvoorbeeld
 door uw huidige contracten en overeenkomsten te controleren. Zijn de
 overeenkomsten nog wel van deze tijd? Of kunnen er aanpassingen gedaan
 worden die in uw voordeel zijn?'
p "Ook uw algemene leveringsvoorwaarden zijn zeker een controle waard."
p "Voorkomen is immers beter dan genezen."

# Juridische producten
h2 '.Tagline', itemscope: 'itemscope', itemtype: "s:Offer", itemid: "#offer"
, 'Naast controle van juridische stukken, verzorgen wij voor u de volgende zaken:'

# $$$ Aanbodgegevens
ul '.Checklist', 'typeof': "gr:Offering", about: "#offering", ->

    # ~M~ Dienstenaanbod en productomschrijving
    meta rev: "gr:offers", resource: "#company"
    meta property: "gr:name", content: "Juristen", @site.taal
    meta rel: "gr:hasBusinessFunction", resource: "gr:ProvideService"
    meta rel: "foaf:page", resource: @document.url
    meta property: "gr:description", @site.taal, content: "De juristen van Tredius staan gereed om u in raad en daad juridisch bij te staan."

    # >> Overeenkomsten
    li 'typeof': "gr:SomeItems, pto:Contract", about: "#product", ->
        strong property: "gr:name", content: "Overeenkomsten", "Overeenkomsten:"
        span "lening- of verpandingsovereenkomsten, huurovereenkomsten en arbeidsovereenkomsten"

    # >> Bankzaken
    li 'typeof': "gr:SomeItems, pto:Financial_accountancy", about: "#product", ->
        strong property: "gr:name", content: "Bankzaken", "Bankzaken:"
        span "Controleren van uw afspraken en overeenkomsten met uw financiers."

    # >> Procederen
    li 'typeof': "gr:SomeItems, pto:Lawsuit", about: "#product", ->
        strong property: "gr:name", content: "Procederen", "Procederen:"
        span "soms moet er ook geprocedeerd worden. Ook dat nemen de juristen van Tredius graag voor u uit handen. Samen wordt de beste strategie bepaald om te zorgen voor de waarborging van uw rechten."

    # >> Contracten
    li 'typeof': "gr:SomeItems, pto:Legal_advise", about: "#product", ->
        strong property: "gr:name", content: "Juridisch advies", "Contracten:"
        span "opstellen van arbeidscontracten of assistentie bij arbeidsgeschillen."

    # >> Juridische bijstand
    li 'typeof': "gr:SomeItems, pto:Legal_aid", about: "#product", ->
        strong property: "gr:name", content: "Juridische bijstand", "Juridische bijstand:"
        span "soms is het prettig om iemand naast u te hebben in een belangrijk gesprek of onderhandeling. Onze juristen weten hier raad mee en voorkomen dat u teveel zegt en waarborgen uw belangen tot het gaatje."


# Oº°‘¨ widget ¨‘°ºO ══════════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \'  Widget >> visitekaartje   `║
, poc: @org.contactpersonen.lennard   #  \`════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan goed juridisch advies <br /> of wilt
 u eens sparren met een van onze juristen?","Neemt u dan contact op met:"]
# ══════════════════════════════════════════════════════════════════════






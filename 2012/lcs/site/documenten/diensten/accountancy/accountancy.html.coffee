### cson
voetmenu:   1
thing:      's:Article'
layout:     'standaard'
kenmerk:    'accountancy'
titel:      'Accountancy'
naam:       'Accountancy'
bannier:    'bg_accountancy.jpg'
product:
    naamkort: 'Accountancy diensten'
    naamvol: 'Accountancy en financieel boekhoudkundige dienstverlening'
    omschrijving: 'De accountants van Tredius zijn u graag van dienst.'
###

p "Wij vinden het belangrijk om u direct en up-to-date te adviseren en niet
 achteraf. Tredius is geen jaarrekeningfabriek, waarin het eindproduct de
 gerealiseerde jaarrekening is. Een jaarrekening wordt vaak geproduceerd
 in het volgende jaar. U bent dan allang met andere zaken bezig en hebt
 niets meer aan deze informatie. Wij willen u een stapje voor zijn."
p "Daarom hebben de accountants van Tredius de jaarrekeningbespreking in
 een nieuw jasje gestoken. In plaats van het vorige jaar door te nemen,
 laten wij een analyse zien van de afgelopen jaren, een prognose jaar
 en – heel belangrijk – een benchmark van uw branche."
p "Op die manier kunnen onze specialisten bepalen hoe het daadwerkelijk
 met uw onderneming gaat. U bent dan in staat veel beter in te schatten
 waar uw kansen en risico’s liggen en daar direct en accuraat op te
 reageren. Zo loopt u nooit achter de feiten aan."

text @partial 'widgets/videofragment', { display: 'full', id: '123' }

p "Wij begrijpen dat financiële informatie van wezenlijk belang is voor
 de continuïteit en levensvatbaarheid van uw onderneming. Het is de bron
 van een duurzaam succesvolle onderneming en u mag van uw adviseur
 verwachten dat hij, of zij, daar accuraat en proactief mee omgaat."
p "Uw belang – het klantbelang – vinden wij namelijk hierin voorop
 staan. Zo heeft u bijvoorbeeld, in 90% van de gevallen, geen
 accountantsverklaring nodig. Dat is ook de reden waarom Tredius geen
 accountantsvergunning heeft. Wij willen vrij zijn in ons handelen om u
 en uw onderneming de best mogelijke service en dienstverlening te kunnen
 bieden."
p "Uiteraard hebben wij wel accountants in dienst, daarmee garanderen
 wij de kennis die nodig is om u optimaal te kunnen adviseren, alleen
 hoeven wij niet aan de strenge wet- en regelgeving te voldoen.
 Zodoende kunnen wij u onder andere een lager tarief bieden. Dus u
 krijgt wel de beste kwaliteit dienstverlening, maar dan voor een
 lagere prijs."

# Accountancy dienstenaanbod
h2 '.Tagline', itemscope: 'itemscope', itemtype: 's:Offer', itemid: '#offer'
, 'Hiermee kunnen onze accountants u nog meer van dienst zijn:'

section '.ProductAanbod', 'typeof': 'gr:Offering', about: '#offering', ->

    # Productomschrijving, bedrijfsactiviteiten en koppelingen
    meta rev: 'gr:offers', resource: '#company'
    meta rel: 'gr:hasBusinessFunction', resource: 'gr:ProvideService'
    meta rel: 'foaf:page', resource: @document.url
    meta property: 'gr:name', @site.taal, content: @document.product.naamvol
    meta property: 'gr:description', @site.taal
    , content: @document.product.omschrijving

    # Opsommen inhoud aanbod
    div rel: 'gr:includes', ->

        # { 'pto:Business_administration': [ 'icon_opzettenadministratie', 'Opzetten en voeren van bedrijfsadministratie']

        # Bedrijfsadministratie
        figure 'typeof': 'gr:SomeItems, pto:Business_administration'
        , about: '#product', ->

            img width: '86', height:'86'
            , src: '/media/afbeeldingen/icon_opzettenadministratie.png'
            , alt: 'Opzetten en voeren van bedrijfsadministratie'

            figcaption property: 'gr:name'
            , content: 'Opzetten en voeren administratie'
            , "Opzetten &amp; Voeren <br /> Administratie"

            div property: 'gr:description'
            , content: 'Opzetten/voeren van bedrijfsadministratie'

        # Managementinformatie
        figure 'typeof': 'gr:SomeItems, pto:Management_information'
        , about: '#product', ->

            img width:'86', height:'86'
            , src: '/media/afbeeldingen/icon_periodiekemanagementinfo.png'
            , alt: 'Stemmen samen met u de periodieke managementinformatie af'

            figcaption property: 'gr:name'
            , content: 'Periodieke Managementinformatie'
            , "Periodieke <br />Managementinformatie"

            div property: 'gr:description'
            , content: 'Samen stemt u de periodieke managementinformatie af'

        # Jaarrekeningen opstellen
        figure 'typeof': 'gr:SomeItems, pto:Fiscal_year'
        , about: '#product', ->

            img src:'/media/afbeeldingen/icon_opstellenjaarrekening.png'
            , width:'86', height:'86', alt:'Het opstellen van jaarrekeningen'

            figcaption property: 'gr:name', content: 'Opstellen jaarrekeningen'
            , 'Opstellen <br /> Jaarrekeningen'

            div property: 'gr:description'
            , content: 'Onze accountants helpen bij het opstellen van jaarrekeningen'

        # Beoordelen jaarrekeningen
        figure 'typeof': 'gr:SomeItems, pto:Fiscal_year'
        , about: '#product', ->

            img width:'86', height:'86'
            , src:'/media/afbeeldingen/icon_beoordelenjaarrekening.png'
            , alt:'Jaarrekeningen beoordelen'

            figcaption property: 'gr:name'
            , content: 'Beoordelen jaarrekeningen'
            , 'Beoordelen <br /> Jaarrekeningen'

            div property: 'gr:description'
            , content: 'De accountants van Tredius beoordelen uw jaarrekeningen'

        # Opstellen begrotingen
        figure 'typeof': 'gr:SomeItems, pto:Budget'
        , about: '#product', ->

            img width:'86', height:'86'
            , src:'/media/afbeeldingen/icon_opstellenbegroting.png'
            , alt:'Tredius helpt u bij het opstellen van begrotingen'

            figcaption property: 'gr:name', content: 'Opstellen begrotingen'
            , "Opstellen <br /> Begrotingen"

            div property: 'gr:description'
            , content: 'Tredius accountancy helpt bij begrotingen opstellen.'

        # Ondernemingsplannen
        figure 'typeof': 'gr:SomeItems, pto:Business_plan'
        , about: '#product', ->

            img width:'86', height:'86'
            , src:'/media/afbeeldingen/icon_makenondernemingsplan.png'
            , alt:'Samen met Tredius werkt u aan uw ondernemingsplannen'

            figcaption property: 'gr:name'
            , content: 'Make ondernemingsplannen'
            , "Maken <br /> Ondernemingsplannen"

            div property: 'gr:description', content: 'Met accountants
             van Tredius werkt u samen aan uw ondernemingsplannen.'

        # Interne controle
        figure 'typeof': 'gr:SomeItems, pto:Financial_audit'
        , about: '#product', ->

            img width:'86', height:'86'
            , src:'/media/afbeeldingen/icon_inrichteninternecontrole.png'
            , alt:'Inrichten van interne controle procedures en audits'

            figcaption property: 'gr:name', content: 'Inrichten interne
             procedure', "Inrichten <br /> Interne Procedure"

            div property: 'gr:description', content: 'We helpen met het
             inrichten van interne controle procedures.'


# Oº°‘¨ widget ¨‘°ºO ══════════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.lennard   #  \\════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan een goede accountant of wilt u eens
 sparren met een van onze adviseurs?","Neemt u dan contact op met:"]
# ══════════════════════════════════════════════════════════════════════


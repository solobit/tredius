### cson
voetmenu:   1
layout:     'standaard'
entiteit:   's:Article'
titel:      'Accountancy'
subtitel:   'Salaris &amp; Personeelszaken'
naam:       'Salarisadministratie'
kenmerk:    'hrpayroll'
bannier:    'bg_accountancy.jpg'
###


h1 '.Tagline', itemscope: 'itemscope', itemtype: 's:Offer', itemid: '#offer'
, 'Een mooi gevoel van vrijheid, onafhankelijkheid en zelfstandigheid'
#----------------------------------------------------------------------
p 'Personeel: uw medewerkers binnen alle lagen van uw organisatie. Het
 zijn de mensen die uw organisatie laten groeien. Werkgevers en
 werknemers presteren optimaal wanneer zij elkaars ambassadeurs zijn.
 Geven en nemen gaan dan hand in hand. Vanaf het moment dat u personeel
 in dienst heeft betekent dit dat uw onderneming groeit. U hoeft en kunt
 niet alles meer alleen doen.'
p 'Aan de andere kant brengt personeel in dienst ook
 verantwoordelijkheid met zich mee. U bent als werkgever verplicht om
 iedere week of maand salaris uit te betalen aan uw medewerkers. Dit
 moet uiteraard iedere keer goed gaan. Een adviseur die dit voor u uit
 handen kan nemen maakt de verantwoordelijkheid minder zwaar.'
p 'Onze adviseurs nemen voor u de hele afwikkeling van de
 salarisadministratie uit handen. Van het verwerken van mutaties,
 contacten met het pensioenfonds, het doen van loonaangiften tot het
 versturen van de jaaropgaven aan uw medewerkers.'

p 'En daar houdt het voor Tredius niet op. Er komt namelijk nog zo veel
 meer bij kijken dan alleen het verwerken van de salarisadministratie.'

p 'Hierbij enkele voorbeelden wat Tredius allemaal voor u kan betekenen
 op salaris & personeelsgebied:'

# Human Resources en Payroll
ul '.Checklist', 'typeof': 'gr:Offering', about: '#offering', ->

    # Dienstenaanbod en productomschrijving
    meta rev: 'gr:offers', resource: '#company'
    meta property: "gr:name", @site.taal, content: "HR and payroll service"
    meta rel:"gr:hasBusinessFunction", resource:"gr:ProvideService"
    meta rel:"foaf:page", resource: @document.url
    meta property:"gr:description", 'xml:lang':"nl"
    ,  content: 'Wat Tredius voor u kan betekenen op salaris en personeelsgebied:'

    # Opsomming van productaanbod
    div rel:"gr:includes"

    #  Nieuw personeel
    li 'typeof': "gr:SomeItems, pto:Employment" , about: "#product", ->

        strong property:"gr:name", content:"Nieuw personeel", 'Nieuw personeel:'

        p 'u gaat nieuw personeel aannemen. Dan is het prettig als uw
         loonadviseur u kan adviseren omtrent een goed arbeidscontract.
         Zo weet u zeker dat de rechten en plichten van u als werkgever
         en voor uw nieuwe personeelslid goed zijn geregeld.'

    # Electronic HRM
    li 'typeof': "gr:SomeItems, pto:E-HRM", about:"#product", ->

        strong property:"gr:name", content:"Online dossier", 'Online personeelsdossier:'

        p 'hoe meer personeel, hoe meer administratie. Met het online
         personeelsdossier heeft u alles bij de hand. U kunt vanuit
         kantoor of thuis altijd inloggen en heeft voor al uw personeel
         de gegevens op één plek: van arbeidscontract tot loonaangiften.
         U wordt zelfs op de hoogte gehouden van verjaardagen, aflopende
         contracten, jubilea en nog veel meer. Gemak dient immers de
         ondernemer.'

    # Ontslagprocedure
    li 'typeof': "gr:SomeItems, pto:Termination_of_employment", about:"#product", ->

        strong property:"gr:name", content:"Ontslagprocedure", 'Ontslagprocedure:'

        p 'het kan om diverse redenen voorkomen dat u afscheid moet
         nemen van een of meerdere personeelsleden. U wilt natuurlijk dat
         dit zo goed mogelijk verloopt. Onze loonadviseurs kunnen u
         hierbij uitstekend helpen. Wij begeleiden u bij de procedure en
         adviseren u wat uw rechten en plichten zijn. Als het nodig moet
         zijn, staan onze juristen klaar om u ook bij de kantonrechter
         van dienst te zijn.'


# Oº°‘¨ widget ¨‘°ºO ══════════════════════════════════════════════════╗
text @partial 'widgets/visitekaartje' # \\   Widget: visitekaartje     ║
, poc: @org.contactpersonen.wil       #  \\════════════════════════════╝
, txt: ["Mocht u behoefte hebben aan adequate salarisadministratie of
 wilt u eens sparren met een van onze loonadviseurs?","Neemt u dan
 contact op met:"]
# ══════════════════════════════════════════════════════════════════════


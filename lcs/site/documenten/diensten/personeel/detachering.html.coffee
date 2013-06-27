### cson
layout:         'standaard'
titel:          'Detachering'
kenmerk:        'detachering'
bannier:        'bg_belastingadvies.jpg'
menu:           "<ul class='menu circleMenu-closed' id='menu16'><li style='display: block;'><a href='#' style='display: block; font-size:14px; position:relative;font-weight:400; top:1px; color:#fff;'><p>BELASTING ADVIES</p></a></li><li style='display: block;'><a href='/diensten/belastingadvies.html' alt='Belastingadvies' title='Belastingadvies'><p>BELASTING ADVIES</a></p></li><li style='display: block;'><a href='/diensten/pensioen.html' alt='Pensioen' title='Pensioen'><p>PENSIOEN</a></p></li><li style='display: block;'><a href='/diensten/estateplanning.html' alt='Estate Planning' title='Estate Planning'><p>ESTATE PLANNING</a></p></li></ul>"
###

coffeescript ->

    $(document).ready ->

        do ->
            # Verbergen van de tweede en laatste span van een lijst item
            $('.lbl').css 'display', 'none'

        $(".Checklist > li").mouseover(() ->
            $(@).find('.lbl').fadeToggle '700', 'easeInCubic'
            $(@).find('.lbl').css 'cursor', 'pointer'
            $(@).find('p').css 'font-weight', '600'
        ).mouseout(() ->
            $(@).find('.lbl').fadeToggle '900', 'easeOutCubic'
            $(@).find('p').css 'font-weight', '400'
        )



p 'Een zwangerschap, tijdelijk project of langdurig zieke werknemer. Het
 zijn situaties waarin u als ondernemer handen te kort komt. Die zijn
 vaak echter wel hard nodig, om de zaken soepel te doen laten verlopen.
 Hoe fijn is het dan om direct te kunnen terugvallen op een partner als
 Tredius.'

p 'Voor al uw personele tekorten op financieel gebied verzorgen wij
 direct de tijdelijke invulling. Of de werkzaamheden vervolgens bij u op
 locatie plaatsvinden, of op één van onze vestigingen laten wij aan u.
 Zo blijft alles gewoon door draaien. Een geruststellende gedachte.'

p 'Zo blijft alles gewoon door draaien, een geruststellende gedachte'

h1 '.Tagline', 'Tredius Detachering is:'

div '.detachering-infolet', ->

    ul '.Checklist', ->

        li ->
            p 'Snel én gegarandeerd'
            span '.lbl', 'De juiste mensen op de juiste plek. Voor ieder
             (financieel) niveau hebben wíj de juiste mensen. Geen dure
             hoogopgeleide mensen, maar hoogopgeleide mensen die hun
             werk met passie doen. Wij garanderen u dat u snel de juiste
             persoon heeft zitten, of detacheren hem of haar via een
             werkplaats op één van onze locaties. (tweede tab als een
             soort blokje met tekst dat er uit komt)'

        li ->
            p 'Ervaring, maar mét een frisse blik'
            span '.lbl', 'U krijgt altijd iemand die veel ervaring
             meebrengt. Maar ook een frisse blik, waar u wel eens
             prettig door verbaasd kan zijn. Daarnaast blijven onze
             professionals zich continue ontwikkelen, waardoor zij
             zullen beschikken over de laatste kennis met betrekking tot
             onder andere regelgeving.'

        li ->
            p 'Flexibel inzetbaar parate kennis'
            span '.lbl', 'Ook onze eigen medewerkers vinden het soms
             uitdagend om te worden gedetacheerd. Omdat Tredius
             medewerkers continue werken met een grote
             klantenportefeuille, zijn zij gewend om flexibel te zijn.
             Ideaal in het geval u een tijdelijk project wilt laten
             detacheren.'

        li ->
            p 'Tijdelijk én probleemloos'
            span '.lbl', 'Dit is een zeer belangrijke reden voor de
             keuze van detacheren. Om welke reden u iemand ook wil
             inhuren, detacheren is altijd tijdelijk. Dus zodra uw
             onderbezetting verleden tijd is of het financieel wat
             minder gaat, u hoeft niemand te ontslaan.'


h2 'Financiële professionals, díe zitten bij Tredius'

p 'Tredius is een zakelijke dienstverlener, gespecialiseerd in
 financiële dienstverlening. Onze medewerkers zijn allemaal specialisten
 in finance. Wij  detacheren dan ook alleen financials, binnen alle
 branches. Onze professionals zijn er op ingesteld en daarom uitermate
 geschikt om bij u te worden gedetacheerd.'

h3 '.Steunlijn', 'Hieronder vindt u een kleine opsomming van
 werkzaamheden waarvoor Tredius Detachering absoluut de juiste partner
 is.'

p 'Mochten de werkzaamheden waar u om verlegen zit er niet bij zitten,
 aarzel dan niet om contact met ons op te nemen. Onze dienstverlening en
 kennis reikt namelijk veel verder. Daarnaast stelt ons netwerk ons in
 staat u in contact te kunnen brengen met een partij die wel de juiste
 mensen voor u heeft.'


coffeescript ->

    $(document).ready ->

        # Slideshow
        menuWrapper = document.getElementById("slideshow-menu-wrapper")
        cursor = document.getElementById("slideshow-menu-cursor")
        slideshow = new Dragdealer "slideshow",
            steps: 4
            loose: true
            animationCallback: (x, y) ->
                top = x * (menuWrapper.offsetHeight - cursor.offsetHeight)
                cursor.style.top = String(top) + "px"

        document.getElementById("slideshow-photo-1").onclick = ->
            slideshow.setStep 1
            false

        document.getElementById("slideshow-photo-2").onclick = ->
            slideshow.setStep 2
            false

        document.getElementById("slideshow-photo-3").onclick = ->
            slideshow.setStep 3
            false

        document.getElementById("slideshow-photo-4").onclick = ->
            slideshow.setStep 4
            false


div id: 'slideshow-menu-wrapper', class: 'top-spaced right-float', ->
    div id: 'slideshow-menu-cursor', class: 'cursor', style: 'top: 66px;', ->
        ul id: 'slideshow-menu', ->
            li ->
                a '#slideshow-photo-1', href: '#photo1', ->
                    span '.title', 'Debiteurenbeheer'
                    span '.description', 'Uw debiteurenbeheer in goede handen.'

            li ->
                a '#slideshow-photo-2', href: '#photo2', ->
                    span '.title', 'Crediteurenadministratie'
                    span '.description', 'Lorem ipsum dolor sit.'

            li ->
                a '#slideshow-photo-3', href: '#photo3', ->
                    span '.title', 'Salarisadministratie'
                    span '.description', 'Lorem ipsum dolor sit.'

            li ->
                a '#slideshow-photo-4', href: '#photo4', ->
                    span '.title', 'Managementrapportage'
                    span '.description', 'Lorem ipsum dolor sit'

div '.top-spaced', ->
    div id: 'slideshow', ->
        div '.handle', style: 'left: -400px;', ->
            div class: 'slide img1'
            div class: 'slide img2'
            div class: 'slide img3'
            div class: 'slide img4'

ul '.detachering-diensten', ->
    li 'Debiteurenbeheer'
    li 'Debiteurenadministratie'
    li 'AO/IO trajecten'
    li 'Crediteurenadministratie'
    li 'Algehele administratie'
    li 'Aangiften (IB/VPB/OB)'
    li 'Salarisadministratie'
    li 'Samenstellen jaarrekening'
    li 'Managementrapportage'

ul '.detachering-adviseurs', ->
    li 'Accountant'
    li 'Fiscalist'
    li 'Salarisadministrateur'
    li 'Loonadviseur'
    li '(Assistent) Controller'
    li 'Financieel Medewerker'
    li 'Financieel Consultant'

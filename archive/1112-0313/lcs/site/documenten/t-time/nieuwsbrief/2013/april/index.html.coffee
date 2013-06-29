### cson
titel:          'Tredius vertelt'
subtitel:       'Fiscale voordelen en een interview met René Goeth'
layout:         'standaard'
kenmerk:        'ttNieuwsOverzicht'
uitgave:        'april'
jaargang:       '2013'
datum:          'dinsdag 16 april 2013'
bannier:        'bg_ttime.jpg'
postbannier:    '/media/afbeeldingen/bg_ttime_vervaagd.jpg'
illustratie:    '/media/afbeeldingen/tredius_juridisch.png'

samenvatting:   'Lees nu alles omtrent de laatste fiscale voordelen voor u als
 ondernemer in T-Time. En lees het interview dat Tredius had met René Goeth,
 franchisenemer van Rivièra Maison, wat zij verstaan onder ondernemen en hoe
 Tredius hen daar bij helpt.'

###

# Data ophalen QueryEngine en Backbone
nieuwsbrieven = @verzameling({nieuwsbrief:@document.uitgave})
testimonials  = @verzameling({testimonial:@document.uitgave})

#══════════════════════════════════════════════════════════════════════╗
h1 '.Tagline', 'Blijf op de hoogte met de Tredius nieuwsbrief' #       ║
#══════════════════════════════════════════════════════════════════════╝

section '.ttNieuwsOverzicht-headlines', ->

    # List comprehension
    for item in testimonials

        a target: '_blank', href: item.urls[0], ->

            # Testimonials
            article '.ttNieuwsOverzicht-artikel', ->

                # Kolom links
                section '.ttNieuwsOverzicht-illustratie', ->
                    img src: item.illustratie

                # Kolom rechts
                section '.ttNieuwsOverzicht-katern', ->
                    h3  '.ttNieuwsOverzicht-titel'      , item.subtitel
                    p   '.ttNieuwsOverzicht-intro'      , item.samenvatting
                    a   '.ttNieuwsOverzicht--openen'    , href: item.urls[0]
                    , target: '_blank', 'Lees Verder'


#══════════════════════════════════════════════════════════════════════╗
h1 '.ttNieuwsOverzicht-kop2.Steunlijn', 'Tredius Actualiteiten' #      ║
#══════════════════════════════════════════════════════════════════════╝

section '.ttNieuwsOverzicht-actualiteit', ->

    # List comprehension actueel
    for nieuws in nieuwsbrieven

        a target: '_blank', href: nieuws.urls[0], ->

            article '.ttNieuwsOverzicht-artikel', ->
                h3  '.ttNieuwsOverzicht-titel'      , nieuws.subtitel
                p   '.ttNieuwsOverzicht-intro'      , nieuws.samenvatting
                a   '.ttNieuwsOverzicht--openen'    , href: nieuws.urls[0]
                , target: '_blank', 'Lees Verder'




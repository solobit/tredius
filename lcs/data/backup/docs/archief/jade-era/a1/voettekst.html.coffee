
snelkoppelingen = 
    @getCollection('documents').findAllLive(
        {voetmenu:$exists:true},[naam:1] ).toJSON()

footer '#snelkoppelingen', role: 'contentinfo', ->

    # Links
    section ->

        h4 '#v1-linklinks', 'ONZE DIENSTEN'
        ul role: 'navigation', 'aria-labelledby': 'v1-linklinks', ->
            for link in snelkoppelingen
                li -> 
                    a href: link.urls[0], link.naam

            li -> a href: '/diensten/accountancy.html', 'Accountancy'
            li -> a href: '/diensten/belastingadvies.html', 'Belastingadvies'
            li -> a href: '/diensten/estateplanning.html', 'Estate Planning'
            li -> a href: '/diensten/juridisch-abonnement.html', 'Juridisch Abonnement'
            li -> a href: '/diensten/juridisch-advies.html', 'Juridisch Advies'
            li -> a href: '/diensten/pensioen.html', 'Pensioen'
            li -> a href: '/diensten/risicoadvies-en-verzekeringen.html', 'Risicoadvies en Verzekeringen'
            li -> a href: '/diensten/overstapservice.html', 'Schoenendoos Overstapservice'
            li -> a href: '/diensten/salaris-en-personeel.html', 'Salarisadministratie'

    # Midden
    section ->

        h4 '#v1-linkmidden', 'WERKEN BIJ TREDIUS'
        ul role: 'navigation', 'aria-labelledby': 'v1-linkmidden', ->
            li -> a href: '/werken-bij/', 'Werken bij Tredius'
            li -> a href: '/werken-bij/stages.html', 'Stageplekken'
            li -> a href: '/werken-bij/wie-ben-jij.html', 'Wie ben jij?'
            li -> a href: '/werken-bij/vacatures.html', 'Vacatures'

    # Rechts
    section ->

        h4 '#v1-linkrechts', 'OVER TREDIUS'
        ul role: 'navigation', 'aria-labelledby': 'v1-linkrechts', ->
            li -> a href: '/overtuiging.html', 'Over Tredius'
            li -> a href: '/t-time/index.html', 'T-Time'
            li -> a href: '/contact.html', 'Contact'

# Onderste voet
footer '#paginavoet', ->
    aside '2013 © Tredius.nl'
    aside -> 
        ul ->
            li -> a href: '/overig/voorwaarden.html', 'Voorwaarden'
            li ->
                text '&nbsp; &#124; &nbsp;'
                a href: '/overig/privacy.html', 'Privacybeleid'
            li ->
                text '&nbsp; &#124; &nbsp;'
                a href: '/overig/handelsregister.html', 'Handelsregister'

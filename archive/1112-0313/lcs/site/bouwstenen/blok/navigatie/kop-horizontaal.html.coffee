



ul '.NavigatieBalk.NavigatieMenu', role: 'menubar', itemscope: 'itemscope', itemtype: 's:SiteNavigationElement', ->

    li role: 'menuitem', 'aria-haspopup': 'false', 'aria-labelledby': 'm1-home', -> a '#m1-home', href: '/index.html', tabindex: '1', 'HOME'

    li role: 'menuitem', 'aria-haspopup': 'false', 'aria-labelledby': 'm1-wzw', -> a '#m1-wzw', href: "/overtuiging.html", tabindex: '2', 'WIE ZIJN WE'

    li '.NavHoofdMenu--openen.NavHoofdMenu--verbreden', role: 'menuitem', 'aria-haspopup': 'true', 'aria-labelledby': 'm1-dienst', ->

        a '#m1-dienst', href: '#', tabindex: '3', 'ONZE DIENSTEN'

        div '.NavHoofdMenu-blok', ->

            div '.NavHoofdMenu-groep', ->

                h3 role: 'menuitem', 'BELASTING'
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '4', href: "/diensten/fiscaal/belastingadvies.html", 'Belastingadvies'
                    li -> a role: 'menuitem', tabindex: '5', href: "/diensten/fiscaal/pensioen.html", 'Pensioen'
                    li -> a role: 'menuitem', tabindex: '6', href: "/diensten/fiscaal/estateplanning.html", 'Estate Planning'

                h3 role: 'menuitem', 'PERSONEEL'
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '9', href: "/diensten/personeel/detachering.html", 'Detachering'

            div '.NavHoofdMenu-groep', ->

                h3 role: 'menuitem', 'JURIDISCH'
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '9', href: "/diensten/juridisch/advies.html", 'Juridisch Advies'
                    li -> a role: 'menuitem', tabindex: '10', href: "/diensten/juridisch/abonnement.html", 'Juridisch Abonnement'

                h3 role: 'menuitem', 'ACCOUNTANCY'
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '7', href: "/diensten/accountancy/accountancy.html", 'Accountancy'
                    li -> a role: 'menuitem', tabindex: '8', href: "/diensten/accountancy/salaris-en-personeel.html", 'Salaris &amp; Personeelszaken'


            div '.NavHoofdMenu-groep', ->

                h3 role: 'menuitem', 'DEBITEUREN'
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '16', href: "/diensten/debiteurenbeheer/", 'Debiteurenbeheer'
                    li -> a role: 'menuitem', tabindex: '17', href: "/diensten/debiteurenbeheer/stappenplan.html", 'Onze werkwijze'
                    li -> a role: 'menuitem', tabindex: '18', href: "/diensten/debiteurenbeheer/abonnement.html", 'Debiteuren Abonnement'


            div '.NavHoofdMenu-groep', ->

                h3  role: 'menuitem', "RISICO- &amp; PENSIOENADVIES"
                ul '.NavHoofdMenu-lijst', role: 'menu', ->
                    li -> a role: 'menuitem', tabindex: '11', href: "/diensten/risicoadvies/verzekeringen.html", 'Risicoadvies &amp; Verzekeringen'
                    li -> a role: 'menuitem', tabindex: '12', href: "/diensten/risicoadvies/pensioenadvies.html", 'Pensioenadvies'
                    li -> a role: 'menuitem', tabindex: '13', href: "/diensten/risicoadvies/risico-pensioenadvies.html", 'Risico- &amp; Pensioenadvies'
                    li -> a role: 'menuitem', tabindex: '14', href: "/diensten/risicoadvies/overstapservice.html", 'Schoenendoos Overstapservice'


    li '.NavHoofdMenu--openen.NavHoofdMenu--versmallen', role: 'menuitem', 'aria-haspopup': 'true', 'aria-labelledby': 'm1-tt', ->

        a '#m1-tt', tabindex: '19', href: "/t-time/", 'T-TIME'
        ul role: 'menu', ->
            li -> a role: 'menuitem', tabindex: '20', href: "/t-time/#1", 'Tredius vertelt...'
            li -> a role: 'menuitem', tabindex: '21', href: "/t-time/#2", 'Nieuwsbrief'
            li -> a role: 'menuitem', tabindex: '22', href: "/t-time/#3", 'Onze columns'
            li -> a role: 'menuitem', tabindex: '23', href: "/t-time/#4", 'Specials'


    li '.NavHoofdMenu--openen.NavHoofdMenu--versmallen', role: 'menuitem', 'aria-haspopup': 'true', 'aria-labelledby': 'm1-werk', ->

        a '#m1-werk', tabindex: '24', href: "/werken-bij/", 'WERKEN BIJ'
        ul role: 'menu', ->
            li -> a role: 'menuitem', tabindex: '25', href: "/werken-bij/index.html", 'Werken bij Tredius'
            li -> a role: 'menuitem', tabindex: '26', href: "/werken-bij/vacatures.html", 'Vacatures'
            li -> a role: 'menuitem', tabindex: '27', href: "/werken-bij/stages.html", 'Stages'
            li -> a role: 'menuitem', tabindex: '28', href: "/werken-bij/wie-ben-jij.html", 'Wie ben jij?'


    li '.NavHoofdMenu--openen.NavHoofdMenu--versmallen', role: 'menuitem', 'aria-haspopup': 'true', 'aria-labelledby': 'm1-locatie', ->

        a '#m1-locatie', tabindex: '29', href: '#', 'VESTIGINGEN'
        ul role: 'menu', ->
            li -> a role: 'menuitem', tabindex: '30', href: "/vestigingen/alkmaar.html", 'Alkmaar'
            li -> a role: 'menuitem', tabindex: '31', href: "/vestigingen/haarlem.html", 'Haarlem'
            li -> a role: 'menuitem', tabindex: '32', href: "/vestigingen/monnickendam.html", 'Monnickendam'
            li -> a role: 'menuitem', tabindex: '33', href: "/vestigingen/purmerend.html", 'Purmerend'


    li role: 'menuitem', 'aria-haspopup': 'false', 'aria-labelledby': 'm1-contact', ->

        a '#m1-contact', tabindex: '34', href: "/contact.html", 'CONTACT'

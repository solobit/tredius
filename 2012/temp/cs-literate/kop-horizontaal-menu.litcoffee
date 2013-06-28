### Navigatie: de horizontale menubalk

We komen dagelijks diverse navigatievormen tegen op alle websites die we
gebruiken: een menubalk, uitklapmenu, ‘mega-dropdown’, accordion,
tagcloud, enzovoorts. Maar hoe bepaal je welke het meest geschikt is
voor de website waar je aan werkt? Goldfield noemt 3 zaken waar je op
moet letten bij de keuze voor een navigatieoplossing:

* plaatsing
* weergavestijl
* interactie

#### Plaatsing

Bestaat er een ideale plaatsing voor globale en lokale navigatie? In
zekere zin wel. Mensen raken snel gewend aan bepaalde conventies.
Bijvoorbeeld dat het logo altijd linksbovenaan de pagina staat, dat de
metanavigatie (‘Contact’, ‘Sitemap’, e.d.) en de zoekfunctie meestal
rechtsbovenin staan, en dat banners vaak aan de rechterkant staan.
Globale navigatie verwacht men over het algemeen als horizontale
menubalk bovenin, of als verticaal menu aan de linkerkant. Lokale
navigatie wordt door de meeste mensen aan de linkerkant verwacht. Dit
blijkt volgens Goldfield uit eyetracking studies.

#### Weergavestijl

##### Horizontaal menu

Gewoon een rij hyperlinks, weergegeven als knoppen, tabs, of gewoon als
links. Plaatsing: bijna altijd bovenin de pagina.

###### Sterkten

* Heel veel toegepast voor globale navigatie, dus conventioneel en
  intuïtief.

* Geschikt om grotere letters in te gebruiken, dus meer te laten
  opvallen als hoofdnavigatie.

* Eenvoudig te bedienen.

###### Zwakten

* Slechts ruimte voor een aantal items, nauwelijks ruimte voor
  uitbreiding (2e rij hoofdingangen is zelden goed).

* Om ruimte te besparen, worden labels vaak ingekort met als risico dat
  de labels minder duidelijk worden.

* Als de labels op elkaar gepropt moeten worden om het te laten passen,
  kan het onduidelijk worden waar het ene item stopt en het andere
  begint.

* Geschikt voor max. 2 niveaus: onder de rij hoofdingangen kan een rij
  met de onderliggende laag gepresenteerd worden.

* Met name geschikt voor globale navigatie, veel minder geschikt voor
  lokale navigatie.

###### Aanbevelingen

* Ideaal voor compacte, stabiele navigatie (dus weinig items en
  geen/weinig uitbreiding).

* Als je labels moet inkorten: Test of de labels nog intuïtief genoeg
  zijn.

[Site navigatie, plaatsing, weergavestijl en interactie][dopper]


    menu =

        'Home':             'Home'

        'Wie zijn we':      'Wie zijn we'

        'Onze diensten':
            belasting:      ['advies', 'pensioen', 'estate planning']
            accountancy:    ['accountancy', 'salaris en personeel']
            juridisch:      ['advies', 'abonnement']
            risicoadvies:   ['advies', 'overstappen', 'pensioen', 'verzekeren']
        'Debiteurenbeheer':
            debiteurenbeheer:   ''
            stappenplan:        'onze werkwijze'
            abonnement:         'debiteuren abonnement'
        'T-Time':           [1,2,3,4]
        'Werken bij':       [1,2,3,4]
        'Vestigingen':      [1,2,3,4]
        'Contact':          ['']





    ul '.meganizr.menu-klasse', role: 'menubar'
    , itemscope: 'itemscope', itemtype: 's:SiteNavigationElement', ->

        # Terug naar de beginpagina
        li role: 'menuitem', 'aria-haspopup': 'false'
        , 'aria-labelledby': 'm1-home', ->

            a '#m1-home', href: '/index.html', tabindex: '1', 'HOME'

        # Wie zijn we
        li role: 'menuitem', 'aria-haspopup': 'false', 'aria-labelledby': 'm1-wzw', ->

            a '#m1-wzw', href: "/overtuiging.html", tabindex: '2', 'WIE ZIJN WE'

        li '.menu-uitvouwen.menu-breedst', role: 'menuitem'
        , 'aria-haspopup': 'true', 'aria-labelledby': 'm1-dienst', ->

            #
            # Onze diensten
            #
            a '#m1-dienst', href: '#', tabindex: '3', 'ONZE DIENSTEN'
            div '.menu-inhoud', ->

                # Belasting
                div '.menu-groep', ->
                    h3 role: 'menuitem', 'BELASTING'
                    ul '.menu-links', role: 'menu', ->

                        li -> a role: 'menuitem', tabindex: '4'
                        , href: "/diensten/financieel/belastingadvies.html"
                        , 'Belastingadvies'

                        li -> a role: 'menuitem', tabindex: '5'
                        , href: "/diensten/financieel/pensioen.html"
                        , 'Pensioen'

                        li -> a role: 'menuitem', tabindex: '6'
                        , href: "/diensten/financieel/estateplanning.html"
                        , 'Estate Planning'

                # Accountancy
                div '.menu-groep', ->
                    h3 role: 'menuitem', 'ACCOUNTANCY'
                    ul '.menu-links', role: 'menu', ->

                        li -> a role: 'menuitem', tabindex: '7'
                        , href: "/diensten/financieel/accountancy.html"
                        , 'Accountancy'

                        li -> a role: 'menuitem', tabindex: '8'
                        , href: "/diensten/personeel/salaris-en-personeel.html"
                        , 'Salaris &amp; Personeelszaken'

                        li '&nbsp;'

                # Juridisch
                div '.menu-groep', ->
                    h3 role: 'menuitem', 'JURIDISCH'
                    ul '.menu-links', role: 'menu', ->

                        li -> a role: 'menuitem', tabindex: '9'
                        , href: "/diensten/juridisch/advies.html"
                        , 'Juridisch Advies'

                        li -> a role: 'menuitem', tabindex: '10'
                        , href: "/diensten/juridisch/abonnement.html"
                        , 'Juridisch Abonnement'

                        li '&nbsp;'

                # Risico- en pensioenadvies
                div '.menu-groep', ->
                    h3  role: 'menuitem', "RISICO- &amp; PENSIOENADVIES"
                    ul '.menu-links', role: 'menu', ->

                        li -> a role: 'menuitem', tabindex: '11'
                        , href: "/diensten/risicoadvies/verzekeringen.html"
                        , 'Risicoadvies &amp; Verzekeringen'

                        li -> a role: 'menuitem', tabindex: '12'
                        , href: "/diensten/risicoadvies/pensioenadvies.html"
                        , 'Pensioenadvies'

                        li -> a role: 'menuitem', tabindex: '13'
                        , href: "/diensten/risicoadvies/risico-pensioenadvies.html"
                        , 'Pensioenadvies'

                        li -> a role: 'menuitem', tabindex: '14'
                        , href: "/diensten/risicoadvies/overstapservice.html"
                        , 'Schoenendoos Overstapservice'

        li '.menu-uitvouwen.menu-smal', role: 'menuitem'
        , 'aria-haspopup': 'true', 'aria-labelledby': 'm1-tt', ->

            # Debiteurenbeheer
            a '#m1-tt', tabindex: '15', href: "/diensten/debiteurenbeheer/", 'DEBITEUREN'
            ul role: 'menu', ->

                li -> a role: 'menuitem', tabindex: '16'
                , href: "/diensten/debiteurenbeheer/"
                , 'Debiteurenbeheer'

                li -> a role: 'menuitem', tabindex: '17'
                , href: "/diensten/debiteurenbeheer/stappenplan.html"
                , 'Onze werkwijze'

                li -> a role: 'menuitem', tabindex: '18'
                , href: "/diensten/debiteurenbeheer/abonnement.html"
                , 'Abonnement'

        li '.menu-uitvouwen.menu-smal', role: 'menuitem'
        , 'aria-haspopup': 'true', 'aria-labelledby': 'm1-tt', ->

            # T-time
            a '#m1-tt', tabindex: '19', href: "/t-time/", 'T-TIME'
            ul role: 'menu', ->

                li -> a role: 'menuitem', tabindex: '20'
                , href: "/t-time/#1", 'Tredius vertelt...'

                li -> a role: 'menuitem', tabindex: '21'
                , href: "/t-time/#2", 'Nieuwsbrief'

                li -> a role: 'menuitem', tabindex: '22'
                , href: "/t-time/#3", 'Onze columns'

                li -> a role: 'menuitem', tabindex: '23'
                , href: "/t-time/#4", 'Specials'

        li '.menu-uitvouwen.menu-smal', role: 'menuitem'
        , 'aria-haspopup': 'true', 'aria-labelledby': 'm1-werk', ->

            # Werken bij
            a '#m1-werk', tabindex: '24', href: "/werken-bij/", 'WERKEN BIJ'
            ul role: 'menu', ->

                li -> a role: 'menuitem', tabindex: '25'
                , href: "/werken-bij/index.html"
                , 'Werken bij Tredius'

                li -> a role: 'menuitem', tabindex: '26'
                , href: "/werken-bij/vacatures.html"
                , 'Vacatures'

                li -> a role: 'menuitem', tabindex: '27'
                , href: "/werken-bij/stages.html"
                , 'Stages'

                li -> a role: 'menuitem', tabindex: '28'
                , href: "/werken-bij/wie-ben-jij.html"
                , 'Wie ben jij?'

        li '.menu-uitvouwen.menu-smal', role: 'menuitem'
        , 'aria-haspopup': 'true', 'aria-labelledby': 'm1-locatie', ->

            # Vestigingen
            a '#m1-locatie', tabindex: '29', href: '#', 'VESTIGINGEN'
            ul role: 'menu', ->

                li -> a role: 'menuitem', tabindex: '30'
                , href: "/vestigingen/alkmaar.html"
                , 'Alkmaar'

                li -> a role: 'menuitem', tabindex: '31'
                , href: "/vestigingen/haarlem.html"
                , 'Haarlem'

                li -> a role: 'menuitem', tabindex: '32'
                , href: "/vestigingen/monnickendam.html"
                , 'Monnickendam'

                li -> a role: 'menuitem', tabindex: '33'
                , href: "/vestigingen/purmerend.html"
                , 'Purmerend'

        li role: 'menuitem', 'aria-haspopup': 'false'
        , 'aria-labelledby': 'm1-contact', ->

            a '#m1-contact', tabindex: '34', href: "/contact.html", 'CONTACT'

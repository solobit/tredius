# Hoofdsjabloon Tredius


# ((todo)) AccessifyHTML5
# ((todo)) Cookiebox
# Dynamische meta-gegevens (LET OP: bovenaan declareren variabelen voor toegang hieronder!!!)
benamingDocument    = if @document.titel then "#{@document.titel} | #{@site.naam}" else @site.naam
metaKernwoorden     = @site.keywords.concat(@document.sleutelwoorden or []).join(', ')
metaOmschrijving    = @document.omschrijving or @site.omschrijving
hoofdIllustratie    = "background: url('/media/afbeeldingen/#{@document.bannier}') repeat-x;"
soortDocument       = @document.soort or "s:Article"
I                   = -> return (li -> span " &#124; ")
#-----------------------------------------------------------------------------------------------------

doctype 5

html lang:      'nl'
, version:      'HTML+RDFa 1.1'
, itemscope:    'itemscope'
, prefix:       'og: http://ogp.me/ns#'
, itemtype:     'http://schema.org/WebPage', ->

    # Voor robots (niet zichtbaar)
    head ->

        meta charset: 'utf-8'

        # http://www.mnot.net/cache_docs
        meta 'http-equiv': 'Content-Language'  , content: 'nl'
        meta 'http-equiv': 'Cache-Control'     , content: 'max-age=3600'
        meta 'http-equiv': 'X-UA-Compatible'   , content: 'IE=edge,chrome=1'

        text @getBlock('meta').toHTML()

        title benamingDocument

        text @partial 'widgets/googlewebfonts'

        coffeescript ->

            # http://en.wikipedia.org/wiki/Framekiller
            # Framekiller script to help partially mitigate risk of
            # clickjacking attacks
            if self is top 
                document.documentElement.style.display = 'block' 
            else
                top.location = self.location



        # http://www.i18nguy.com/markup/metatags.html

        # Robots en caching
        meta name:     'robots'         , content: 'all'
        meta name:     'rivist-after'   , content: '1 days'

        # Auteurs- en publicatiegegevens creatief werk
        meta name:     'author'         , content: @site.auteur
        meta name:     'email'          , content: @site.contact
        meta name:     'copyright'      , content: @org.auteursrecht

        # Web 1.0 era
        meta name:     'keywords'       , content: metaKernwoorden
        meta name:     'description'    , content: metaOmschrijving

        # Web 3.0 semantisch web
        meta name:     'rating'         , content: 'General'

        # Facebook OpenGraph, corrected variable names.
        # The four required properties for every page are:
        meta property: 'og:title'       , content: @document.subtitel or benamingDocument
        meta property: 'og:url'         , content: @document.urls[0]
        meta property: 'og:type'        , content: @document.type or 'website'
        meta property: 'og:image'       , content: @document.afbeelding or @org.bedrijfslogo

        # Google +1
        meta itemprop: 'name'           , content: @document.soort or 's:WebPage'
        meta itemprop: 'description'    , content: @document.samenvatting or metaOmschrijving
        meta itemprop: 'image'          , content: @org.bedrijfslogo

        # Weergave schermen
        meta name: 'viewport'           , content: 'width=device-width, initial-scale=0.7'

        # Stijlbladen en vormgeving (ook die van plugins)
        text @getBlock("styles").add(@site.stijl.bladen).toHTML()

        link rel: 'shortcut icon'       , href: @site.stijl.icoon, type: 'image/png'


        script src: '/assets/js/headjs/dist/head.min.js'


    # Voor mensen (zichtbaar gedeelte)
    body role: 'document', 'typeof': soortDocument, @site.vocabulaire ,->

        section '.PaginaKop', ->

            # Merknaam / identiteit (bedrijfslogo) en verwijzen via vrienden (foaf)
            header itemscope: 'itemscope', itemtype: 'gr:BusinessEntity', about: '#company', ->

                meta property: 'gr:legalName', content: @org.bedrijfsnaam

                a href: '/', alt: "Naar #{@site.url}", rel: 'foaf:page', resource: @site.url, ->

                    img width: '160', height: '59', rel: 'foaf:logo', alt: "Ga terug naar #{@site.naam} hoofdpagina"
                    , title: @site.naam, src: @org.bedrijfslogo, resource: @org.bedrijfsogo


            # http://paulmakowski.wordpress.com/2009/07/20/http-post-https-bad-idea
            aside -> a '.login.knop', href: 'https://login.twinfield.com/', 'Inloggen'


            # Menubalk hoofdmenu
            text @partial "blok/navigatie/kop-horizontaal", @


        # Illustratief, wisselende afbeelding
        header '.PaginaContext-afbeelding', role: 'banner', 'aria-labelledby': 'label_titel'
        , style: hoofdIllustratie, ->

            div '.PaginaContext', itemscope: 'itemscope', itemtype: 's:WebPage', ->

                div ->

                    h1 '.PaginaContext-hoofdtitel', itemprop: 'name', @document.titel
                    h2 '.PaginaContext-ondertitel', itemprop: 'about', @document.subtitel
                    p '.PaginaContext-beknopt', itemprop: 'description', @document.samenvatting
                    meta itemprop: 'keywords', content: @document.labels
                    meta itemprop: 'creator', content: @org.bedrijfsnaam

        # Alle inhoud komt hier via @content binnen
        #
        section role: 'main', -> article class: "PaginaInhoud Pagina-#{@document.kenmerk}", -> @content



        # Voetblokken

        # Multimedia
        div '.PaginaBand-grijs', ->
            section role: 'complementary', ->

                # Nieuwsbrief
                aside ->

                    h3 'Kwartaal Nieuwsbrief'
                    p 'Meld je aan voor de Tredius nieuwsbrief'

                    # Graphicmail API formulier aanmelden nieuwsbrief
                    form '.FormulierNieuwsbrief-aanmelden'
                    , action: @getMailUri(145464,20853)
                    , role: 'form', name: 'form_api', method: 'post', ->

                        # Geef het emailadres op en klik op versturen
                        input '.InvoerVeld-email', type: 'email'
                        , name: 'Email', size: '20'
                        , placeholder: 'Uw emailadres...'

                        # Aanmelden nieuwsbrief versturen
                        input '.knop.versturen.klein'
                        , type: 'submit'
                        , value: 'Aanmelden &raquo;'


                # Vimeo embedded spelers met JavaScript API Froogaloop
                # Encapsulated voor list comprehension van wel 2 hele waardes
                (aside itemscope: 'itemscope', itemtype: 's:VideoObject', ->
                    iframe id: "VideoSpeler-#{vid}", src: @getVimeoUri(vid)
                    , width: '300', height: '169'
                    , frameborder: '0') for vid in ['55429476', '55430952']


        # Snelmenu onderaan, 3 kolommen evenredig verdeeld
        footer '.PaginaVoet-snelkoppelingen', role: 'contentinfo', ->

            # Simpele comprehension over een array van 3 kolommen die we vullen
            for sleutel, index in ['Onze diensten','Werken bij Tredius','Over Tredius']

                section ->

                    # Gegevens uit de Backbone/QE halen (traag?)
                    snelkoppelingen = @getCollection('documents').findAllLive(
                        {voetmenu:index+1},[naam:1]).toJSON()

                    h4 "#NavigatieVoet-#{index+1}", sleutel

                    ul role: 'navigation', 'aria-labelledby': "NavigatieVoet-#{index+1}", ->

                        # Menu items genereren aan de hand van meta-data
                        (li -> a href: link.urls[0], link.naam) for link in snelkoppelingen


        # Onderste voetblok
        footer '.PaginaVoet-colofoon', ->

            aside @org.auteursrecht

            aside ->


                ul ->
                    li -> a href: "/overig/voorwaarden.html"    , 'Voorwaarden'
                    I()
                    li -> a href: "/overig/privacy.html"        , 'Privacybeleid'
                    I()
                    li -> a href: "/overig/handelsregister.html", 'Handelsregister'

            p()


        # Scripts, defered execution zodat ze onze HTML/CSS pijp niet blokkeren
        #text @getBlock("scripts").add(@site.nonBlocking).toHTML()



        # replaced by webfont config tool
        #link rel: 'stylesheet'          , href: @site.stijl.lettertype

# http://www.w3.org/QA/Tips/Doctype

#base href: @site.url       # Disable in local

# Scripts die de doorvoer van onderstaande document kunnen blokkeren
# LET OP: Beperk deze tot het strict noodzakelijke
#script src:  url for url in @site.blockingScripts


###
script '''
    AccessifyHTML5();
    '''
###

# TODO
#comment '.cookieWarningBox'
#script type: 'text/javascript', '(function() {\n  $("#position3").position({\n    my: "right center",\n    at: "right bottom",\n    of: "#targetElement"\n  });\n\n}).call(this);'
#comment '[if lt IE 7]>\n    <p class="chromeframe">Uw browser is<em>antiek!</em></p><a href="http://browsehappy.com/">Upgrade</a><span>de browser of</span><a href="http://www.google.nl/chromeframe/?redirect=true">installeer Google Chrome Frame</a><span>om deze site te ervaren.</span><![endif]'



Dit is een verhaal van jantje en pietjes avontuur
=================================================



    doctype 5

    html lang: 'nl', version: 'HTML+RDFa 1.1', prefix: 'og: http://ogp.me/ns#', ->

        # ## Kop
        head, ->


            # ### Header van HTML document
            meta charset: 'utf-8'
            
            meta http-equiv: 'cache-control', content: 'Public'
            meta http-equiv: 'content-language', content: 'nl'
            meta http-equiv: 'content-type', content: 'text/html; charset=UTF-8'

            text @getBlock('meta').toHTML()

            # ## Documenttitel ###
            title if @document.titel "#{@document.titel} | #{@site.naam}" else @site.naam
            
            # ## Meta-gegevens zoekmachines
            meta name: 'robots', content: 'all'
            meta name: 'rating', content: 'General'
            meta name: 'author', content: 'site.auteur'
            meta name: 'rivist-after', content: '1 days'
            meta name: 'copyright', content: 'site.copyRight()'
            meta name: 'keywords', content: 'geefSleutelwoorden()'
            meta name: 'description', content: 'geefOmschrijving()'
            meta name: 'viewport', content: 'width=device-width, initial-scale=0.7'

            meta property: 'og:url' , content: 'document.url'
            meta property: 'og:type', content: 'document.type'
            meta property: 'og:title', content: 'document.titel'
            meta property: 'og:image', content: 'org.merknamen.bedrijfslogo'

            # ## Styles ###
            text @getBlock('styles').toHTML()

            link rel: 'shortcut icon',  href: '/media/afbeeldingen/favicon.png', type: 'image/png'
            link rel: 'stylesheet',     href: '//fonts.googleapis.com/css?family=Dosis:400,500,600|Open+Sans:400italic,600italic,700italic,400,600,700&quot;'
            
            # ## Scripts (blocking kind) ###
            script src: '/assets/modernizr-custom.js'
            script src: '//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js'
            script src: '//ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js'
            script src: '/assets/jquery.colorbox.js'
           
            

        body role: 'document', typeof: 'geefEntiteit()', xmlns:s: 'http://schema.org/', xmlns:gr: 'http://purl.org/goodrelations/v1#', xmlns:rdfs: 'http://www.w3.org/2000/01/rdf-schema#', xmlns:vcard: 'http://www.w3.org/2006/vcard/ns#', xmlns:foaf: 'http://xmlns.com/foaf/0.1/', xmlns:xsd: 'http://www.w3.org/2001/XMLSchema#', xmlns:v: 'http://rdf.data-vocabulary.org/#', xmlns:pto: 'http://www.productontology.org/id/', xmlns:wn: 'http://xmlns.com/wordnet/1.6/', ->
        
            #comment '.cookieWarningBox'
            #script type: 'text/javascript', '(function() {\n  $("#position3").position({\n    my: "right center",\n    at: "right bottom",\n    of: "#targetElement"\n  });\n\n}).call(this);'
            #comment '[if lt IE 7]>\n    <p class="chromeframe">Uw browser is<em>antiek!</em></p><a href="http://browsehappy.com/">Upgrade</a><span>de browser of</span><a href="http://www.google.nl/chromeframe/?redirect=true">installeer Google Chrome Frame</a><span>om deze site te ervaren.</span><![endif]'
            
            section '#paginakop', ->
            
                header itemscope: 'itemscope', itemtype: 'gr:BusinessEntity', about: '#company', ->
                    div property: 'gr:legalName', content: 'org.naam'
                    a href: '@site.url', alt: 'Terug naar startpagina', rel: 'foaf:page', resource: 'site.url', ->
                        img width: '160', height: '59', rel: 'foaf:logo', title: 'site.naam', alt: 'Ga terug naar site.naam', src: 'org.merknamen.bedrijfslogo', resource: '@org.merknamen.bedrijfslogo'
            
                aside ->
                    a '.login.knop' href: 'https://login.twinfield.com/', 'Inloggen'
            
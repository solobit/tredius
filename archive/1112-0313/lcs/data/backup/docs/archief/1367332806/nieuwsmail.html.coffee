
doctype 5

html ->

    head ->

        meta charset: 'utf-8'

        meta 'http-equiv': 'content-language'  , content: 'nl'

        meta itemprop: 'image', content: @org.bedrijfslogo

        text @getBlock("styles").add(@site.stijl.bladen).toHTML()

        link rel: 'shortcut icon', href: @site.stijl.icoon, type: 'image/png'
        link rel: 'stylesheet', href: @site.stijl.lettertype

    body ->

        section '#paginakop', ->



                a href: @site.url, alt: 'Naar Tredius.nl', ->

                    img width: '160', height: '59', rel: 'foaf:logo', alt: "Naar Tredius.nl", title: @site.naam, src: @org.bedrijfslogo

        header '#bannier', style: "background: url('./media/afbeeldingen/bg_ttime_vervaagd.jpg')"

        section '#pagina', -> article id: @document.kenmerk, class: 'inhoud', -> @content







doctype 5

html lang: 'nl', version: 'HTML+RDFa 1.1', prefix: 'og: http://ogp.me/ns#'
, itemscope: 'itemscope', itemtype: "http://schema.org/WebPage", ->

    # Voor robots (niet zichtbaar)
    head ->

        meta charset: 'utf-8'

        # http://www.mnot.net/cache_docs
        meta 'http-equiv': 'Content-Language'  , content: 'nl'
        meta 'http-equiv': 'Cache-Control'     , content: 'max-age=600'
        meta 'http-equiv': 'X-UA-Compatible'   , content: 'IE=edge,chrome=1'

        text @getBlock('meta').toHTML()

        title "Index"

    # Voor mensen (zichtbaar gedeelte)
    body role: 'document', 'typeof': @document.type or 'webpage', @site.vocabulaire ,->


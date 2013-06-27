

h1 '.Tagline', itemscope: 'itemscope', itemtype: 's:VideoObject'
, 'Bekijk onderstaande video voor een indruk van Tredius'

section '.MediaSpeler-groot', role: 'region', itemprop: 'video', ->

    meta itemprop: 'name', content: 'Tredius Introductiefilm'
    meta itemprop: 'duration', content: 'T1M26S'

    iframe '#video-vimeo.crossdomain'
    , src: 'http://player.vimeo.com/video/55429476?title=0&amp;byline=0&amp;portrait=0'
    , role:                     'application'
    , name:                     'crossdomain'
    , webkitAllowFullScreen:    'true'
    , mozallowfullscreen:       'true'
    , allowFullScreen:          'true'
    , width:                    '500'
    , height:                   '281'
    , frameborder:              '0'


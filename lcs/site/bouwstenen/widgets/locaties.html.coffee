
# contactgegevens.styl

# Kolom links
div '.BedrijfVestiging', itemscope: 'itemscope', itemtype: "s:FinancialService", ->

    # Niet-zichtbare gegevens toch aan zoekmachine laten zien
    meta itemprop:"name"           , content:"Tredius "+ @.vestiging.bezoekadres[2]
    meta itemprop:"addressRegion"  , content:            @.vestiging.bezoekadres[3]
    meta itemprop:"addressCountry" , content:            @.vestiging.bezoekadres[4]

    # Bezoekadres
    strong '.adreskop', itemscope: 'itemscope', itemprop:"address"
    , itemtype:"s:PostalAddress", "Bezoekadres"

    span '.adres'     , itemprop: "streetAddress"   ,     @.vestiging.bezoekadres[0]
    span '.postcode'  , itemprop: "postalCode"      ,     @.vestiging.bezoekadres[1]
    span '.plaats'    , itemprop: "addressLocality" ,     @.vestiging.bezoekadres[2]


    # 2x adres? Postadres is geen type...
    strong '.adreskop'  , itemscope: 'itemscope'
    , itemprop:"address", itemtype:"s:PostalAddress"
    , 'Postadres'

    span '.adres'       , itemprop:"streetAddress"  ,    @.vestiging.postadres[0]
    span '.postcode'    , itemprop:"postalCode"     ,    @.vestiging.postadres[1]
    span '.plaats'      , itemprop:"addressLocality",    @.vestiging.postadres[2]

    # Telefoon, fax en mailadressen
    span '.telefoon'    , itemprop:"telephone"      ,        @.vestiging.telefoon
    span '.faxnummer'   , itemprop:"faxNumber"      ,             @.vestiging.fax

    span '.email', 'E:', ->
        a '.link', itemprop:"email", href:"mailto:#{@.vestiging.email}",        @.vestiging.email

    # Button routebeschrijving
    a '.Knop'
    , title:    'Routebeschrijving'
    , target:   '_blank'
    , itemprop: "map"
    , href:"https://maps.google.com/maps?daddr:#{@.vestiging.bezoekadres.join()},+Nederland&amp;ie:UTF8&amp;t:m"
    , 'Routebeschrijving &raquo;'

    # Kaart rechts
    div '.BedrijfVestiging-kaart' , itemscope: 'itemscope'
    , itemprop:   "geo"
    , itemtype:   "s:GeoCoordinates", ->

        iframe width:   '666'
        , height:       '260'
        , frameborder:  '0'
        , scrolling:    'no'
        , marginheight: '0'
        , marginwidth:  '0'
        , src:"https://maps.google.com/maps?daddr:#{@.vestiging.bezoekadres.join()}&amp;ie:UTF8&t:m&ll:#{@.vestiging.geocode[0]},#{@.vestiging.geocode[1]}&#{@.vestiging.rest}&amp;z:16&output:embed"



        img src:"//maps.googleapis.com/maps/api/streetview?size:666x280&amp;location:#{@.vestiging.geocode[0]},#{@.vestiging.geocode[1]}&amp;heading:151.78&amp;pitch:-0.76&amp;sensor:false"

        meta itemprop:"latitude", content:"#{@.vestiging.geocode[0]}"
        meta itemprop:"longitude", content:"#{@.vestiging.geocode[1]}"



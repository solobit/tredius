

# ((TODO)) Check properly mixed vocabularies v/h/schema
div '.Visitekaart.vcard', 'typeof': 'v:Person', itemtype: 's:Person', ->

    hr '.stippellijn', ''

    # Wilt u eens...?
    p @.txt[0]
    p @.txt[1]

    div '.ContactGegevens.address', itemtype: 's:ContactPoint'
    , itemscope: 'itemscope', ->
        span '.ContactPersoon', property: 'v:name', @poc.naam
        strong  '.ContactTelefoon', itemprop: 'telephone', @poc.telefoon
        meta property: 'v:affiliation', content: 'Tredius'
        (meta property: 'v:title', @titel) if @titel?


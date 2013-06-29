
# gr:GoodRelations and s:Schema.org
# The most powerful languages for product, price, and company data

# Helpers
product = @.document.meta.product
scheidingsteken = (chars) -> (li '.amp--', -> hr ''; p "#{chars}")


# ((question)) Be article or section?

section '.ProductInformatie'
, itemid:     '#offer'
, itemscope:  'itemscope'
, itemtype:   's:Offer'
, ->

    # Productafbeelding (pictogram of icoontje)
    img '.Product-icoon', itemprop: 'image'
    , src: '/media/afbeeldingen/producten/' + product.icoon
    , alt: product.naam

    # Aanbod GoodRelations
    h3 '.Product-titel', product.naam, 'typeof': 'gr:Offering'
    , about: '#offering'

     # Productomschrijving, bedrijfsactiviteiten en koppelingen
    meta resource: '#company', rev: 'gr:offers'
    meta property: 'gr:naam', @.site.taal, content: product.naam

    # Ons product is een dienstverlenende (bedrijfs)activiteit
    meta resource: 'gr:ProvideService'  , rel: 'gr:hasBusinessFunction'

    # Friend-of-a-Friend koppeling naar onze pagina's
    meta resource:  @.document.url, @.site.taal, rel: 'foaf:page'
    meta property: 'gr:description', content: @.document.meta.omschrijving

    # ((todo)) flexibel maken
    # Lijst met detailgegevens
    ul '.Product-specificatie', ->
        li product.prijs
        scheidingsteken('&amp;')
        li 'Per jaar opzegbaar'

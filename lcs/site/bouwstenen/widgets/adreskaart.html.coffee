
div '.adr', itemscope, itemtype: 's:LocalBusiness'

    # Niet-zichtbare gegevens toch aan zoekmachines tonen
    meta itemprop: 'name'          , content: 'Tredius'
    meta itemprop: 'addressRegion' , content: 'Randstad'
    meta itemprop: 'addressCountry', content: 'Nederland'

    meta itemprop: 'address', itemscope:  'itemscope'
    , itemtype: 's:PostalAddress'

    span '.adres'   , itemprop: 'streetAddress',     straat
    span '.postcode', itemprop: 'postalCode',        postcode
    span '.plaats'  , itemprop: 'addressLocality',   plaats

    #span '.telefoon', itemprop: 'telephone' :           telefoon
    #span '.faxnummer', itemprop: 'faxNumber' :          fax


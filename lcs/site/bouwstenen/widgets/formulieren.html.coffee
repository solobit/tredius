



# Hash of default form values
#
defaultVals = {
    anaam:
        fldname:    'Achternaam'
        typedef:    'text'
        apiname:    'col2'
        numchar:    24
        pattern:    '[a-zA-Z]{3,23}'
        default:    ''
        example:    "Uw achternaam"
        verbose:    'Uw achternaam bestaat uit maximaal 24 tekens.'
        oninput:    ->
        invalid:    ->
    bnaam:
        fldname:    'Bedrijfsnaam'
        typedef:    'text'
        apiname:    'col4'
        numchar:    24
        pattern:    '[a-zA-Z]{3,23}'
        default:    ''
        example:    "Firma Jansen en Janssen"
        verbose:    'De naam van uw bedrijf of organisatie.'
        oninput:    ->
        invalid:    ->
    tel:
        fldname:    'Telefoonnummer'
        typedef:    'tel'
        apiname:    'col'
        numchar:    13
        pattern:    '\\d{10,13}'
        default:    ''
        example:    "0123456789"
        verbose:    'Het telefoonnummer waarop u tijdens kantooruren te bereiken bent.'
        oninput:    ->
        invalid:    ->
    gsm:
        fldname:    'Mobiel nummer'
        typedef:    'tel'
        apiname:    'col'
        numchar:    13
        pattern:    '\\d{10,13}'
        default:    ''
        example:    "0612345678"
        verbose:    'Geef hier uw mobiele telefoonnummer op.'
        oninput:    ->
        invalid:    ->
    email:
        fldname:    'E-mailadres'
        typedef:    'email'
        apiname:    'Email'
        numchar:    25
        pattern:    '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'
        default:    ''
        example:    "voorbeeld@email.nl"
        verbose:    'U dient een geldig e-mailadres op te geven.'
        oninput:    ->
        invalid:    ->
    pc:
        fldname:    'Postcode'
        typedef:    'text'
        apiname:    'col13'
        numchar:    8
        pattern:    '[0-9]{4} [A-Za-z]{2}'
        default:    ''
        example:    '1234 AB'
        verbose:    'Uw postcode bestaat uit 4 cijfers en 2 letters'
        oninput:    ->
        invalid:    ->
    plaats:
        fldname:    'Woonplaats'
        typedef:    'text'
        apiname:    'col11'
        numchar:    30
        pattern:    '[a-zA-Z]+'
        default:    ''
        example:    "Uw woonplaats"
        verbose:    'Uw woonplaats mag uit maximaal 30 tekens bestaan.'
        oninput:    ->
        invalid:    ->
    straat:
        fldname:    'Straatnaam'
        typedef:    'text'
        apiname:    'col9'
        numchar:    30
        pattern:    '[a-zA-Z]+'
        default:    ''
        example:    'Uw straatnaam'
        verbose:    'U dient een straatnaam voor het adres op te geven.'
        oninput:    ->
        invalid:    ->
    huisnr:
        fldname:    'Huisnummer'
        typedef:    'number'
        apiname:    ''
        numchar:    6
        pattern:    '[0-9]{0,6}'
        default:    ''
        example:    '1'
        verbose:    'U huisnummer bestaat uit maximaal 6 cijfers.'
        oninput:    ->
        invalid:    ->
    toev:
        fldname:    'Toevoeging'
        typedef:    'text'
        apiname:    ''
        numchar:    8
        pattern:    '[a-zA-Z]{0,8}'
        default:    ''
        example:    'A'
        verbose:    'Uw toevoeging huisnummer mag maximaal uit 8 tekens 0-9 en Aa-Zz bestaan.'
        oninput:    ->
        invalid:    ->
    vink:
        fldname:    'Akkoord'
        typedef:    'checkbox'
        apiname:    'akkoord'
        checked:    true
        verbose:    'U dient onze voorwaarden te accorderen!'
        lbltext:    "Ja, ik wil mij aanmelden en ga akkoord met de <a href='/overig/voorwaarden.html'>
        voorwaarden</a> van Tredius".trim '\n'
    zend:
        fldname:    'Verzenden'
        typedef:    'submit'
        classes:    '.FormulierKnop--verzenden'
    wis:
        fldname:    'Wissen'
        typedef:    'reset'
        classes:    '.FormulierKnop--wissen'
}

#
# Functions
#

# Returns a string to use for attributes in CoffeeCup
isRequired  = (req) -> if req then 'required' else 'false'

# Obtain HTML (CoffeeCup) elements
getElement  = (r, req) ->

    # Decision-tree
    switch r.typedef

        # (1) Small (radio/check)boxes
        #
        when 'checkbox', 'radiobox'

            # Encapsulate return value
            return (

                # New row
                li '.FormulierRij', ->

                    # Control element goes first (left)
                    input type: r.typedef
                    , name:     r.apiname

                    # Label comes afterwards (aesthetics)
                    # ((todo)) make dynamic
                    label ".FormulierVoorwaarden.label"
                    , for:      r.apiname
                    ,           r.lbltext
                    ) #TODO = logic for radios

        # (2) The 'regular' text entry fields
        #
        when  'text', 'email', 'tel', 'url'

            # Encapsulate
            return (

                # Print a new list item (row)
                li '.FormulierRij', ->

                    # Label goes first, floats left
                    label ".FormVeld-label.label"
                    , for: r.apiname
                    , r.fldname

                    # Next comes the heavy markup
                    input "\##{r.apiname}"
                    , type:         r.typedef
                    , name:         r.apiname
                    , maxlength:    r.numchar
                    , title:        r.verbose
                    , pattern:      r.pattern
                    , placeholder:  r.placeholder
                    , required:     isRequired req
                    )

# Lookup the keys in defaults hash
getKeys     = (item) ->

    # Strings in the array are looked up
    if typeof item is 'string'

        # Required by convention marked *
        required = true if ~item.indexOf "*"
        item     = item.replace '*', ''

        # Exit earliest moment if not found
        return if defaultVals[item]? isnt true

        # Call form/html element builder
        return getElement defaultVals[item], required?

    # Buttons TODO better array check, custom objects
    if typeof item is 'object'

        return (li '.FormulierRij.FormulierRij-rechts', ->
            (input "#{defaultVals[x].classes}.btn"
                , type: defaultVals[x].typedef
                , value: defaultVals[x].fldname
                ) for x in item
            )

# Form element, URI obtained via function call and has title + recursive calls
form ".FormElement.#{@.cls}", action: @.uri, name: "frm#{@.doc.kenmerk}"
, method: 'POST', lang: 'nl', ->

    # Nice custom header for every form
    h3 '.FormulierElement-titel', @.txt

    # List comprehension over the array of strings, arrays
    ul '.FormulierLijst', -> getKeys(veld) for veld in @.fld

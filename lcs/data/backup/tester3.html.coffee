
#
# Multilingual and accessibility ARIA forms
# using HTML5 form API and browser-side validation
# with element-builtin regular expressions and responses.
#

# Generate localized / multi-lingual forms
lang = 'nl'

# I'm lazy
log = (args...) -> console.log args...


# Each language can have a object under its country code with the
# following key/value pairs: language: full native written language
# wordlist: object of two key/value pairs 1) entry's and 2) expressions
# (either array of labels or string of regex)
localized_forms = {
        dk:
            language: 'dansk'
      , de:
            language: 'Deutsch'
      , en:
            language: 'English'
            wordlist:
                name:
                    numchar:    0
                    require:    true
                    caption:    null
                    pattern:    null
                    apiname:    null
                    example:    null
                    default:    null
                    synonym:    null
                    respond:    null
                    istruth:    null
                    isfalse:    null
                    oninput:    ->
                    invalid:    ->

      , fr:
            language: 'français'
      , es:
            language: 'español'
      , it:
            language: 'italiano'
      , nl:
            language: 'Nederlands'
            wordlist:
                naam:
                    numchar:    24
                    require:    true
                    caption:    'Achternaam'
                    pattern:    "[A-Za-z]{3,23}"
                    apiname:    'col2'
                    example:    ''
                    default:    ''
                    synonym:    ['naam', 'achternaam','familienaam','volledige naam' ]
                    respond:    "Uw CAPTION bestaat ISFALSE uit alleen maar letters."
                    istruth:    ""
                    isfalse:    "niet"
                    oninput:    ->
                    invalid:    ->
                bedrijfsnaam:
                    numchar:    24
                    require:    true
                    caption:    'Bedrijfsnaam'
                    pattern:    '[a-zA-Z]{3,23}'
                    default:    ''
                    apiname:   'col4'
                    example:    "Uw CAPTION"
                    synonym:    ['bizz','bedrijf', 'organisatie' ]
                    respond:    "Uw CAPTION bestaat ISFALSE uit alleen maar letters."
                    istruth:    ""
                    isfalse:    "niet"
                    oninput:    ->
                    invalid:    ->
                telefoon:
                    numchar:    13
                    require:    true
                    caption:    'Telefoonnummer overdag'
                    pattern:    '\d{10,13}'
                    default:    ''
                    apiname:   'col'
                    example:    "0123456789"
                    synonym:    ['telefoon','telefoon overdag','vaste lijn','telefoon nummer', 'tel']
                    respond:    "Uw CAPTIONnummer bestaat ISTRUTH uit ISFALSE 10 tot 13 cijfers"
                    istruth:    "exact"
                    isfalse:    "niet"
                    oninput:    ->
                    invalid:    ->
                mobiel:
                    numchar:    13
                    require:    true
                    caption:    'Mobiel nummer'
                    pattern:    '\d{10,13}'
                    default:    ''
                    apiname:   'col'
                    example:    "Uw CAPTION nummer"
                    synonym:    ['gsm', 'mobiel','mobiele telefoon', 'mobiel nummer']
                    respond:    "Uw CAPTIONnummer bestaat ISFALSE uit ISTRUTH 10 tot 13 cijfers"
                    istruth:    "exact"
                    isfalse:    "niet"
                    oninput:    ->
                    invalid:    ->
                email:
                    numchar:    25
                    require:    true
                    caption:    'E-mailadres'
                    apiname:    'Email'
                    pattern:    '[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}'
                    default:    ''
                    synonym:    ['e-mail', 'mail', 'e-mailadres', 'mailadres', 'email adres']
                    example:    "voorbeeld@email.nl"
                    respond:    "Uw CAPTION ISFALSE uit ISTRUTH de juiste tekens"
                    istruth:    "een reeks van geheel"
                    isfalse:    "bestaat niet"
                    oninput:    ->
                    invalid:    ->
                postcode:
                    numchar:    8
                    require:    true
                    caption:    'Postcode'
                    pattern:    "[0-9]{4}[A-Z]{2}"
                    apiname:    'col13'
                    default:    ''
                    synonym:    ['post-code', 'pc', 'post code', 'postnummer', 'postadres']
                    example:    '1234 AB'
                    respond:    "Uw CAPTION ISFALSE ISTRUTH de juiste tekens"
                    istruth:    ""
                    isfalse:    "bestaat niet uit"
                    oninput:    ->
                    invalid:    ->
                woonplaats:
                    numchar:    30
                    require:    true
                    caption:    'Woonplaats'
                    pattern:    '[a-zA-Z]+'
                    apiname:    'col11'
                    default:    ''
                    synonym:    ['vestigingsplaats', 'woonplaats','locatie','plaats', 'stad']
                    example:    "Uw CAPTION"
                    respond:    "Uw CAPTION ISFALSE ISTRUTH uit 30 tekens van A tot Z."
                    istruth:    "bestaat geheel"
                    isfalse:    "bestaat niet"
                    oninput:    ->
                    invalid:    ->
                straat:
                    numchar:    30
                    require:    true
                    caption:    'Straatnaam'
                    pattern:    '[a-zA-Z]+'
                    apiname:   'col9'
                    default:    ''
                    synonym:    ['adres', 'straat','woonadres']
                    example:    'Hoofdstraat'
                    respond:    "Uw CAPTION ISFALSE ISTRUTH de juiste tekens"
                    istruth:    ""
                    isfalse:    "bestaat niet uit"
                    oninput:    ->
                    invalid:    ->
                huisnummer:
                    numchar:    5
                    require:    true
                    caption:    'Huisnummer'
                    pattern:    '[0-9]{5}'
                    apiname:   'col9'
                    default:    ''
                    synonym:    ['huisnr','huisnummer']
                    example:    '33'
                    respond:    "Uw CAPTION ISFALSE ISTRUTH de juiste tekens"
                    istruth:    ""
                    isfalse:    "bestaat niet uit"
                    oninput:    ->
                    invalid:    ->
                toevoeging:
                    numchar:    6
                    require:    false
                    caption:    'Toevoeging'
                    pattern:    '[0-9A-Za-z-_.]{6}'
                    apiname:    'col9'
                    default:    ''
                    synonym:    ['toevoeging','huisnummer toevoeging', 'huisnr toev', 'toev']
                    example:    '33'
                    respond:    "Uw CAPTION ISFALSE ISTRUTH de juiste tekens"
                    istruth:    ""
                    isfalse:    "bestaat niet uit"
                    oninput:    ->
                    invalid:    ->
                standaard:
                    numchar:    24
                    require:    false
                    caption:    '[Nieuw veld]'
                    pattern:    '[0-9A-Za-z-_.+]{24}'
                    apiname:    ''
                    default:    ''
                    synonym:    []
                    example:    ''
                    respond:    ""
                    istruth:    ""
                    isfalse:    ""
                    oninput:    ->
                    invalid:    ->

      , pl:
            language: 'polski'
      , pt:
            language: 'português'
      , sv:
            language: 'svenska'
    }

# Shorter access path (static object anyway)
record = localized_forms[lang].wordlist



findSynonyms = (field) ->
    for key, word of record
        for syn in word.synonym when syn is field
            return record[key]


#
# Define first a lookup function. We receive elements from a collection
# which (array) may contain several strings or objects. If it is a
# string, we will look up the value in a internal hash map, if found it
# will returned else we pass a default value. If it is an object, we
# also look it up, but only by its key this time. If found, we replace
# that objects hash keys with those provided, If not found, we return
# the provided values.
#
getRows = (field) ->

    switch typeof field

        # Lazily defined fields as strings in the array:
        # e.g. arrGroup = ['field1', 'postcode', 'address']
        when 'string'

            # Try and match the string with a default map key
            printRow record[field] if record[field]?

            # Keep trying, include synonyms now as well!
            if findSynonyms(field)?
                printRow findSynonyms(field)

            # Give up. Make a copy, append name to default.
            else
                hash = record['standaard']
                hash.caption = field
                printRow hash

        # Lookup objects
        when 'object'

            # Loop keys/value pairs
            for key,value of field
                printRow record[key] if record[key]?
                log value if not record[key]?

        # Numbers, null, etc.
        else
            return null

# Let op! Gebruik van 'fat arrow'
# voor bewaren van de context
printRow = ({args}) =>

    li '.FormulierRij', ->

        label for: args.caption, args.caption

        input id: args.caption
        , name:         ''
        , type:         'text'
        , size:         '23'
        , oninput:      ''
        , placeholder:  "Uw ?"
        , pattern:      "[a-zA-Z]{3,23}"
        , title:        "Uw  mag alleen uit letters bestaan."
        , oninvalid:    "this.setCustomValidity('Ongeldige !')"
        , required:      'required'
        , 'aria-required': 'true'

arrx = ['some', 'achternaam', 'tel', {mail: { pattern: "[a-z]" }}]
getRows y for y in arrx


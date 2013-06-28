
# Helpers
log = console.log

# Hash with short-coded keys for quick entries in the array that
# is used to populate the form
standaard_waarde = {
    anaam:
        fldname:    'Achternaam'
        typedef:    'text'
        apiname:    'col2'
        numchar:    24
        pattern:    "[a-zA-Z]{3,23}"
        default:    ''
        example:    "Uw achternaam"
        oninput:    ->
        invalid:    ->
    bnaam:
        fldname:    'Bedrijfsnaam'
        typedef:    'text'
        apiname:    'col4'
        numchar:    24
        pattern:    "[a-zA-Z]{3,23}"
        default:    ''
        example:    "Firma Jansen en Janssen"
        oninput:    ->
        invalid:    ->
    tel:
        fldname:    'Telefoonnummer'
        typedef:    'tel'
        apiname:    'col'
        numchar:    13
        pattern:    "\d{10,13}"
        default:    ''
        example:    "0123456789"
        oninput:    ->
        invalid:    ->
    gsm:
        fldname:    'Mobiel nummer'
        typedef:    'tel'
        apiname:    'col'
        numchar:    13
        pattern:    "\d{10,13}"
        default:    ''
        example:    "0612345678"
        oninput:    ->
        invalid:    ->
    email:
        fldname:    'E-mailadres'
        typedef:    'email'
        apiname:    'Email'
        numchar:    25
        pattern:    "[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}"
        default:    ''
        example:    "voorbeeld@email.nl"
        oninput:    ->
        invalid:    ->
    pc:
        fldname:    'Postcode'
        typedef:    'text'
        apiname:    'col13'
        numchar:    8
        pattern:    "[0-9]{4}[A-Z]{2}"
        default:    ''
        example:    '1234 AB'
        oninput:    ->
        invalid:    ->
    plaats:
        fldname:    'Woonplaats'
        typedef:    'text'
        apiname:    'col11'
        numchar:    30
        pattern:    "[a-zA-Z]+"
        default:    ''
        example:    "Uw woonplaats"
        oninput:    ->
        invalid:    ->
    straat:
        fldname:    'Straatnaam'
        typedef:    'text'
        apiname:    'col9'
        numchar:    30
        pattern:    "[a-zA-Z]+"
        default:    ''
        example:    'Uw straatnaam'
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
        oninput:    ->
        invalid:    ->
}

# Lookup function used while looping over the members of our lazy list
opzoeken = (veld) ->

    isVerplicht = false

    # Convention to add a trailing * to the key if we want it required
    (isVerplicht = true; veld = veld.replace '*', '') if ~veld.indexOf "*"

    # Premature key lookup, return earliest possible
    return if standaard_waarde[veld]? isnt true # <----------------\ here
    #                                              \
    # Overly qualified conditional setter, else undefined?
    r = standaard_waarde[veld] if standaard_waarde[veld]?

    # Generate an array of unambiguous accesskey names
    #xskeys = []; xskeys.push key[0] for key of hash


    # If the value of our input key is another hash, then OBSOLOTE
    #log key for key,val of resultaat when typeof resultaat is 'object'

    # The result is another hash, but its keys are named by convention,
    # so we can reference them directly instead of having to populate
    # using a loop

    # Encapsulate (
    return (li ->

        label for:      r.apiname #<----
                                  #    | link these together
        input id:       r.apiname #<----
        , type:         r.typedef # define a type of input field
        , placeholder:  r.example # example text to disappear on click
        , maxlength:    r.numchar # max length of value in the field
        , pattern:      r.pattern # pattern to validate browser-side
        )


# FORMULIER
#
form '. FormulierElement', action: '', name: "frm#{@.doc.naam.trim(' ')}"
, method:  'POST', lang: 'nl', ->

    h3 '.FormulierElement-titel', @.txt

    ul '.FormulierLijst', -> opzoeken(veld) for veld in @.fld

